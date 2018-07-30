package com.oechsler.controller;

import com.oechsler.common.utils.CommonUtils;
import com.oechsler.model.Employee;
import com.oechsler.model.Order;
import com.oechsler.model.OrderProcedure;
import com.oechsler.model.OrderProcedureLog;
import com.oechsler.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author Rocky
 * @create 2017-10-31 17:05
 **/
@Controller
@RequestMapping("/worker")
public class WorkerController {


    @Autowired
    private OrderService orderService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private OrderProcedureLogService orderProcedureLogService;
    @Autowired
    private OrderProcedureService orderProcedureService;

    @RequestMapping("/order")
    public ModelAndView order(String barCode) {
        ModelAndView mv = new ModelAndView();
        if (barCode != null) {
            Order order = new Order();
            order.setBarCode(barCode);
            order = orderService.getOneOrder(order);
            if (order != null) {
                String dwgNo;
                //判断是否有同时加工的工件
                if (order.getSameDwgNo() != null) {
                    dwgNo = order.getSameDwgNo();
                } else {
                    dwgNo = order.getNewDwgNo();
                }
                OrderProcedure orderProcedure = new OrderProcedure();
                orderProcedure.setDwgNo(dwgNo);
                //查询工序列表
                List<OrderProcedure> orderProcedureList = orderProcedureService.getOrderProcedureListByParam(orderProcedure);

                if (order.getStatus().intValue() == 1) {
                    mv.addObject("currentSort", "1.0");
                } else if (order.getStatus().intValue() == 2) {
                    for (int i = 0; i < orderProcedureList.size(); i++) {
                        orderProcedure = orderProcedureList.get(i);
                        //匹配当前工序
                        if (orderProcedure.getSort().equals(order.getCurrentSort())) {
                            if (orderProcedure.getStatus().intValue() == 5) {
                                //如果当前工序已经完成，那么就取下一个工序的的排序
                                mv.addObject("currentSort", orderProcedureList.get(i + 1).getSort());
                                break;
                            }
                        }
                    }
                }
                mv.addObject("order", order);
                mv.addObject("orderProcedureList", orderProcedureList);
            }
        }

        mv.addObject("barCode", barCode);
        mv.setViewName("worker/order");
        return mv;
    }

    @RequestMapping(value = "/accept")
    @ResponseBody
    public String accept(HttpServletResponse response, Integer id, String barCode, String workNo) {
        int result;
        OrderProcedureLog orderProcedureLog = new OrderProcedureLog();
        orderProcedureLog.setCreateTime(new Date());
        orderProcedureLog.setUpdateTime(new Date());
        orderProcedureLog.setWorkNo(workNo);
        orderProcedureLog.setProcedureId(id);
        orderProcedureLog.setReceiveTime(new Date());
        orderProcedureLog.setLogType(1);
        //插入接收记录
        result = orderProcedureLogService.insert(orderProcedureLog);
        if (result == 0) {
            return "failure";
        }

        OrderProcedure orderProcedure = orderProcedureService.getById(id);
        orderProcedure.setUpdateTime(new Date());
        orderProcedure.setStatus(2);
        //更新工序状态为已接收
        result = orderProcedureService.updateOrderProcedure(orderProcedure);
        if (result == 0) {
            return "failure";
        }

        Order order = new Order();
        order.setBarCode(barCode);
        //查询订单
        order = orderService.getOneOrder(order);

        Map map = new HashMap();
        map.put("updateTime", new Date());
        map.put("status", 2);
        map.put("currentProcedure", orderProcedure.getEnName());
        map.put("currentSort", orderProcedure.getSort());
        if (order.getSameDwgNo() != null) {
            map.put("dwgNo", order.getSameDwgNo());
        } else {
            map.put("dwgNo", order.getNewDwgNo());
        }
        //更新订单和同时加工的订单信息
        result = orderService.updateOrderAndSameDwgNoOrder(map);
        if (result == 0) {
            return "failure";
        }
        return "success";
    }

    @RequestMapping(value = "/start")
    @ResponseBody
    public String start(Integer id, String workNo) {
        OrderProcedureLog orderProcedureLog = new OrderProcedureLog();
        orderProcedureLog.setCreateTime(new Date());
        orderProcedureLog.setUpdateTime(new Date());
        orderProcedureLog.setWorkNo(workNo);
        orderProcedureLog.setProcedureId(id);
        orderProcedureLog.setStartTime(new Date());
        orderProcedureLog.setLogType(2);
        //插入接收记录
        int result = orderProcedureLogService.insert(orderProcedureLog);
        if (result == 0) {
            return "failure";
        }
        OrderProcedure orderProcedure = new OrderProcedure();
        orderProcedure.setUpdateTime(new Date());
        orderProcedure.setStatus(3);
        orderProcedure.setId(id);
        //更新工序状态为进行中
        result = orderProcedureService.updateOrderProcedure(orderProcedure);
        if (result == 0) {
            return "failure";
        }
        return "success";
    }

