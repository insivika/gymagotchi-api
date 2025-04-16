import { Router } from "express";
import { generatePlan, savePlan } from "@/controllers/index.js";
import { jwtAuth } from "@/services/supabase.js";
const router = Router();

router.post("/generate", async (req, res) => {
  try {
    const response = await generatePlan(req.body);
    res.status(200).send(response);
  } catch (error) {
    res.status(500).send(error);
  }
});

router.post("/save", jwtAuth, async (req, res) => {
  try {
    const userId = req.user.id;

    const response = await savePlan({ plan: req.body, userId });
    res.status(200).send(response);
  } catch (error) {
    res.status(500).send(error);
  }
});

export default router;
