// const express = require("express");
// const { routerVideo } = require("./videoDistribution.router");
// const app = express();
// const server = require("http").createServer(app);
// const PORT = 80;

// app.use(express.json());

// app.use("/", routerVideo);

// server.listen(PORT, () => {
//   console.log("====================================");
//   console.log("VIDEO DISTRIBUTION SERVICE IS UP ON PORT " + PORT + "...");
//   console.log("====================================");
// });

const express = require("express");
const { routerVideo } = require("./videoDistribution.router");
const app = express();
const server = require("http").createServer(app);

const PORT = 80;

app.use(express.json());

app.use("/data", routerVideo);

server.listen(PORT, () => {
  console.log("LISTENING ON PORT: " + PORT + "...");
});
