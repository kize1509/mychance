const { getMultiplePaths } = require("../repository/get.paths");
async function form() {
  try {
    const result = await getMultiplePaths(10, 1);
    console.log("====================================");
    console.log("service: " + result);
    console.log("====================================");
    return new Promise((reject, resolve) => {
      if (result) {
        resolve(result);
      } else {
        reject(false);
      }
    });
  } catch (error) {
    return error;
  }
}

module.exports = { form };
