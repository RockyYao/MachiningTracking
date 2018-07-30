package com.oechsler.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oechsler.common.page.PageResult;
import com.oechsler.mapper.OrderProcedureMapper;
import com.oechsler.model.OrderProcedure;
import com.oechsler.service.OrderProcedureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * author:Kris
 * date:2017/10/27
 */
@Service("orderProcedureService")
public class OrderProcedureServiceImpl implements OrderProcedureService {

    @Autowired
    private OrderProcedureMapper orderProcedureMapper;
    @Override
    public PageResult<OrderProcedure> getOrderProcedureList(OrderProcedure orderProcedure, int pageIndex, int pageSize) {
        PageHelper.startPage(pageIndex, pageSize);
        List<OrderProcedure> data = orderProcedureMapper.queryOrderProcedureListByParam(orderProcedure);
        PageInfo<OrderProcedure> pageInfo = new PageInfo<OrderProcedure>(data);
        PageResult<OrderProcedure> pageResult = new PageResult<>(data, pageIndex, pageSize, (int) pageInfo.getTotal());
        return pageResult;
    }

    @Override
    @Transactional
    public int addOrderProcedure(OrderProcedure orderProcedure) {
        return orderProcedureMapper.insertSelective(orderProcedure);
    }

    @Override
    public OrderProcedure getOrderProcedureByParam(OrderProcedure orderProcedure) {
        return orderProcedureMapper.queryOneOrderProcedure(orderProcedure);
    }

    @Override
    public OrderProcedure getById(Integer id) {
        return orderProcedureMapper.getById(id);
    }

    @Override
    @Transactional
    public int updateOrderProcedure(OrderProcedure orderProcedure) {
        return orderProcedureMapper.updateOrderProcedure(orderProcedure);
    }

    @Override
    public OrderProcedure getOrderProcedureNotSelfByParam(OrderProcedure orderProcedure) {
        return orderProcedureMapper.getOrderProcedureNotSelfByParam(orderProcedure);
    }

    @Override
    public List<OrderProcedure> getOrderProcedureListByParam(OrderProcedure orderProcedure) {
        return orderProcedureMapper.queryOrderProcedureListByParam(orderProcedure);
    }

    @Override
    public OrderProcedure findLastProcedure(String dwgNo) {
        return orderProcedureMapper.findLastProcedure(dwgNo);
    }

    @Override
    public boolean deleteProcedureById(Integer id) {
        int result = orderProcedureMapper.deleteProcedureById(id);
        return result >0 ? true : false;
    }
}
