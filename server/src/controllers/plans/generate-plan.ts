import { supabase } from "../../services/supabase.js";
import { createResponse } from "../../services/openai.js";

export const generatePlan = async ({
  equipmentAccess,
  timesPerWeek,
  experienceLevel,
  minutesPerWorkout,
  goal,
}: {
  equipmentAccess: string;
  timesPerWeek: number;
  experienceLevel: string;
  minutesPerWorkout: number;
  goal: string;
}) => {
  const { data: exercises, error: exercisesError } = await supabase
    .from("exercises")
    .select("*");

  if (exercisesError) {
    throw exercisesError;
  }

  const exercisesString = exercises
    .map((exercise) => `${exercise.id} - ${exercise.name}`)
    .join("\n");

  const prompt = `
   Generate a workout plan based on the following information:
    - Equipment Access: ${equipmentAccess}, 
    - Times Per Week: ${timesPerWeek}, 
    - Experience Level: ${experienceLevel}, 
    - Minutes Per Workout: ${minutesPerWorkout}, 
    - Goal: ${goal}.

  You must choose from the following list of exercises:
  ${exercisesString}

  Consider that each exercise takes 10 - 15 minutes to complete.

  If the goal is to build muscle, you must include a mix of strength and hypertrophy exercises.

  If the goal is to lose weight, you must include a mix of cardio and strength exercises.

  You must return a JSON object with the following format:
  {
    "name": [Generate a name for the plan],
    "plan": [
      {
        "day": 1,
        "setName": [Generate a name for the group of exercises, eg "Chest Day"],
        "exercises": [{
          "id": [Exercise ID (you must use the exercise id from the list of exercises)],
          "name": [Exercise Name (you must use the exercise name from the list of exercises)],
          "sets": 3,
          "reps": 10,
          "rest": 10,
       
        },
        {
          "id": [Exercise ID (you must use the exercise id from the list of exercises)],
          "name": [Exercise Name (you must use the exercise name from the list of exercises)],
          "sets": [Number of sets],
          "reps": [Number of reps],
          "rest": [Number of seconds to rest between sets],
        },
        ...
      ],
      },
      {
        "day": 2,
        "setName": [Generate a name for the group of exercises, eg "Back Day"],
        "exercises": [{
          "id": [Exercise ID (you must use the exercise id from the list of exercises)],
          "name": [Exercise Name (you must use the exercise name from the list of exercises)],
          "sets": [Number of sets],
          "reps": [Number of reps],
          "rest": [Number of seconds to rest between sets],
        },
        ...
      ]
      },
      ...
    ]
  }
  `;
  const response = await createResponse({ prompt });
  return JSON.parse(response);
};
