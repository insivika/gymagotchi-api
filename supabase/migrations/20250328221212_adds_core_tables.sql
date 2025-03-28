create table "public"."beast_levels" (
    "uuid" uuid not null default gen_random_uuid(),
    "label" text not null,
    "beast_sprite_x" smallint,
    "beast_sprite_y" smallint
);


alter table "public"."beast_levels" enable row level security;

create table "public"."beasts" (
    "id" uuid not null default gen_random_uuid(),
    "beast_level_id" uuid not null default gen_random_uuid(),
    "beast_sprite_url" text
);


alter table "public"."beasts" enable row level security;

create table "public"."exercises" (
    "id" uuid not null default gen_random_uuid(),
    "muscle_group_id" uuid default gen_random_uuid(),
    "name" text,
    "points" smallint,
    "instructions" text,
    "image_url" text
);


alter table "public"."exercises" enable row level security;

create table "public"."muscle_groups" (
    "id" uuid not null default gen_random_uuid(),
    "label" text not null,
    "image_url" text
);


alter table "public"."muscle_groups" enable row level security;

create table "public"."plans" (
    "id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "user_id" uuid default gen_random_uuid(),
    "name" text
);


alter table "public"."plans" enable row level security;

create table "public"."profiles" (
    "user_id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "beast_id" uuid default gen_random_uuid(),
    "beast_score" smallint
);


alter table "public"."profiles" enable row level security;

create table "public"."sets" (
    "id" uuid not null default gen_random_uuid(),
    "workout_id" uuid not null default gen_random_uuid(),
    "rest_time_milliseconds" integer
);


alter table "public"."sets" enable row level security;

create table "public"."workout_group" (
    "id" uuid not null default gen_random_uuid(),
    "plan_id" uuid not null default gen_random_uuid(),
    "name" text
);


alter table "public"."workout_group" enable row level security;

create table "public"."workout_templates" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "exercise_id" uuid default gen_random_uuid(),
    "workout_group_id" uuid default gen_random_uuid(),
    "set_count" smallint,
    "weight_count" smallint
);


alter table "public"."workout_templates" enable row level security;

create table "public"."workouts" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "workout_template_id" uuid default gen_random_uuid(),
    "user_id" uuid default gen_random_uuid(),
    "is_completed" boolean,
    "workout_score" smallint
);


alter table "public"."workouts" enable row level security;

CREATE UNIQUE INDEX beast_levels_pkey ON public.beast_levels USING btree (uuid);

CREATE UNIQUE INDEX beasts_pkey ON public.beasts USING btree (id);

CREATE UNIQUE INDEX exercises_pkey ON public.exercises USING btree (id);

CREATE UNIQUE INDEX muscle_groups_pkey ON public.muscle_groups USING btree (id);

