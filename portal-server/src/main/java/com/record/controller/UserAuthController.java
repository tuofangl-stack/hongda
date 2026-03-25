package com.record.controller;

import com.record.entity.User;
import com.record.service.EmailService;
import com.record.service.UserService;
import com.record.utils.JwtUtils;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Api(tags = "前台用户-认证")
@RestController
@RequestMapping("/api/user")
public class UserAuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmailService emailService;

    @ApiOperation("发送邮箱验证码")
    @PostMapping("/sendCode")
    public Result sendCode(@RequestBody Map<String, Object> params) {
        String email = (String) params.get("email");
        Integer type = params.get("type") != null ? Integer.parseInt(params.get("type").toString()) : 1;

        if (email == null || email.isEmpty()) {
            return Result.fail("邮箱不能为空");
        }

        // 简单的邮箱格式校验
        if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            return Result.fail("邮箱格式不正确");
        }

        // 注册时检查邮箱是否已存在
        if (type == 1) {
            User existUser = userService.findByEmail(email);
            if (existUser != null) {
                return Result.fail("该邮箱已被注册");
            }
        }

        boolean success = emailService.sendVerificationCode(email, type);
        if (success) {
            return Result.success("验证码已发送");
        } else {
            return Result.fail("验证码发送失败，请稍后重试");
        }
    }

    @ApiOperation("用户注册")
    @PostMapping("/register")
    public Result register(@RequestBody Map<String, String> params) {
        String username = params.get("username");
        String email = params.get("email");
        String password = params.get("password");
        String code = params.get("code");

        if (username == null || username.isEmpty()) {
            return Result.fail("用户名不能为空");
        }
        if (email == null || email.isEmpty()) {
            return Result.fail("邮箱不能为空");
        }
        if (password == null || password.isEmpty()) {
            return Result.fail("密码不能为空");
        }
        if (code == null || code.isEmpty()) {
            return Result.fail("验证码不能为空");
        }

        // 用户名长度校验
        if (username.length() < 3 || username.length() > 20) {
            return Result.fail("用户名长度需在3-20个字符之间");
        }

        // 密码长度校验
        if (password.length() < 6) {
            return Result.fail("密码长度不能少于6位");
        }

        // 检查用户名是否已存在
        if (userService.findByUsername(username) != null) {
            return Result.fail("用户名已被使用");
        }

        // 检查邮箱是否已存在
        if (userService.findByEmail(email) != null) {
            return Result.fail("邮箱已被注册");
        }

        // 验证验证码
        if (!emailService.verifyCode(email, code, 1)) {
            return Result.fail("验证码错误或已过期");
        }

        // 创建用户
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(DigestUtils.md5Hex(password));
        user.setNickname(username);
        user.setStatus(1);
        user.setEmailVerified(1);
        user.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        user.setUpdateTime(user.getCreateTime());

        userService.save(user);

        return Result.success("注册成功");
    }

    @ApiOperation("用户登录")
    @PostMapping("/login")
    public Result login(@RequestBody Map<String, String> params) {
        String account = params.get("account"); // 用户名或邮箱
        String password = params.get("password");

        if (account == null || account.isEmpty()) {
            return Result.fail("账号不能为空");
        }
        if (password == null || password.isEmpty()) {
            return Result.fail("密码不能为空");
        }

        // 通过用户名或邮箱查找用户
        User user = userService.findByUsername(account);
        if (user == null) {
            user = userService.findByEmail(account);
        }
        if (user == null) {
            return Result.fail("用户不存在");
        }

        // 检查用户状态
        if (user.getStatus() != null && user.getStatus() == 0) {
            return Result.fail("账号已被禁用，请联系管理员");
        }

        // 验证密码
        String md5Password = DigestUtils.md5Hex(password);
        if (!md5Password.equals(user.getPassword())) {
            return Result.fail("密码错误");
        }

        // 生成Token
        String token = JwtUtils.generateUserToken(user.getUserId(), user.getUsername());

        Map<String, Object> data = new HashMap<>();
        data.put("token", token);
        data.put("userId", user.getUserId());
        data.put("username", user.getUsername());
        data.put("nickname", user.getNickname());
        data.put("avatar", user.getAvatar());
        data.put("email", user.getEmail());

        return Result.success(data);
    }

    @ApiOperation("获取当前用户信息")
    @GetMapping("/info")
    public Result getUserInfo(HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        if (userId == null) {
            return Result.fail("未登录");
        }

        User user = userService.getById(userId);
        if (user == null) {
            return Result.fail("用户不存在");
        }

        user.setPassword(null); // 隐藏密码
        return Result.success(user);
    }
}
