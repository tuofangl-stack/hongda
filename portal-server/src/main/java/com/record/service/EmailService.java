package com.record.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.record.entity.EmailVerification;
import com.record.mapper.EmailVerificationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.Random;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private EmailVerificationMapper emailVerificationMapper;

    @Value("${spring.mail.username}")
    private String fromEmail;

    /**
     * 发送验证码邮件
     * @param toEmail 收件邮箱
     * @param type 类型 1注册 2密码重置
     * @return 是否发送成功
     */
    public boolean sendVerificationCode(String toEmail, int type) {
        // 生成6位随机验证码
        String code = generateCode();

        // 设置5分钟过期
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 5);
        Date expireTime = calendar.getTime();

        // 将之前未使用的验证码标记为已使用
        emailVerificationMapper.update(null,
                new LambdaUpdateWrapper<EmailVerification>()
                        .eq(EmailVerification::getEmail, toEmail)
                        .eq(EmailVerification::getType, type)
                        .eq(EmailVerification::getUsed, 0)
                        .set(EmailVerification::getUsed, 1));

        // 保存验证码
        EmailVerification verification = new EmailVerification();
        verification.setEmail(toEmail);
        verification.setCode(code);
        verification.setType(type);
        verification.setExpireTime(expireTime);
        verification.setUsed(0);
        emailVerificationMapper.insert(verification);

        // 发送邮件
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("验证码 - 鸿达制冷");
            String typeDesc = type == 1 ? "注册" : "密码重置";
            message.setText("您好！\n\n您的" + typeDesc + "验证码为：" + code + "\n\n验证码有效期为5分钟，请尽快使用。\n\n如非本人操作，请忽略此邮件。");
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 验证验证码
     */
    public boolean verifyCode(String email, String code, int type) {
        EmailVerification verification = emailVerificationMapper.selectOne(
                new LambdaQueryWrapper<EmailVerification>()
                        .eq(EmailVerification::getEmail, email)
                        .eq(EmailVerification::getCode, code)
                        .eq(EmailVerification::getType, type)
                        .eq(EmailVerification::getUsed, 0)
                        .orderByDesc(EmailVerification::getId)
                        .last("LIMIT 1"));

        if (verification == null) {
            return false;
        }

        // 检查是否过期
        if (verification.getExpireTime().before(new Date())) {
            return false;
        }

        // 标记为已使用
        verification.setUsed(1);
        emailVerificationMapper.updateById(verification);
        return true;
    }

    private String generateCode() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
}