    @RequestMapping(value = "/pause")
    @ResponseBody
    public String pause(Integer id, String barCode) {
        OrderProcedureLog orderProcedureLog = new OrderProcedureLog();
        orderProcedureLog.setProcedureId(id);
        OrderProcedureLog procedureLogStart = orderProcedureLogService.selectStartTime(orderProcedureLog);

        Date date = new Date();
        Map logMap = CommonUtils.getFormatTime(procedureLogStart.getStartTime(), date, "0");
        orderProcedureLog.setUpdateTime(date);
        orderProcedureLog.setId(procedureLogStart.getId());
        orderProcedureLog.setEndTime(date);
        orderProcedureLog.setCostTime(logMap.get("relCostTime").toString());
        orderProcedureLog.setFormatRelCostTime(logMap.get("formatRelCostTime").toString());
        //更新记录结束时间
        int result = orderProcedureLogService.updateOrderProcedureLog(orderProcedureLog);
        if (result == 0) {
            return "failure";
        }

        Order order = new Order();
        order.setBarCode(barCode);
        order = orderService.getOneOrder(order);
        Map orderMap = CommonUtils.getFormatTime(procedureLogStart.getStartTime(), date, order.getRelCostTime());
        Map map = new HashMap();
        map.put("updateTime", new Date());
        map.put("relCostTime", orderMap.get("relCostTime").toString());
        map.put("formatRelCostTime", orderMap.get("formatRelCostTime").toString());
        if (order.getSameDwgNo() != null) {
            map.put("dwgNo", order.getSameDwgNo());
        } else {
            map.put("dwgNo", order.getNewDwgNo());
        }
        //更新订单实际工时
        result = orderService.updateOrderAndSameDwgNoOrder(map);
        if (result == 0) {
            return "failure";
        }

        OrderProcedure orderProcedure = orderProcedureService.getById(id);
        Map procedureMap = CommonUtils.getFormatTime(procedureLogStart.getStartTime(), date, orderProcedure.getRelCostTime());
        orderProcedure.setUpdateTime(date);
        orderProcedure.setStatus(4);
        orderProcedure.setRelCostTime(procedureMap.get("relCostTime").toString());
        orderProcedure.setFormatRelCostTime(procedureMap.get("formatRelCostTime").toString());
        //更新工序实际工时
        result = orderProcedureService.updateOrderProcedure(orderProcedure);
        if (result == 0) {
            return "failure";
        }
        return "success";
    }


    @RequestMapping(value = "/complete")
    @ResponseBody
    public String complete(Integer id, String barCode) {
        OrderProcedureLog orderProcedureLog = new OrderProcedureLog();
        orderProcedureLog.setProcedureId(id);
        //查询工序记录
        OrderProcedureLog procedureLogStart = orderProcedureLogService.selectStartTime(orderProcedureLog);

        Date date = new Date();
        Map logMap = CommonUtils.getFormatTime(procedureLogStart.getStartTime(), date, "0");
        orderProcedureLog.setUpdateTime(date);
        orderProcedureLog.setId(procedureLogStart.getId());
        orderProcedureLog.setEndTime(date);
        orderProcedureLog.setCostTime(logMap.get("relCostTime").toString());
        orderProcedureLog.setFormatRelCostTime(logMap.get("formatRelCostTime").toString());
        //更新工序记录
        int result = orderProcedureLogService.updateOrderProcedureLog(orderProcedureLog);
        if (result == 0) {
            return "failure";
        }

        Order order = new Order();
        order.setBarCode(barCode);
        order = orderService.getOneOrder(order);
        Map orderMap = CommonUtils.getFormatTime(procedureLogStart.getStartTime(), date, order.getRelCostTime());
        Map map = new HashMap();
        map.put("updateTime", new Date());
        map.put("relCostTime", orderMap.get("relCostTime").toString());
        map.put("formatRelCostTime", orderMap.get("formatRelCostTime").toString());
        String dwgNo;
        if (order.getSameDwgNo() != null) {
            dwgNo = order.getSameDwgNo();
        } else {
            dwgNo = order.getNewDwgNo();
        }
        map.put("dwgNo", dwgNo);

        //查询最后一道工序
        OrderProcedure orderProcedureLast = orderProcedureService.findLastProcedure(dwgNo);
        //查询当前工序
        OrderProcedure orderProcedureThis = orderProcedureService.getById(id);
        //判断是否是最后一道工序
        if (orderProcedureThis.getSort().equals(orderProcedureLast.getSort())) {
            map.put("status", 3);
            map.put("sortIsNull", true);
            map.put("procedureIsNull", true);
        }
        //更新订单实际工时
        result = orderService.updateOrderAndSameDwgNoOrder(map);
        if (result == 0) {
            return "failure";
        }

        Map procedureMap = CommonUtils.getFormatTime(procedureLogStart.getStartTime(), date, orderProcedureThis.getRelCostTime());
        orderProcedureThis.setUpdateTime(date);
        orderProcedureThis.setStatus(5);
        orderProcedureThis.setRelCostTime(procedureMap.get("relCostTime").toString());
        orderProcedureThis.setFormatRelCostTime(procedureMap.get("formatRelCostTime").toString());
        //更新工序实际工时
        result = orderProcedureService.updateOrderProcedure(orderProcedureThis);
        if (result == 0) {
            return "failure";
        }
        return "success";
    }

    @RequestMapping("/checkEmployee")
    @ResponseBody
    public Object checkEmployee(String workNo, Integer id) {
        OrderProcedure orderProcedure = orderProcedureService.getById(id);
        Map map = new HashMap();
        map.put("workNo", workNo);
        Employee employee = employeeService.getOneEmployeeByParam(map);
        boolean result = employee != null ? true : false;
        if (result) {
            map.put("procedureName",orderProcedure.getEnName());
            List<String> names = employeeService.queryProcedureByWorkNo(map);
            return names.size() > 0 ? true : false;
        } else {
            return result;
        }
    }
}

