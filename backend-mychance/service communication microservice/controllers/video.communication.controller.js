const axios = require("axios");
const apiEndpoint = ""; // django api endpoint
const errMessage = { message: "file not uploaded" };
const internalFault = { message: "internal fault" };
async function Post(req, res) {
  if (!req.file) {
    res.status(400).send(errMessage);
  }
  id = req.query.id;
  const videoBuffer = req.file.buffer;
  try {
    const response = await axios.post(apiEndpoint, videoBuffer, {
      headers: {
        "Content-Type": "application/octet-stream",
      },
    });
    res.status(response.status).send(response.message);
  } catch (error) {
    res.status(500).send(internalFault);
  }
}

module.exports = { Post };
