const http = require("http");

const server = http.createServer((req, res) => {
  if (req.url === "/api") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ message: "Hola desde el Backend 🚀" }));
  } else {
    res.writeHead(404);
    res.end();
  }
});

server.listen(3000);
