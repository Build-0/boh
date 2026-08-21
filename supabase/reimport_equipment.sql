-- 重新匯入設備（修正各表欄位錯位與保養記錄誤連）。在 SQL Editor 跑一次。
delete from equipment_maintenance;
delete from equipment;

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
  ('空氣清新機', '前臺(新增）', '無編號', '910160056', '維修中', 26),
  ('抽濕機', '96', NULL, NULL, '正常', 27),
  ('抽濕機', '辦公室', 'Dehumidifier02', NULL, '正常', 28),
  ('抽濕機', '倉庫', 'Dehumidifier03', NULL, '正常', 29),
  ('抽濕機', '乾净布草房', 'Dehumidifier04', NULL, '正常', 30),
  ('抽濕機', '辦公室', 'Dehumidifier05', NULL, '正常', 31),
  ('抽濕機', '辦公室', 'Dehumidifier06', NULL, '正常', 32),
  ('抽濕機', '財務部（上次保養地點）', 'dehumidifier07', NULL, '正常', 33),
  ('加濕機', 'warehourse', 'humi001', NULL, '報廢', 34),
  ('加濕機', 'warehourse', 'humi002', NULL, '正常', 35),
  ('加濕機', 'warehourse', 'humi003', NULL, '正常', 36),
  ('加濕機', 'warehourse', 'humi004', NULL, '正常', 37),
  ('加濕機', 'warehourse', 'humi005', NULL, '正常', 38),
  ('加濕機', 'warehourse', 'humi006', NULL, '正常', 39),
  ('加濕機', 'warehourse', 'humi007', NULL, '正常', 40),
  ('加濕機', 'warehourse', 'humi008', NULL, '正常', 41),
  ('加濕機', 'warehourse', 'humi009', NULL, '正常', 42),
  ('加濕機', 'warehourse', 'humi010', NULL, '正常', 43),
  ('燙斗', '倉庫', 'iron01', NULL, '維修中', 44),
  ('燙斗', '倉庫', 'iron02', NULL, '正常', 45),
  ('燙斗', '倉庫', 'iron03', NULL, '維修中', 46),
  ('燙斗', '倉庫', 'iron04', NULL, '正常', 47),
  ('燙斗', '倉庫', 'iron05', NULL, '維修中', 48),
  ('燙斗', '倉庫', 'iron06', NULL, '維修中', 49),
  ('燙斗', '倉庫', 'iron07', NULL, '正常', 50),
  ('燙斗', '倉庫', 'iron08', NULL, '正常', 51),
  ('燙斗', '倉庫', 'iron09', NULL, '正常', 52),
  ('燙斗', '倉庫', 'iron10', NULL, '維修中', 53),
  ('燙斗', '倉庫', 'iron11', NULL, '報廢', 54),
  ('燙斗', '倉庫', 'iron12', NULL, '維修中', 55),
  ('燙斗', '倉庫', 'iron13', NULL, '維修中', 56),
  ('燙斗', '倉庫', 'iron14', NULL, '正常', 57),
  ('燙斗', '倉庫', 'iron15', NULL, '正常', 58),
  ('燙斗', '倉庫', 'iron16', NULL, '維修中', 59),
  ('燙斗', '倉庫', 'iron17', NULL, '正常', 60),
  ('燙斗', '倉庫', 'iron18', NULL, '正常', 61),
  ('燙斗', '倉庫', 'iron19', NULL, '維修中', 62),
  ('燙斗', '倉庫', 'iron20', NULL, '正常', 63),
  ('燙斗', '8F消防梯', 'iron21', NULL, '正常', 64),
  ('燙斗', '倉庫', 'iron22', NULL, '正常', 65),
  ('燙斗', '倉庫', 'iron23', NULL, '正常', 66),
  ('燙斗', '倉庫', 'iron24', NULL, '正常', 67),
  ('燙斗', '190', NULL, NULL, '報廢', 68),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 69),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 70),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 71),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 72),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 73),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 74),
  ('燙斗', '192', NULL, NULL, '正常', 75),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 76),
  ('燙斗', '倉庫', 'iron26', NULL, '正常', 77),
  ('燙斗', '192', NULL, NULL, '正常', 78),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer01', NULL, '報廢', 79),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer02', NULL, '正常', 80),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer03', NULL, '報廢', 81),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer04', NULL, '報廢', 82),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer05', NULL, '正常', 83),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer06', NULL, '報廢', 84),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer07', NULL, '正常', 85),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer08', NULL, '正常', 86),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer09', NULL, '報廢', 87),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer10', NULL, '報廢', 88),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer11', NULL, '正常', 89),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer12', NULL, '維修中', 90),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer13', NULL, '維修中', 91),
  ('嬰兒奶瓶消毒器', '仓库', 'sterilizer14', NULL, '維修中', 92),
  ('嬰兒奶瓶消毒器', '216', NULL, NULL, '正常', 93),
  ('暖奶器', '仓库', 'warmer01', NULL, '正常', 94),
  ('暖奶器', '仓库', 'warmer02', NULL, '正常', 95),
  ('暖奶器', '59', NULL, NULL, '維修中', 96),
  ('暖奶器', '仓库', 'warmer04', NULL, '正常', 97),
  ('暖奶器', '仓库', 'warmer05', NULL, '正常', 98),
  ('暖奶器', '仓库', 'warmer06', NULL, '正常', 99),
  ('暖奶器', '仓库', 'warmer07', NULL, '正常', 100),
  ('暖奶器', '仓库', 'warmer08', NULL, '正常', 101),
  ('暖奶器', '仓库', 'warmer09', NULL, '正常', 102),
  ('暖奶器', '仓库', 'warmer10', NULL, '正常', 103),
  ('臭氧機', '3F', 'T23JA097', NULL, '正常', 104),
  ('臭氧機', '4F', 'T19BA122', NULL, '正常', 105),
  ('臭氧機', '5F', 'T19BA121', NULL, '正常', 106),
  ('臭氧機', '6F', 'T19BA135', NULL, '正常', 107),
  ('臭氧機', '7F', 'T19BA133', NULL, '正常', 108),
  ('臭氧機', '8F', 'T19BA123', NULL, '正常', 109),
  ('臭氧機', '9F', 'T23JA099', NULL, '正常', 110),
  ('臭氧機', '10F', 'T23JA107', NULL, '正常', 111),
  ('臭氧機', '11F', 'T23JA101', NULL, '正常', 112),
  ('臭氧機', '12F', 'T23JA098', NULL, '正常', 113);

