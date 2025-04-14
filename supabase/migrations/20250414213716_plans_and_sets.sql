drop policy "Enable insert for authenticated users only" on "public"."plans";

revoke delete on table "public"."workout_group" from "anon";

revoke insert on table "public"."workout_group" from "anon";

revoke references on table "public"."workout_group" from "anon";

revoke select on table "public"."workout_group" from "anon";

revoke trigger on table "public"."workout_group" from "anon";

revoke truncate on table "public"."workout_group" from "anon";

revoke update on table "public"."workout_group" from "anon";

revoke delete on table "public"."workout_group" from "authenticated";

revoke insert on table "public"."workout_group" from "authenticated";

revoke references on table "public"."workout_group" from "authenticated";

revoke select on table "public"."workout_group" from "authenticated";

revoke trigger on table "public"."workout_group" from "authenticated";

revoke truncate on table "public"."workout_group" from "authenticated";

revoke update on table "public"."workout_group" from "authenticated";

revoke delete on table "public"."workout_group" from "service_role";

revoke insert on table "public"."workout_group" from "service_role";

revoke references on table "public"."workout_group" from "service_role";

revoke select on table "public"."workout_group" from "service_role";

revoke trigger on table "public"."workout_group" from "service_role";

revoke truncate on table "public"."workout_group" from "service_role";

revoke update on table "public"."workout_group" from "service_role";

revoke delete on table "public"."workout_templates" from "anon";

revoke insert on table "public"."workout_templates" from "anon";

revoke references on table "public"."workout_templates" from "anon";

revoke select on table "public"."workout_templates" from "anon";

revoke trigger on table "public"."workout_templates" from "anon";

revoke truncate on table "public"."workout_templates" from "anon";

revoke update on table "public"."workout_templates" from "anon";

revoke delete on table "public"."workout_templates" from "authenticated";

revoke insert on table "public"."workout_templates" from "authenticated";

revoke references on table "public"."workout_templates" from "authenticated";

revoke select on table "public"."workout_templates" from "authenticated";

revoke trigger on table "public"."workout_templates" from "authenticated";

revoke truncate on table "public"."workout_templates" from "authenticated";

revoke update on table "public"."workout_templates" from "authenticated";

revoke delete on table "public"."workout_templates" from "service_role";

revoke insert on table "public"."workout_templates" from "service_role";

revoke references on table "public"."workout_templates" from "service_role";

revoke select on table "public"."workout_templates" from "service_role";

revoke trigger on table "public"."workout_templates" from "service_role";

revoke truncate on table "public"."workout_templates" from "service_role";

revoke update on table "public"."workout_templates" from "service_role";

alter table "public"."sets" drop constraint "sets_workout_id_fkey";

alter table "public"."workout_group" drop constraint "workout_group_plan_id_fkey";

alter table "public"."workout_templates" drop constraint "workout_templates_exercise_id_fkey";

alter table "public"."workout_templates" drop constraint "workout_templates_workout_group_id_fkey";

alter table "public"."workout_group" drop constraint "workout_group_pkey";

alter table "public"."workout_templates" drop constraint "workout_templates_pkey";

drop index if exists "public"."workout_templates_pkey";

drop index if exists "public"."workout_group_pkey";

drop table "public"."workout_group";

drop table "public"."workout_templates";

create table "public"."plan_sets" (
    "id" uuid not null default gen_random_uuid(),
    "plan_id" uuid not null,
    "name" text,
    "day" smallint
);


alter table "public"."plan_sets" enable row level security;

alter table "public"."plans" alter column "id" set default gen_random_uuid();

alter table "public"."sets" drop column "rest_time_milliseconds";

alter table "public"."sets" drop column "workout_id";

alter table "public"."sets" add column "exercise_id" uuid default gen_random_uuid();

alter table "public"."sets" add column "plan_set_id" uuid not null default gen_random_uuid();

alter table "public"."sets" add column "rep_count_goal" smallint;

alter table "public"."sets" add column "rest" smallint;

alter table "public"."sets" add column "set_count" smallint;

CREATE UNIQUE INDEX workout_group_pkey ON public.plan_sets USING btree (id);

alter table "public"."plan_sets" add constraint "workout_group_pkey" PRIMARY KEY using index "workout_group_pkey";

alter table "public"."plan_sets" add constraint "workout_group_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES plans(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."plan_sets" validate constraint "workout_group_plan_id_fkey";

alter table "public"."sets" add constraint "sets_exercise_id_fkey" FOREIGN KEY (exercise_id) REFERENCES exercises(id) not valid;

alter table "public"."sets" validate constraint "sets_exercise_id_fkey";

alter table "public"."sets" add constraint "sets_workout_group_id_fkey" FOREIGN KEY (plan_set_id) REFERENCES plan_sets(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."sets" validate constraint "sets_workout_group_id_fkey";

grant delete on table "public"."plan_sets" to "anon";

grant insert on table "public"."plan_sets" to "anon";

grant references on table "public"."plan_sets" to "anon";

grant select on table "public"."plan_sets" to "anon";

grant trigger on table "public"."plan_sets" to "anon";

grant truncate on table "public"."plan_sets" to "anon";

grant update on table "public"."plan_sets" to "anon";

grant delete on table "public"."plan_sets" to "authenticated";

grant insert on table "public"."plan_sets" to "authenticated";

grant references on table "public"."plan_sets" to "authenticated";

grant select on table "public"."plan_sets" to "authenticated";

grant trigger on table "public"."plan_sets" to "authenticated";

grant truncate on table "public"."plan_sets" to "authenticated";

grant update on table "public"."plan_sets" to "authenticated";

grant delete on table "public"."plan_sets" to "service_role";

grant insert on table "public"."plan_sets" to "service_role";

grant references on table "public"."plan_sets" to "service_role";

grant select on table "public"."plan_sets" to "service_role";

grant trigger on table "public"."plan_sets" to "service_role";

grant truncate on table "public"."plan_sets" to "service_role";

grant update on table "public"."plan_sets" to "service_role";

create policy "Enable read access for all users"
on "public"."exercises"
as permissive
for select
to public
using (true);


create policy "Allow inserts"
on "public"."plan_sets"
as permissive
for insert
to public
with check (true);


create policy "Enable read access"
on "public"."plan_sets"
as permissive
for select
to public
using (true);


create policy "Allow inserts"
on "public"."plans"
as permissive
for insert
to public
with check (true);


create policy "Enable read access"
on "public"."plans"
as permissive
for select
to public
using (true);


create policy "Allow inserts"
on "public"."profile_plans"
as permissive
for insert
to public
with check (true);


create policy "Enable read access"
on "public"."profile_plans"
as permissive
for select
to public
using (true);


create policy "Allow inserts"
on "public"."sets"
as permissive
for insert
to public
with check (true);


create policy "Enable read access"
on "public"."sets"
as permissive
for select
to public
using (true);



