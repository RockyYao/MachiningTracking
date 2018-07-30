package com.oechsler.service;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.OrderProcedure;

import java.util.List;

/**
 * author:Kris
 * date:2017/10/27
 */
public interface OrderProcedureService {

    PageResult<OrderProcedure> getOrderProcedureList(OrderProcedure orderProcedure, int pageIndex, int pageSize);

    int addOrderProcedure(OrderProcedure orderProcedure);

    OrderProcedure getOrderProcedureByParam(OrderProcedure orderProcedure);

    OrderProcedure getById(Integer id);

    int updateOrderProcedure(OrderProcedure orderProcedure);

    OrderProcedure getOrderProcedureNotSelfByParam(OrderProcedure orderProcedure);

    List<OrderProcedure> getOrderProcedureListByParam(OrderProcedure orderProcedure);

    OrderProcedure findLastProcedure(String dwgNo);

    boolean deleteProcedureById(Integer id);
}
