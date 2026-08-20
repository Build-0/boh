-- Import generated from the two Excel workbooks. Run ONCE in Supabase SQL Editor.
-- (Needs schema.sql + schema_modules.sql + schema_equipment.sql already run.)
alter table vacuums   add column if not exists label text;
alter table vacuums   add column if not exists serial text;
alter table equipment add column if not exists label text;
alter table equipment add column if not exists serial text;

-- Update upsert RPCs so admin edits also save label/serial
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
      status=coalesce(nullif(p_vacuum->>'status',''),status), image=coalesce(p_vacuum->>'image',image),
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
      image=coalesce(p_equipment->>'image',image), notes=p_equipment->>'notes',
      sort_order=coalesce(nullif(p_equipment->>'sort_order','')::int,sort_order)
    where id=eid returning * into rec;
    if not found then raise exception 'equipment not found'; end if;
  end if;
  return rec;
end $$;

-- Vacuums (110)
insert into vacuums (model, brand, serial, floor_code, label, status, notes, sort_order) values
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '191400025', 'Warehouse', 'S33', '維修中', '到貨 2019-11-07；編號 14', 1),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000001', 'Warehouse', 'S32', '正常', '到貨 2020-02-26；編號 44', 2),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200082', 'Warehouse', 'S31', '正常', '到貨 2019-11-07；編號 43', 3),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000081', 'Warehouse', 'S30', '正常', '到貨 2020-02-26；編號 42', 4),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000031', 'Warehouse', 'S27', '正常', '到貨 2020-02-26；編號 97', 5),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000033', 'Warehouse', 'S28', '正常', '到貨 2020-02-26；編號 96', 6),
  ('Nilfisk (VP304 HEPA UK)', 'Nilfisk', '194500039', 'Warehouse', '05C', '正常', '編號 95', 7),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500050', 'Warehouse', 'S26', '正常', '到貨 2020-02-26；編號 4', 8),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000047', 'Warehouse', 'S25', '正常', '到貨 2020-02-26；編號 5；2.24.9.30接觸不良', 9),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000003', 'Warehouse', 'S24', '正常', '到貨 2020-02-26；編號 3', 10),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500051', 'Warehouse', 'S23', '正常', '到貨 2020-02-26；編號 34', 11),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '191400019', 'Warehouse', 'S22', '正常', '到貨 2019-11-07；編號 30', 12),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000043', 'Warehouse', 'S21', '正常', '到貨 2019-11-22；編號 32', 13),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000034', 'Warehouse', 'S20', '正常', '到貨 2020-02-26；編號 31', 14),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '191400018', 'Warehouse', 'S19', '正常', '到貨 2019-11-07；編號 33', 15),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000017', 'Warehouse', 'S18', '正常', '到貨 2020-02-26；編號 35', 16),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200083', 'Warehouse', 'S17', '正常', '到貨 2020-02-26；編號 41', 17),
  ('Nilfisk (VP305 HEPA UK)', 'Nilfisk', '194500038', 'Warehouse', 'S16', '正常', '到貨 2020-02-26；編號 37', 18),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000049', '3F', 'S14', '正常', '到貨 2020-02-26；編號 36', 19),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000006', '3F', '03D', '維修中', '到貨 2020-02-26；編號 21', 20),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000019', 'Warehouse', 'S12', '維修中', '到貨 2020-02-26；編號 20', 21),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000045', 'Warehouse', 'S11', '正常', '到貨 2020-02-26；編號 40', 22),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000050', 'Warehouse', 'S10', '正常', '到貨 2020-02-26；編號 58', 23),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000036', 'Warehouse', 'S09', '正常', '到貨 2020-02-26；編號 48', 24),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000011', '6F', '6F', '正常', '到貨 2020-02-26；編號 28', 25),
  ('Nilfisk (VP301 HEPA UK)', 'Nilfisk', '194500040', 'Warehouse', 'S07', '正常', '到貨 2020-02-26；編號 47', 26),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200037', 'Warehouse', 'S06', '維修中', '到貨 2019-11-07；編號 17', 27),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000020', '4F', '04B', '正常', '到貨 2020-02-26；編號 45', 28),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000021', 'Warehouse', 'S04', '維修中', '到貨 2020-02-26；編號 15', 29),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200024', 'Warehouse', 'S03', '報廢', '到貨 2019-11-07；編號 54', 30),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000039', 'Warehouse', 'S02', '報廢', '到貨 2019-11-22；編號 82', 31),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000016', 'Warehouse', 'S01', '正常', '到貨 2020-02-26；編號 46', 32),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500014', 'Uniform room', 'PA5', '正常', '到貨 2019-11-22；編號 27', 33),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000013', 'chemical room', 'PA4', '正常', '到貨 2020-02-26；編號 39', 34),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000040', 'Near 1F Luggage Room Pantry', 'PA3', '正常', '到貨 2019-11-22；編號 29', 35),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500055', '1F Mall Ｎear Stanley café Pantry', 'PA2', '正常', '到貨 2020-02-26；編號 70；原4A更換為備用S02；原S02變更為PA2', 36),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000029', '1F Mall Ｎear Stanley café Pantry', 'PA1', '維修中', '到貨 2020-02-26；編號 18', 37),
  ('Nilfisk (VP300 HEPA UK) （backpack)', 'Nilfisk', '193300009', 'Equipment room', 'NEW', '正常', '到貨 2019-11-22；編號 38', 38),
  ('Nilfisk (VP300 HEPA UK) （backpack)', 'Nilfisk', '193300012', 'Warehouse', 'B4', '正常', '到貨 2019-11-22；編號 9', 39),
  ('Nilfisk (VP300 HEPA UK) （backpack)', 'Nilfisk', '193300039', 'Warehouse', 'B3', '正常', '到貨 2019-11-22；編號 8', 40),
  ('Nilfisk (VP300 HEPA UK) （backpack)', 'Nilfisk', '193300008', 'Warehouse', 'B2', '正常', '到貨 2019-11-22；編號 7', 41),
  ('Nilfisk (VP300 HEPA UK) （backpack)', 'Nilfisk', '193300007', 'Warehouse', 'B1', '正常', '到貨 2019-11-22；編號 6', 42),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150245', '9F', '9F', '正常', '到貨 2025-11-20；編號 106', 43),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150244', '9F', '9E', '正常', '到貨 2025-11-20；編號 105', 44),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150243', '9F', '9D', '正常', '到貨 2025-11-20；編號 104', 45),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150242', '9F', '9C', '正常', '到貨 2025-11-20；編號 103', 46),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150241', '9F', '9B', '正常', '到貨 2025-11-20；編號 102', 47),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150240', '9F', '9A', '正常', '到貨 2025-11-20；編號 101', 48),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150246', '8F', '8C', '正常', '到貨 2025-11-20；編號 107', 49),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150247', '8F', '8B', '正常', '到貨 2025-11-20；編號 108', 50),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150248', '8F', '8A', '正常', '到貨 2025-11-20；編號 109', 51),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000080', '7F', '7D', '維修中', '到貨 2020-02-26；編號 16', 52),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000021', '6F', '6A', '維修中', '到貨 2020-02-26；編號 19', 53),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000004', '3F', '3E', '正常', '到貨 2020-02-26；編號 76', 54),
  ('Nilfisk (VP302 HEPA UK)', 'Nilfisk', '194500044', '3F', '3A', '維修中', '到貨 2020-02-26；編號 22', 55),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117414', '12F', '12F', '正常', '到貨 2023-08-24；編號 85', 56),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117412', '12F', '12E', '正常', '到貨 2023-08-24；編號 84', 57),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117410', '12F', '12D', '正常', '到貨 2023-08-24；編號 83', 58),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147191', '12F', '12C', '正常', '到貨 2025-03-17；編號 87', 59),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147240', '12F', '12B', '正常', '到貨 2025-03-17；編號 86', 60),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147239', '12F', '12A', '正常', '到貨 2025-03-17；編號 25', 61),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117415', '11F', '11F', '正常', '到貨 2023-08-24；編號 91', 62),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117416', '11F', '11E', '正常', '到貨 2023-08-24；編號 90', 63),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117419', '11F', '11D', '正常', '到貨 2023-08-24；編號 89', 64),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117408', '11F', '11C', '正常', '到貨 2023-08-24；編號 92', 65),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147190', '11F', '11B', '正常', '到貨 2025-03-17；編號 93', 66),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117411', '11F', '11A', '正常', '到貨 2023-08-24；編號 94', 67),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117418', '10F', '10F', '正常', '到貨 2023-08-24；編號 79', 68),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147193', '10F', '10E', '正常', '到貨 2025-03-17；編號 24', 69),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147188', '10F', '10D', '正常', '到貨 2025-03-17；編號 26', 70),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147192', '10F', '10C', '正常', '到貨 2025-03-17；編號 99', 71),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147189', '10F', '10B', '正常', '到貨 2025-03-17；編號 98', 72),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147187', '10F', '10A', '正常', '到貨 2025-03-17；編號 100', 73),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500049', 'Warehouse', 'S34', '正常', '到貨 2020-02-26；編號 51', 74),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000007', 'Warehouse', 'S15', '正常', '到貨 2019-11-22；編號 50', 75),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200070', '8F', '08D', '正常', '到貨 2019-11-07', 76),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '191400022', '7F', '07F', '正常', '到貨 2019-11-07', 77),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500056', '7F', '07E', '正常', NULL, 78),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '191400023', '7F', '07C', '正常', '到貨 2020-02-26', 79),
  ('Nilfisk (VP303 HEPA UK)', 'Nilfisk', '194500046', '7F', '07B', '正常', NULL, 80),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000046', 'Warehouse', 's08', '報廢', '到貨 2020-02-26；和備用機S8對換使用', 81),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000026', '6F', '06E', '正常', '到貨 2020-02-26', 82),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200010', '6F', '06D', '正常', '到貨 2019-11-07', 83),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000083', '6F', '06C', '正常', '到貨 2020-02-26', 84),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000025', '6F', '06B', '正常', '到貨 2020-02-26', 85),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '194500053', '5F', '05F', '正常', '到貨 2020-02-26；編號 69', 86),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000012', '5F', '05E', '正常', '到貨 2020-02-26；編號 68', 87),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000030', '5F', '05D', '正常', '到貨 2019-11-22；編號 67', 88),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000008', '5F', 'S29', '正常', '到貨 2020-02-26；編號 66', 89),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200079', '5F', '05B', '正常', '到貨 2019-11-07；編號 65', 90),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000027', '5F', '05A', '正常', '到貨 2019-11-22', 91),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000023', '4F', '04F', '正常', '到貨 2020-02-26', 92),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000032', '4F', '04E', '正常', '到貨 2020-02-26', 93),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000041', '4F', '04D', '正常', '到貨 2020-02-26', 94),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000015', '4F', '04C', '正常', '到貨 2020-02-26', 95),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200071', 'Warehouse', 'S05', '正常', '到貨 2019-11-07', 96),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000018', '4F', '04A', '維修中', '到貨 2020-02-26；原S02更換為備用機04A', 97),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000022', 'Warehouse', 'S13', '正常', '到貨 2020-02-26；原03D更換備用機S13', 98),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000024', '3F', '03C', '正常', '到貨 2020-02-26；原備用機S11', 99),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '193200094', 'Warehouse', 's35', '正常', '到貨 2019-11-07', 100),
  ('Wetrok Type Durovac 11', 'Wetrok', '40733-1147238', '8F', '8F', '正常', '到貨 2025-03-17', 101),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731-1150249', '3F', '3B', '正常', '到貨 2025-11-20', 102),
  ('Wetrok Type Durovac 11', 'Wetrok', '40731 - 1117409', '8F', '8E', '正常', '到貨 2023-08-24', 103),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000035', '7F', '43887', '正常', NULL, 104),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000048', NULL, NULL, '報廢', '待報銷/已報廢；到貨 2019-11-07；原3C塵機', 105),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '191400009', NULL, NULL, '報廢', '待報銷/已報廢；到貨 2019-11-07；Waiting for  disposal；等待報銷', 106),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000044', NULL, NULL, '報廢', '待報銷/已報廢；到貨 2020-02-26；Waiting for  disposal；等待報銷', 107),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000028', NULL, NULL, '報廢', '待報銷/已報廢；到貨 2020-02-26；Waiting for  disposal；等待報銷', 108),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000038', NULL, NULL, '報廢', '待報銷/已報廢；到貨 2019-11-07；Waiting for  disposal；等待報銷', 109),
  ('Nilfisk (VP300 HEPA UK)', 'Nilfisk', '195000002', NULL, NULL, '報廢', '待報銷/已報廢；到貨 2019-11-22；Waiting for  disposal；等待報銷', 110);

