-- ============================================================================
--  把清潔工具「其他」(23 樣) 拆細成 4 個新分類，「其他」只留 2 樣。
--  在 Supabase SQL Editor 跑一次即可。只會改動目前仍屬「其他」的工具。
-- ============================================================================

-- 1) 新分類（排序：垃圾桶、防滑牌、洗手液器、拖把及拖桶、掃把及地刷、玻璃及高空、百潔墊、其他）
insert into tool_categories (name, sort_order) values
  ('拖把及拖桶', 4), ('掃把及地刷', 5), ('玻璃及高空', 6), ('百潔墊', 7)
on conflict (name) do update set sort_order = excluded.sort_order;
update tool_categories set sort_order = 99 where name = '其他';

-- 2) 拖把及拖桶（8）：套款平頭拖(小)、套款平頭拖(大)、魔術貼款平頭拖、乾濕兩用平板拖、
--    純棉毛拖、排頭拖、黃色可移動拖桶、平板拖桶(ecolab)
update tools set category = '拖把及拖桶' where category = '其他' and id in (45,46,47,48,49,50,60,61);

-- 3) 掃把及地刷（6）：大掃把、紅色硬毛掃把、地刷、洗衣刷、防風垃圾鏟、長柄拾物器
update tools set category = '掃把及地刷' where category = '其他' and id in (44,55,56,57,58,59);

-- 4) 玻璃及高空（4）：水刮器、玻璃刮、毛頭玻璃刮、高空抹塵棒
update tools set category = '玻璃及高空' where category = '其他' and id in (51,52,53,54);

-- 5) 百潔墊（3）：17寸百潔墊(白)、6.6寸百潔墊(紅)、鋼絲棉
update tools set category = '百潔墊' where category = '其他' and id in (63,64,67);

-- 6) 更正錯字：套款平頭彈（大）→ 套款平頭拖（大）
update tools set name = '套款平頭拖（大）' where id = 48 and name = '套款平頭彈（大）';

-- 其餘維持「其他」（2）：藤籃、大盤紙抽取器

-- 檢查結果
select category, count(*) from tools group by category order by 1;
