import { OpenAI } from "openai";

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export const createResponse = async ({ prompt }: { prompt: string }) => {
  const response = await client.responses.create({
    model: "gpt-4o",
    input: prompt,
    temperature: 1,
    text: {
      format: {
        type: "json_object", // This enables JSON mode
      },
    },
  });
  return response.output_text;
};
