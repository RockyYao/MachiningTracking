package com.oechsler.service.impl;

import com.oechsler.mapper.OrderProcedureLogMapper;
import com.oechsler.model.OrderProcedureLog;
import com.oechsler.service.OrderProcedureLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * author:kriswang
 * date:2017/11/18 0018上午 9:58
 **/
@Service("orderProcedureLogService")
public class OrderProcedureLogServiceImpl implements OrderProcedureLogService {

    @Autowired
    private OrderProcedureLogMapper orderProcedureLogMapper;

    @Override
    @Transactional
    public int insert(OrderProcedureLog orderProcedureLog) {
        return orderProcedureLogMapper.insertSelective(orderProcedureLog);
    }

    @Override
    public OrderProcedureLog selectStartTime(OrderProcedureLog orderProcedureLog) {
        return orderProcedureLogMapper.selectStartTime(orderProcedureLog);
    }


    @Override
    @Transactional
    public int updateOrderProcedureLog(OrderProcedureLog orderProcedureLog) {
        return orderProcedureLogMapper.updateOrderProcedureLog(orderProcedureLog);
    }

    @Override
    public OrderProcedureLog getById(Integer id) {
        return orderProcedureLogMapper.getById(id);
    }
}
