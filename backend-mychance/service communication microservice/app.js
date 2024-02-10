const app = require("express")();
const server = require("http").createServer(app);
const io = require("socket.io")(server);
const PORT = 51001;
const routerVideo = require("./communication.router");

app.use(express.json());

app.use("/", routerVideo);

server.listen(PORT, () => {
  console.log("listening");
});
