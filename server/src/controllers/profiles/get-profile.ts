import { supabase } from "../../services/supabase.js";
import camelcaseKeys from "camelcase-keys";

export const getProfile = async (userId: string) => {
  try {
    const { data, error } = await supabase
      .from("profiles")
      .select("*")
      .eq("user_id", userId)
      .single();

    if (error) {
      throw error;
    }

    return camelcaseKeys(data, { deep: true });
  } catch (error) {
    throw camelcaseKeys(error as Record<string, unknown>, { deep: true });
  }
};
