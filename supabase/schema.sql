-- Схема Supabase для облачного бэкапа/синхронизации (ТЗ разд. 4.17, roadmap M2).
-- Выполните в Supabase → SQL Editor (один раз).
--
-- Хранит снимок данных пользователя (профиль + результаты) одной строкой JSONB.
-- Row Level Security гарантирует: каждый видит и меняет ТОЛЬКО свою строку.

create table if not exists public.backups (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  data       jsonb        not null,
  updated_at timestamptz  not null default now()
);

alter table public.backups enable row level security;

create policy "own backup - select" on public.backups
  for select using (auth.uid() = user_id);

create policy "own backup - insert" on public.backups
  for insert with check (auth.uid() = user_id);

create policy "own backup - update" on public.backups
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own backup - delete" on public.backups
  for delete using (auth.uid() = user_id);

-- Табличные привилегии для роли авторизованных пользователей. Нужны, когда
-- «Automatically expose new tables» выключено. Доступ к строкам всё равно
-- ограничивают RLS-политики выше (каждый видит только свою строку).
grant select, insert, update, delete on public.backups to authenticated;

-- Realtime для мультидевайс-синхронизации (ТЗ M2, #4): правки с одного
-- устройства подтягиваются на другое. Публикуем таблицу в supabase_realtime и
-- включаем полную реплику строки, чтобы работал фильтр по user_id.
alter table public.backups replica identity full;
alter publication supabase_realtime add table public.backups;
