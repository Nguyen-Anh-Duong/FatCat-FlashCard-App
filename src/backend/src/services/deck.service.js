"use strict";

const { NotFoundError } = require("../core/error.response");
const { Deck, Category, Card } = require("../models");

class DeckService {
    static async getDecksByCategoryName(categoryName) {
        const category = await Category.findOne({   
            where: { name: categoryName }
        });
        if (!category) {
            throw new NotFoundError("Category not found");
        }
        return await Deck.findAll({
            where: { category_id: category.id },
            include: [{ model: Category, attributes: ['name'] }]
        });
    }
    static async getCardsByDeckId(deckId) {
        return await Card.findAll({
            where: { deck_id: deckId }
        });
    }
    static async getDeckById(deckId) {
        return await Deck.findByPk(deckId);
    }
    static async createDeck({user_id, name, description, category_id, is_published = false}) {
        return await Deck.create({user_id, name, description, category_id, is_published});
    }
    static async updateDeck(deckId, {name, description, category_name, is_published}) {
        const updateFields = {};
        if (name) updateFields.name = name;
        if (description) updateFields.description = description;
        if (category_name) {
            const category = await Category.findOne({where: {name: category_name}});
            if (!category) throw new NotFoundError("Category not found");
            updateFields.category_id = category.id;
        }
        if (is_published !== undefined) updateFields.is_published = is_published;
        const updatedDeck = await Deck.update(updateFields, {where: {id: deckId}});
        if (!updatedDeck) throw new NotFoundError("Deck not found");
        return updatedDeck;
    }
    static async deleteDeck(deckId) {
        return await Deck.destroy({where: {id: deckId}});
    }
}

module.exports = DeckService;
