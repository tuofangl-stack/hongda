package com.record.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.record.entity.EmailVerification;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmailVerificationMapper extends BaseMapper<EmailVerification> {
}
