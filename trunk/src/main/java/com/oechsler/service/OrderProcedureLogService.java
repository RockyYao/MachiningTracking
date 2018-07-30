package com.oechsler.service;

import com.oechsler.model.OrderProcedureLog;

/**
 * author:kriswang
 * date:2017/11/18 0018上午 9:58
 **/
public interface OrderProcedureLogService {

    int insert(OrderProcedureLog orderProcedureLog);

    OrderProcedureLog selectStartTime(OrderProcedureLog orderProcedureLog);

    int updateOrderProcedureLog(OrderProcedureLog orderProcedureLog);

    OrderProcedureLog getById(Integer id);
}
