import { Router } from "express";
import { generatePlan } from "../../controllers/index.js";

const router = Router();

router.post("/generate", async (req, res) => {
  try {
    const response = await generatePlan(req.body);
    res.status(200).send(response);
  } catch (error) {
    res.status(500).send(error);
  }
});

export default router;
