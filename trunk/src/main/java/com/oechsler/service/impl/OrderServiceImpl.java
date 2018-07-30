package com.oechsler.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oechsler.common.page.PageResult;
import com.oechsler.common.utils.CommonUtils;
import com.oechsler.common.utils.excel.ExcelUtil;
import com.oechsler.mapper.OrderMapper;
import com.oechsler.mapper.OrderProcedureMapper;
import com.oechsler.model.Order;
import com.oechsler.model.OrderProcedure;
import com.oechsler.service.OrderService;
import com.oechsler.shiro.token.manager.TokenManager;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;

/**
 * author:Kris
 * date:2017/10/20
 */
@Service("orderService")
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderProcedureMapper orderProcedureMapper;

    @Override
    public PageResult<Order> getOrderList(Order order, int pageIndex, int pageSize) {
        PageHelper.startPage(pageIndex, pageSize);
        List<Order> data = orderMapper.queryOrderList(order);
        PageInfo<Order> pageInfo = new PageInfo<Order>(data);
        PageResult<Order> pageResult = new PageResult<>(data, pageIndex, pageSize, (int) pageInfo.getTotal());
        return pageResult;
    }

    @Override
    public Order getOrderById(Integer orderId) {
        return orderMapper.queryOrderById(orderId);
    }

    @Override
    @Transactional
    public int updateOrder(Order order) {
        return orderMapper.updateOrder(order);
    }

    @Override
    public List<Order> getOrderListByParam(Order order) {
        return orderMapper.queryOrderListByParam(order);
    }

    @Override
    public Order getOneOrder(Order order) {
        return orderMapper.queryOneOrder(order);
    }

    @Override
    @Transactional
    public int updateOrderAndSameDwgNoOrder(Map map) {
        return orderMapper.updateOrderAndSameDwgNoOrder(map);
    }

    @Override
    public void batchDeleteOrder(String ids) {
        orderMapper.batchDeleteOrder(ids);
    }

    @Override
    public Boolean importOrderExcelInfo(InputStream in, MultipartFile file, String importType) {
        try {
            //创建Excel工作薄
            Workbook work = ExcelUtil.getWorkbook(in, file.getOriginalFilename());
            if (null == work) {
                return false;
            }
            Sheet sheet = null;
            if (importType.equals("all")) {
                for (int i = 0; i < work.getNumberOfSheets(); i++) {
                    //获取最后一张sheet
                    sheet = work.getSheetAt(i);
                    if (sheet == null) {
                        return false;
                    }
                    doImport(sheet);
                }
            } else {
                //获取最后一张sheet
                sheet = work.getSheetAt(work.getNumberOfSheets() - 1);
                if (sheet == null) {
                    return false;
                }
                doImport(sheet);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public void doImport(Sheet sheet) {
        Row row = null;
        Cell cell, initiatorCell, initiatorDateCell, targetDateCell;
        String jobNo, initiator, initiatorDate, targetDate;
        List<List<Object>> list = new ArrayList<List<Object>>();
        List<Object> procedureList = new ArrayList<>();
        //获取jobNo
        cell = sheet.getRow(3).getCell(3);
        jobNo = ExcelUtil.getCellValue(cell).toString();
        //获取TARGET DATE
        targetDateCell = sheet.getRow(4).getCell(3);
        targetDate = ExcelUtil.getCellValue(targetDateCell).toString();
        //获取INITIATOR
        initiatorCell = sheet.getRow(3).getCell(32);
        initiator = ExcelUtil.getCellValue(initiatorCell).toString();
        //获取INITIATOR Date
        initiatorDateCell = sheet.getRow(4).getCell(32);
        initiatorDate = ExcelUtil.getCellValue(initiatorDateCell).toString();
        //获取工序列表
        row = sheet.getRow(6);
        procedureList = new ArrayList<Object>();
        for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
            cell = row.getCell(y);
            procedureList.add(ExcelUtil.getCellValue(cell));
        }
        //遍历当前sheet中的所有行
        //包涵头部，所以要小于等于最后一列数,这里也可以在初始值加上头部行数，以便跳过头部
        for (int j = sheet.getFirstRowNum() + 7; j <= sheet.getLastRowNum() - 5; j++) {
            //读取一行
            row = sheet.getRow(j);
            //去掉空行和表头
            if (row == null || row.getFirstCellNum() == j) {
                continue;
            }
            //遍历所有的列
            List<Object> li = new ArrayList<Object>();
            for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
                cell = row.getCell(y);
                li.add(ExcelUtil.getCellValue(cell));
            }
            list.add(li);
        }
        //订单新增列表
        List<Order> orderList = new ArrayList<>();
        List<Order> updateOrderList = new ArrayList<>();
        //工序新增列表
        List<OrderProcedure> orderProcedureList = new ArrayList<>();
        List<OrderProcedure> updateOrderProcedureList = new ArrayList<>();
        for (int i = 0; i < list.size(); i = i + 2) {
            List<Object> rowList = list.get(i);
            String dwgNo = rowList.get(1).toString();
            if (dwgNo.equals("")) {
                continue;
            }
            //order对象
            Order order = new Order();
            order.setCreateBy(TokenManager.getUserId());
            order.setCreateTime(new Date());
            order.setUpdateBy(TokenManager.getUserId());
            order.setUpdateTime(new Date());
            order.setDeleted(0);
            order.setTargetDate(CommonUtils.formatDate(targetDate, "yyyy-MM-dd"));
            order.setInitiator(initiator);
            order.setInitiatorDate(CommonUtils.formatDate(initiatorDate, "yyyy-MM-dd"));
            order.setStatus(1);
            order.setJobNo(jobNo);
            order.setDwgNo(rowList.get(1).toString());
            order.setNewDwgNo(jobNo + rowList.get(1));
            order.setRev(rowList.get(2).toString());
            order.setOrderQty(rowList.get(3).toString());
            order.setPlot(rowList.get(4).toString());
            order.setProdQty(rowList.get(5).toString());
            Random ne = new Random();
            //随机四位数
            int x = ne.nextInt(9999 - 1000 + 1) + 1000;
            order.setBarCode(CommonUtils.formatTime("yyyyMMddHHmmss", new Date()) + x);
            order.setPreCostTime(rowList.get(rowList.size() - 1).toString());

            String sameDwgNo = list.get(i + 1).get(procedureList.size() - 3).toString();
            if (sameDwgNo.equals("")) {
                //遍历创建工序对象
                //不存在共同加工的零件
                String tempProcedureName = "";
                for (int j = 6; j < procedureList.size() - 3; j++) {
                    //工序名称
                    String procedureName = procedureList.get(j).toString();
                    //排序
                    String sort = list.get(i).get(j).toString();
                    //预估工时
                    String costTime = list.get(i + 1).get(j).toString();
                    if (!procedureName.equals("")) {
                        tempProcedureName = procedureName;
                    }
                    if (!sort.equals("")) {
                        OrderProcedure procedure = new OrderProcedure();
                        procedure.setCreateBy(TokenManager.getUserId());
                        procedure.setCreateTime(new Date());
                        procedure.setUpdateBy(TokenManager.getUserId());
                        procedure.setUpdateTime(new Date());
                        procedure.setDeleted(0);
                        procedure.setEnName(tempProcedureName);
                        procedure.setStatus(1);
                        procedure.setSort(sort);
                        if (!costTime.equals("")) {
                            procedure.setPreCostTime(costTime);
                        }
                        procedure.setDwgNo(order.getNewDwgNo());
                        //查询工序是否存在
                        OrderProcedure resultProcedure = orderProcedureMapper.queryOneOrderProcedure(procedure);
                        if (resultProcedure == null) {
                            //不存在则新增
                            orderProcedureList.add(procedure);
                        } else {
                            //存在则修改
                            procedure.setId(resultProcedure.getId());
                            updateOrderProcedureList.add(procedure);
                        }
                    }
                }
            } else {
                order.setSameDwgNo(jobNo + sameDwgNo);
            }
            //查询数据是否存在
            Order resultOrder = orderMapper.checkOrderByNewDwgNo(order.getNewDwgNo());
            if (resultOrder == null) {
                //不存在则新增
                orderList.add(order);
            } else {
                //存在则修改
                order.setId(resultOrder.getId());
                updateOrderList.add(order);
            }
        }
        if (orderList.size() > 0) {
            int result = orderMapper.batchInsertOrder(orderList);
            if (result > 0 && orderProcedureList.size() > 0) {
                orderProcedureMapper.batchInsertOrderProcedure(orderProcedureList);
            }
        }
        if (updateOrderList.size() > 0) {
            int result = orderMapper.batchUpdateOrder(updateOrderList);
            if (result > 0 && updateOrderProcedureList.size() > 0) {
                orderProcedureMapper.batchUpdateOrderProcedure(updateOrderProcedureList);
            }
        }
    }

    @Override
    public List<Order> getByIds(String ids) {
        return orderMapper.getByIds(ids);
    }
}
