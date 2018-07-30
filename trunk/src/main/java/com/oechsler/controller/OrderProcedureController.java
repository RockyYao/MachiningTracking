package com.oechsler.controller;

import com.oechsler.common.model.BaseResult;
import com.oechsler.common.page.PageResult;
import com.oechsler.common.utils.CommonUtils;
import com.oechsler.model.Order;
import com.oechsler.model.OrderProcedure;
import com.oechsler.service.OrderProcedureService;
import com.oechsler.service.OrderService;
import com.oechsler.shiro.token.manager.TokenManager;
import javafx.geometry.Pos;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;

/**
 * author:Kris
 * date:2017/10/27
 */
@Controller
@RequestMapping("/orderProcedure")
public class OrderProcedureController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderProcedureService orderProcedureService;

    @RequestMapping("/orderProcedureList")
    public ModelAndView orderProcedureList(Integer orderId, OrderProcedure orderProcedure,
                                           @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                           @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                           Integer orderCurrentPage,Integer orderPageSize) {
        orderProcedure.setDwgNo(getDwgNo(orderId));
        PageResult<OrderProcedure> orderProcedurePageResult = orderProcedureService.getOrderProcedureList(orderProcedure, currentPage, pageSize);
        return new ModelAndView("order_procedure/order_procedure_list")
                .addObject("orderProcedurePageResult", orderProcedurePageResult)
                .addObject("orderId", orderId)
                .addObject("orderCurrentPage",orderCurrentPage)
                .addObject("orderPageSize",orderPageSize);
    }

    @RequestMapping("/addOrderProcedure")
    public ModelAndView toAddOrderProcedure(Integer orderId) {
        return new ModelAndView("order_procedure/order_procedure_add")
                .addObject("orderId", orderId);
    }

    @RequestMapping(value = "/addOrderProcedure",method = RequestMethod.POST)
    public void addOrderProcedure(HttpServletResponse response, OrderProcedure orderProcedure, Integer orderId) {
        try {
            //获取dwgNo
            String dwgNo = getDwgNo(orderId);
            JSONObject jsonObject = new JSONObject();
            orderProcedure.setCreateBy(TokenManager.getUserId());
            orderProcedure.setCreateTime(new Date());
            orderProcedure.setUpdateBy(TokenManager.getUserId());
            orderProcedure.setUpdateTime(new Date());
            orderProcedure.setDeleted(0);
            orderProcedure.setStatus(1);
            orderProcedure.setDwgNo(dwgNo);
            orderProcedure.setSort(CommonUtils.decimalFormat("0.0", orderProcedure.getSort()));
            orderProcedure.setPreCostTime(CommonUtils.decimalFormat("0.0", orderProcedure.getPreCostTime()));
            orderProcedureService.addOrderProcedure(orderProcedure);
            //查询订单
            Order order = orderService.getOrderById(orderId);
            Float oldCostTime = Float.parseFloat(order.getPreCostTime());
            Float addCostTime = Float.parseFloat(orderProcedure.getPreCostTime());
            Float newCostTime = oldCostTime + addCostTime;
            order.setPreCostTime(CommonUtils.decimalFormat("0.0", newCostTime.toString()));
            //更新订单时间
            orderService.updateOrder(order);
            jsonObject.put("result", true);
            response.setContentType("text/plain");
            response.setHeader("Cache-Control", "no-cache");
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/editOrderProcedure")
    public ModelAndView toEditOrderProcedure(Integer id, Integer orderId) {
        OrderProcedure orderProcedure = orderProcedureService.getById(id);
        return new ModelAndView("order_procedure/order_procedure_edit")
                .addObject("orderProcedure", orderProcedure)
                .addObject("orderId", orderId);
    }

    @RequestMapping(value = "/editOrderProcedure",method = RequestMethod.POST)
    public void editOrderProcedure(HttpServletResponse response, OrderProcedure orderProcedure, Integer orderId) {
        try {
            OrderProcedure oldProcedure = orderProcedureService.getById(orderProcedure.getId());
            orderProcedure.setUpdateBy(TokenManager.getUserId());
            orderProcedure.setUpdateTime(new Date());
            orderProcedure.setSort(CommonUtils.decimalFormat("0.0", orderProcedure.getSort()));
            orderProcedure.setPreCostTime(CommonUtils.decimalFormat("0.0", orderProcedure.getPreCostTime()));
            orderProcedureService.updateOrderProcedure(orderProcedure);
            //查询订单
            Order order = orderService.getOrderById(orderId);
            Float oldCostTime = Float.parseFloat(order.getPreCostTime());
            Float oldProcedureCostTime = Float.parseFloat(oldProcedure.getPreCostTime());
            //计算修改钱的预估工时
            Float preCostTime = oldCostTime - oldProcedureCostTime;

            Float addCostTime = Float.parseFloat(orderProcedure.getPreCostTime());
            //计算修改后的预估工时
            Float newCostTime = preCostTime + addCostTime;
            order.setPreCostTime(CommonUtils.decimalFormat("0.0", newCostTime.toString()));
            //更新订单时间
            orderService.updateOrder(order);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("result",true);
            response.setContentType("text/plain");
            response.setHeader("Cache-Control", "no-cache");
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/deleteOrderProcedure")
    public ModelAndView deleteOrderProcedure(Integer id,Integer orderId){
        orderProcedureService.deleteProcedureById(id);
        return new ModelAndView("redirect:orderProcedureList.htm?orderId="+orderId);
    }

    @RequestMapping("/checkProcedureSort")
    @ResponseBody
    public Object checkProcedureSort(OrderProcedure orderProcedure, Integer orderId) {
        BaseResult baseResult = new BaseResult();
        baseResult.setResult(true);
        Order order = orderService.getOrderById(orderId);
        if(order.getStatus().intValue() == 3){
            baseResult.setResult(false);
            baseResult.setMessage("订单已完成无法添加");
            return baseResult;
        }
        if(order.getCurrentSort() != null){
            if(new BigDecimal(orderProcedure.getSort()).compareTo(new BigDecimal(order.getCurrentSort()))<=0){
                baseResult.setResult(false);
                baseResult.setMessage("无法在已完成工序前添加");
                return baseResult;
            }
        }
        //获取DwgNo
        orderProcedure.setDwgNo(getDwgNo(orderId));
        orderProcedure.setSort(CommonUtils.decimalFormat("0.0", orderProcedure.getSort()));
        orderProcedure = orderProcedureService.getOrderProcedureNotSelfByParam(orderProcedure);
        if (orderProcedure != null) {
            baseResult.setResult(false);
            baseResult.setMessage("无法添加相同排序的工序");
            return baseResult;
        }
        return baseResult;
    }

    private String getDwgNo(Integer orderId) {
        //查询对应订单
        Order order = orderService.getOrderById(orderId);
        String dwgNo;
        if (order.getSameDwgNo() != null && !order.getSameDwgNo().equals("")) {
            dwgNo = order.getSameDwgNo();
        } else {
            dwgNo = order.getNewDwgNo();
        }
        return dwgNo;
    }
}
