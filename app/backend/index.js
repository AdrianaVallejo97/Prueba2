const http = require("http");

const server = http.createServer((req, res) => {
  if (req.url === "/api") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ message: "Hola desde el Backend 🚀" }));
  }
});

server.listen(3000);
