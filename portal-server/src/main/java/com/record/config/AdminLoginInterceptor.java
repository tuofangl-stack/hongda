package com.record.config;

import com.alibaba.fastjson.JSON;
import com.record.utils.JwtUtils;
import com.record.utils.Result;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 管理后台登录拦截器
 */
@Component
public class AdminLoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 放行预检请求
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            return true;
        }

        String token = request.getHeader("Authorization");
        if (token != null && token.startsWith("Bearer ")) {
            token = token.substring(7);
        }

        if (token == null || !JwtUtils.validateToken(token)) {
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(401);
            response.getWriter().write(JSON.toJSONString(Result.build(401, "未登录或登录已过期", null)));
            return false;
        }

        // 将用户信息存入request
        request.setAttribute("adminId", JwtUtils.getAdminIdFromToken(token));
        request.setAttribute("username", JwtUtils.getUsernameFromToken(token));
        return true;
    }
}