CREATE UNIQUE INDEX plans_pkey ON public.plans USING btree (id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (user_id);

CREATE UNIQUE INDEX sets_pkey ON public.sets USING btree (id);

CREATE UNIQUE INDEX workout_group_pkey ON public.workout_group USING btree (id);

CREATE UNIQUE INDEX workout_templates_pkey ON public.workout_templates USING btree (id);

CREATE UNIQUE INDEX workouts_pkey ON public.workouts USING btree (id);

alter table "public"."beast_levels" add constraint "beast_levels_pkey" PRIMARY KEY using index "beast_levels_pkey";

alter table "public"."beasts" add constraint "beasts_pkey" PRIMARY KEY using index "beasts_pkey";

alter table "public"."exercises" add constraint "exercises_pkey" PRIMARY KEY using index "exercises_pkey";

alter table "public"."muscle_groups" add constraint "muscle_groups_pkey" PRIMARY KEY using index "muscle_groups_pkey";

alter table "public"."plans" add constraint "plans_pkey" PRIMARY KEY using index "plans_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."sets" add constraint "sets_pkey" PRIMARY KEY using index "sets_pkey";

alter table "public"."workout_group" add constraint "workout_group_pkey" PRIMARY KEY using index "workout_group_pkey";

alter table "public"."workout_templates" add constraint "workout_templates_pkey" PRIMARY KEY using index "workout_templates_pkey";

alter table "public"."workouts" add constraint "workouts_pkey" PRIMARY KEY using index "workouts_pkey";

alter table "public"."beasts" add constraint "beasts_beast_level_id_fkey" FOREIGN KEY (beast_level_id) REFERENCES beast_levels(uuid) not valid;

alter table "public"."beasts" validate constraint "beasts_beast_level_id_fkey";

alter table "public"."exercises" add constraint "exercises_muscle_group_id_fkey" FOREIGN KEY (muscle_group_id) REFERENCES muscle_groups(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."exercises" validate constraint "exercises_muscle_group_id_fkey";

alter table "public"."plans" add constraint "plans_id_fkey" FOREIGN KEY (id) REFERENCES profiles(user_id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."plans" validate constraint "plans_id_fkey";

alter table "public"."profiles" add constraint "profiles_beast_id_fkey" FOREIGN KEY (beast_id) REFERENCES beasts(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_beast_id_fkey";

alter table "public"."profiles" add constraint "profiles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_user_id_fkey";

alter table "public"."sets" add constraint "sets_workout_id_fkey" FOREIGN KEY (workout_id) REFERENCES workouts(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."sets" validate constraint "sets_workout_id_fkey";

alter table "public"."workout_group" add constraint "workout_group_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES plans(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."workout_group" validate constraint "workout_group_plan_id_fkey";

alter table "public"."workout_templates" add constraint "workout_templates_workout_group_id_fkey" FOREIGN KEY (workout_group_id) REFERENCES workout_group(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."workout_templates" validate constraint "workout_templates_workout_group_id_fkey";

alter table "public"."workouts" add constraint "workouts_id_fkey" FOREIGN KEY (id) REFERENCES profiles(user_id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."workouts" validate constraint "workouts_id_fkey";

grant delete on table "public"."beast_levels" to "anon";

grant insert on table "public"."beast_levels" to "anon";

grant references on table "public"."beast_levels" to "anon";

grant select on table "public"."beast_levels" to "anon";

grant trigger on table "public"."beast_levels" to "anon";

grant truncate on table "public"."beast_levels" to "anon";

grant update on table "public"."beast_levels" to "anon";

grant delete on table "public"."beast_levels" to "authenticated";

grant insert on table "public"."beast_levels" to "authenticated";

grant references on table "public"."beast_levels" to "authenticated";

grant select on table "public"."beast_levels" to "authenticated";

grant trigger on table "public"."beast_levels" to "authenticated";

grant truncate on table "public"."beast_levels" to "authenticated";

grant update on table "public"."beast_levels" to "authenticated";

grant delete on table "public"."beast_levels" to "service_role";

grant insert on table "public"."beast_levels" to "service_role";

grant references on table "public"."beast_levels" to "service_role";

grant select on table "public"."beast_levels" to "service_role";

grant trigger on table "public"."beast_levels" to "service_role";

grant truncate on table "public"."beast_levels" to "service_role";

grant update on table "public"."beast_levels" to "service_role";

grant delete on table "public"."beasts" to "anon";

grant insert on table "public"."beasts" to "anon";

grant references on table "public"."beasts" to "anon";

grant select on table "public"."beasts" to "anon";

grant trigger on table "public"."beasts" to "anon";

grant truncate on table "public"."beasts" to "anon";

grant update on table "public"."beasts" to "anon";

grant delete on table "public"."beasts" to "authenticated";

grant insert on table "public"."beasts" to "authenticated";

grant references on table "public"."beasts" to "authenticated";

grant select on table "public"."beasts" to "authenticated";

grant trigger on table "public"."beasts" to "authenticated";

grant truncate on table "public"."beasts" to "authenticated";

grant update on table "public"."beasts" to "authenticated";

grant delete on table "public"."beasts" to "service_role";

grant insert on table "public"."beasts" to "service_role";

grant references on table "public"."beasts" to "service_role";

grant select on table "public"."beasts" to "service_role";

grant trigger on table "public"."beasts" to "service_role";

grant truncate on table "public"."beasts" to "service_role";

grant update on table "public"."beasts" to "service_role";

grant delete on table "public"."exercises" to "anon";

grant insert on table "public"."exercises" to "anon";

grant references on table "public"."exercises" to "anon";

grant select on table "public"."exercises" to "anon";

grant trigger on table "public"."exercises" to "anon";

grant truncate on table "public"."exercises" to "anon";

grant update on table "public"."exercises" to "anon";

grant delete on table "public"."exercises" to "authenticated";

grant insert on table "public"."exercises" to "authenticated";

grant references on table "public"."exercises" to "authenticated";

grant select on table "public"."exercises" to "authenticated";

grant trigger on table "public"."exercises" to "authenticated";

grant truncate on table "public"."exercises" to "authenticated";

grant update on table "public"."exercises" to "authenticated";

grant delete on table "public"."exercises" to "service_role";

grant insert on table "public"."exercises" to "service_role";

grant references on table "public"."exercises" to "service_role";

grant select on table "public"."exercises" to "service_role";

grant trigger on table "public"."exercises" to "service_role";

grant truncate on table "public"."exercises" to "service_role";

grant update on table "public"."exercises" to "service_role";

grant delete on table "public"."muscle_groups" to "anon";

grant insert on table "public"."muscle_groups" to "anon";

grant references on table "public"."muscle_groups" to "anon";

grant select on table "public"."muscle_groups" to "anon";

grant trigger on table "public"."muscle_groups" to "anon";

grant truncate on table "public"."muscle_groups" to "anon";

grant update on table "public"."muscle_groups" to "anon";

grant delete on table "public"."muscle_groups" to "authenticated";

grant insert on table "public"."muscle_groups" to "authenticated";

grant references on table "public"."muscle_groups" to "authenticated";

grant select on table "public"."muscle_groups" to "authenticated";

grant trigger on table "public"."muscle_groups" to "authenticated";

grant truncate on table "public"."muscle_groups" to "authenticated";

grant update on table "public"."muscle_groups" to "authenticated";

grant delete on table "public"."muscle_groups" to "service_role";

grant insert on table "public"."muscle_groups" to "service_role";

grant references on table "public"."muscle_groups" to "service_role";

grant select on table "public"."muscle_groups" to "service_role";

grant trigger on table "public"."muscle_groups" to "service_role";

grant truncate on table "public"."muscle_groups" to "service_role";

grant update on table "public"."muscle_groups" to "service_role";

grant delete on table "public"."plans" to "anon";

grant insert on table "public"."plans" to "anon";

grant references on table "public"."plans" to "anon";

grant select on table "public"."plans" to "anon";

grant trigger on table "public"."plans" to "anon";

grant truncate on table "public"."plans" to "anon";

grant update on table "public"."plans" to "anon";

grant delete on table "public"."plans" to "authenticated";

grant insert on table "public"."plans" to "authenticated";

grant references on table "public"."plans" to "authenticated";

grant select on table "public"."plans" to "authenticated";

grant trigger on table "public"."plans" to "authenticated";

grant truncate on table "public"."plans" to "authenticated";

grant update on table "public"."plans" to "authenticated";

grant delete on table "public"."plans" to "service_role";

grant insert on table "public"."plans" to "service_role";

grant references on table "public"."plans" to "service_role";

grant select on table "public"."plans" to "service_role";

grant trigger on table "public"."plans" to "service_role";

grant truncate on table "public"."plans" to "service_role";

grant update on table "public"."plans" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."sets" to "anon";

grant insert on table "public"."sets" to "anon";

grant references on table "public"."sets" to "anon";

grant select on table "public"."sets" to "anon";

grant trigger on table "public"."sets" to "anon";

grant truncate on table "public"."sets" to "anon";

grant update on table "public"."sets" to "anon";

grant delete on table "public"."sets" to "authenticated";

grant insert on table "public"."sets" to "authenticated";

grant references on table "public"."sets" to "authenticated";

grant select on table "public"."sets" to "authenticated";

grant trigger on table "public"."sets" to "authenticated";

grant truncate on table "public"."sets" to "authenticated";

grant update on table "public"."sets" to "authenticated";

grant delete on table "public"."sets" to "service_role";

grant insert on table "public"."sets" to "service_role";

grant references on table "public"."sets" to "service_role";

grant select on table "public"."sets" to "service_role";

grant trigger on table "public"."sets" to "service_role";

grant truncate on table "public"."sets" to "service_role";

grant update on table "public"."sets" to "service_role";

grant delete on table "public"."workout_group" to "anon";

grant insert on table "public"."workout_group" to "anon";

grant references on table "public"."workout_group" to "anon";

grant select on table "public"."workout_group" to "anon";

grant trigger on table "public"."workout_group" to "anon";

grant truncate on table "public"."workout_group" to "anon";

grant update on table "public"."workout_group" to "anon";

grant delete on table "public"."workout_group" to "authenticated";

grant insert on table "public"."workout_group" to "authenticated";

grant references on table "public"."workout_group" to "authenticated";

grant select on table "public"."workout_group" to "authenticated";

grant trigger on table "public"."workout_group" to "authenticated";

grant truncate on table "public"."workout_group" to "authenticated";

grant update on table "public"."workout_group" to "authenticated";

grant delete on table "public"."workout_group" to "service_role";

grant insert on table "public"."workout_group" to "service_role";

grant references on table "public"."workout_group" to "service_role";

grant select on table "public"."workout_group" to "service_role";

grant trigger on table "public"."workout_group" to "service_role";

grant truncate on table "public"."workout_group" to "service_role";

grant update on table "public"."workout_group" to "service_role";

grant delete on table "public"."workout_templates" to "anon";

grant insert on table "public"."workout_templates" to "anon";

grant references on table "public"."workout_templates" to "anon";

grant select on table "public"."workout_templates" to "anon";

grant trigger on table "public"."workout_templates" to "anon";

grant truncate on table "public"."workout_templates" to "anon";

grant update on table "public"."workout_templates" to "anon";

grant delete on table "public"."workout_templates" to "authenticated";

grant insert on table "public"."workout_templates" to "authenticated";

grant references on table "public"."workout_templates" to "authenticated";

grant select on table "public"."workout_templates" to "authenticated";

grant trigger on table "public"."workout_templates" to "authenticated";

grant truncate on table "public"."workout_templates" to "authenticated";

grant update on table "public"."workout_templates" to "authenticated";

grant delete on table "public"."workout_templates" to "service_role";

grant insert on table "public"."workout_templates" to "service_role";

grant references on table "public"."workout_templates" to "service_role";

grant select on table "public"."workout_templates" to "service_role";

grant trigger on table "public"."workout_templates" to "service_role";

grant truncate on table "public"."workout_templates" to "service_role";

grant update on table "public"."workout_templates" to "service_role";

grant delete on table "public"."workouts" to "anon";

grant insert on table "public"."workouts" to "anon";

grant references on table "public"."workouts" to "anon";

grant select on table "public"."workouts" to "anon";

grant trigger on table "public"."workouts" to "anon";

grant truncate on table "public"."workouts" to "anon";

grant update on table "public"."workouts" to "anon";

grant delete on table "public"."workouts" to "authenticated";

grant insert on table "public"."workouts" to "authenticated";

grant references on table "public"."workouts" to "authenticated";

grant select on table "public"."workouts" to "authenticated";

grant trigger on table "public"."workouts" to "authenticated";

grant truncate on table "public"."workouts" to "authenticated";

grant update on table "public"."workouts" to "authenticated";

grant delete on table "public"."workouts" to "service_role";

grant insert on table "public"."workouts" to "service_role";

grant references on table "public"."workouts" to "service_role";

grant select on table "public"."workouts" to "service_role";

grant trigger on table "public"."workouts" to "service_role";

grant truncate on table "public"."workouts" to "service_role";

grant update on table "public"."workouts" to "service_role";


