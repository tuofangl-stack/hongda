package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.record.entity.TypeDetails;
import com.record.entity.Type;
import com.record.service.TypeDetailsService;
import com.record.service.TypeService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "管理后台-产品管理(前台展示)")
@RestController
@RequestMapping("/admin/typeDetails")
public class AdminTypeDetailsController {

    @Autowired
    private TypeDetailsService typeDetailsService;

    @Autowired
    private TypeService typeService;

    @ApiOperation("获取所有产品分类")
    @GetMapping("/types")
    public Result types() {
        return Result.success(typeService.list());
    }

    @ApiOperation("新增产品分类")
    @PostMapping("/type")
    public Result addType(@RequestBody Type type) {
        return typeService.save(type) ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("删除产品分类")
    @DeleteMapping("/type/{id}")
    public Result deleteType(@PathVariable Integer id) {
        return typeService.removeById(id) ? Result.success() : Result.fail("删除失败");
    }

    @ApiOperation("产品分页列表")
    @GetMapping("/list")
    public Result list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String title,
            @RequestParam(required = false) Integer typeId) {

        Page<TypeDetails> page = new Page<>(pageNum, pageSize);
        QueryWrapper<TypeDetails> wrapper = new QueryWrapper<>();
        if (StringUtils.isNotBlank(title)) {
            wrapper.like("title", title);
        }
        if (typeId != null) {
            wrapper.eq("type_id", typeId);
        }
        wrapper.orderByDesc("create_time");
        return Result.success(typeDetailsService.page(page, wrapper));
    }

    @ApiOperation("产品详情")
    @GetMapping("/{id}")
    public Result detail(@PathVariable Integer id) {
        return Result.success(typeDetailsService.getById(id));
    }

    @ApiOperation("新增产品")
    @PostMapping
    public Result add(@RequestBody TypeDetails typeDetails) {
        return typeDetailsService.save(typeDetails) ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("编辑产品")
    @PutMapping
    public Result update(@RequestBody TypeDetails typeDetails) {
        return typeDetailsService.updateById(typeDetails) ? Result.success() : Result.fail("更新失败");
    }

    @ApiOperation("删除产品")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return typeDetailsService.removeById(id) ? Result.success() : Result.fail("删除失败");
    }
}
