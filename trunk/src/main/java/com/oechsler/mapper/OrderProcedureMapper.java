package com.oechsler.mapper;

import com.oechsler.model.Order;
import com.oechsler.model.OrderProcedure;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderProcedureMapper {
    int insert(OrderProcedure record);

    int insertSelective(OrderProcedure record);

    int batchInsertOrderProcedure(List<OrderProcedure> orderProcedureList);

    int batchUpdateOrderProcedure(List<OrderProcedure> orderProcedureList);

    OrderProcedure queryOneOrderProcedure(OrderProcedure orderProcedure);

    List<OrderProcedure> queryOrderProcedureListByParam(OrderProcedure orderProcedure);

    OrderProcedure getById(Integer id);

    int updateOrderProcedure(OrderProcedure orderProcedure);

    OrderProcedure getOrderProcedureNotSelfByParam(OrderProcedure orderProcedure);

    OrderProcedure findLastProcedure(String dwgNo);

    int deleteProcedureById(Integer id);



}