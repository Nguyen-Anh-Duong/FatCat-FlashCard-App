const fs = require('fs');
const path = require('path');
const { Deck, Card } = require('../models');

async function convertAndInsertJsonToDb(filePath, deckInfo, transaction) {
    const resultArray = [];
    const jsonData = fs.readFileSync(filePath, 'utf8');
    const jsonObject = JSON.parse(jsonData);
    let partNumber = 1;
    let currentDeck = [];
    let currentWordCount = 0;

    for (const [question, answer] of Object.entries(jsonObject)) {
        const wordCount = question.split(' ').length + answer.split(' ').length;
        
        if (currentWordCount + wordCount > 200) {
            await insertDeckAndCards(deckInfo, currentDeck, partNumber, transaction);
            partNumber++;
            if (partNumber > 5) break;
            currentDeck = [];
            currentWordCount = 0;
        }

        currentDeck.push({ question, answer });
        currentWordCount += wordCount;
    }

    if (currentDeck.length > 0 && partNumber <= 5) {
        await insertDeckAndCards(deckInfo, currentDeck, partNumber, transaction);
    }
}

async function insertDeckAndCards(deckInfo, cards, partNumber, transaction) {
    const deck = await Deck.create({
        ...deckInfo,
        name: `${deckInfo.name} Part ${partNumber}`,
        description: `${deckInfo.description} Part ${partNumber}`,
        deck_cards_count: cards.length
    }, { transaction });

    const cardsWithDeckId = cards.map(card => ({ ...card, deck_id: deck.id }));
    await Card.bulkCreate(cardsWithDeckId, { transaction });
}

module.exports = { convertAndInsertJsonToDb };
