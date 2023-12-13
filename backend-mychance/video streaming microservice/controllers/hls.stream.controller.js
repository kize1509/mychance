const { existsSync, createReadStream, readFileSync } = require("fs");
const path = require("path");
const { pool } = require("../utils/utils.db.pool");
const { form } = require("../services/playlist.formation");
const { taskDone, taskFailed } = require("../utils/response.forms");

function getManifest(req, res) {
  const name = req.query.name;
  const playlistPath = path.join(__dirname, "../", "hls", name, name + ".m3u8");
  const playlistContent = readFileSync(playlistPath, "utf-8");
  res.setHeader("Content-Type", "application/vnd.apple.mpegurl");
  res.send(playlistContent);
}

function getSegment(req, res) {
  const segmentDirectory = path.join(
    __dirname,
    "../",
    "hls",
    "fea54ce18bd0401bad061c35c778887e"
  );
  const segmentName = req.params.segmentName;
  const segmentPath = path.join(segmentDirectory, `${segmentName}`);
  console.log("====================================");
  console.log(segmentPath);
  console.log("====================================");

  if (existsSync(segmentPath)) {
    res.setHeader("Content-Type", "video/MP2T");
    createReadStream(segmentPath).pipe(res);
  } else {
    res.status(404).send("Segment not found");
  }
}

async function getPlaylist(req, res) {
  try {
    const result = await form();

    res.status(200).send(result);
  } catch (error) {
    res.status(500).send(taskFailed);
  }
}

module.exports = { getManifest, getSegment, getPlaylist };
