const app = require("./src/app");
const { initCronJob } = require("./src/utils/cronJob.js");
const PORT = process.env.PORT || 3056;

const server = app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  initCronJob();
});

process.on("SIGINT", () => {
  server.close(() => {
    console.log("Server is shutting down");
  });
});
