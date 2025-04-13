import { supabase } from "../../services/supabase.js";
import { Request, Response } from "express";
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
    .map((exercise) => `${exercise.name} - ${exercise.description}`)
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
        "exercises": [{
          "name": "Exercise 1",
          "sets": 3,
          "reps": 10,
          "rest": 10,
       
        },
        {
          "name": "Exercise 2",
          "sets": 3,
          "reps": 10,
          "rest": 10,
        },
        ...
      ],
      },
      {
        "day": 2,
        "exercises": [{
          "name": "Exercise 1",
          "sets": 3,
          "reps": 10,
          "rest": 10,
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
