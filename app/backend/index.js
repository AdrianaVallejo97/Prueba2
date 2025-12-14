const http = require("http");

const server = http.createServer((req, res) => {
  res.end("Hola Mundo desde el BACKEND ");
});

server.listen(3000);
