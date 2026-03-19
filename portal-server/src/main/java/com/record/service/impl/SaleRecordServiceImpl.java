package com.record.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.record.entity.SaleRecord;
import com.record.mapper.SaleRecordMapper;
import com.record.service.SaleRecordService;
import org.springframework.stereotype.Service;

@Service
public class SaleRecordServiceImpl extends ServiceImpl<SaleRecordMapper, SaleRecord> implements SaleRecordService {
}
