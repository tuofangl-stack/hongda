package com.record.controller;

import com.record.mapper.PageViewMapper;
import com.record.mapper.SaleRecordMapper;
import com.record.service.ProductService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(tags = "管理后台-数据面板")
@RestController
@RequestMapping("/admin/dashboard")
public class AdminDashboardController {

    @Autowired
    private ProductService productService;

    @Autowired
    private PageViewMapper pageViewMapper;

    @Autowired
    private SaleRecordMapper saleRecordMapper;

    @ApiOperation("统计概览")
    @GetMapping("/stats")
    public Result stats() {
        Map<String, Object> data = new HashMap<>();

        // 产品总数
        data.put("productCount", productService.count());
        // 总浏览量
        data.put("totalViews", pageViewMapper.totalViews());
        // 今日浏览量
        data.put("todayViews", pageViewMapper.todayViews());
        // 总销量
        data.put("totalSales", saleRecordMapper.totalQuantity());
        // 总销售额
        data.put("totalAmount", saleRecordMapper.totalAmount());
        // 今日销售额
        data.put("todayAmount", saleRecordMapper.todayAmount());

        return Result.success(data);
    }

    @ApiOperation("趋势数据")
    @GetMapping("/trend")
    public Result trend(@RequestParam(defaultValue = "7") int days) {
        Map<String, Object> data = new HashMap<>();

        // 浏览量趋势
        List<Map<String, Object>> viewTrend = pageViewMapper.countByDays(days);
        data.put("viewTrend", viewTrend);

        // 销售趋势
        List<Map<String, Object>> saleTrend = saleRecordMapper.countByDays(days);
        data.put("saleTrend", saleTrend);

        return Result.success(data);
    }

    @ApiOperation("热销产品排行")
    @GetMapping("/topProducts")
    public Result topProducts() {
        // 按销量倒序取前10
        return Result.success(
                productService.lambdaQuery()
                        .orderByDesc(com.record.entity.Product::getSales)
                        .last("LIMIT 10")
                        .list()
        );
    }
}
