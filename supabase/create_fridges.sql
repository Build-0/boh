-- ============================================================================
--  批次建立 46 台冰箱（每台預設 5 項配件、狀態正常、暫用編號 冰箱#1..#46）
--  需先跑過 add_tools_equipment_fields.sql（equipment 要有 accessories 欄位）。
--  之後在網頁上逐台編輯：改型號/位置/狀態、勾配件是否齊全。
-- ============================================================================
insert into equipment (type, label, status, accessories, sort_order)
select '冰箱',
       '冰箱#' || g,
       '正常',
       '[{"name":"層架","ok":true},{"name":"門邊條","ok":true},{"name":"蛋架","ok":true},{"name":"冷凍盒","ok":true},{"name":"溫控旋鈕","ok":true}]'::jsonb,
       1000 + g
from generate_series(1, 46) as g;
