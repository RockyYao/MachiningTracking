package com.oechsler.mapper;

import com.oechsler.model.OrderProcedureLog;
import org.springframework.stereotype.Repository;


@Repository
public interface OrderProcedureLogMapper {
    int insert(OrderProcedureLog record);

    int insertSelective(OrderProcedureLog record);

    OrderProcedureLog selectStartTime(OrderProcedureLog orderProcedureLog);

    int updateOrderProcedureLog(OrderProcedureLog orderProcedureLog);

    OrderProcedureLog getById(Integer id);

}