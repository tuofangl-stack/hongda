package com.record.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.record.entity.AdminUser;

public interface AdminUserService extends IService<AdminUser> {
    AdminUser findByUsername(String username);
}
