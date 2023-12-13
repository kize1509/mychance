const express = require("express");
const hlsRouter = express.Router();
const streamController = require("./controllers/hls.stream.controller");

hlsRouter.get("/stream.m3u8", streamController.getManifest());
hlsRouter.get("/:segmentName", streamController.getSegment());
hlsRouter.get("/playlist", streamController.getPlaylist);
module.exports = { hlsRouter };
