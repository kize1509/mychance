const express = require("express");
const { hlsRouter } = require("./streaming.router");
// const { existsSync, createReadStream, readFileSync } = require("fs");
// const path = require("path");

const app = express();
const port = 8000; // Change this to the desired port number
// Path to the directory containing segments
app.use("/stream", hlsRouter);
// app.get("/stream.m3u8", (req, res) => {
//   const playlistPath = path.join(
//     __dirname,
//     "../",
//     "hls",
//     "fea54ce18bd0401bad061c35c778887e",
//     "fea54ce18bd0401bad061c35c778887e.m3u8"
//   );
//   const playlistContent = readFileSync(playlistPath, "utf-8");
//   res.setHeader("Content-Type", "application/vnd.apple.mpegurl");
//   res.send(playlistContent);
// });

// app.get("/:segmentName", (req, res) => {
//   const segmentDirectory = path.join(
//     __dirname,
//     "../",
//     "hls",
//     "fea54ce18bd0401bad061c35c778887e"
//   );
//   const segmentName = req.params.segmentName;
//   const segmentPath = path.join(segmentDirectory, `${segmentName}`);
//   console.log("====================================");
//   console.log(segmentPath);
//   console.log("====================================");

//   if (existsSync(segmentPath)) {
//     res.setHeader("Content-Type", "video/MP2T");
//     createReadStream(segmentPath).pipe(res);
//   } else {
//     res.status(404).send("Segment not found");
//   }
// });

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