-- 保養記錄（以 sort_order 精確連結，不再撞 key）
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=1 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=1 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=1 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=1 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=2 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=2 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=2 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=2 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=2 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=3 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=3 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=3 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=3 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=4 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=4 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=4 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=4 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=4 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=5 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=5 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=5 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=5 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=6 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=6 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=6 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=6 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=6 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=7 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=7 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=7 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=7 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=8 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=8 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=8 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=8 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=8 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=9 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=9 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=9 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=9 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=10 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=10 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=10 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=10 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=11 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=11 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=11 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=11 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=11 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=12 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=12 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=13 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=13 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=13 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=13 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=13 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=14 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=14 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=14 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=14 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=14 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=15 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=15 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=15 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=16 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=16 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=16 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=16 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=16 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=17 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=17 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=17 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=18 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=18 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=18 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=18 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=18 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=19 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=19 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=19 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=19 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=19 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=20 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=20 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=20 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=20 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=21 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=21 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=21 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=21 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=22 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=22 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=22 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=22 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=22 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=23 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-04', '保養/清潔' from equipment where sort_order=23 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=23 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=23 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=24 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=24 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=24 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=24 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-14', '維修' from equipment where sort_order=25 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=25 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=25 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=25 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=26 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-12', '2025.3.12開機異鄉' from equipment where sort_order=27 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '保養/清潔' from equipment where sort_order=27 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=27 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=27 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=28 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=28 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=28 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修' from equipment where sort_order=29 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=29 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=29 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=29 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修' from equipment where sort_order=30 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=30 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=30 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=30 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修' from equipment where sort_order=31 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=31 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=31 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=31 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=32 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=32 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=32 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=32 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-14', '維修' from equipment where sort_order=33 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=33 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-09', '保養/清潔' from equipment where sort_order=33 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '保養/清潔' from equipment where sort_order=34 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=34 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=34 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=35 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=35 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=35 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修' from equipment where sort_order=36 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=36 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=36 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=37 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=37 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=37 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修' from equipment where sort_order=38 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=38 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=38 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=39 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=39 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=39 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修' from equipment where sort_order=40 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=40 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=40 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修' from equipment where sort_order=41 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=41 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=41 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修' from equipment where sort_order=42 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=42 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=42 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-05-30', '維修' from equipment where sort_order=43 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=43 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=43 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=44 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=44 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=44 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=45 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=45 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=45 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=46 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=46 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=46 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=47 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=47 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=47 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=48 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=48 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=48 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=49 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=49 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=49 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=50 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=50 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=50 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=51 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=51 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=51 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=52 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=52 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=52 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=53 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=53 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=53 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=54 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=54 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=55 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=55 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=55 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=56 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=56 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=56 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=57 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=57 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=57 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=58 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=58 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=58 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=59 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=59 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=59 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=60 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=60 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=60 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=61 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=61 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=61 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=62 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=62 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=62 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=63 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=63 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=63 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '保養/清潔' from equipment where sort_order=64 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=64 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=64 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=65 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=65 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=65 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=66 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=66 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=66 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-10', '維修' from equipment where sort_order=67 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-09-27', '保養/清潔' from equipment where sort_order=67 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=67 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=69 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=70 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=71 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=72 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=73 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=74 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=76 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=77 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '保養/清潔' from equipment where sort_order=79 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=79 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=79 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=80 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=80 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=80 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '保養/清潔' from equipment where sort_order=81 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=81 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=81 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '保養/清潔' from equipment where sort_order=82 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=82 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=82 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=83 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=83 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=83 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '保養/清潔' from equipment where sort_order=84 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=84 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=84 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=85 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=85 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=85 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=86 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=86 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=86 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '保養/清潔' from equipment where sort_order=87 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=87 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=87 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=88 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=88 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=89 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=90 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=91 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '維修' from equipment where sort_order=92 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=94 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=94 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=94 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=95 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=95 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=95 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=97 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=97 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=97 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=98 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=98 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=98 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=99 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=99 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=99 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=100 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=100 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=100 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=101 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=101 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=101 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=102 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=102 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=102 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-01', '維修' from equipment where sort_order=103 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2025-03-31', '保養/清潔' from equipment where sort_order=103 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2026-07-10', '保養/清潔' from equipment where sort_order=103 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=104 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where sort_order=104 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-02', '維修' from equipment where sort_order=105 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where sort_order=105 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-04', '維修' from equipment where sort_order=106 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where sort_order=106 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修' from equipment where sort_order=107 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where sort_order=107 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-06-05', '維修' from equipment where sort_order=108 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where sort_order=108 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修' from equipment where sort_order=109 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '保養/清潔' from equipment where sort_order=110 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修' from equipment where sort_order=111 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修' from equipment where sort_order=112 limit 1;
insert into equipment_maintenance (equipment_id, service_date, description) select id, '2024-07-13', '維修' from equipment where sort_order=113 limit 1;
