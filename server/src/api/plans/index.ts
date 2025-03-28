import { Router } from "express";
import supabase from "../../services/supabase.js";
const router = Router();

router.post("/", async (req, res) => {
  try {
    const { name, description } = req.body;
    const { data, error } = await supabase
      .from("plans")
      .insert({ name, description });
    res.send(data);
  } catch (error) {
    res.status(500).send(error);
  }
});

export default router;
