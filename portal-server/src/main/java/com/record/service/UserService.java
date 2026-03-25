package com.record.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.record.entity.User;

public interface UserService extends IService<User> {
    User findByUsername(String username);
    User findByEmail(String email);
}
