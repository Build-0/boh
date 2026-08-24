-- ============================================================================
--  清潔工具：分類 category、在用 in_use、最低庫存 min_stock
--  設備：配件清單 accessories(jsonb: [{"name":"層架","ok":true}, ...])
--  在 SQL Editor 跑一次。
-- ============================================================================
alter table tools     add column if not exists category  text not null default '其他';
alter table tools     add column if not exists in_use    int  not null default 0;
alter table tools     add column if not exists min_stock int  not null default 0;
alter table equipment add column if not exists accessories jsonb not null default '[]'::jsonb;

-- 更新 upsert_tool（含新欄位；相片可清空）
create or replace function upsert_tool(p_password text, p_tool jsonb)
returns tools language plpgsql security definer set search_path = public, extensions as $$
declare rec tools; tid int := nullif(p_tool->>'id','')::int;
begin
  perform _require_admin(p_password);
  if tid is null then
    insert into tools (name, category, stock, in_use, min_stock, status, image, notes, sort_order)
    values (p_tool->>'name', coalesce(nullif(p_tool->>'category',''),'其他'),
      coalesce(nullif(p_tool->>'stock','')::int,0), coalesce(nullif(p_tool->>'in_use','')::int,0),
      coalesce(nullif(p_tool->>'min_stock','')::int,0),
      coalesce(nullif(p_tool->>'status',''),'啟用'), p_tool->>'image', p_tool->>'notes',
      coalesce(nullif(p_tool->>'sort_order','')::int,0)) returning * into rec;
  else
    update tools set name=coalesce(p_tool->>'name',name),
      category=coalesce(nullif(p_tool->>'category',''),category),
      stock=coalesce(nullif(p_tool->>'stock','')::int,stock),
      in_use=coalesce(nullif(p_tool->>'in_use','')::int,in_use),
      min_stock=coalesce(nullif(p_tool->>'min_stock','')::int,min_stock),
      status=coalesce(nullif(p_tool->>'status',''),status),
      image=p_tool->>'image', notes=p_tool->>'notes',
      sort_order=coalesce(nullif(p_tool->>'sort_order','')::int,sort_order)
    where id=tid returning * into rec;
    if not found then raise exception 'tool not found'; end if;
  end if;
  return rec;
end $$;

-- 更新 upsert_equipment（含 accessories 配件清單；相片可清空；label/serial）
create or replace function upsert_equipment(p_password text, p_equipment jsonb)
returns equipment language plpgsql security definer set search_path = public, extensions as $$
declare rec equipment; eid int := nullif(p_equipment->>'id','')::int;
begin
  perform _require_admin(p_password);
  if eid is null then
    insert into equipment (type, model, brand, serial, floor_code, label, status, image, notes, accessories, sort_order)
    values (coalesce(nullif(p_equipment->>'type',''),'其他'), p_equipment->>'model', p_equipment->>'brand',
      p_equipment->>'serial', p_equipment->>'floor_code', p_equipment->>'label',
      coalesce(nullif(p_equipment->>'status',''),'正常'), p_equipment->>'image', p_equipment->>'notes',
      coalesce(p_equipment->'accessories','[]'::jsonb),
      coalesce(nullif(p_equipment->>'sort_order','')::int,0)) returning * into rec;
  else
    update equipment set type=coalesce(nullif(p_equipment->>'type',''),type), model=p_equipment->>'model',
      brand=p_equipment->>'brand', serial=p_equipment->>'serial', floor_code=p_equipment->>'floor_code',
      label=p_equipment->>'label', status=coalesce(nullif(p_equipment->>'status',''),status),
      image=p_equipment->>'image', notes=p_equipment->>'notes',
      accessories=coalesce(p_equipment->'accessories', accessories),
      sort_order=coalesce(nullif(p_equipment->>'sort_order','')::int,sort_order)
    where id=eid returning * into rec;
    if not found then raise exception 'equipment not found'; end if;
  end if;
  return rec;
end $$;
