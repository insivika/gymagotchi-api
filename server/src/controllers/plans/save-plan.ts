import { supabase } from "../../services/supabase.js";
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

    console.log("planId ===>", planId);
    console.log("userId ===>", userId);

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
      console.log("day ===>", day);

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
          console.log("exercise ===>", exercise);
          throw setError;
        }
      });
    });

    return planId;
  } catch (error) {
    throw error;
  }
};
// {
//     "name": "Three-Day Fat Loss Workout Plan",
//     "plan": [
//         {
//             "day": 1,
//             "groupName": "Full Body Strength and Cardio",
//             "exercises": [
//                 {
//                     "id": "a03496cd-75c3-410e-8563-8f07734a3805",
//                     "name": "Deadlift",
//                     "sets": 3,
//                     "reps": 10,
//                     "rest": 60
//                 },
//                 {
//                     "id": "7900b977-0b5b-4cb9-81aa-44baaaf0834b",
//                     "name": "Mountain Climbers",
//                     "sets": 3,
//                     "reps": 15,
//                     "rest": 30
//                 },
//                 {
//                     "id": "c64336af-9390-4e0d-9273-9eb7f7bbbb51",
//                     "name": "Push-Up Against Wall",
//                     "sets": 3,
//                     "reps": 15,
//                     "rest": 30
//                 },
//                 {
//                     "id": "39a661f1-eddb-40e4-b7dc-beecc35c9d57",
//                     "name": "Bench Press",
//                     "sets": 3,
//                     "reps": 10,
//                     "rest": 60
//                 }
//             ]
//         },
//         {
//             "day": 2,
//             "groupName": "Upper Body and Core Conditioning",
//             "exercises": [
//                 {
//                     "id": "e560d569-54d0-42d4-a161-6e45ed0e0e7f",
//                     "name": "Lat Pulldown",
//                     "sets": 3,
//                     "reps": 10,
//                     "rest": 60
//                 },
//                 {
//                     "id": "e35a773c-ba01-439f-804c-2486cdc406d5",
//                     "name": "Seated Leg Curl",
//                     "sets": 3,
//                     "reps": 12,
//                     "rest": 45
//                 },
//                 {
//                     "id": "6900e785-dcbf-46de-a9ca-1e4070ccce70",
//                     "name": "Dumbbell Shrugs",
//                     "sets": 3,
//                     "reps": 12,
//                     "rest": 45
//                 },
//                 {
//                     "id": "3fd46d12-b771-463e-b4e5-43d3805d3673",
//                     "name": "Plank",
//                     "sets": 3,
//                     "reps": 30,
//                     "rest": 30
//                 }
//             ]
//         },
//         {
//             "day": 3,
//             "groupName": "Lower Body and Cardio Blast",
//             "exercises": [
//                 {
//                     "id": "c616a602-147a-4542-8538-0746241d336f",
//                     "name": "Assisted Chin-Ups",
//                     "sets": 3,
//                     "reps": 10,
//                     "rest": 60
//                 },
//                 {
//                     "id": "74e38479-a55a-401e-aaf0-8e7a0cd20cb1",
//                     "name": "Box Jump",
//                     "sets": 3,
//                     "reps": 10,
//                     "rest": 30
//                 },
//                 {
//                     "id": "95fe4881-79c2-4df1-99bb-aaff4f5fd23e",
//                     "name": "Barbell Lunge",
//                     "sets": 3,
//                     "reps": 12,
//                     "rest": 60
//                 },
//                 {
//                     "id": "e7c601f3-7c41-403f-b23a-284f332831cd",
//                     "name": "Kneeling Side Plank",
//                     "sets": 3,
//                     "reps": 30,
//                     "rest": 30
//                 }
//             ]
//         }
//     ]
// }
