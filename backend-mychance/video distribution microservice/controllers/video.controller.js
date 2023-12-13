const service = require("../service/video.manipulation.js");

const taskComplete = {
  status: "done",
  operation: "",
};

const taskFailed = {
  status: "failed",
  operation: "",
};

async function Get(req, res) {
  res.status(200).send("Up...");
}

async function Post(req, res) {
  const name = req.file.originalname;
  const userId = req.query.id;
  const result = await service.Convert(name, userId);
  if (result) {
    console.log("EXPECT POSITIVE");
    taskComplete.operation = "video conversion + saving";
    res.status(200).send(taskComplete);
  } else {
    res.status(500).send(taskFailed);
  }
}

module.exports = { Post, Get };
