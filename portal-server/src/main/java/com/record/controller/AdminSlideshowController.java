package com.record.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.record.entity.Slideshow;
import com.record.service.SlideshowService;
import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "管理后台-轮播图管理")
@RestController
@RequestMapping("/admin/slideshow")
public class AdminSlideshowController {

    @Autowired
    private SlideshowService slideshowService;

    @ApiOperation("轮播图列表")
    @GetMapping("/list")
    public Result list() {
        QueryWrapper<Slideshow> wrapper = new QueryWrapper<>();
        wrapper.orderByAsc("slideshow_id");
        return Result.success(slideshowService.list(wrapper));
    }

    @ApiOperation("新增轮播图")
    @PostMapping
    public Result add(@RequestBody Slideshow slideshow) {
        return slideshowService.save(slideshow) ? Result.success() : Result.fail("新增失败");
    }

    @ApiOperation("编辑轮播图")
    @PutMapping
    public Result update(@RequestBody Slideshow slideshow) {
        return slideshowService.updateById(slideshow) ? Result.success() : Result.fail("更新失败");
    }

    @ApiOperation("删除轮播图")
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return slideshowService.removeById(id) ? Result.success() : Result.fail("删除失败");
    }
}
