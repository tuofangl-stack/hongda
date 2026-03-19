package com.record.controller;

import com.record.config.AdminLoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private AdminLoginInterceptor adminLoginInterceptor;

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

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(adminLoginInterceptor)
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/admin/login");
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 上传文件访问路径
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:uploads/");
    }
}
