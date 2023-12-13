const path = require("path");
const crypto = require("crypto");
const ffmpeg = require("ffmpeg");
const { mkdirSync, existsSync, writeFile } = require("fs");
const { exec } = require("child_process");

const {
  saveVideo,
  setWatched,
  findSavedVideo,
} = require("../repository/video.repository");
const { log } = require("console");
const { rejects } = require("assert");

// const positive = {
//   message: "saved",
// };

// const negative = {
//   message: "error while saving",
// };

async function Save(finalDest, userId) {
  return new Promise((resolve, reject) => {
    let sResult = saveVideo(finalDest, userId);
    if (sResult) resolve(true);
    else reject(false);
  });
}

async function Convert(name, userId) {
  const outDirPath = path.join(__dirname, "../", "data", name);
  let flag = await excecuteConversion(outDirPath, name, userId);
  console.log("====================================");
  console.log(flag);
  console.log("====================================");
  return flag;
}

async function excecuteConversion(inputPath, name, userId) {
  const fileName = name.split(".")[0];
  const outputFileName = fileName + ".m3u8";
  const outputDirectory = path.join(__dirname, "../", "../", "hls", fileName);

  if (!existsSync(outputDirectory)) {
    mkdirSync(outputDirectory);
  }

  var finalDest = path.join(outputDirectory, outputFileName);

  const ffmpegCommand = `ffmpeg -i "${inputPath}" -codec:a copy -start_number 0 -hls_time 10 -hls_list_size 0 -f hls "${finalDest}"`;
  try {
    await executeCommand(ffmpegCommand);
    // const { error, stdout, stderr } = exec(ffmpegCommand);

    // if (error) {
    //   console.error("Error:", error);
    //   return false;
    // } else {
    //   console.log("Conversion finished.");
    //   console.log("-----------------------");
    try {
      const saveResult = await Save(name, userId);
      return saveResult;
    } catch (error) {
      console.log("====================================");
      console.log("error: " + error);
      console.log("====================================");
    }
    //}
  } catch (error) {
    console.error("Error:", error);
    return false;
  }
}

function executeCommand(ffmpegCommand) {
  return new Promise((resolve, reject) => {
    const { error, stdout, stderr } = exec(ffmpegCommand);
    if (error) {
      console.error("Error:", error);
      reject(error);
    } else {
      console.log("====================================");
      console.log("CONVERSION FINISHED");
      console.log("====================================");
      resolve();
    }
  });
}

module.exports = { Convert };
