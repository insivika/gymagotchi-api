alter table "public"."plans" drop constraint "plans_id_fkey";

create table "public"."profile_plans" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null default gen_random_uuid(),
    "plan_id" uuid default gen_random_uuid()
);


alter table "public"."profile_plans" enable row level security;

alter table "public"."plans" drop column "user_id";

alter table "public"."workout_templates" add column "rest_time_milliseconds" integer;

alter table "public"."workouts" drop column "workout_template_id";

alter table "public"."workouts" add column "workout_template" jsonb not null;

alter table "public"."profile_plans" add constraint "profile_plans_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES plans(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."profile_plans" validate constraint "profile_plans_plan_id_fkey";

alter table "public"."profile_plans" add constraint "profile_plans_user_id_fkey" FOREIGN KEY (user_id) REFERENCES profiles(user_id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."profile_plans" validate constraint "profile_plans_user_id_fkey";

grant delete on table "public"."profile_plans" to "anon";

grant insert on table "public"."profile_plans" to "anon";

grant references on table "public"."profile_plans" to "anon";

grant select on table "public"."profile_plans" to "anon";

grant trigger on table "public"."profile_plans" to "anon";

grant truncate on table "public"."profile_plans" to "anon";

grant update on table "public"."profile_plans" to "anon";

grant delete on table "public"."profile_plans" to "authenticated";

grant insert on table "public"."profile_plans" to "authenticated";

grant references on table "public"."profile_plans" to "authenticated";

grant select on table "public"."profile_plans" to "authenticated";

grant trigger on table "public"."profile_plans" to "authenticated";

grant truncate on table "public"."profile_plans" to "authenticated";

grant update on table "public"."profile_plans" to "authenticated";

grant delete on table "public"."profile_plans" to "service_role";

grant insert on table "public"."profile_plans" to "service_role";

grant references on table "public"."profile_plans" to "service_role";

grant select on table "public"."profile_plans" to "service_role";

grant trigger on table "public"."profile_plans" to "service_role";

grant truncate on table "public"."profile_plans" to "service_role";

grant update on table "public"."profile_plans" to "service_role";

create policy "Enable insert for authenticated users only"
on "public"."plans"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for all users"
on "public"."profiles"
as permissive
for select
to public
using (true);



