package com.record.controller;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Api(tags = "EntranceController")
@Controller
public class EntranceController {

    @ApiOperation(value = "首页")
    @GetMapping({"/","/index","/product","/product.html","/example","/example.html","/news","/news.html","/about","/about.html"})
    public String index(){
        return "forward:/index.html";
    }
}
