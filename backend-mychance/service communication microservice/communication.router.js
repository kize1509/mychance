const express = require("express");
const videoController = require("./controllers/video.communication.controller");
const routerVideo = express.Router();

routerVideo.post("/video", upload.single("video"), videoController.Post);

module.exports = { routerVideo };
