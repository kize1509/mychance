const controllerVideo = require("./controllers/video.controller");
const express = require("express");
const routerVideo = express.Router();
const multer = require("multer");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "data/");
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  },
});

const upload = multer({ storage: storage });

routerVideo.post("/single", upload.single("video"), controllerVideo.Post);
routerVideo.get("/single", controllerVideo.Get);

module.exports = { routerVideo };
