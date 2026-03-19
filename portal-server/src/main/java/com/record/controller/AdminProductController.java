package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.record.entity.Product;
import com.record.service.ProductService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "管理后台-产品管理")
@RestController
@RequestMapping("/admin/product")
public class AdminProductController {

    @Autowired
    private ProductService productService;

    @ApiOperation("产品分页列表")
    @GetMapping("/list")
    public Result list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) Integer typeId,
            @RequestParam(required = false) Integer status) {

        Page<Product> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Product> wrapper = new QueryWrapper<>();

        if (StringUtils.isNotBlank(name)) {
            wrapper.like("name", name);
        }
        if (typeId != null) {
            wrapper.eq("type_id", typeId);
        }
        if (status != null) {
            wrapper.eq("status", status);
        }
        wrapper.orderByDesc("create_time");

        return Result.success(productService.page(page, wrapper));
    }

    @ApiOperation("产品详情")
    @GetMapping("/{id}")
    public Result detail(@PathVariable Long id) {
        Product product = productService.getById(id);
        if (product == null) {
            return Result.fail("产品不存在");
        }
        return Result.success(product);
    }

    @ApiOperation("新增产品")
    @PostMapping
    public Result add(@RequestBody Product product) {
        boolean saved = productService.save(product);
        return saved ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("编辑产品")
    @PutMapping
    public Result update(@RequestBody Product product) {
        boolean updated = productService.updateById(product);
        return updated ? Result.success() : Result.fail("更新失败");
    }

    @ApiOperation("删除产品")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        boolean removed = productService.removeById(id);
        return removed ? Result.success() : Result.fail("删除失败");
    }

    @ApiOperation("所有产品(下拉选择用)")
    @GetMapping("/all")
    public Result all() {
        return Result.success(productService.list());
    }
}
