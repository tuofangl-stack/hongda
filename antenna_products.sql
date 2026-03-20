-- =============================================
-- 天线产品数据（双语 CN/EN）
-- 执行此脚本前确保 t_product 和 t_type 表已存在
-- =============================================

SET NAMES utf8mb4;

-- ----------------------------
-- 清除旧示例数据
-- ----------------------------
DELETE FROM `t_product` WHERE `is_delete` = 0;
DELETE FROM `t_type` WHERE 1=1;

-- ----------------------------
-- 新增产品分类
-- ----------------------------
INSERT INTO `t_type` (`type_id`, `type_name`, `is_delete`, `create_time`) VALUES
(1, '5.8G抛物面天线', 0, NOW()),
(2, '2.4G抛物面天线', 0, NOW()),
(3, '1.35~1.85G抛物面天线', 0, NOW()),
(4, '900M抛物面天线', 0, NOW());

-- ----------------------------
-- 5.8G 抛物面天线系列
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('5.8G抛物面天线 0.4m', 1, '/images/products/antenna_5g8_small.png', '["/images/products/antenna_5g8_small.png"]',
'5.8G Parabolic Antenna 0.4m\n频率范围 Frequency: 5150~5850MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 24.8±1.5dBi\n水平波瓣宽度 H-Beamwidth: 8.0°\n垂直波瓣宽度 V-Beamwidth: 7.5°\n前后比 F/B Ratio: ≥25dB\n最大功率 Max Power: 200W\n阻抗 Impedance: 50Ω\n重量 Weight: 3kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ48-Φ70mm\n接口 Connector: 2×N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('5.8G抛物面天线 0.6m', 1, '/images/products/antenna_5g8_small.png', '["/images/products/antenna_5g8_small.png"]',
'5.8G Parabolic Antenna 0.6m\n频率范围 Frequency: 5150~5850MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 28±1dBi\n水平波瓣宽度 H-Beamwidth: 6°\n垂直波瓣宽度 V-Beamwidth: 5.5°\n前后比 F/B Ratio: ≥28dB\n最大功率 Max Power: 200W\n阻抗 Impedance: 50Ω\n重量 Weight: 6kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ48-Φ70mm\n接口 Connector: 2×N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('5.8G抛物面天线 0.9m', 1, '/images/products/antenna_5g8_large.png', '["/images/products/antenna_5g8_large.png"]',
'5.8G Parabolic Antenna 0.9m\n频率范围 Frequency: 5150~5850MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 32±1dBi\n水平波瓣宽度 H-Beamwidth: 4°\n垂直波瓣宽度 V-Beamwidth: 3.8°\n前后比 F/B Ratio: ≥30dB\n最大功率 Max Power: 200W\n阻抗 Impedance: 50Ω\n重量 Weight: 9kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ48-Φ70mm\n接口 Connector: 2×N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('5.8G抛物面天线 1.2m', 1, '/images/products/antenna_5g8_large.png', '["/images/products/antenna_5g8_large.png"]',
'5.8G Parabolic Antenna 1.2m\n频率范围 Frequency: 5150~5850MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 34.2±1dBi\n水平波瓣宽度 H-Beamwidth: 3.3°\n垂直波瓣宽度 V-Beamwidth: 3°\n前后比 F/B Ratio: ≥32dB\n最大功率 Max Power: 200W\n阻抗 Impedance: 50Ω\n重量 Weight: 13.5kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ48-Φ70mm\n接口 Connector: 2×N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 2.4G 抛物面天线系列
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('2.4G抛物面天线 0.9×0.6m', 2, '/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'2.4G Parabolic Antenna 0.9×0.6m\n频率范围 Frequency: 2400~2500MHz\n极化方式 Polarization: 垂直 Vertical\nVSWR: ≤1.8\n增益 Gain: 23±1.5dBi\n水平波瓣宽度 H-Beamwidth: 10°\n垂直波瓣宽度 V-Beamwidth: 14°\n前后比 F/B Ratio: ≥25dB\n最大功率 Max Power: 150W\n阻抗 Impedance: 50Ω\n重量 Weight: 3kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ35-45mm\n接口 Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('2.4G抛物面天线 0.4m', 2, '/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'2.4G Parabolic Antenna 0.4m\n频率范围 Frequency: 2400~2500MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 17.5±1.5dBi\n水平波瓣宽度 H-Beamwidth: 24°\n垂直波瓣宽度 V-Beamwidth: 22°\n前后比 F/B Ratio: ≥23dB\n最大功率 Max Power: 150W\n阻抗 Impedance: 50Ω\n重量 Weight: 4kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ48-70mm\n接口 Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('2.4G抛物面天线 0.6m', 2, '/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'2.4G Parabolic Antenna 0.6m\n频率范围 Frequency: 2400~2500MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 21±1.5dBi\n水平波瓣宽度 H-Beamwidth: 13°\n垂直波瓣宽度 V-Beamwidth: 12°\n前后比 F/B Ratio: ≥23dB\n最大功率 Max Power: 150W\n阻抗 Impedance: 50Ω\n重量 Weight: 6kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ48-70mm\n接口 Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('2.4G抛物面天线 1.2m', 2, '/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'2.4G Parabolic Antenna 1.2m\n频率范围 Frequency: 2400~2500MHz\n极化方式 Polarization: 垂直+水平 Vertical+Horizontal\nVSWR: ≤1.8\n增益 Gain: 27.5±1dBi\n水平波瓣宽度 H-Beamwidth: 7.2°\n垂直波瓣宽度 V-Beamwidth: 7°\n前后比 F/B Ratio: ≥25dB\n最大功率 Max Power: 150W\n阻抗 Impedance: 50Ω\n重量 Weight: 13.6kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ60-70mm\n接口 Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 1.35~1.85G 抛物面天线
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('1.35~1.85G抛物面天线 1.8m', 3, '/images/products/antenna_1g35.png', '["/images/products/antenna_1g35.png"]',
'1.35~1.85G Parabolic Antenna 1.8m\n频率范围 Frequency: 1350~1850MHz\n极化方式 Polarization: 垂直 Vertical\nVSWR: ≤2\n增益 Gain: 26±1.5dBi\n水平波瓣宽度 H-Beamwidth: 8°\n垂直波瓣宽度 V-Beamwidth: 10°\n前后比 F/B Ratio: ≥25dB\n最大功率 Max Power: 200W\n阻抗 Impedance: 50Ω\n重量 Weight: 3kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ60-70mm\n接口 Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 900M 抛物面天线系列
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('900M抛物面天线 1.8m', 4, '/images/products/antenna_900m.png', '["/images/products/antenna_900m.png"]',
'900M Parabolic Antenna 1.8m\n频率范围 Frequency: 806~960MHz\n极化方式 Polarization: 垂直 Vertical\nVSWR: ≤1.8\n增益 Gain: 18±1.5dBi\n水平波瓣宽度 H-Beamwidth: 15°\n垂直波瓣宽度 V-Beamwidth: 20°\n前后比 F/B Ratio: ≥20dB\n最大功率 Max Power: 150W\n阻抗 Impedance: 50Ω\n重量 Weight: 15kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ60-70mm\n接口 Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('900M抛物面天线 2m', 4, '/images/products/antenna_900m.png', '["/images/products/antenna_900m.png"]',
'900M Parabolic Antenna 2m\n频率范围 Frequency: 880~960MHz\n极化方式 Polarization: ±45°\nVSWR: ≤1.8\n增益 Gain: 23±1.5dBi\n水平波瓣宽度 H-Beamwidth: 10°\n垂直波瓣宽度 V-Beamwidth: 10°\n前后比 F/B Ratio: ≥25dB\n最大功率 Max Power: 150W\n阻抗 Impedance: 50Ω\n重量 Weight: 37kg\n颜色 Color: 灰 Grey\n工作温度 Temp: -40~+70°C\n最大风速 Wind: 126km/h\n安装 Mount: 抱杆 Pole Φ76-114mm\n接口 Connector: 2×7/16 DIN Female',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);
