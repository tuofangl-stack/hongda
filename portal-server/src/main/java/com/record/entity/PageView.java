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

@Getter
@Setter
@Accessors(chain = true)
@TableName("t_page_view")
@ApiModel(value = "PageView对象", description = "页面浏览记录")
public class PageView implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("浏览记录ID")
    @TableId(value = "view_id", type = IdType.AUTO)
    private Long viewId;

    @ApiModelProperty("页面类型")
    private String pageType;

    @ApiModelProperty("关联资源ID")
    private Long refId;

    @ApiModelProperty("访问者IP")
    private String ip;

    @ApiModelProperty("访问时间")
    private String createTime;
}
