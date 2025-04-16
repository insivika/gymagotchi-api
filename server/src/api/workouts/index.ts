import { Router } from "express";
import { jwtAuth } from "@/services/supabase.js";
import { createWorkout } from "@/controllers/index.js";
const router = Router();

router.post("/", jwtAuth, async (req, res) => {
  try {
    const userId = req.user.id;

    const workout = await createWorkout(userId);
    res.status(200).send(workout);
  } catch (error) {
    res.status(500).send(error);
  }
});

export default router;
