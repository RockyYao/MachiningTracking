package com.oechsler.controller;

import com.oechsler.common.page.PageResult;
import com.oechsler.common.utils.CommonUtils;
import com.oechsler.common.utils.ZplPrinter;
import com.oechsler.model.Order;
import com.oechsler.model.OrderProcedure;
import com.oechsler.service.OrderProcedureService;
import com.oechsler.service.OrderService;
import com.oechsler.shiro.token.manager.TokenManager;
import net.sf.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

/**
 * author:Kris
 * date:2017/10/24
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderProcedureService orderProcedureService;

    @RequestMapping("/orderList")
    public ModelAndView orderList(HttpServletResponse response, HttpServletRequest request,
                                  @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                  Order order) {
        PageResult<Order> orderPageResult = orderService.getOrderList(order, currentPage, pageSize);
        return new ModelAndView("order/order_list")
                .addObject("orderPageResult", orderPageResult)
                .addObject("order", order);
    }

    @RequestMapping("/importOrder")
    public ModelAndView toImportOrder() {
        return new ModelAndView("order/order_import");
    }

    @RequestMapping(value = "/importOrder", method = RequestMethod.POST)
    public void importOrder(HttpServletRequest request, HttpServletResponse response) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message", "导入成功");
        jsonObject.put("url", "/order/orderList.htm");
        String importType = request.getParameter("importType");
        try {
            //获取上传的文件
            MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
            MultipartFile file = multipart.getFile("fileToUpload");
            InputStream in = file.getInputStream();
            //数据导入
            boolean result = orderService.importOrderExcelInfo(in, file, importType);
            in.close();

            jsonObject.put("result", result);
            response.setContentType("text/plain");
            response.setHeader("Cache-Control", "no-cache");
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/editOrder")
    public ModelAndView toEditOrder(Integer id,Integer currentPage,Integer pageSize) {
        Order order = orderService.getOrderById(id);
        return new ModelAndView("order/order_edit")
                .addObject("order", order)
                .addObject("currentPage",currentPage)
                .addObject("pageSize",pageSize);
    }

    @RequestMapping(value = "/editOrder", method = RequestMethod.POST)
    public ModelAndView editOrder(Order order,Integer currentPage,Integer pageSize) {
        order.setUpdateBy(TokenManager.getUserId());
        order.setUpdateTime(new Date());
        order.setNewDwgNo(order.getJobNo() + order.getDwgNo());
        Random ne = new Random();
        //随机四位数
        int x = ne.nextInt(9999 - 1000 + 1) + 1000;
        order.setBarCode(CommonUtils.formatTime("yyyyMMddHHmmss", new Date()) + x);
        orderService.updateOrder(order);
        return new ModelAndView("redirect:/order/orderList.htm?currentPage="+currentPage+"&pageSize="+pageSize);
    }

    @RequestMapping("/exportOrder")
    public ModelAndView toExportOrder() {
        return new ModelAndView("order/order_export");
    }

    @RequestMapping(value = "/exportOrder", method = RequestMethod.POST)
    public void exportOrder(HttpServletResponse response, String exportData, String exportValue) {
        Order order = new Order();
        if (exportData.equals("dwgNo")) {
            order.setDwgNo(exportValue);
        } else if (exportData.equals("jobNo")) {
            order.setJobNo(exportValue);
        }
        List<Order> orderList = orderService.getOrderListByParam(order);
        //创建HSSFWorkbook对象(excel的文档对象)
        HSSFWorkbook wb = new HSSFWorkbook();
        //建立新的sheet对象（excel的表单）
        HSSFSheet sheet = wb.createSheet("订单条形码");
        for (int i = 0; i < orderList.size(); i++) {
            HSSFRow row = sheet.createRow(i);
            //创建单元格并设置单元格内容
            row.createCell(0).setCellValue(orderList.get(i).getBarCode());
        }
        try {
            //输出Excel文件
            OutputStream output = response.getOutputStream();
            response.reset();
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode("订单条形码.xls", "UTF-8"));
            response.setContentType("application/msexcel");
            wb.write(output);
            output.flush();
            output.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/downloadExcel")
    public void downloadExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getSession().getServletContext().getRealPath("/excel/ot-excel.xls");
        File f = new File(path);
        // 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        try {
            response.setHeader("Content-Disposition", "attachment;filename=" + new String(("订单模版" + ".xls").getBytes(), "iso-8859-1"));//下载文件的名称
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        ServletOutputStream out = response.getOutputStream();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        try {
            bis = new BufferedInputStream(new FileInputStream(f));
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
        } catch (final IOException e) {
            throw e;
        } finally {
            if (bis != null)
                bis.close();
            if (bos != null)
                bos.close();
        }
    }

    @RequestMapping("/deleteOrder")
    public ModelAndView deleteOrder(Integer id,Integer currentPage,Integer pageSize) {
        //删除订单
        Order order = new Order();
        order.setDeleted(1);
        order.setId(id);
        orderService.updateOrder(order);
        return new ModelAndView("redirect:/order/orderList.htm?currentPage="+currentPage+"&pageSize="+pageSize);
    }

    @RequestMapping("/batchDeleteOrder")
    public ModelAndView batchDeleteOrder(String ids) {
        //删除订单
        orderService.batchDeleteOrder(ids);
        return new ModelAndView("redirect:/order/orderList.htm");
    }

    @RequestMapping("/printTag")
    @ResponseBody
    public Object printTag(Integer orderId) {
        //查询订单
        Order order = orderService.getOrderById(orderId);
        ZplPrinter p = new ZplPrinter("ZDesigner 110Xi4 600 dpi");
        //1.打印单个条码

        String bar0Zpl = "^FO110,110^BY6^BCN,280,Y,N,N^FD${data}^FS";//条码内容
//        String bar0Zpl = "^FO110,110^BY6,3.0,280^BCN,,Y,N,N^FD${data}^FS";//条码样式模板
        p.setBarcode(order.getBarCode(), bar0Zpl);
        String content = order.getJobNo() + "-" + order.getDwgNo() + "-" + order.getRev();
        p.setChar(content, 110, 550, 100, 100);
        String zpl = p.getZpl();
        System.out.println(zpl);
        boolean result = p.print(zpl);//打印
        return result;
    }

    @RequestMapping("/batchPrint")
    @ResponseBody
    public Object batchPrint(String ids) {
        //查询选中订单
        List<Order> orderList = orderService.getByIds(ids);
        boolean result = true;
        for(Order order : orderList){
            ZplPrinter p = new ZplPrinter("ZDesigner 110Xi4 600 dpi");
            //1.打印单个条码
            String bar0Zpl = "^FO110,110^BY6^BCN,280,Y,N,N^FD${data}^FS";//条码内容
//        String bar0Zpl = "^FO110,110^BY6,3.0,280^BCN,,Y,N,N^FD${data}^FS";//条码样式模板
            p.setBarcode(order.getBarCode(), bar0Zpl);
            String content = order.getJobNo() + "-" + order.getDwgNo() + "-" + order.getRev();
            p.setChar(content, 110, 550, 100, 100);
            String zpl = p.getZpl();
            System.out.println(zpl);
            result = p.print(zpl);//打印
            if(!result){
                break;
            }
        }
        return result;
    }
}
