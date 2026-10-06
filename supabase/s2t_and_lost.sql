-- ============================================================================
--  簡體 → 繁體（2026-10-06）：吸塵機保養記錄 41 條 + 設備位置 1 個；
--  另：前臺括號統一、暖奶器 warmer03 改為「遺失」。每行只會改仍係舊文字嘅記錄。
-- ============================================================================
update vacuum_maintenance set description = '2024.7.14電源綫壞' where id = 7 and description = '2024.7.14電源綫坏';
update vacuum_maintenance set description = '2025.8.30原10F變更為備用機S29' where id = 17 and description = '2025.8.30原10F变更为备用机S29';
update vacuum_maintenance set description = '2025.7.6二檔開關壞' where id = 20 and description = '2025.7.6二檔開關坏';
update vacuum_maintenance set description = '2025.8.30原10E變更為備用機S28' where id = 21 and description = '2025.8.30原10E变更为备用机S28';
update vacuum_maintenance set description = '2025.8.30原10D變更為備用機S27' where id = 26 and description = '2025.8.30原10D变更为备用机S27';
update vacuum_maintenance set description = '2024.8.19電源綫壞' where id = 33 and description = '2024.8.19電源綫坏';
update vacuum_maintenance set description = '2024.8.19電源綫壞' where id = 36 and description = '2024.8.19電源綫坏';
update vacuum_maintenance set description = '2024.6.14電源綫壞' where id = 47 and description = '2024.6.14電源綫坏';
update vacuum_maintenance set description = '2025.7.21更換防塵罩' where id = 63 and description = '2025.7.21更换防尘罩';
update vacuum_maintenance set description = '2025.11.5摩打膠邊固定壞無法使用' where id = 89 and description = '2025.11.5摩打膠邊固定坏無法使用';
update vacuum_maintenance set description = '2025.10.29插頭壞' where id = 106 and description = '2025.10.29插頭坏';
update vacuum_maintenance set description = '2026.1.24 更換塵機管掛鈎' where id = 114 and description = '2026.1.24 更換塵機管挂鈎';
update vacuum_maintenance set description = '2025.1.19更換槍管插銷' where id = 126 and description = '2025.1.19更换枪管插销';
update vacuum_maintenance set description = '2025.1.19更換槍管插銷' where id = 131 and description = '2025.1.19更换枪管插销';
update vacuum_maintenance set description = '2025.1.19更換槍管掛鈎' where id = 134 and description = '2025.1.19更换枪管挂鈎';
update vacuum_maintenance set description = '2025.8.30原3F變更為10F' where id = 140 and description = '2025.8.30原3F变更为10F';
update vacuum_maintenance set description = '2024.9.17電源綫壞' where id = 162 and description = '2024.9.17電源綫坏';
update vacuum_maintenance set description = '2025.7.25不通電' where id = 164 and description = '2025.7.25不通电';
update vacuum_maintenance set description = '2024.7.2擋位壞' where id = 170 and description = '2024.7.2擋位坏';
update vacuum_maintenance set description = '2024.8.21 電源綫壞' where id = 181 and description = '2024.8.21 電源綫坏';
update vacuum_maintenance set description = '2025.10.15塵機管接頭壞' where id = 190 and description = '2025.10.15塵機管接頭坏';
update vacuum_maintenance set description = '2024.9.11電源綫壞' where id = 191 and description = '2024.9.11電源綫坏';
update vacuum_maintenance set description = '2025.4.23更換耙頭' where id = 196 and description = '2025.4.23更换耙头';
update vacuum_maintenance set description = '2024.8.16電源綫壞' where id = 203 and description = '2024.8.16電源綫坏';
update vacuum_maintenance set description = '2025.2.22塵機異鄉，摩打壞' where id = 224 and description = '2025.2.22塵機異鄉，摩打坏';
update vacuum_maintenance set description = '2025/7/22 已報廢處理' where id = 225 and description = '2025/7/22 已报废处理';
update vacuum_maintenance set description = '2025/7/22 已報廢處理' where id = 226 and description = '2025/7/22 已报废处理';
update vacuum_maintenance set description = '2025/7/22 已報廢處理' where id = 227 and description = '2025/7/22 已报废处理';
update vacuum_maintenance set description = '2025/7/22 已報廢處理' where id = 229 and description = '2025/7/22 已报废处理';
update vacuum_maintenance set description = '2025/7/22 已報廢處理' where id = 230 and description = '2025/7/22 已报废处理';
update vacuum_maintenance set description = '2025/7/22 已報廢處理' where id = 231 and description = '2025/7/22 已报废处理';
update vacuum_maintenance set description = '收回倉庫' where id = 256 and description = '收回仓库';
update vacuum_maintenance set description = '收回倉庫' where id = 257 and description = '收回仓库';
update vacuum_maintenance set description = '原8D收回倉庫' where id = 259 and description = '原8D收回仓库';
update vacuum_maintenance set description = '原6E收貨倉庫' where id = 260 and description = '原6E收货仓库';
update vacuum_maintenance set description = '原6F收回倉庫' where id = 261 and description = '原6F收回仓库';
update vacuum_maintenance set description = '原6D收回倉庫' where id = 263 and description = '原6D收回仓库';
update vacuum_maintenance set description = '原07A收回倉庫' where id = 272 and description = '原07A收回仓库';
update vacuum_maintenance set description = '上樓替用12A' where id = 281 and description = '上楼替用12A';
update vacuum_maintenance set description = '塵機管破損' where id = 282 and description = '尘机管破损';
update vacuum_maintenance set description = '輪子脱落' where id = 283 and description = '轮子脱落';
update equipment set floor_code = '乾淨布草房' where id = 143 and floor_code = '乾净布草房';

-- 前臺括號統一為全形
update equipment set floor_code = '前臺（新增）' where floor_code = '前臺(新增）';

-- 暖奶器 warmer03（備註 LOST）改為新狀態「遺失」
update equipment set status = '遺失' where label = 'warmer03' and type = '暖奶器';

-- 讓「切換狀態」RPC 亦接受「遺失」
create or replace function update_vacuum_status(p_password text, p_id int, p_status text)
returns vacuums language plpgsql security definer set search_path = public, extensions as $$
declare rec vacuums;
begin
  perform _require_admin(p_password);
  if p_status not in ('正常', '維修中', '報廢', '遺失') then raise exception 'invalid status'; end if;
  update vacuums set status = p_status where id = p_id returning * into rec;
  if not found then raise exception 'vacuum not found'; end if;
  return rec;
end $$;
create or replace function update_equipment_status(p_password text, p_id int, p_status text)
returns equipment language plpgsql security definer set search_path = public, extensions as $$
declare rec equipment;
begin
  perform _require_admin(p_password);
  if p_status not in ('正常', '維修中', '報廢', '遺失') then raise exception 'invalid status'; end if;
  update equipment set status = p_status where id = p_id returning * into rec;
  if not found then raise exception 'equipment not found'; end if;
  return rec;
end $$;

select count(*) as 仍有簡體 from vacuum_maintenance where description ~ '[坏仓库报废处换变为机备枪尘挂销电头货楼损轮]';
