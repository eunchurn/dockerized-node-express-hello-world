import express from "express";
import os from "os";

const app = express();

app.use(express.json());

const port = process.env.PORT || "8080";

app.get("/", (req, res) => {
  res.send(
    `Dockerized nodejs express hello world, I'm run on ${os.hostname()}, Environment MY_KEY=${
      process.env.MY_KEY
    }`,
  );
});

app.listen(port, () => {
  console.log(`🎉 Server running on http://localhost:${port}`);
});
