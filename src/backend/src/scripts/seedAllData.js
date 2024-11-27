const { sequelize } = require('../database/init.database');
const { User, Category, Deck, Card, Class, ClassMember, ClassDeck, Token } = require('../models');
const { convertAndInsertJsonToDb } = require('./jsonToArray');

const seedAllData = async () => {
  try {
    await sequelize.transaction(async (t) => {
      // Seed Users
      const adminUser = await User.create({
        name: 'Admin',
        email: 'admin@gmail.com',
        password: 'admin',
        role_system: 'admin',
        isVerified: true,
      }, { transaction: t });
      // Token
      if(adminUser) {
        const newToken = await Token.create({
          userId: adminUser.id,
          accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNzMxMzc5MDA2LCJleHAiOjE3MzkxNTUwMDZ9.UCUJ512XTdkciDexOcNRzRQ6SStmlSju9IdtFbyYdEk",
        }, { transaction: t });
        console.log(`adminEmail:: ${adminUser.email}\npassword:: ${adminUser.password}\nadminRole:: ${adminUser.role_system}\nadminToken:: ${newToken.accessToken}`)
      }

      const regularUser = await User.create({
        name: 'User',
        email: 'user@gmail.com',
        password: 'user',
        role_system: 'user',
        isVerified: true,
      }, { transaction: t });
      if (regularUser) {
        const userToken = await Token.create({  
          userId: regularUser.id,
          accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoidXNlckBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTczMTQ3MDI5MiwiZXhwIjoxNzM5MjQ2MjkyfQ.5xB0SWzFFVVpz7yXYbiBdNycBLfxkKggdB_qncvKF3A",
        }, { transaction: t });
        console.log(`userEmail:: ${regularUser.email}\npassword:: ${regularUser.password}\nuserRole:: ${regularUser.role_system}\nuserToken:: ${userToken.accessToken}`)
      }

      // Seed Categories
      const unknownCategory = await Category.create({
        name: 'Không xác định',
      }, { transaction: t }); 
      const languageCategory = await Category.create({
        name: 'Ngôn ngữ',
      }, { transaction: t });

      const mathCategory = await Category.create({
        name: 'Toán học',
      }, { transaction: t });

      const scienceCategory = await Category.create({
        name: 'Khoa học',
      }, { transaction: t });

      const artCategory = await Category.create({
        name: 'Nghệ thuật',
      }, { transaction: t });

      const literatureCategory = await Category.create({
        name: 'Văn học',
      }, { transaction: t });

 
      // Seed Cards for English Deck
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/n5-vocab-kanji-eng.json', 'N5 Vocabulary', 'N5 Vocabulary', 'ja', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/n4-vocab-kanji-eng.json', 'N4 Vocabulary', 'N4 Vocabulary', 'ja', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/n3-vocab-kanji-eng.json', 'N3 Vocabulary', 'N3 Vocabulary', 'ja', 'en-US', adminUser.id, languageCategory.id, t);
      // await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/n2-vocab-kanji-eng.json', 'N2 Vocabulary', 'N2 Vocabulary', 'ja', 'en-US', adminUser.id, languageCategory.id, t);
      // await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/n1-kanji-char-eng.json', 'N1 Vocabulary', 'N1 Vocabulary', 'ja', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/hsk1_words.json', 'HSK 1', 'HSK 1', 'zh-CN', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/hsk2_words.json', 'HSK 2', 'HSK 2', 'zh-CN', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/hsk3_words.json', 'HSK 3', 'HSK 3', 'zh-CN', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/hsk4_words.json', 'HSK 4', 'HSK 4', 'zh-CN', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/hsk5_words.json', 'HSK 5', 'HSK 5', 'zh-CN', 'en-US', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/english_basic.json', 'English Basic', 'English Basic', 'en-US', 'vi', adminUser.id, languageCategory.id, t);
      await createAndInsertDeck('D:/Workspace/FatCat/src/backend/src/database/english_basic_2.json', 'English Basic 2', 'English Basic 2', 'en-US', 'vi', adminUser.id, languageCategory.id, t);

      console.log('All seed data inserted successfully');
    });
  } catch (error) {
    console.error('Error seeding data:', error);
  }
};
const createAndInsertDeck = async (filePath, name, description, questionLang, answerLang, userId, categoryId, transaction) => {
  const deckInfo = {
    user_id: userId,
    name: name,
    description: description,
    category_id: categoryId,
    is_published: true,
    question_language: questionLang,
    answer_language: answerLang,
  };

  await convertAndInsertJsonToDb(filePath, deckInfo, transaction);
};

module.exports = seedAllData;