-- Vacuum maintenance (231) — linked by label
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-05', '2025.11.5本機S03與9F對換使用' from vacuums where label = 'S33' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S33' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-30', '2024.9.30接觸不良' from vacuums where label = 'S32' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-12-02', '2024.12.2更換耙頭' from vacuums where label = 'S32' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-07', '2025.10.7更換耙頭' from vacuums where label = 'S32' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S32' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-07-14', '2024.7.14電源綫坏' from vacuums where label = 'S31' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-23', '2024.10.23不通電' from vacuums where label = 'S31' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S31' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-19', '2024.8.19更換耙頭' from vacuums where label = 'S30' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和S6更換外殼' from vacuums where label = 'S30' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-02', '2025.8.2不通電' from vacuums where label = 'S30' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-09', '2025.10.9不通電' from vacuums where label = 'S30' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S30' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-19', '2024.8.19更換耙頭' from vacuums where label = 'S27' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和S10更換外殼' from vacuums where label = 'S27' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-30', '2025.8.30原10F变更为备用机S29' from vacuums where label = 'S27' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-15', '2024.9.15更換吸塵機耙頭' from vacuums where label = 'S28' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-08', '2025.2.8更換塵機耙頭及鐵管' from vacuums where label = 'S28' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-06', '2025.7.6二檔開關坏' from vacuums where label = 'S28' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-30', '2025.8.30原10E变更为备用机S28' from vacuums where label = 'S28' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-29', '2024.8.29更換耙頭' from vacuums where label = '05C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-12-01', '2024.12.1不通電' from vacuums where label = '05C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-06', '2025.2.6更換耙頭 不鏽鋼伸縮管' from vacuums where label = '05C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-15', '2025.5.15不通電' from vacuums where label = '05C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-30', '2025.8.30原10D变更为备用机S27' from vacuums where label = '05C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-06-24', '2026.6.24與5C更換使用' from vacuums where label = '05C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-19', '2024.8.19更換耙頭 不鏽鋼伸縮管' from vacuums where label = 'S26' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-07', '2025.2.7更換耙頭 不鏽鋼伸縮管' from vacuums where label = 'S26' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025.4.3原10B塵機被替換做備用機' from vacuums where label = 'S26' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-28', '2024.8.28更換耙頭' from vacuums where label = 'S25' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025.4.3原10C塵機被替換做備用機' from vacuums where label = 'S25' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-19', '2024.8.19電源綫坏' from vacuums where label = 'S24' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025.4.3原10A塵機被替換做備用機' from vacuums where label = 'S24' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-03-20', '2024.3.20原12B變更為S23' from vacuums where label = 'S23' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-19', '2024.8.19電源綫坏' from vacuums where label = 'S22' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-03-20', '2024.3.20原11A變更為S22' from vacuums where label = 'S22' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-03-20', '2024.3.20原11C變更為S21' from vacuums where label = 'S21' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-25', '2024.8.25 更換耙頭' from vacuums where label = 'S20' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-24', '2025.1.24更換耙頭' from vacuums where label = 'S20' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-16', '2025.2.16更換耙頭' from vacuums where label = 'S20' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-03-20', '2024.3.20原11B變更為S20' from vacuums where label = 'S20' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-29', '2025.1.29不通電' from vacuums where label = 'S19' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-03-20', '2024.3.20原12A變更為S19' from vacuums where label = 'S19' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-03', '2024.9.3不通電' from vacuums where label = 'S18' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-03-20', '2024.3.20原12C變更為S18' from vacuums where label = 'S18' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-06-14', '2024.6.14電源綫坏' from vacuums where label = 'S17' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-11-17', '2024.11.17更換吸塵機管卡扣' from vacuums where label = 'S17' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-25', '2025.7.25電源不通電' from vacuums where label = 'S17' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S17' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-19', '2026.2.19原S13更換為03D' from vacuums where label = '03D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和3A更換外殼' from vacuums where label = 'S12' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-03', '2025.11.3不通電' from vacuums where label = 'S12' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-15', '2024.9.15更換吸塵機耙頭' from vacuums where label = 'S11' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-06-24', '2025.6.24不通電' from vacuums where label = 'S11' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S11' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-20', '2024.10.20不通電' from vacuums where label = 'S10' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-01-17', '原6A  2026.1.17與S10更換主機' from vacuums where label = 'S10' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-19', '2024.10.19不通電' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-04', '2025.3.4通電無反應' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-27', '2025.5.27更換葩頭' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-29', '2025.5.29不通電' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-21', '2025.7.21更换防尘罩' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-16', '2025.9.16不通電' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-04', '2025.11.4不通電' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S09' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-10', '2025.2.10原S9替換PA1使用' from vacuums where label = '6F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-04', '2026.2.4原PA1替換為備用機S8' from vacuums where label = '6F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-04', '2026.2.4 不通電' from vacuums where label = '6F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-19', '2026.7.19改爲3F備用機使用' from vacuums where label = '6F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-26', '2026.7.26本機S8上樓6F使用' from vacuums where label = '6F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-28', '2025.2.28通電無反應' from vacuums where label = 'S07' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-28', '2025.4.28 插頭爛' from vacuums where label = 'S07' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-14', '2025.8.14更換耙頭' from vacuums where label = 'S07' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S07' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和9C更換外殼' from vacuums where label = 'S06' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和S17更換外殼' from vacuums where label = '04B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-20', '2025.5.20接觸不良' from vacuums where label = '04B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-07', '2025.10.7更換耙頭' from vacuums where label = '04B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-02', '2025.11.2本機9F和S05對調使用' from vacuums where label = '04B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-19', '2026.7.19本機S05與4B對調使用' from vacuums where label = '04B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-25', '2024.10.25不通電' from vacuums where label = 'S04' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-23', '2025.2.23換塵機外殼' from vacuums where label = 'S04' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-17', '2025.3.17更換塵機耙頭，塵機管' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-24', '2025.7.24更換耙頭' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-28', '2025.10.28不通電' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-28', '2025.10.28本機7D與S5個對換使用' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-02', '2025.11.2本機S05和9F對換使用' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-05', '2025.11.5摩打膠邊固定坏無法使用' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-05', '2025.11.5本機9F與S03對換使用' from vacuums where label = 'S03' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-08', '2025.2.8不通電' from vacuums where label = 'S02' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-04', '2026.2.4 馬達異鄉' from vacuums where label = 'S02' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-04', '2026.2.4原PA2替換為備用機S02' from vacuums where label = 'S02' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-04', '2026.2.4摩打燒 無法使用' from vacuums where label = 'S02' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-09', '2024.10.9更換塵機耙頭' from vacuums where label = 'S01' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-27', '2025.5.27更換耙頭' from vacuums where label = 'S01' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-12', '2025.7.12更換塵袋' from vacuums where label = 'S01' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-31', '2025.10.31更換塵機管' from vacuums where label = 'S01' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-06', '2025.12.06收回倉庫' from vacuums where label = 'S01' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-26', '2024.10.26不通電' from vacuums where label = 'PA3' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-04', '2024.9.4接觸不良' from vacuums where label = 'PA2' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-11-07', '2024.11.7更換鉄管' from vacuums where label = 'PA2' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-15', '2025.2.15異響' from vacuums where label = 'PA2' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-11', '2025.3.11防塵罩更換' from vacuums where label = 'PA2' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-26', '2025.7.26更換耙頭' from vacuums where label = 'PA2' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-29', '2025.10.29插頭坏' from vacuums where label = 'PA2' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-04', '2026.2.4原S08替換給PA1使用' from vacuums where label = 'PA1' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '9F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '9E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-08-10', '2026.8.10塵機輪骨斷' from vacuums where label = '9E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '9D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '9C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '9B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-01-24', '2026.1.24 更換塵機管挂鈎' from vacuums where label = '9B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '9A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '8C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '8B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-03', '2025.12.03上樓使用' from vacuums where label = '8A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和6D更換外殼' from vacuums where label = '7D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-28', '2025.10.28本機S05和7D對換使用' from vacuums where label = '7D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和10F更換外殼' from vacuums where label = '6A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-01-17', '原S10 2026.1.17 與6A更換主機' from vacuums where label = '6A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和S12更換外殼' from vacuums where label = '3E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-24', '2025.4.24 更換伸縮管' from vacuums where label = '3E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-01', '2025.10.1更換耙頭' from vacuums where label = '12E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-19', '2025.1.19更换枪管插销' from vacuums where label = '12D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-19', '2025.5.19更換塵機卡扣' from vacuums where label = '12D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-12', '2025.7.12無法通電' from vacuums where label = '12D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-11', '2025.12.11上樓使用' from vacuums where label = '12A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-12-16', '2024.12.16不通電' from vacuums where label = '11F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-19', '2025.1.19更换枪管插销' from vacuums where label = '11F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-11', '2024.8.11 更換耙頭' from vacuums where label = '11E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-24', '2025.1.24不通電' from vacuums where label = '11E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-19', '2025.1.19更换枪管挂鈎' from vacuums where label = '11D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-24', '2025.1.24 更換塵機頭' from vacuums where label = '11D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025/4/3上樓使用' from vacuums where label = '11C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025/4/3上樓使用' from vacuums where label = '11B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025/4/3上樓使用' from vacuums where label = '11A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-13', '2025.7.13不通電' from vacuums where label = '10F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-30', '2025.8.30原3F变更为10F' from vacuums where label = '10F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-25', '2025.7.25更換耙頭' from vacuums where label = '10F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-01-06', '2026.1.6更換塵機頭' from vacuums where label = '10F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025/4/3上樓使用' from vacuums where label = '10C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-11', '2025/12/11 更換電綫' from vacuums where label = '10C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025/4/3上樓使用' from vacuums where label = '10B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025/4/3上樓使用' from vacuums where label = '10A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-24', '2024.8.24更換耙頭，不鏽鋼伸縮管' from vacuums where label = 'S34' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-01', '2025.8.1更換耙頭' from vacuums where label = 'S34' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-07', '2025.9.7不通電' from vacuums where label = 'S34' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-08', '2025.10.8不通電' from vacuums where label = 'S34' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-03-02', '2026.3.2更換為備用機使用' from vacuums where label = 'S34' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-13', '2024.8.13 更換耙頭' from vacuums where label = 'S15' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-12-02', '2024.12.2不通電' from vacuums where label = 'S15' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-04', '2025.8.4更換耙頭' from vacuums where label = 'S15' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-03-02', '2026.3.2更換為備用機使用' from vacuums where label = 'S15' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-17', '2025.4.17通電無反應' from vacuums where label = '08D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-13', '2025.7.13不通電' from vacuums where label = '08D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-28', '2024.8.28更換耙頭' from vacuums where label = '07F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-30', '2024.9.30接觸不良' from vacuums where label = '07F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-05', '2025.8.5更換耙頭' from vacuums where label = '07F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-06-24', '2026.6.24更換塵機管槍頭，原槍頭爛' from vacuums where label = '07E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-17', '2024.9.17電源綫坏' from vacuums where label = 's08' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-21', '2024.9.21電源綫不通電' from vacuums where label = 's08' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-25', '2025.7.25不通电' from vacuums where label = 's08' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-17', '2025.10.17接觸不良' from vacuums where label = 's08' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-26', '2026.7.26 摩打燒無法使用' from vacuums where label = 's08' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-27', '2025.4.27 接觸不良' from vacuums where label = '06E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-01-24', '2025.1.24不通電' from vacuums where label = '06D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和S5更換外殼' from vacuums where label = '06D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-07-02', '2024.7.2擋位坏' from vacuums where label = '06C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-15', '2024.8.15 更換耙頭' from vacuums where label = '06C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-03', '2025.2.3不通電' from vacuums where label = '06C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.03.21和S01更換外殼' from vacuums where label = '06C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-06-18', '2024.6.18換新耙頭' from vacuums where label = '06B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-05', '2025.2.5不通電' from vacuums where label = '06B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-20', '2025.2.20不通電' from vacuums where label = '06B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-06-07', '2025.06.07不通電' from vacuums where label = '06B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-18', '2024.8.18 換吸塵器耙頭' from vacuums where label = '05E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-17', '2024.10.17不通電' from vacuums where label = '05E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-24', '2025.4.24 不通電' from vacuums where label = '05E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-21', '2024.8.21 電源綫坏' from vacuums where label = '05D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-05', '2024.10.5更換塵機耙頭' from vacuums where label = '05D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-27', '2025.9.27更換耙頭' from vacuums where label = '05D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-06-24', '2026.6.24改為備用機S29' from vacuums where label = 'S29' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-19', '2024.9.19電源綫壞' from vacuums where label = '05B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-09', '2025.9.9更換耙頭' from vacuums where label = '05B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-20', '2025.9.20更換耙頭' from vacuums where label = '05B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-29', '2024.8.29更換耙頭' from vacuums where label = '05A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-08-03', '2025.8.3接觸不良' from vacuums where label = '05A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-15', '2025.10.15塵機管接頭坏' from vacuums where label = '05A' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-11', '2024.9.11電源綫坏' from vacuums where label = '04F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-09', '2024.10.9更換塵機耙頭' from vacuums where label = '04F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.3.21和S4更換外殼' from vacuums where label = '04F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-03', '2025.4.3不通電' from vacuums where label = '04F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-13', '2025.7.13不通電' from vacuums where label = '04F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-23', '2025.4.23更换耙头' from vacuums where label = '04D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-12', '2025.10.12更換耙頭' from vacuums where label = '04D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-11-03', '2025.11.3不通電' from vacuums where label = '04D' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-09-02', '2024.9.2更換耙頭' from vacuums where label = '04C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-10-01', '2024.10.1接觸不良' from vacuums where label = '04C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-21', '2025.03.21和S11更換外殼' from vacuums where label = '04C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-16', '2025.9.16更換耙頭' from vacuums where label = '04C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-16', '2024.8.16電源綫坏' from vacuums where label = 'S05' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-01', '2025.2.1不通電' from vacuums where label = 'S05' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-19', '2026.7.19綫太短與S5對換' from vacuums where label = 'S05' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-02-19', '2026.2.19吸力小' from vacuums where label = 'S13' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-25', '2025.2.25替換3C' from vacuums where label = '03C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-14', '2025.9.14更換耙頭' from vacuums where label = '03C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-10-17', '2025.10.17更換耙頭' from vacuums where label = '03C' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-28', '2024.8.28  更換耙頭' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-03-03', '2025.3.3通電無反應' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-04-20', '2025.4.20通電無反應' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-02', '2025.5.2 更換耙頭 伸縮管' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-05-15', '2025.5.15更換耙頭' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-09-14', '2025.9.14更換耙頭' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-07', '2026.7.7 收回倉庫做備用機使用' from vacuums where label = 's35' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-12-11', '2025.12.11 底部爛 與備用機兌換' from vacuums where label = '8F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-03-02', '2026.3.2上樓使用' from vacuums where label = '8F' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-07-07', '2026.7.7上樓使用' from vacuums where label = '3B' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2026-03-02', '2026.3.2上樓使用' from vacuums where label = '8E' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '225-10-09', '20225.10/9不通電' from vacuums where label = '43887' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-08-29', '2024.8.29更換耙頭' from vacuums where serial = '195000048' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2024-12-01', '2024.12.1不通電' from vacuums where serial = '195000048' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-22', '2025.2.22塵機異鄉，摩打坏' from vacuums where serial = '195000048' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-22', '2025/7/22 已报废处理' from vacuums where serial = '195000048' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-22', '2025/7/22 已报废处理' from vacuums where serial = '191400009' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-22', '2025/7/22 已报废处理' from vacuums where serial = '195000044' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-02-10', '2025.2.10原PA1' from vacuums where serial = '195000028' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-22', '2025/7/22 已报废处理' from vacuums where serial = '195000028' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-22', '2025/7/22 已报废处理' from vacuums where serial = '195000038' limit 1;
insert into vacuum_maintenance (vacuum_id, service_date, description) select id, '2025-07-22', '2025/7/22 已报废处理' from vacuums where serial = '195000002' limit 1;

