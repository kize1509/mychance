const { pool } = require("../utilities/db.pool");

async function saveVideo(videoPath, userId) {
  pool.query(
    `INSERT INTO mvp_mychance.video_data (path) values ('${videoPath}')`,
    async function (err, result) {
      if (err) {
        console.log(err);
        return false;
      } else {
        let finalRes = await findSavedVideo(videoPath, userId);
        return finalRes;
      }
    }
  );

  // pool.releaseConnection();
}

async function findSavedVideo(videoPath, userId) {
  console.log("====================================");
  console.log("FIND SAVED VIDEO\nname to search by: " + videoPath);
  pool.query(
    `SELECT id from mvp_mychance.video_data WHERE path = '${videoPath}'`,
    async function (err, result) {
      if (err) return false;
      console.log("res: " + result[0].id);
      videoId = result[0].id;
      console.log("====================================");
      res = await setWatched(userId, videoId);
      return res;
    }
  );
}

async function setWatched(userId, videoId) {
  console.log("====================================");
  console.log(
    "SET WATCHED\nid kosrisnika: " + userId + "\nid videa: " + videoId
  );
  console.log("====================================");
  pool.query(
    `INSERT INTO mvp_mychance.user_watched (user, video) VALUES ('${userId}', '${videoId}')`,
    function (err, result) {
      if (err) return false;
      return true;
    }
  );
}

module.exports = { saveVideo, findSavedVideo, setWatched };
