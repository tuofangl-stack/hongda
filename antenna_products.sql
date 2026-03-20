-- =============================================
-- 天线产品数据（双语 CN/EN）
-- 执行此脚本前确保 t_product 和 t_type 表已存在
-- =============================================

-- ----------------------------
-- 清除旧示例数据
-- ----------------------------
DELETE FROM `t_product` WHERE `is_delete` = 0;
DELETE FROM `t_type` WHERE 1=1;

-- ----------------------------
-- 新增产品分类（天线）
-- ----------------------------
INSERT INTO `t_type` (`type_id`, `type_name`, `is_delete`, `create_time`) VALUES
(1, '5.8G抛物面天线 / 5.8G Parabolic Antenna', 0, NOW()),
(2, '2.4G抛物面天线 / 2.4G Parabolic Antenna', 0, NOW()),
(3, '1.35~1.85G抛物面天线 / 1.35~1.85G Parabolic Antenna', 0, NOW()),
(4, '900M抛物面天线 / 900M Parabolic Antenna', 0, NOW());

-- ----------------------------
-- 5.8G 抛物面天线系列 (4 products: 0.4m, 0.6m, 0.9m, 1.2m)
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
(
  '5.8G抛物面天线 0.4m / 5.8G Parabolic Antenna 0.4m',
  1, '/uploads/products/antenna_5g8_small.png', '["/uploads/products/antenna_5g8_small.png"]',
  '【中文】5.8G抛物面天线，口径0.4m。频率范围：5150~5850MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：24.8±1.5dBi | 水平波瓣宽度3dB：8.0° | 垂直波瓣宽度3dB：7.5° | 前后比≥25dB | 最大功率200W | 输入阻抗50Ω | 重量3kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，直径Φ48-Φ70mm | 接口：2×N-K (N-female)\n\n【English】5.8G Parabolic Antenna, Reflector Aperture 0.4m. Frequency Range: 5150~5850MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 24.8±1.5dBi | Horizontal 3dB Beamwidth: 8.0° | Vertical 3dB Beamwidth: 7.5° | Front-to-back Ratio: ≥25dB | Max CW Input Power: 200W | Impedance: 50Ω | Weight: 3kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Dia. Φ48-Φ70mm | Connector: 2×N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '5.8G抛物面天线 0.6m / 5.8G Parabolic Antenna 0.6m',
  1, '/uploads/products/antenna_5g8_small.png', '["/uploads/products/antenna_5g8_small.png"]',
  '【中文】5.8G抛物面天线，口径0.6m。频率范围：5150~5850MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：28±1dBi | 水平波瓣宽度3dB：6° | 垂直波瓣宽度3dB：5.5° | 前后比≥28dB | 最大功率200W | 输入阻抗50Ω | 重量6kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，直径Φ48-Φ70mm | 接口：2×N-K (N-female)\n\n【English】5.8G Parabolic Antenna, Reflector Aperture 0.6m. Frequency Range: 5150~5850MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 28±1dBi | Horizontal 3dB Beamwidth: 6° | Vertical 3dB Beamwidth: 5.5° | Front-to-back Ratio: ≥28dB | Max CW Input Power: 200W | Impedance: 50Ω | Weight: 6kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Dia. Φ48-Φ70mm | Connector: 2×N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '5.8G抛物面天线 0.9m / 5.8G Parabolic Antenna 0.9m',
  1, '/uploads/products/antenna_5g8_large.png', '["/uploads/products/antenna_5g8_large.png"]',
  '【中文】5.8G抛物面天线，口径0.9m。频率范围：5150~5850MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：32±1dBi | 水平波瓣宽度3dB：4° | 垂直波瓣宽度3dB：3.8° | 前后比≥30dB | 最大功率200W | 输入阻抗50Ω | 重量9kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，直径Φ48-Φ70mm | 接口：2×N-K (N-female)\n\n【English】5.8G Parabolic Antenna, Reflector Aperture 0.9m. Frequency Range: 5150~5850MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 32±1dBi | Horizontal 3dB Beamwidth: 4° | Vertical 3dB Beamwidth: 3.8° | Front-to-back Ratio: ≥30dB | Max CW Input Power: 200W | Impedance: 50Ω | Weight: 9kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Dia. Φ48-Φ70mm | Connector: 2×N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '5.8G抛物面天线 1.2m / 5.8G Parabolic Antenna 1.2m',
  1, '/uploads/products/antenna_5g8_large.png', '["/uploads/products/antenna_5g8_large.png"]',
  '【中文】5.8G抛物面天线，口径1.2m。频率范围：5150~5850MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：34.2±1dBi | 水平波瓣宽度3dB：3.3° | 垂直波瓣宽度3dB：3° | 前后比≥32dB | 最大功率200W | 输入阻抗50Ω | 重量13.5kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，直径Φ48-Φ70mm | 接口：2×N-K (N-female)\n\n【English】5.8G Parabolic Antenna, Reflector Aperture 1.2m. Frequency Range: 5150~5850MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 34.2±1dBi | Horizontal 3dB Beamwidth: 3.3° | Vertical 3dB Beamwidth: 3° | Front-to-back Ratio: ≥32dB | Max CW Input Power: 200W | Impedance: 50Ω | Weight: 13.5kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Dia. Φ48-Φ70mm | Connector: 2×N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
);

