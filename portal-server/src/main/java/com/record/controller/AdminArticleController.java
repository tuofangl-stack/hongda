package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.record.entity.Article;
import com.record.service.ArticleService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "管理后台-文章管理")
@RestController
@RequestMapping("/admin/article")
public class AdminArticleController {

    @Autowired
    private ArticleService articleService;

    @ApiOperation("文章分页列表")
    @GetMapping("/list")
    public Result list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) String title) {

        Page<Article> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Article> wrapper = new QueryWrapper<>();
        if (StringUtils.isNotBlank(title)) {
            wrapper.like("title", title);
        }
        wrapper.orderByDesc("create_time");
        return Result.success(articleService.page(page, wrapper));
    }

    @ApiOperation("文章详情")
    @GetMapping("/{id}")
    public Result detail(@PathVariable Long id) {
        return Result.success(articleService.getById(id));
    }

    @ApiOperation("新增文章")
    @PostMapping
    public Result add(@RequestBody Article article) {
        return articleService.save(article) ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("编辑文章")
    @PutMapping
    public Result update(@RequestBody Article article) {
        return articleService.updateById(article) ? Result.success() : Result.fail("更新失败");
    }

    @ApiOperation("删除文章")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Long id) {
        return articleService.removeById(id) ? Result.success() : Result.fail("删除失败");
    }
}
