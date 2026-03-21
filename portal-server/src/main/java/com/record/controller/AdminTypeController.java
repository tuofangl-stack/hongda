package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.record.entity.Type;
import com.record.service.TypeService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Api(tags = "管理后台-分类管理")
@RestController
@RequestMapping("/admin/category")
public class AdminTypeController {

    @Autowired
    private TypeService typeService;

    @ApiOperation("分类列表")
    @GetMapping("/list")
    public Result list() {
        return Result.success(typeService.list(new QueryWrapper<Type>().orderByAsc("type_id")));
    }

    @ApiOperation("新增分类")
    @PostMapping
    public Result add(@RequestBody Type type) {
        type.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        type.setIsDelete(0);
        boolean saved = typeService.save(type);
        return saved ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("编辑分类")
    @PutMapping
    public Result update(@RequestBody Type type) {
        boolean updated = typeService.updateById(type);
        return updated ? Result.success() : Result.fail("更新失败");
    }

    @ApiOperation("删除分类")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        boolean removed = typeService.removeById(id);
        return removed ? Result.success() : Result.fail("删除失败");
    }
}
