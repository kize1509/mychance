const app = require("express")();
const server = require("http").createServer(app);
const io = require("socket.io")(server);
const PORT = 3000;
const routerVideo = require("./communication.router");

io.on("connection", (socket) => {
  console.log("connected");
});
io.on("disconnect", () => {
  console.log("disconnected");
});
app.use(express.json());

app.use("/upload", routerVideo);

server.listen(PORT, () => {
  console.log("listening");
});
