-- =============================================
-- 天线产品分类与产品数据（双语 CN/EN，使用 / 分隔）
-- 执行此脚本前确保 t_product 和 t_type 表已存在
-- =============================================

SET NAMES utf8mb4;

-- ----------------------------
-- 清除旧示例数据
-- ----------------------------
DELETE FROM `t_product` WHERE `is_delete` = 0;
DELETE FROM `t_type` WHERE 1=1;

-- ----------------------------
-- 新增产品分类（双语名称，用 / 分隔）
-- 按照官网产品中心分类结构
-- ----------------------------
INSERT INTO `t_type` (`type_id`, `type_name`, `is_delete`, `create_time`) VALUES
(1, '基站天线部件/Base Station Antenna Parts', 0, NOW()),
(2, '抛物面天线部件/Parabolic Antenna Parts', 0, NOW()),
(3, '五金零部件/Hardware Components', 0, NOW()),
(4, '基站天线/Base Station Antenna', 0, NOW()),
(5, '美化天线/Concealed Antenna', 0, NOW()),
(6, '抛物面天线、微波天线/Parabolic & Microwave Antenna', 0, NOW()),
(7, '车间风彩/Workshop Gallery', 0, NOW());

-- ----------------------------
-- 基站天线部件
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('基站天线底板/Base Station Antenna Base Plate', 1,
'/images/products/antenna_5g8_small.png', '["/images/products/antenna_5g8_small.png"]',
'产品类型/Type: 基站天线底板/Base Station Antenna Base Plate\n材质/Material: 铝合金/Aluminum Alloy\n工艺/Process: CNC加工+阳极氧化/CNC Machining+Anodizing\n应用/Application: 移动通信基站/Mobile Communication Base Station',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('基站天线零部件/Base Station Antenna Components', 1,
'/images/products/antenna_5g8_small.png', '["/images/products/antenna_5g8_small.png"]',
'产品类型/Type: 基站天线零部件/Base Station Antenna Components\n材质/Material: 铝合金+不锈钢/Aluminum+Stainless Steel\n工艺/Process: 冲压+焊接+表面处理/Stamping+Welding+Surface Treatment\n应用/Application: 4G/5G基站天线/4G/5G Base Station Antenna',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 抛物面天线部件
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('反射面部件/Reflector Components', 2,
'/images/products/antenna_5g8_large.png', '["/images/products/antenna_5g8_large.png"]',
'产品类型/Type: 抛物面天线反射面/Parabolic Antenna Reflector\n材质/Material: 铝板/Aluminum Sheet\n工艺/Process: 旋压成型+喷涂/Spinning+Coating\n精度/Accuracy: 表面精度RMS≤0.5mm/Surface RMS≤0.5mm',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('夹码部件/Clamp Components', 2,
'/images/products/antenna_5g8_large.png', '["/images/products/antenna_5g8_large.png"]',
'产品类型/Type: 天线夹码/Antenna Clamp\n材质/Material: 镀锌钢/Galvanized Steel\n工艺/Process: 冲压+热镀锌/Stamping+Hot-dip Galvanizing\n应用/Application: 天线抱杆安装/Antenna Pole Mounting',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('栅格抛物面/Grid Parabolic', 2,
'/images/products/antenna_1g35.png', '["/images/products/antenna_1g35.png"]',
'产品类型/Type: 栅格抛物面天线/Grid Parabolic Antenna\n材质/Material: 铝合金栅格/Aluminum Grid\n工艺/Process: 焊接+喷涂/Welding+Coating\n特点/Feature: 低风阻设计/Low Wind Resistance Design',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 五金零部件
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('五金冲压件/Hardware Stamping Parts', 3,
'/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'产品类型/Type: 五金冲压件/Hardware Stamping Parts\n材质/Material: 不锈钢/冷轧板/Stainless Steel/CRS\n工艺/Process: 数控冲床+折弯/CNC Punching+Bending\n精度/Accuracy: ±0.1mm',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('机加工部件/CNC Machined Parts', 3,
'/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'产品类型/Type: 机加工部件/CNC Machined Parts\n材质/Material: 铝合金/铜/Aluminum Alloy/Copper\n工艺/Process: CNC车铣复合加工/CNC Turning & Milling\n精度/Accuracy: ±0.05mm',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 基站天线
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('4G/5G基站天线/4G/5G Base Station Antenna', 4,
'/images/products/antenna_5g8_small.png', '["/images/products/antenna_5g8_small.png"]',
'频率范围/Frequency: 698~2690MHz\n极化方式/Polarization: ±45°\n增益/Gain: 15~18dBi\n波束宽度/Beamwidth: 65°\n前后比/F/B Ratio: ≥25dB\n阻抗/Impedance: 50Ω\n接口/Connector: 4.3-10 Female\n下倾/Tilt: 电调0~10°/Electrical 0~10°',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 美化天线
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('美化天线/Concealed Antenna', 5,
'/images/products/antenna_900m.png', '["/images/products/antenna_900m.png"]',
'产品类型/Type: 美化天线/Concealed Antenna\n频率范围/Frequency: 698~3800MHz\n应用场景/Application: 城市景观美化/Urban Landscape\n外观/Appearance: 树形/灯杆/路牌/Tree/Lamppost/Sign\n特点/Feature: 完美融入城市环境/Blends into urban environment',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 抛物面天线、微波天线
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('5.8G抛物面天线 0.6m/5.8G Parabolic Antenna 0.6m', 6,
'/images/products/antenna_5g8_small.png', '["/images/products/antenna_5g8_small.png"]',
'频率范围/Frequency: 5150~5850MHz\n极化方式/Polarization: 垂直+水平/Vertical+Horizontal\nVSWR: ≤1.8\n增益/Gain: 28±1dBi\n水平波瓣宽度/H-Beamwidth: 6°\n垂直波瓣宽度/V-Beamwidth: 5.5°\n前后比/F/B Ratio: ≥28dB\n最大功率/Max Power: 200W\n阻抗/Impedance: 50Ω\n重量/Weight: 6kg\n接口/Connector: 2×N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('2.4G抛物面天线 0.6m/2.4G Parabolic Antenna 0.6m', 6,
'/images/products/antenna_2g4.png', '["/images/products/antenna_2g4.png"]',
'频率范围/Frequency: 2400~2500MHz\n极化方式/Polarization: 垂直+水平/Vertical+Horizontal\nVSWR: ≤1.8\n增益/Gain: 21±1.5dBi\n水平波瓣宽度/H-Beamwidth: 13°\n垂直波瓣宽度/V-Beamwidth: 12°\n前后比/F/B Ratio: ≥23dB\n最大功率/Max Power: 150W\n阻抗/Impedance: 50Ω\n重量/Weight: 6kg\n接口/Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('900M抛物面天线 1.8m/900M Parabolic Antenna 1.8m', 6,
'/images/products/antenna_900m.png', '["/images/products/antenna_900m.png"]',
'频率范围/Frequency: 806~960MHz\n极化方式/Polarization: 垂直/Vertical\nVSWR: ≤1.8\n增益/Gain: 18±1.5dBi\n水平波瓣宽度/H-Beamwidth: 15°\n垂直波瓣宽度/V-Beamwidth: 20°\n前后比/F/B Ratio: ≥20dB\n最大功率/Max Power: 150W\n阻抗/Impedance: 50Ω\n重量/Weight: 15kg\n接口/Connector: N-K (N-female)',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);

-- ----------------------------
-- 车间风彩（展示类）
-- ----------------------------
INSERT INTO `t_product` (`name`, `type_id`, `cover`, `images`, `description`, `price`, `stock`, `sales`, `views`, `status`, `create_time`, `update_time`, `is_delete`) VALUES
('生产设备/Production Equipment', 7,
'/images/products/antenna_5g8_large.png', '["/images/products/antenna_5g8_large.png"]',
'设备类型/Equipment: 数控冲床、折弯机、剪板机、液压机、CNC车床\nEquipment: CNC Punch, Bending Machine, Shearing Machine, Hydraulic Press, CNC Lathe\n产能/Capacity: 年产值过亿/Annual output over 100M RMB',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('模具阵列/Mold Array', 7,
'/images/products/antenna_5g8_large.png', '["/images/products/antenna_5g8_large.png"]',
'模具类型/Mold Type: 冲压模具、拉伸模具、旋压模具\nMold Types: Stamping, Drawing, Spinning Molds\n精度/Accuracy: ±0.02mm\n材质/Material: Cr12MoV/SKD11',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0),

('工厂及车间现场/Factory & Workshop', 7,
'/images/products/antenna_1g35.png', '["/images/products/antenna_1g35.png"]',
'占地面积/Area: 32亩（约21300㎡）/32 mu (approx 21,300㎡)\n厂区/Factory: 广东省清远市广清产业转移园创新路5号\nAddress: No.5 Innovation Rd, Guangqing Industrial Park, Qingyuan\n设施/Facilities: 64探头暗室、SMT生产线/64-probe anechoic chamber, SMT line',
0.00, 100, 0, 0, 1, NOW(), NOW(), 0);
