package com.record.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;

@Getter
@Setter
@Accessors(chain = true)
@TableName("t_product")
@ApiModel(value = "Product对象", description = "产品")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("产品ID")
    @TableId(value = "product_id", type = IdType.AUTO)
    private Long productId;

    @ApiModelProperty("产品名称")
    private String name;

    @ApiModelProperty("关联分类ID")
    private Integer typeId;

    @ApiModelProperty("封面图URL")
    private String cover;

    @ApiModelProperty("多图片(JSON数组)")
    private String images;

    @ApiModelProperty("产品描述")
    private String description;

    @ApiModelProperty("价格")
    private BigDecimal price;

    @ApiModelProperty("库存")
    private Integer stock;

    @ApiModelProperty("销量")
    private Integer sales;

    @ApiModelProperty("浏览量")
    private Integer views;

    @ApiModelProperty("状态：1上架 0下架")
    private Integer status;

    @ApiModelProperty("创建时间")
    private String createTime;

    @ApiModelProperty("更新时间")
    private String updateTime;

    @ApiModelProperty("逻辑删除")
    @TableLogic
    private Integer isDelete;
}
