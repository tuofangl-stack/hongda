package com.record.controller;

import com.record.entity.AdminUser;
import com.record.service.AdminUserService;
import com.record.utils.JwtUtils;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Api(tags = "管理后台-登录")
@RestController
@RequestMapping("/admin")
public class AdminLoginController {

    @Autowired
    private AdminUserService adminUserService;

    @ApiOperation("管理员登录")
    @PostMapping("/login")
    public Result login(@RequestBody Map<String, String> loginForm) {
        String username = loginForm.get("username");
        String password = loginForm.get("password");

        if (username == null || password == null) {
            return Result.fail("用户名和密码不能为空");
        }

        AdminUser user = adminUserService.findByUsername(username);
        if (user == null) {
            return Result.fail("用户不存在");
        }

        // MD5加密对比
        String md5Password = DigestUtils.md5Hex(password);
        if (!md5Password.equals(user.getPassword())) {
            return Result.fail("密码错误");
        }

        // 生成Token
        String token = JwtUtils.generateToken(user.getAdminId(), user.getUsername());

        Map<String, Object> data = new HashMap<>();
        data.put("token", token);
        data.put("nickname", user.getNickname());
        data.put("avatar", user.getAvatar());
        data.put("username", user.getUsername());

        return Result.success(data);
    }

    @ApiOperation("获取当前用户信息")
    @GetMapping("/userInfo")
    public Result userInfo(HttpServletRequest request) {
        Long adminId = (Long) request.getAttribute("adminId");
        AdminUser user = adminUserService.getById(adminId);
        if (user == null) {
            return Result.fail("用户不存在");
        }
        user.setPassword(null); // 隐藏密码
        return Result.success(user);
    }
}