-- Equipment (113)
insert into equipment (type, floor_code, label, serial, status, sort_order) values
  ('空氣清新機', '105', NULL, '910160077', '正常', 1),
  ('空氣清新機', '倉庫', 'puri002', '912240184', '正常', 2),
  ('空氣清新機', '辦公室', 'puri003', '912240152', '正常', 3),
  ('空氣清新機', '倉庫', 'puri004', '912240227', '正常', 4),
  ('空氣清新機', '108', NULL, '912240175', '正常', 5),
  ('空氣清新機', '倉庫', 'puri006', '910160067', '正常', 6),
  ('空氣清新機', '110', NULL, '912240206', '正常', 7),
  ('空氣清新機', '辦公室', 'puri008', '912240254', '正常', 8),
  ('空氣清新機', '112', NULL, '912240202', '正常', 9),
  ('空氣清新機', '洗衣房', 'puri010', '912240255', '正常', 10),
  ('空氣清新機', '倉庫', 'puri011', '912240207', '正常', 11),
  ('空氣清新機', '115', NULL, '912240221', '正常', 12),
  ('空氣清新機', '辦公室', 'puri013', '912240176', '正常', 13),
  ('空氣清新機', '倉庫', 'puri014', '910160116', '正常', 14),
  ('空氣清新機', '工程部（上次檢查地點）', 'puri015', '912240165', '正常', 15),
  ('空氣清新機', '8F', 'puri016', '912240201', '正常', 16),
  ('空氣清新機', '11F', 'puri017', '912240226', '正常', 17),
  ('空氣清新機', '倉庫', 'puri018', '912240224', '正常', 18),
  ('空氣清新機', '倉庫', 'puri019', '910160055', '正常', 19),
  ('空氣清新機', '辦公室', 'puri020', '910160121', '正常', 20),
  ('空氣清新機', '124', NULL, '91224x226', '正常', 21),
  ('空氣清新機', '倉庫', 'puri022', '910160117', '正常', 22),
  ('空氣清新機', '126', NULL, '910160042', '正常', 23),
  ('空氣清新機', '倉庫', 'puri024', '912240171', '正常', 24),
  ('空氣清新機', '132', NULL, '912240151', '正常', 25),
  ('空氣清新機', '前臺(新增）', '無編號', '910160056', '正常', 26),
  ('抽濕機', '96', NULL, '正常', '正常', 27),
  ('抽濕機', '辦公室', 'Dehumidifier02', '正常', '正常', 28),
  ('抽濕機', '倉庫', 'Dehumidifier03', '正常', '正常', 29),
  ('抽濕機', '乾净布草房', 'Dehumidifier04', '正常', '正常', 30),
  ('抽濕機', '辦公室', 'Dehumidifier05', '正常', '正常', 31),
  ('抽濕機', '辦公室', 'Dehumidifier06', '正常', '正常', 32),
  ('抽濕機', '財務部（上次保養地點）', 'dehumidifier07', '正常', '正常', 33),
  ('加濕機', 'warehourse', 'humi001', '開機無反應', '報廢', 34),
  ('加濕機', 'warehourse', 'humi002', '正常', '正常', 35),
  ('加濕機', 'warehourse', 'humi003', '正常', '正常', 36),
  ('加濕機', 'warehourse', 'humi004', '正常', '正常', 37),
  ('加濕機', 'warehourse', 'humi005', '正常', '正常', 38),
  ('加濕機', 'warehourse', 'humi006', '正常', '正常', 39),
  ('加濕機', 'warehourse', 'humi007', '正常', '正常', 40),
  ('加濕機', 'warehourse', 'humi008', '正常', '正常', 41),
  ('加濕機', 'warehourse', 'humi009', '正常', '正常', 42),
  ('加濕機', 'warehourse', 'humi010', '正常', '正常', 43),
  ('燙斗', '倉庫', 'iron01', '燙面花', '正常', 44),
  ('燙斗', '倉庫', 'iron02', '正常', '正常', 45),
  ('燙斗', '倉庫', 'iron03', '染色', '正常', 46),
  ('燙斗', '倉庫', 'iron04', '正常', '正常', 47),
  ('燙斗', '倉庫', 'iron05', '殼爛', '正常', 48),
  ('燙斗', '倉庫', 'iron06', '燙面花', '正常', 49),
  ('燙斗', '倉庫', 'iron07', '正常', '正常', 50),
  ('燙斗', '倉庫', 'iron08', '正常', '正常', 51),
  ('燙斗', '倉庫', 'iron09', '正常', '正常', 52),
  ('燙斗', '倉庫', 'iron10', '燙面花', '正常', 53),
  ('燙斗', '倉庫', 'iron11', '破損，待報廢', '正常', 54),
  ('燙斗', '倉庫', 'iron12', '殼爛', '正常', 55),
  ('燙斗', '倉庫', 'iron13', '燙面花', '正常', 56),
  ('燙斗', '倉庫', 'iron14', '正常', '正常', 57),
  ('燙斗', '倉庫', 'iron15', '正常', '正常', 58),
  ('燙斗', '倉庫', 'iron16', '燙面花', '正常', 59),
  ('燙斗', '倉庫', 'iron17', '正常', '正常', 60),
  ('燙斗', '倉庫', 'iron18', '正常', '正常', 61),
  ('燙斗', '倉庫', 'iron19', '燙面花 殼爛', '正常', 62),
  ('燙斗', '倉庫', 'iron20', '正常', '正常', 63),
  ('燙斗', '8F消防梯', 'iron21', '正常', '正常', 64),
  ('燙斗', '倉庫', 'iron22', '正常', '正常', 65),
  ('燙斗', '倉庫', 'iron23', '正常', '正常', 66),
  ('燙斗', '倉庫', 'iron24', '正常', '正常', 67),
  ('燙斗', '190', NULL, '燙麵膠漬，待報損', '正常', 68),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 69),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 70),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 71),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 72),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 73),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 74),
  ('燙斗', '192', NULL, '正常', '正常', 75),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 76),
  ('燙斗', '倉庫', 'iron26', '正常', '正常', 77),
  ('燙斗', '192', NULL, '正常', '正常', 78),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer01', '開機自動息屏', '報廢', 79),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer02', '正常', '正常', 80),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer03', '屏顯坏', '報廢', 81),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer04', '開關無反應', '報廢', 82),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer05', '正常', '正常', 83),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer06', '通電無反應', '報廢', 84),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer07', '正常', '正常', 85),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer08', '正常', '正常', 86),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer09', '無法修復', '正常', 87),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer10', '消毒功能無法調節', '報廢', 88),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer11', '正常', '正常', 89),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer12', '未開封', '正常', 90),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer13', '未開封', '正常', 91),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer14', '未開封', '正常', 92),
  ('嬰兒奶瓶消毒器', '216', NULL, '正常', '正常', 93),
  ('暖奶器', '仓库', 'warmer01', '正常（少暖奶欄）', '正常', 94),
  ('暖奶器', '仓库', 'warmer02', '正常（少暖奶欄）', '正常', 95),
  ('暖奶器', '59', NULL, '45444', '正常', 96),
  ('暖奶器', '仓库', 'warmer04', '正常（少暖奶欄）', '正常', 97),
  ('暖奶器', '仓库', 'warmer05', '正常（少暖奶欄）', '正常', 98),
  ('暖奶器', '仓库', 'warmer06', '正常（少暖奶欄）', '正常', 99),
  ('暖奶器', '仓库', 'warmer07', '正常（少暖奶欄）', '正常', 100),
  ('暖奶器', '仓库', 'warmer08', '正常（少暖奶欄）', '正常', 101),
  ('暖奶器', '仓库', 'warmer09', '正常（少暖奶欄）', '正常', 102),
  ('暖奶器', '仓库', 'warmer10', '正常（少暖奶欄）', '正常', 103),
  ('臭氧機', '3F', 'T23JA097', '45474', '正常', 104),
  ('臭氧機', '4F', 'T19BA122', '43586', '正常', 105),
  ('臭氧機', '5F', 'T19BA121', '43586', '正常', 106),
  ('臭氧機', '6F', 'T19BA135', '43586', '正常', 107),
  ('臭氧機', '7F', 'T19BA133', '43586', '正常', 108),
  ('臭氧機', '8F', 'T19BA123', '43586', '正常', 109),
  ('臭氧機', '9F', 'T23JA099', '45474', '正常', 110),
  ('臭氧機', '10F', 'T23JA107', '45474', '正常', 111),
  ('臭氧機', '11F', 'T23JA101', '45474', '正常', 112),
  ('臭氧機', '12F', 'T23JA098', '45474', '正常', 113);

