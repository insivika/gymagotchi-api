import { signUp, signIn } from "../../controllers/auth/index.js";
import { Router } from "express";

const router = Router();

router.use("/sign-up", async (req, res) => {
  try {
    const data = await signUp(req.body);
    res.send(data);
  } catch (error) {
    res.status(500).send(error);
  }
});

router.use("/sign-in", async (req, res) => {
  try {
    const data = await signIn(req.body);
    res.send(data);
  } catch (error) {
    res.status(500).send(error);
  }
});

export default router;
