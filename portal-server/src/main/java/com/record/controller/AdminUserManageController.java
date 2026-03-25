package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.record.entity.User;
import com.record.service.UserService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Api(tags = "管理后台-用户管理")
@RestController
@RequestMapping("/admin/user")
public class AdminUserManageController {

    @Autowired
    private UserService userService;

    @ApiOperation("用户列表（分页）")
    @GetMapping("/list")
    public Result list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword) {

        Page<User> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.isNotBlank(keyword)) {
            wrapper.and(w -> w.like(User::getUsername, keyword)
                    .or().like(User::getEmail, keyword)
                    .or().like(User::getNickname, keyword));
        }

        wrapper.orderByDesc(User::getUserId);
        Page<User> result = userService.page(pageParam, wrapper);

        // 隐藏密码
        result.getRecords().forEach(u -> u.setPassword(null));

        return Result.success(result);
    }

    @ApiOperation("用户详情")
    @GetMapping("/{id}")
    public Result detail(@PathVariable Long id) {
        User user = userService.getById(id);
        if (user == null) {
            return Result.fail("用户不存在");
        }
        user.setPassword(null);
        return Result.success(user);
    }

    @ApiOperation("修改用户状态（启用/禁用）")
    @PutMapping("/status")
    public Result updateStatus(@RequestBody Map<String, Object> params) {
        Long userId = Long.parseLong(params.get("userId").toString());
        Integer status = Integer.parseInt(params.get("status").toString());

        User user = userService.getById(userId);
        if (user == null) {
            return Result.fail("用户不存在");
        }

        user.setStatus(status);
        userService.updateById(user);
        return Result.success();
    }

    @ApiOperation("删除用户")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        userService.removeById(id);
        return Result.success();
    }
}
