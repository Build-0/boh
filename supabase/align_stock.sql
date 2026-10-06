-- 對齊庫存：將效期批次調整到同卡片庫存一致（以前直接改數造成的差額）。
-- 記為「更正」(kind = 'correct')，不計入用量報表。只會改動不夾數的產品。
do $$
declare p record; gap int; b record; take int;
begin
  for p in select pr.id, pr.stock, sum(pb.qty_remaining)::int as bsum
             from products pr join product_batches pb on pb.product_id = pr.id
            group by pr.id, pr.stock
           having sum(pb.qty_remaining) <> pr.stock
  loop
    gap := p.bsum - p.stock;
    if gap > 0 then
      for b in select id, qty_remaining from product_batches
                where product_id = p.id and qty_remaining > 0
                order by expiry_date asc nulls last, received_date asc, id asc
      loop
        exit when gap <= 0;
        take := least(gap, b.qty_remaining);
        update product_batches set qty_remaining = qty_remaining - take where id = b.id;
        gap := gap - take;
      end loop;
    else
      update product_batches set qty_remaining = qty_remaining - gap
       where id = (select id from product_batches where product_id = p.id
                   order by received_date desc nulls last, id desc limit 1);
    end if;
    insert into stock_movements (product_id, kind, qty, happened_on, note)
    values (p.id, 'correct', abs(p.bsum - p.stock), current_date,
            '對齊更正：直接改庫存差額（' || p.bsum || '→' || p.stock || '），不計用量');
  end loop;
end $$;

select pr.name_zh, pr.stock, sum(pb.qty_remaining) as 批次合計
  from products pr join product_batches pb on pb.product_id = pr.id
 group by pr.id, pr.name_zh, pr.stock
having sum(pb.qty_remaining) <> pr.stock;
