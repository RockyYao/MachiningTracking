package com.oechsler.controller;

import com.oechsler.common.model.BaseResult;
import com.oechsler.common.utils.CommonUtils;
import com.oechsler.model.Order;
import com.oechsler.model.OrderProcedure;
import com.oechsler.model.OrderProcedureLog;
import com.oechsler.service.OrderProcedureLogService;
import com.oechsler.service.OrderProcedureService;
import com.oechsler.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * author:kriswang
 * date:2017/11/22 0022上午 10:41
 **/
@Controller
@RequestMapping("/procedureLog")
public class OrderProcedureLogController {

    @Autowired
    private OrderProcedureService orderProcedureService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderProcedureLogService orderProcedureLogService;

    @RequestMapping("/editProcedureLog")
    public ModelAndView toEditProcedureLog(Integer id){
        OrderProcedureLog orderProcedureLog = orderProcedureLogService.getById(id);
        return new ModelAndView("order_procedure_log/procedure_log_edit")
                .addObject("orderProcedureLog",orderProcedureLog);
    }

    @RequestMapping(value = "/editProcedureLog",method = RequestMethod.POST)
    @ResponseBody
    public BaseResult editProcedureLog(Integer id, String endTime){
        BaseResult baseResult = new BaseResult();
        baseResult.setResult(true);
        try {
            //查询当前记录
            OrderProcedureLog orderProcedureLog = orderProcedureLogService.getById(id);
            //查询对应工序
            OrderProcedure orderProcedure = orderProcedureService.getById(orderProcedureLog.getProcedureId());
            long procedureCostTime = Long.parseLong(orderProcedure.getRelCostTime()) - Long.parseLong(orderProcedureLog.getCostTime());
            Order order = new Order();
            order.setDwgNo(orderProcedure.getDwgNo());
            //查询对应订单
            order = orderService.getOneOrder(order);
            String dwgNo;
            if (order.getSameDwgNo() != null && !order.getSameDwgNo().equals("")) {
                dwgNo = order.getSameDwgNo();
            } else {
                dwgNo = order.getDwgNo();
            }
            long orderCostTime = Long.parseLong(order.getRelCostTime()) - Long.parseLong(orderProcedureLog.getCostTime());
            //时间转换
            Date endDate = CommonUtils.formatDate(endTime,"yyyy-MM-dd HH:mm:ss");
            //获取记录耗时
            Map logMap = CommonUtils.getFormatTime(orderProcedureLog.getStartTime(),endDate,"0");
            orderProcedureLog.setEndTime(endDate);
            orderProcedureLog.setCostTime(logMap.get("relCostTime").toString());
            orderProcedureLog.setFormatRelCostTime(logMap.get("formatRelCostTime").toString());
            //更新记录
            orderProcedureLogService.updateOrderProcedureLog(orderProcedureLog);

            //获取工序耗时
            Map procedureMap = CommonUtils.getFormatTime(orderProcedureLog.getStartTime(),endDate,String.valueOf(procedureCostTime));
            orderProcedure.setRelCostTime(procedureMap.get("relCostTime").toString());
            orderProcedure.setFormatRelCostTime(procedureMap.get("formatRelCostTime").toString());
            //更新工序
            orderProcedureService.updateOrderProcedure(orderProcedure);
            //获取订单耗时
            Map orderMap = CommonUtils.getFormatTime(orderProcedureLog.getStartTime(),endDate,String.valueOf(orderCostTime));
            Map map = new HashMap();
            map.put("dwgNo",dwgNo);
            map.put("updateTime",new Date());
            map.put("relCostTime",orderMap.get("relCostTime").toString());
            map.put("formatRelCostTime",orderMap.get("formatRelCostTime").toString());
            //更新订单
            orderService.updateOrderAndSameDwgNoOrder(map);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            baseResult.setResult(false);
        }
        return baseResult;
    }
}
