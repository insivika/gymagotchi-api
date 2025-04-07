alter table "public"."beasts" alter column "beast_level_id" drop default;

alter table "public"."beasts" alter column "beast_level_id" drop not null;

alter table "public"."plans" alter column "user_id" drop default;

alter table "public"."profiles" add column "avatar_url" text;

alter table "public"."profiles" add column "email" text;

alter table "public"."profiles" add column "stripe_customer_id" text;

alter table "public"."profiles" alter column "beast_id" drop default;

alter table "public"."sets" alter column "workout_id" drop default;

alter table "public"."workout_group" alter column "plan_id" drop default;

alter table "public"."workout_templates" alter column "exercise_id" drop default;

alter table "public"."workout_templates" alter column "workout_group_id" drop default;

alter table "public"."workouts" alter column "user_id" drop default;

alter table "public"."workouts" alter column "workout_template_id" drop default;

alter table "public"."workout_templates" add constraint "workout_templates_exercise_id_fkey" FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."workout_templates" validate constraint "workout_templates_exercise_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.create_profile_for_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$ 
begin   
    insert into public.profiles (user_id, email, avatar_url)   
    values (     
        new.id ,      
        new.raw_user_meta_data->>'email',
        new.raw_user_meta_data->>'avatar_url'
    );   
    return new; 
end; 
$function$
;