-- Equipment maintenance (254) — linked by type+serial(or label)
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160077' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160077' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160077' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160077' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240184' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240184' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240184' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240184' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240184' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240152' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240152' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240152' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240152' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240227' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240227' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240227' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240227' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240227' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240175' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240175' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240175' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240175' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160067' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160067' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160067' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160067' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160067' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240206' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240206' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240206' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240206' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240254' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240254' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240254' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240254' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240254' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240202' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240202' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240202' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240202' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240255' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240255' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240255' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240255' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240207' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240207' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240207' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240207' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240207' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240221' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240221' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240176' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240176' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240176' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240176' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240176' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160116' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160116' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160116' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160116' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160116' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240165' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240165' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240165' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240201' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240201' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240201' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240201' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240201' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240224' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240224' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240224' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240224' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240224' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160055' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160055' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160055' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160055' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160055' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160121' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160121' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160121' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160121' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='91224x226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='91224x226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='91224x226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='91224x226' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160117' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160117' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160117' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160117' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160117' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160042' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160042' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160042' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160042' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240171' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240171' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240171' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240171' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-14', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240151' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240151' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240151' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='912240151' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修記錄' from equipment where type='空氣清新機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='910160056' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修記錄' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where type='抽濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修記錄' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開機無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開機無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開機無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='加濕機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='染色' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='染色' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='殼爛' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='殼爛' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='破損，待報廢' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='殼爛' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='殼爛' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花 殼爛' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='燙面花 殼爛' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修記錄' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='燙斗' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修記錄' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開機自動息屏' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開機自動息屏' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開機自動息屏' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修記錄' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='屏顯坏' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='屏顯坏' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='屏顯坏' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修記錄' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開關無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開關無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='開關無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修記錄' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='通電無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='通電無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='通電無反應' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修記錄' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='無法修復' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='無法修復' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='無法修復' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '維修記錄' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='消毒功能無法調節' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='嬰兒奶瓶消毒器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='消毒功能無法調節' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where type='暖奶器' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='正常（少暖奶欄）' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='45474' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='45474' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='43586' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='45474' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='45474' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='45474' limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修記錄' from equipment where type='臭氧機' and coalesce(nullif(serial,''), nullif(label,''), type||sort_order::text)='45474' limit 1;
