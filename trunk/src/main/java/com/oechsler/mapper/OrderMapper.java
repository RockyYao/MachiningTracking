package com.oechsler.mapper;

import com.oechsler.model.Order;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface OrderMapper {
    int insert(Order record);

    int insertSelective(Order record);

    int batchInsertOrder(List<Order> orderList);

    int batchUpdateOrder(List<Order> orderList);

    List<Order> queryByOrderList(List<Order> orderList);

    Order queryOneOrder(Order order);

    List<Order> queryOrderListByParam(Order order);

    List<Order> queryOrderList(Order order);

    Order queryOrderById(Integer orderId);

    int updateOrder(Order order);

    int updateOrderAndSameDwgNoOrder(Map map);

    Order checkOrderByNewDwgNo(String newDwgNo);

    int batchDeleteOrder(String ids);

    List<Order> getByIds(String ids);
}