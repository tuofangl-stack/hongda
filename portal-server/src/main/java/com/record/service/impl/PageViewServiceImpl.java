package com.record.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.record.entity.PageView;
import com.record.mapper.PageViewMapper;
import com.record.service.PageViewService;
import org.springframework.stereotype.Service;

@Service
public class PageViewServiceImpl extends ServiceImpl<PageViewMapper, PageView> implements PageViewService {
}
