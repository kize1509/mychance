const { pool } = require("../utils/utils.db.pool");
const finalQuery =
  "SELECT * FROM mvp_mychance.video_data WHERE id NOT IN (?) LIMIT 10";

async function getMultiplePaths(fixedNumber, userId) {
  return new Promise((reject, resolve) => {
    pool.query(
      `SELECT video from mvp_mychance.user_watched WHERE user = '${userId}'`,
      async function (error, result) {
        if (error) {
          return false;
        } else {
          let len = result.length;
          let pathList = [];
          for (let index = 0; index < len; index++) {
            const element = result[index].video;
            pathList.push(element);
          }

          console.log("====================================");
          console.log(pathList);
          console.log("====================================");
          operationResult = pool.query(
            finalQuery,
            [pathList],
            function (error, res) {
              if (error) {
                reject(error);
              } else {
                returnList = [];
                console.log("====================================");
                for (let index = 0; index < res.length; index++) {
                  const element = res[index];
                  console.log(
                    index +
                      1 +
                      ". na ucitavanju: " +
                      element.path +
                      "\n" +
                      "id: " +
                      element.id
                  );
                  returnList.push(element.path);
                }

                console.log("====================================");
                resolve(returnList);
              }
            }
          );
        }
      }
    );
  });
}
module.exports = { getMultiplePaths };
