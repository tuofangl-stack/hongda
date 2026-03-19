package com.record.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.record.entity.Product;
import com.record.mapper.ProductMapper;
import com.record.service.ProductService;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl extends ServiceImpl<ProductMapper, Product> implements ProductService {
}
