import { supabase } from "@/services/supabase.js";
export const createWorkout = async (userId: string) => {
  try {
    const { data, error } = await supabase.from("workouts").insert({
      user_id: userId,
    });
  } catch (error) {
    throw error;
  }
};
