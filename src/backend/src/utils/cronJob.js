const cron = require('node-cron');
const axios = require('axios');

const initCronJob = () => {
    const serverUrl = 'https://fatcat-flashcard-app.onrender.com/v1/api/';
    // Schedule task to run every 5 minutes
    cron.schedule('*/5 * * * *', async () => {
        try {
            const response = await axios.get(serverUrl);
            console.log('Ping server response:', response.data);
        } catch (error) {
            console.error('Error pinging server:', error.message);
        }
    });
    
    console.log('Cron job initialized - Server will be pinged every 5 minutes');
};

module.exports = { initCronJob };