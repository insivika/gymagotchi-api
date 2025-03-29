import { supabase } from "../../services/supabase.js";
import camelcaseKeys from "camelcase-keys";

export const signIn = async (values: { email: string; password: string }) => {
  try {
    const { email, password } = values;
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (error) {
      throw error;
    }
    return camelcaseKeys(data, { deep: true });
  } catch (error) {
    throw camelcaseKeys(error, { deep: true });
  }
};
