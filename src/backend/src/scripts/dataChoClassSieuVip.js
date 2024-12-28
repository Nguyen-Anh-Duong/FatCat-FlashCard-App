const { Deck } = require("../models");

async function main () {
    const deck2 = await Deck.create({
        name: 'Công nghệ phần mềm',
        description: 'Deck này bao gồm các khái niệm và công nghệ trong lĩnh vực phần mềm.',
      }, { transaction: t })
    
}