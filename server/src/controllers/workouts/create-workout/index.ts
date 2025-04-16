import { supabase } from "@/services/supabase.js";
import camelcaseKeys from "camelcase-keys";

export const createWorkout = async ({
  userId,
  planSetId,
}: {
  userId: string;
  planSetId: string;
}) => {
  try {
    // Find all the sets with the planSetId
    const { data: setsData, error: setsError } = await supabase
      .from("sets")
      .select("*")
      .eq("plan_set_id", planSetId);

    if (!setsData) {
      throw new Error("No sets found");
    }

    if (setsError) {
      console.error("Error fetching sets", setsError);
      throw setsError;
    }

    const sets = camelcaseKeys(setsData, { deep: true });

    const { data, error } = await supabase
      .from("workouts")
      .insert({
        user_id: userId,
        workout_template: sets,
      })
      .select()
      .single();

    if (error) {
      console.error("Error creating workout", error);
      throw error;
    }

    return camelcaseKeys(data, { deep: true });
  } catch (error) {
    throw error;
  }
};
