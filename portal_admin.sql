/*
 Portal Admin - 后台管理系统数据库脚本
 
 Source Server Type    : MySQL
 Source Server Version : 80028
 
 Date: 2026-03-19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin_user (管理员用户表)
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_user`;
CREATE TABLE `t_admin_user` (
  `admin_id` bigint NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码(MD5加密)',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_delete` int NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 默认管理员: admin / admin123
-- MD5("admin123") = 0192023a7bbd73250516f069df18b500
-- ----------------------------
INSERT INTO `t_admin_user` VALUES (1, 'admin', '0192023a7bbd73250516f069df18b500', '超级管理员', NULL, NOW(), 0);

-- ----------------------------
-- Table structure for t_product (产品表)
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `product_id` bigint NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `type_id` int NULL DEFAULT NULL COMMENT '关联分类ID',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图URL',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '多图片(JSON数组)',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '产品描述',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '价格',
  `stock` int NULL DEFAULT 0 COMMENT '库存',
  `sales` int NULL DEFAULT 0 COMMENT '销量',
  `views` int NULL DEFAULT 0 COMMENT '浏览量',
  `status` int NULL DEFAULT 1 COMMENT '状态：1上架 0下架',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` int NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `idx_type_id`(`type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 示例产品数据
-- ----------------------------
INSERT INTO `t_product` VALUES (1, '家用小型电梯 E-200', 1, 'https://www.alsidt.com/public/uploads/20201003/d0b0b777240dadeb0e36656ceffa8d19.jpg', '["https://www.alsidt.com/public/uploads/20201003/d0b0b777240dadeb0e36656ceffa8d19.jpg","https://www.alsidt.com/public/uploads/20201003/415c5ac4bef61cdc4b647a3d15ddaafd.jpg"]', '适用于2-3层别墅的家用小型电梯，安全稳定，静音运行。', 128000.00, 50, 12, 358, 1, NOW(), NOW(), 0);
INSERT INTO `t_product` VALUES (2, '别墅观光电梯 V-500', 2, 'https://www.alsidt.com/public/uploads/20201003/42835265b591791c3f5e15917f437763.jpg', '["https://www.alsidt.com/public/uploads/20201003/42835265b591791c3f5e15917f437763.jpg"]', '全景玻璃轿厢，适用于高端别墅，载重500kg。', 256000.00, 30, 8, 520, 1, NOW(), NOW(), 0);
INSERT INTO `t_product` VALUES (3, '商用载货电梯 C-1000', 3, 'https://www.alsidt.com/public/uploads/20201003/880fdc8f430da010a1e91c68fa4440d8.jpg', '["https://www.alsidt.com/public/uploads/20201003/880fdc8f430da010a1e91c68fa4440d8.jpg"]', '大载重商用电梯，适用于商场、写字楼等场景。', 380000.00, 20, 5, 210, 1, NOW(), NOW(), 0);
INSERT INTO `t_product` VALUES (4, '无障碍家用电梯 A-300', 1, 'https://www.alsidt.com/public/uploads/20220331/e83d8c0d46f6bfc580b3642775c22dd9.png', '["https://www.alsidt.com/public/uploads/20220331/e83d8c0d46f6bfc580b3642775c22dd9.png"]', '专为老人和行动不便人士设计，超低门槛，一键呼叫。', 168000.00, 40, 15, 430, 1, NOW(), NOW(), 0);

-- ----------------------------
-- Table structure for t_page_view (页面浏览记录表)
-- ----------------------------
DROP TABLE IF EXISTS `t_page_view`;
CREATE TABLE `t_page_view` (
  `view_id` bigint NOT NULL AUTO_INCREMENT COMMENT '浏览记录ID',
  `page_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '页面类型: index/product/news/about/example',
  `ref_id` bigint NULL DEFAULT NULL COMMENT '关联资源ID(可空)',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问者IP',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  PRIMARY KEY (`view_id`) USING BTREE,
  INDEX `idx_page_type`(`page_type`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '页面浏览记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 示例浏览数据（近7天）
-- ----------------------------
INSERT INTO `t_page_view` (`page_type`, `ref_id`, `ip`, `create_time`) VALUES
('index', NULL, '192.168.1.100', DATE_SUB(NOW(), INTERVAL 6 DAY)),
('index', NULL, '192.168.1.101', DATE_SUB(NOW(), INTERVAL 6 DAY)),
('product', 1, '192.168.1.100', DATE_SUB(NOW(), INTERVAL 5 DAY)),
('product', 2, '192.168.1.102', DATE_SUB(NOW(), INTERVAL 5 DAY)),
('index', NULL, '192.168.1.103', DATE_SUB(NOW(), INTERVAL 4 DAY)),
('product', 1, '192.168.1.104', DATE_SUB(NOW(), INTERVAL 4 DAY)),
('news', 1, '192.168.1.100', DATE_SUB(NOW(), INTERVAL 3 DAY)),
('index', NULL, '192.168.1.105', DATE_SUB(NOW(), INTERVAL 3 DAY)),
('product', 3, '192.168.1.106', DATE_SUB(NOW(), INTERVAL 2 DAY)),
('index', NULL, '192.168.1.107', DATE_SUB(NOW(), INTERVAL 2 DAY)),
('about', NULL, '192.168.1.108', DATE_SUB(NOW(), INTERVAL 1 DAY)),
('product', 4, '192.168.1.109', DATE_SUB(NOW(), INTERVAL 1 DAY)),
('index', NULL, '192.168.1.110', NOW()),
('product', 1, '192.168.1.111', NOW()),
('product', 2, '192.168.1.112', NOW());

-- ----------------------------
-- Table structure for t_sale_record (销售记录表)
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_record`;
CREATE TABLE `t_sale_record` (
  `record_id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `quantity` int NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '金额',
  `buyer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '买家信息',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_delete` int NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_product_id`(`product_id`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '销售记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 示例销售数据
-- ----------------------------
INSERT INTO `t_sale_record` (`product_id`, `quantity`, `amount`, `buyer`, `remark`, `create_time`) VALUES
(1, 1, 128000.00, '张先生', '成都锦江区别墅安装', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(2, 1, 256000.00, '李女士', '成都高新区别墅安装', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(1, 2, 256000.00, '王先生', '双流区两套家用电梯', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(4, 1, 168000.00, '赵先生', '温江区无障碍电梯', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 1, 380000.00, '某商场', '商场载货电梯采购', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(1, 1, 128000.00, '陈先生', '龙泉驿别墅安装', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, 1, 256000.00, '刘女士', '武侯区观光电梯', NOW());

SET FOREIGN_KEY_CHECKS = 1;
