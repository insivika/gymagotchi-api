import { supabase } from "../../services/supabase.js";
import { Request, Response } from "express";

export const createPlan = async (req: Request, res: Response) => {
  const { name, description } = req.body;
  const { data, error } = await supabase
    .from("plans")
    .insert({ name, description });
  res.send(data);
};
