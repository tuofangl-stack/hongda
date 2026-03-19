package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.record.entity.SaleRecord;
import com.record.service.SaleRecordService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "管理后台-销售记录")
@RestController
@RequestMapping("/admin/sale")
public class AdminSaleController {

    @Autowired
    private SaleRecordService saleRecordService;

    @ApiOperation("销售记录列表")
    @GetMapping("/list")
    public Result list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {

        Page<SaleRecord> page = new Page<>(pageNum, pageSize);
        QueryWrapper<SaleRecord> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("create_time");

        return Result.success(saleRecordService.page(page, wrapper));
    }

    @ApiOperation("新增销售记录")
    @PostMapping
    public Result add(@RequestBody SaleRecord saleRecord) {
        boolean saved = saleRecordService.save(saleRecord);
        return saved ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("删除销售记录")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        boolean removed = saleRecordService.removeById(id);
        return removed ? Result.success() : Result.fail("删除失败");
    }
}
