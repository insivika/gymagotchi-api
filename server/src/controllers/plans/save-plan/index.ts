import { supabase } from "@/services/supabase.js";
import { eachOfSeries } from "async";

export const savePlan = async ({
  plan: planData,
  userId,
}: {
  plan: any;
  userId: string;
}) => {
  try {
    const { data: plan, error: planError } = await supabase
      .from("plans")
      .insert({
        name: planData.name,
      })
      .select()
      .single();

    if (planError) {
      console.log("Error inserting plan ===>", planError);
      throw planError;
    }
    const planId = plan.id;

    const { data: profilePlan, error: profilePlanError } = await supabase
      .from("profile_plans")
      .insert({
        user_id: userId,
        plan_id: planId,
      })
      .select()
      .single();

    if (profilePlanError) {
      console.log("Error inserting profile plan ===>", profilePlanError);
      throw profilePlanError;
    }

    //   Loop over plan and insert workout_groups
    await eachOfSeries(planData.plan, async (day: any) => {
      const { data: planSet, error: planSetError } = await supabase
        .from("plan_sets")
        .insert({
          plan_id: planId,
          day: day.day,
          name: day.setName,
        })
        .select()
        .single();

      if (planSetError) {
        console.log("Error inserting plan sets ===>", planSetError);
        throw planSetError;
      }

      //   Loop over exercises and insert workout_group_exercises

      await eachOfSeries(day.exercises, async (exercise: any) => {
        const { data: set, error: setError } = await supabase
          .from("sets")
          .insert({
            plan_set_id: planSet.id,
            exercise_id: exercise.id,
            set_count: exercise.sets,
            rep_count_goal: exercise.reps,
            rest: exercise.rest,
          })
          .select()
          .single();

        if (setError) {
          console.log("Error inserting set ===>", setError);
          throw setError;
        }
      });
    });

    return planId;
  } catch (error) {
    throw error;
  }
};
