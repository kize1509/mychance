const axios = require("axios");
const apiEndpoint = "localhost:port/serviceName/"; // django api endpoint
const errMessage = { message: "file not uploaded" };
const internalFault = { message: "internal fault" };

async function Post(req, res) {
  ///checking if the file got uploaded
  if (!req.file) {
    res.status(400).send(errMessage);
  }

  //taking the id from route query

  id = req.query.id;
  const videoBuffer = req.file.buffer;

  //sending the uploaded file to Django service
  try {
    //waiting for the response from Django service
    const response = await axios.post(apiEndpoint, videoBuffer, {
      headers: {
        "Content-Type": "application/octet-stream",
      },
    });

    //collecting the DJango service response status and sending it back to the client
    res.status(response.status).send(response.message);
  } catch (error) {
    //error happened somwhere in the process
    res.status(500).send(internalFault);
  }
}

module.exports = { Post };
