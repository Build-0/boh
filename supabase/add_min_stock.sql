-- ============================================================================
--  清潔劑：加入「最低庫存」min_stock，低於它就在頁面提醒補貨。
--  在 SQL Editor 跑一次即可。
-- ============================================================================
alter table products add column if not exists min_stock int not null default 0;

-- 重新定義 upsert_product，加入 min_stock（並維持相片可清空）
create or replace function upsert_product(p_password text, p_product jsonb)
returns products language plpgsql security definer set search_path = public, extensions as $$
declare rec products; pid int := nullif(p_product->>'id','')::int;
begin
  perform _require_admin(p_password);
  if pid is null then
    insert into products (category_id, name_zh, name_en, subname_zh, subname_en,
      applicable_zh, applicable_en, dilution_zh, dilution_en, rinse_zh, rinse_en,
      image, alt, stock, min_stock, status, sort_order)
    values (nullif(p_product->>'category_id','')::int, p_product->>'name_zh', p_product->>'name_en',
      p_product->>'subname_zh', p_product->>'subname_en', p_product->>'applicable_zh', p_product->>'applicable_en',
      p_product->>'dilution_zh', p_product->>'dilution_en', p_product->>'rinse_zh', p_product->>'rinse_en',
      p_product->>'image', p_product->>'alt', coalesce(nullif(p_product->>'stock','')::int,0),
      coalesce(nullif(p_product->>'min_stock','')::int,0),
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
      min_stock=coalesce(nullif(p_product->>'min_stock','')::int,min_stock),
      status=coalesce(nullif(p_product->>'status',''),status),
      sort_order=coalesce(nullif(p_product->>'sort_order','')::int,sort_order)
    where id=pid returning * into rec;
    if not found then raise exception 'product not found'; end if;
  end if;
  return rec;
end $$;
