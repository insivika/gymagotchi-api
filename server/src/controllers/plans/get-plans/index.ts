import { supabase } from "@/services/supabase.js";

export const getPlans = async ({ userId }: { userId: string }) => {
  try {
    const { data: plans, error: plansError } = await supabase
      .from("profile_plans")
      .select(
        `
        *,
        plans (
          *,
          plan_sets (
            *,
            sets (
              *,
              exercises (
                *
              )
            )
          )
        )
      `
      )
      .eq("user_id", userId);

    if (plansError) {
      console.log("Error fetching plans ===>", plansError);
      throw plansError;
    }

    return plans;
  } catch (error) {
    throw error;
  }
};
