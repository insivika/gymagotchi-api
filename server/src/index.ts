import "dotenv/config";
import express, { Express, Request, Response, Router } from "express";
import plansRouter from "./api/plans/index.js";
import authRouter from "./api/auth/index.js";
import profilesRouter from "./api/profiles/index.js";
const app: Express = express();
const port = process.env.PORT || 3000;

// Create API router
const apiRouter = Router();

// Middleware
app.use(express.json());

app.get("/", (req: Request, res: Response) => {
  res.send("Gymagotchi API");
});

// Define routes on the API router
apiRouter.get("/hello", (req: Request, res: Response) => {
  res.send("Hello World");
});
apiRouter.use("/auth", authRouter);
apiRouter.use("/plans", plansRouter);
apiRouter.use("/profiles", profilesRouter);
// Mount all API routes under /api
app.use("/api", apiRouter);

// Start server
app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