-- ----------------------------
-- 2.4G 抛物面天线系列 (4 products)
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
(
  '2.4G抛物面天线 0.9×0.6m / 2.4G Parabolic Antenna 0.9×0.6m',
  2, '/uploads/products/antenna_2g4.png', '["/uploads/products/antenna_2g4.png"]',
  '【中文】2.4G抛物面天线，口径0.9×0.6m。频率范围：2400~2500MHz | 极化方式：垂直 | 电压驻波比VSWR≤1.8 | 增益：23±1.5dBi | 水平波瓣宽度3dB：10° | 垂直波瓣宽度3dB：14° | 前后比≥25dB | 最大功率150W | 输入阻抗50Ω | 重量3kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ35-45mm | 接口：N-K (N-female)\n\n【English】2.4G Parabolic Antenna, Reflector Aperture 0.9×0.6m. Frequency Range: 2400~2500MHz | Polarization: Vertical | VSWR ≤1.8 | Gain: 23±1.5dBi | Horizontal 3dB Beamwidth: 10° | Vertical 3dB Beamwidth: 14° | Front-to-back Ratio: ≥25dB | Max CW Input Power: 150W | Impedance: 50Ω | Weight: 3kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Φ35-45mm | Connector: N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '2.4G抛物面天线 0.4m / 2.4G Parabolic Antenna 0.4m',
  2, '/uploads/products/antenna_2g4.png', '["/uploads/products/antenna_2g4.png"]',
  '【中文】2.4G抛物面天线，口径0.4m。频率范围：2400~2500MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：17.5±1.5dBi | 水平波瓣宽度3dB：24° | 垂直波瓣宽度3dB：22° | 前后比≥23dB | 最大功率150W | 输入阻抗50Ω | 重量4kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ48-70mm | 接口：N-K (N-female)\n\n【English】2.4G Parabolic Antenna, Reflector Aperture 0.4m. Frequency Range: 2400~2500MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 17.5±1.5dBi | Horizontal 3dB Beamwidth: 24° | Vertical 3dB Beamwidth: 22° | Front-to-back Ratio: ≥23dB | Max CW Input Power: 150W | Impedance: 50Ω | Weight: 4kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Φ48-70mm | Connector: N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '2.4G抛物面天线 0.6m / 2.4G Parabolic Antenna 0.6m',
  2, '/uploads/products/antenna_2g4.png', '["/uploads/products/antenna_2g4.png"]',
  '【中文】2.4G抛物面天线，口径0.6m。频率范围：2400~2500MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：21±1.5dBi | 水平波瓣宽度3dB：13° | 垂直波瓣宽度3dB：12° | 前后比≥23dB | 最大功率150W | 输入阻抗50Ω | 重量6kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ48-70mm | 接口：N-K (N-female)\n\n【English】2.4G Parabolic Antenna, Reflector Aperture 0.6m. Frequency Range: 2400~2500MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 21±1.5dBi | Horizontal 3dB Beamwidth: 13° | Vertical 3dB Beamwidth: 12° | Front-to-back Ratio: ≥23dB | Max CW Input Power: 150W | Impedance: 50Ω | Weight: 6kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Φ48-70mm | Connector: N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '2.4G抛物面天线 1.2m / 2.4G Parabolic Antenna 1.2m',
  2, '/uploads/products/antenna_2g4.png', '["/uploads/products/antenna_2g4.png"]',
  '【中文】2.4G抛物面天线，口径1.2m。频率范围：2400~2500MHz | 极化方式：垂直+水平 | 电压驻波比VSWR≤1.8 | 增益：27.5±1dBi | 水平波瓣宽度3dB：7.2° | 垂直波瓣宽度3dB：7° | 前后比≥25dB | 最大功率150W | 输入阻抗50Ω | 重量13.6kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ60-70mm | 接口：N-K (N-female)\n\n【English】2.4G Parabolic Antenna, Reflector Aperture 1.2m. Frequency Range: 2400~2500MHz | Polarization: Vertical + Horizontal | VSWR ≤1.8 | Gain: 27.5±1dBi | Horizontal 3dB Beamwidth: 7.2° | Vertical 3dB Beamwidth: 7° | Front-to-back Ratio: ≥25dB | Max CW Input Power: 150W | Impedance: 50Ω | Weight: 13.6kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Φ60-70mm | Connector: N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
);

