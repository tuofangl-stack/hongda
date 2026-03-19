package com.record.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.record.entity.PageView;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface PageViewMapper extends BaseMapper<PageView> {

    /**
     * 近N天每天的浏览量
     */
    @Select("SELECT DATE(create_time) as date, COUNT(*) as count FROM t_page_view WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL #{days} DAY) GROUP BY DATE(create_time) ORDER BY date")
    List<Map<String, Object>> countByDays(@Param("days") int days);

    /**
     * 总浏览量
     */
    @Select("SELECT COUNT(*) FROM t_page_view")
    int totalViews();

    /**
     * 今日浏览量
     */
    @Select("SELECT COUNT(*) FROM t_page_view WHERE DATE(create_time) = CURDATE()")
    int todayViews();
}
