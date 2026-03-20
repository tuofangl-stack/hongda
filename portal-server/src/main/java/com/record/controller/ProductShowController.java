package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.record.entity.Product;
import com.record.service.ProductService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 前台产品展示接口（公开，无需登录）
 */
@Api(tags = "前台-产品展示")
@RestController
public class ProductShowController {

    @Autowired
    private ProductService productService;

    @ApiOperation("获取所有上架产品分类(按typeId分组)")
    @GetMapping("/productTypes")
    public Result productTypes() {
        QueryWrapper<Product> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1)
               .select("DISTINCT type_id")
               .isNotNull("type_id");
        List<Product> products = productService.list(wrapper);
        // 返回去重的typeId列表
        List<Integer> typeIds = products.stream()
                .map(Product::getTypeId)
                .distinct()
                .collect(Collectors.toList());
        return Result.success(typeIds);
    }

    @ApiOperation("获取所有上架产品")
    @GetMapping("/productList")
    public Result productList() {
        QueryWrapper<Product> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1)
               .orderByDesc("sales");
        return Result.success(productService.list(wrapper));
    }

    @ApiOperation("按分类获取上架产品")
    @GetMapping("/productListByType/{typeId}")
    public Result productListByType(@PathVariable Integer typeId) {
        QueryWrapper<Product> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1)
               .eq("type_id", typeId)
               .orderByDesc("sales");
        return Result.success(productService.list(wrapper));
    }

    @ApiOperation("产品详情(前台)")
    @GetMapping("/productDetail/{id}")
    public Result productDetail(@PathVariable Long id) {
        Product product = productService.getById(id);
        if (product == null || product.getStatus() != 1) {
            return Result.fail("产品不存在");
        }
        // 增加浏览量
        product.setViews(product.getViews() + 1);
        productService.updateById(product);
        return Result.success(product);
    }
}
