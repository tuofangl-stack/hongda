package com.record.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.record.entity.SaleRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Mapper
public interface SaleRecordMapper extends BaseMapper<SaleRecord> {

    /**
     * 近N天每天的销售额
     */
    @Select("SELECT DATE(create_time) as date, IFNULL(SUM(amount),0) as amount, IFNULL(SUM(quantity),0) as quantity FROM t_sale_record WHERE is_delete=0 AND create_time >= DATE_SUB(CURDATE(), INTERVAL #{days} DAY) GROUP BY DATE(create_time) ORDER BY date")
    List<Map<String, Object>> countByDays(@Param("days") int days);

    /**
     * 总销售额
     */
    @Select("SELECT IFNULL(SUM(amount),0) FROM t_sale_record WHERE is_delete=0")
    BigDecimal totalAmount();

    /**
     * 总销量
     */
    @Select("SELECT IFNULL(SUM(quantity),0) FROM t_sale_record WHERE is_delete=0")
    int totalQuantity();

    /**
     * 今日销售额
     */
    @Select("SELECT IFNULL(SUM(amount),0) FROM t_sale_record WHERE is_delete=0 AND DATE(create_time) = CURDATE()")
    BigDecimal todayAmount();
}
