import "dotenv/config";

import express, { Express, Request, Response } from "express";
import plansRouter from "./api/plans/index.js";

const app: Express = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());


// Basic route
app.get("/", (req: Request, res: Response) => {
  res.send("Gymagotchi API");
});



app.use("/plans", plansRouter);

// Start server
app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
