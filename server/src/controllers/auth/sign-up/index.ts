import { supabase } from "@/services/supabase.js";
import camelcaseKeys from "camelcase-keys";

export const signUp = async (values: { email: string; password: string }) => {
  try {
    const { email, password } = values;
    const { data, error } = await supabase.auth.signUp({ email, password });
    if (error) {
      throw error;
    }
    return camelcaseKeys(data, { deep: true });
  } catch (error) {
    if (error instanceof Error && error.message === "user_already_exists") {
      throw { error: "User already exists" };
    }
    throw camelcaseKeys(error as Record<string, unknown>, { deep: true });
  }
};
