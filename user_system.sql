-- 用户表
CREATE TABLE IF NOT EXISTS `h_user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` VARCHAR(50) NOT NULL COMMENT '用户名',
  `email` VARCHAR(100) NOT NULL COMMENT '邮箱',
  `password` VARCHAR(64) NOT NULL COMMENT '密码(MD5)',
  `nickname` VARCHAR(50) DEFAULT NULL COMMENT '昵称',
  `avatar` VARCHAR(255) DEFAULT NULL COMMENT '头像',
  `phone` VARCHAR(20) DEFAULT NULL COMMENT '手机号',
  `status` TINYINT DEFAULT 1 COMMENT '状态(0禁用 1正常)',
  `email_verified` TINYINT DEFAULT 0 COMMENT '邮箱是否验证(0否 1是)',
  `create_time` VARCHAR(20) DEFAULT NULL COMMENT '创建时间',
  `update_time` VARCHAR(20) DEFAULT NULL COMMENT '更新时间',
  `is_delete` INT DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 邮箱验证码表
CREATE TABLE IF NOT EXISTS `h_email_verification` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL COMMENT '邮箱',
  `code` VARCHAR(6) NOT NULL COMMENT '验证码',
  `type` TINYINT NOT NULL COMMENT '类型(1注册 2密码重置)',
  `expire_time` DATETIME NOT NULL COMMENT '过期时间',
  `used` TINYINT DEFAULT 0 COMMENT '是否已使用',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮箱验证码表';
