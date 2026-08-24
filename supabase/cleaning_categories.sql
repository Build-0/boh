-- ============================================================================
--  清潔劑分類管理：改名（中/英）、圖示、排序、增刪。
--  categories 表已存在（schema.sql）。products 以 category_id 連結，故改名不需連動。
--  在 SQL Editor 跑一次。
-- ============================================================================
create or replace function save_categories(p_password text, p_cats jsonb)
returns void language plpgsql security definer set search_path = public, extensions as $$
declare
  el jsonb; i int := 0; cid int; keep int[] := '{}'; d record; fb int;
begin
  perform _require_admin(p_password);
  for el in select value from jsonb_array_elements(p_cats) loop
    i := i + 1;
    if btrim(coalesce(el->>'name_zh','')) = '' then continue; end if;
    cid := nullif(el->>'id','')::int;
    if cid is null then
      select coalesce(max(id),0) + 1 into cid from categories;
      insert into categories(id, name_zh, name_en, icon, color, bg, sort_order)
      values (cid, el->>'name_zh', coalesce(nullif(el->>'name_en',''), el->>'name_zh'),
              coalesce(nullif(el->>'icon',''), '📦'),
              coalesce(nullif(el->>'color',''), '#2b7280'),
              coalesce(nullif(el->>'bg',''), '#eef5f6'), i);
    else
      update categories set
        name_zh = el->>'name_zh',
        name_en = coalesce(nullif(el->>'name_en',''), el->>'name_zh'),
        icon    = coalesce(nullif(el->>'icon',''), icon),
        sort_order = i
      where id = cid;
    end if;
    keep := array_append(keep, cid);
  end loop;
  select id into fb from categories where id = any(keep) order by sort_order limit 1;
  for d in select id from categories where not (id = any(keep)) loop
    if fb is not null then update products set category_id = fb where category_id = d.id; end if;
    delete from categories where id = d.id;
  end loop;
end $$;
grant execute on function save_categories(text, jsonb) to anon, authenticated;
