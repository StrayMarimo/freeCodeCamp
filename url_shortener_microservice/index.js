require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();
let urlDatabase = {};

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/public", express.static(`${process.cwd()}/public`));

app.get("/", function (req, res) {
  res.sendFile(process.cwd() + "/views/index.html");
});

const dns = require("dns");
const url = require("url");

app.post("/api/shorturl", function (req, res) {
  const original_url = req.body.url;
  const hostname = url.parse(original_url).hostname;

  dns.lookup(hostname, (err) => {
    if (err) {
      res.status(400).json({ error: "invalid url" });
    } else {
      const short_url = Object.keys(urlDatabase).length.toString();
      urlDatabase[short_url] = original_url;
      res.json({ original_url, short_url });
    }
  });
});

app.get("/api/shorturl/:shortUrl", function (req, res) {
  const short_url = req.params.shortUrl;
  const original_url = urlDatabase[short_url];

  if (original_url) {
    res.redirect(original_url);
  } else {
    res.status(404).json({ error: "Short URL not found" });
  }
});

app.listen(port, function () {
  console.log(`Listening on port ${port}`);
});
