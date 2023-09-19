import supertest from "supertest";

const port = process.env.PORT || "8080";

const server = supertest.agent(`http://localhost:${port}`);

describe("Root test", () => {
  it("should response main text", (done) => {
    server
      .get("/")
      .expect("Content-type", /text/)
      .expect(200)
      .end((_err, _res) => {
        done();
      });
  });
});
