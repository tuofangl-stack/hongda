package com.record.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // 所有前端路由都转发到 index.html（SPA）
        registry.addViewController("/").setViewName("forward:/index.html");
        registry.addViewController("/index").setViewName("forward:/index.html");
        registry.addViewController("/product").setViewName("forward:/index.html");
        registry.addViewController("/product.html").setViewName("forward:/index.html");
        registry.addViewController("/example").setViewName("forward:/index.html");
        registry.addViewController("/example.html").setViewName("forward:/index.html");
        registry.addViewController("/news").setViewName("forward:/index.html");
        registry.addViewController("/news.html").setViewName("forward:/index.html");
        registry.addViewController("/about").setViewName("forward:/index.html");
        registry.addViewController("/about.html").setViewName("forward:/index.html");
    }
}
