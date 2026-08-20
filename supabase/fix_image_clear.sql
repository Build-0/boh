-- ============================================================================
--  讓「移除相片」生效：把 4 支 upsert 的 image 由 coalesce(新,舊) 改成直接指派，
--  這樣前端傳 null 就能把相片清空。其餘欄位邏輯不變。
--  在 SQL Editor 跑一次即可。
-- ============================================================================

create or replace function upsert_product(p_password text, p_product jsonb)
returns products language plpgsql security definer set search_path = public, extensions as $$
declare rec products; pid int := nullif(p_product->>'id','')::int;
begin
  perform _require_admin(p_password);
  if pid is null then
    insert into products (category_id, name_zh, name_en, subname_zh, subname_en,
      applicable_zh, applicable_en, dilution_zh, dilution_en, rinse_zh, rinse_en,
      image, alt, stock, status, sort_order)
    values (nullif(p_product->>'category_id','')::int, p_product->>'name_zh', p_product->>'name_en',
      p_product->>'subname_zh', p_product->>'subname_en', p_product->>'applicable_zh', p_product->>'applicable_en',
      p_product->>'dilution_zh', p_product->>'dilution_en', p_product->>'rinse_zh', p_product->>'rinse_en',
      p_product->>'image', p_product->>'alt', coalesce(nullif(p_product->>'stock','')::int,0),
      coalesce(nullif(p_product->>'status',''),'啟用'), coalesce(nullif(p_product->>'sort_order','')::int,0))
    returning * into rec;
  else
    update products set category_id=nullif(p_product->>'category_id','')::int,
      name_zh=coalesce(p_product->>'name_zh',name_zh), name_en=p_product->>'name_en',
      subname_zh=p_product->>'subname_zh', subname_en=p_product->>'subname_en',
      applicable_zh=p_product->>'applicable_zh', applicable_en=p_product->>'applicable_en',
      dilution_zh=p_product->>'dilution_zh', dilution_en=p_product->>'dilution_en',
      rinse_zh=p_product->>'rinse_zh', rinse_en=p_product->>'rinse_en',
      image=p_product->>'image', alt=p_product->>'alt',
      stock=coalesce(nullif(p_product->>'stock','')::int,stock),
      status=coalesce(nullif(p_product->>'status',''),status),
      sort_order=coalesce(nullif(p_product->>'sort_order','')::int,sort_order)
    where id=pid returning * into rec;
    if not found then raise exception 'product not found'; end if;
  end if;
  return rec;
end $$;

create or replace function upsert_tool(p_password text, p_tool jsonb)
returns tools language plpgsql security definer set search_path = public, extensions as $$
declare rec tools; tid int := nullif(p_tool->>'id','')::int;
begin
  perform _require_admin(p_password);
  if tid is null then
    insert into tools (name, stock, status, image, notes, sort_order)
    values (p_tool->>'name', coalesce(nullif(p_tool->>'stock','')::int,0),
      coalesce(nullif(p_tool->>'status',''),'啟用'), p_tool->>'image', p_tool->>'notes',
      coalesce(nullif(p_tool->>'sort_order','')::int,0)) returning * into rec;
  else
    update tools set name=coalesce(p_tool->>'name',name),
      stock=coalesce(nullif(p_tool->>'stock','')::int,stock),
      status=coalesce(nullif(p_tool->>'status',''),status),
      image=p_tool->>'image', notes=p_tool->>'notes',
      sort_order=coalesce(nullif(p_tool->>'sort_order','')::int,sort_order)
    where id=tid returning * into rec;
    if not found then raise exception 'tool not found'; end if;
  end if;
  return rec;
end $$;

create or replace function upsert_vacuum(p_password text, p_vacuum jsonb)
returns vacuums language plpgsql security definer set search_path = public, extensions as $$
declare rec vacuums; vid int := nullif(p_vacuum->>'id','')::int;
begin
  perform _require_admin(p_password);
  if vid is null then
    insert into vacuums (model, brand, serial, floor_code, label, status, image, notes, sort_order)
    values (p_vacuum->>'model', p_vacuum->>'brand', p_vacuum->>'serial', p_vacuum->>'floor_code', p_vacuum->>'label',
      coalesce(nullif(p_vacuum->>'status',''),'正常'), p_vacuum->>'image', p_vacuum->>'notes',
      coalesce(nullif(p_vacuum->>'sort_order','')::int,0)) returning * into rec;
  else
    update vacuums set model=coalesce(p_vacuum->>'model',model), brand=p_vacuum->>'brand',
      serial=p_vacuum->>'serial', floor_code=p_vacuum->>'floor_code', label=p_vacuum->>'label',
      status=coalesce(nullif(p_vacuum->>'status',''),status), image=p_vacuum->>'image',
      notes=p_vacuum->>'notes', sort_order=coalesce(nullif(p_vacuum->>'sort_order','')::int,sort_order)
    where id=vid returning * into rec;
    if not found then raise exception 'vacuum not found'; end if;
  end if;
  return rec;
end $$;

create or replace function upsert_equipment(p_password text, p_equipment jsonb)
returns equipment language plpgsql security definer set search_path = public, extensions as $$
declare rec equipment; eid int := nullif(p_equipment->>'id','')::int;
begin
  perform _require_admin(p_password);
  if eid is null then
    insert into equipment (type, model, brand, serial, floor_code, label, status, image, notes, sort_order)
    values (coalesce(nullif(p_equipment->>'type',''),'其他'), p_equipment->>'model', p_equipment->>'brand',
      p_equipment->>'serial', p_equipment->>'floor_code', p_equipment->>'label',
      coalesce(nullif(p_equipment->>'status',''),'正常'), p_equipment->>'image', p_equipment->>'notes',
      coalesce(nullif(p_equipment->>'sort_order','')::int,0)) returning * into rec;
  else
    update equipment set type=coalesce(nullif(p_equipment->>'type',''),type), model=p_equipment->>'model',
      brand=p_equipment->>'brand', serial=p_equipment->>'serial', floor_code=p_equipment->>'floor_code',
      label=p_equipment->>'label', status=coalesce(nullif(p_equipment->>'status',''),status),
      image=p_equipment->>'image', notes=p_equipment->>'notes',
      sort_order=coalesce(nullif(p_equipment->>'sort_order','')::int,sort_order)
    where id=eid returning * into rec;
    if not found then raise exception 'equipment not found'; end if;
  end if;
  return rec;
end $$;
