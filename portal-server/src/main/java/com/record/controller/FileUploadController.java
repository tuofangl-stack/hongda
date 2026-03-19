package com.record.controller;

import com.record.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Api(tags = "管理后台-文件上传")
@RestController
@RequestMapping("/admin")
public class FileUploadController {

    @ApiOperation("上传图片")
    @PostMapping("/upload")
    public Result upload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.fail("请选择文件");
        }

        // 按日期分目录
        String datePath = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
        String uploadDir = System.getProperty("user.dir") + "/uploads/" + datePath + "/";

        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 生成唯一文件名
        String originalFilename = file.getOriginalFilename();
        String ext = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            ext = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String filename = UUID.randomUUID().toString().replace("-", "") + ext;

        try {
            file.transferTo(new File(uploadDir + filename));
        } catch (IOException e) {
            return Result.fail("上传失败: " + e.getMessage());
        }

        // 返回可访问的URL路径
        String url = "/uploads/" + datePath + "/" + filename;
        return Result.success(url);
    }
}
