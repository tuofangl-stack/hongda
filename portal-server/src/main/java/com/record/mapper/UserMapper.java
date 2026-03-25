package com.record.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.record.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}
