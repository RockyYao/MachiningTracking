package com.oechsler.service;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.Order;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * author:Kris
 * date:2017/10/20
 */
public interface OrderService {

    Boolean importOrderExcelInfo(InputStream in, MultipartFile file, String importType);

    PageResult<Order> getOrderList(Order order, int pageIndex, int pageSize);

    Order getOrderById(Integer orderId);

    int updateOrder(Order order);

    List<Order> getOrderListByParam(Order order);

    Order getOneOrder(Order order);

    int updateOrderAndSameDwgNoOrder(Map map);

    void batchDeleteOrder(String ids);

    List<Order> getByIds(String ids);
}
