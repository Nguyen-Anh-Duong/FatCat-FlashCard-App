"use strict"

const ClassModel = require("../models/class.model")
const DeckModel = require("../models/deck.model")
const ClassDeckModel = require("../models/classdeck.model")
const { BadRequestError } = require("../core/error.response")
const { User, Deck, Card, ClassDeck } = require("../models")
const ApiError = require("../utils/ApiError")

class DeckForClassService {
    
    static createDeckForClass = async ({ deck, user_id, classId }) => {
        if (!deck) throw new ApiError("Missing deck data.", 400);
        const foundUser = await User.findByPk(user_id)
    
        const cards = deck.Cards && deck.Cards.length > 0 ? deck.Cards : [];
    
        cards.forEach((card) => {
          delete card.id;
        });
    
        deck.user_id = user_id;
    
        const insertDeckAndCards = await Deck.create(
          {
            ...deck,
            deck_cards_count: cards.length,
            Cards: cards,
          },
          {
            //attributes: { exclude: ["id", "createdAt", "updatedAt"] },
            include: [Card],
          }
        );
        console.log(insertDeckAndCards.id);
        console.log(user_id);
        await ClassDeck.create({class_id: classId, deck_id: insertDeckAndCards.id
        })
        insertDeckAndCards['user_name']=foundUser.user_name
        return insertDeckAndCards
         
    
      };  

    static async getDeckForClass(classId) {
        const foundClass = await ClassModel.findOne({where: {id: classId}})
        if(!foundClass)
            throw new BadRequestError("Class not found")
        
        const decks = await ClassDeckModel.findAll({where: {class_id: classId}, include: [{model: DeckModel, as: "Deck"}, ]})
        if(!decks)
            throw new BadRequestError("No decks found")

        const decksData = await Promise.all(decks.map(async deck => {
            const user_id = deck.Deck.user_id;
            const foundUser = await User.findByPk(user_id);
            return {
                ...deck.Deck.dataValues,
                user_name: foundUser ? foundUser.name : null
            };
        }));
        
        return decksData;
    }
}

module.exports = DeckForClassService;
