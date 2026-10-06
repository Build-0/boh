-- ============================================================================
--  資料整理（2026-10-06 檢查結果）— 只做明確的錯字/格式統一，不刪任何資料。
--  在 Supabase SQL Editor 跑一次即可，重跑亦無影響。
-- ============================================================================

-- 1) 設備位置統一：warehourse（拼錯）、仓库（簡體）→ 倉庫   （共 33 台）
update equipment set floor_code = '倉庫' where floor_code in ('warehourse', '仓库');

-- 2) 清潔劑英文名內的 &quot; 亂碼 → "   （大理石結晶粉、大理石拋光劑）
update products set name_en    = replace(name_en,    '&quot;', '"'),
                    subname_zh = replace(subname_zh, '&quot;', '"'),
                    subname_en = replace(subname_en, '&quot;', '"')
 where name_en like '%&quot;%' or subname_zh like '%&quot;%' or subname_en like '%&quot;%';

-- 3) 清潔工具：簡體字 / 括號統一為繁體全形
update tools set name = '室外方形不帶煙缸垃圾桶（鐵灰白款）' where id = 26;
update tools set name = '6.6寸百潔墊（紅色）'                 where id = 67;
update tools set name = '洗手液感應器（冰室）'                 where id = 66;

-- 4) 吸塵機編號大小寫統一：s47 → S47、s35 → S35
update vacuums set label = upper(label) where label in ('s47', 's35');

-- 5) 吸塵機備註：刪走重複的英文「Waiting for  disposal」（中文「等待報銷」保留）
update vacuums set notes = replace(notes, '；Waiting for  disposal', '')
 where notes like '%Waiting for  disposal%';

-- 6) 冰箱編號改為 R1（型號／序號原本係「1」，屬佔位資料，一併清空）
update equipment set label = 'R1', model = null, serial = null where id = 228 and type = '冰箱';

-- 7) 最後三款清潔劑：補上英文欄位，英文名改正大小寫
update products set name_en = 'Copper Shine Special', subname_zh = 'Copper Shine Special',
       applicable_en = 'Metal', dilution_en = 'Not required' where id = 36;
update products set name_en = 'Water-based Stainless Steel Polish', subname_zh = 'Water-based Stainless Steel Polish',
       applicable_zh = '不鏽鋼表面', applicable_en = 'Stainless steel', dilution_en = 'Not required' where id = 37;
update products set applicable_en = 'All surfaces', dilution_en = '1:125' where id = 38;

-- 檢查
select floor_code, count(*) from equipment group by 1 order by 1;
