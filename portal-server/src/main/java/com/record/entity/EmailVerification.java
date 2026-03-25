package com.record.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
@Accessors(chain = true)
@TableName("h_email_verification")
@ApiModel(value = "EmailVerification对象", description = "邮箱验证码")
public class EmailVerification implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("验证码")
    private String code;

    @ApiModelProperty("类型(1注册 2密码重置)")
    private Integer type;

    @ApiModelProperty("过期时间")
    private Date expireTime;

    @ApiModelProperty("是否已使用")
    private Integer used;

    @ApiModelProperty("创建时间")
    private Date createTime;
}