-- ----------------------------
-- 1.35~1.85G 抛物面天线 (1 product: 1.8m)
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
(
  '1.35~1.85G抛物面天线 1.8m / 1.35~1.85G Parabolic Antenna 1.8m',
  3, '/uploads/products/antenna_1g35.png', '["/uploads/products/antenna_1g35.png"]',
  '【中文】1.35~1.85G抛物面天线，口径1.8m。频率范围：1350~1850MHz | 极化方式：垂直 | 电压驻波比VSWR≤2 | 增益：26±1.5dBi | 水平波瓣宽度3dB：8° | 垂直波瓣宽度3dB：10° | 前后比≥25dB | 最大功率200W | 输入阻抗50Ω | 重量3kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ60-70mm | 接口：N-K (N-female)\n\n【English】1.35~1.85G Parabolic Antenna, Reflector Aperture 1.8m. Frequency Range: 1350~1850MHz | Polarization: Vertical | VSWR ≤2 | Gain: 26±1.5dBi | Horizontal 3dB Beamwidth: 8° | Vertical 3dB Beamwidth: 10° | Front-to-back Ratio: ≥25dB | Max CW Input Power: 200W | Impedance: 50Ω | Weight: 3kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Installation Φ60-70mm | Connector: N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
);

-- ----------------------------
-- 900M 抛物面天线系列 (2 products: 1.8m, 2m)
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
(
  '900M抛物面天线 1.8m / 900M Parabolic Antenna 1.8m',
  4, '/uploads/products/antenna_900m.png', '["/uploads/products/antenna_900m.png"]',
  '【中文】900M抛物面天线，口径1.8m。频率范围：806~960MHz | 极化方式：垂直 | 电压驻波比VSWR≤1.8 | 增益：18±1.5dBi | 水平波瓣宽度3dB：15° | 垂直波瓣宽度3dB：20° | 前后比≥20dB | 最大功率150W | 输入阻抗50Ω | 重量15kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ60-70mm | 接口：N-K (N-female)\n\n【English】900M Parabolic Antenna, Reflector Aperture 1.8m. Frequency Range: 806~960MHz | Polarization: Vertical | VSWR ≤1.8 | Gain: 18±1.5dBi | Horizontal 3dB Beamwidth: 15° | Vertical 3dB Beamwidth: 20° | Front-to-back Ratio: ≥20dB | Max CW Input Power: 150W | Impedance: 50Ω | Weight: 15kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Installation Φ60-70mm | Connector: N-K (N-female)',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
),
(
  '900M抛物面天线 2m / 900M Parabolic Antenna 2m',
  4, '/uploads/products/antenna_900m.png', '["/uploads/products/antenna_900m.png"]',
  '【中文】900M抛物面天线，口径2m。频率范围：880~960MHz | 极化方式：±45° | 电压驻波比VSWR≤1.8 | 增益：23±1.5dBi | 水平波瓣宽度3dB：10° | 垂直波瓣宽度3dB：10° | 前后比≥25dB | 最大功率150W | 输入阻抗50Ω | 重量37kg | 颜色：灰色 | 工作温度：-40~+70°C | 最大风速126km/h | 安装方式：抱杆安装，Φ76-114mm | 接口：2×7/16 DIN Female\n\n【English】900M Parabolic Antenna, Reflector Aperture 2m. Frequency Range: 880~960MHz | Polarization: ±45° | VSWR ≤1.8 | Gain: 23±1.5dBi | Horizontal 3dB Beamwidth: 10° | Vertical 3dB Beamwidth: 10° | Front-to-back Ratio: ≥25dB | Max CW Input Power: 150W | Impedance: 50Ω | Weight: 37kg | Color: Grey | Operating Temp: -40~+70°C | Max Wind: 126km/h | Mounting: Pole Installation Φ76-114mm | Connector: 2×7/16 DIN Female',
  0.00, 100, 0, 0, 1, NOW(), NOW(), 0
);
