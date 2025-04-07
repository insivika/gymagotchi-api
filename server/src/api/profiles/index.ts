import { Router } from "express";
import { getProfile } from "../../controllers/index.js";
import { jwtAuth } from "../../services/supabase.js";

const router = Router();

router.get("/", jwtAuth, async (req, res) => {
  try {
    const userId = req.user.id;

    const profile = await getProfile(userId);
    res.status(200).send(profile);
  } catch (error) {
    res.status(500).send(error);
  }
});

export default router;
