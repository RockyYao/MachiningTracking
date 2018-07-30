package com.oechsler.controller;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.Employee;
import com.oechsler.service.EmployeeService;
import com.oechsler.shiro.token.manager.TokenManager;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * author:kriswang
 * date:2017/11/13 0013下午 14:19
 **/
@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/employeeList")
    public ModelAndView employeeList(Employee employeeParam,
                                     @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                     @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageResult<Employee> employeePageResult = employeeService.getEmployeeList(employeeParam, currentPage, pageSize);
        return new ModelAndView("employee/employee_list")
                .addObject("employeePageResult", employeePageResult)
                .addObject("employeeParam", employeeParam);
    }

    @RequestMapping("/addEmployee")
    public ModelAndView toAddEmployee() {
        return new ModelAndView("employee/employee_add");
    }

    @RequestMapping(value = "/addEmployee", method = RequestMethod.POST)
    public ModelAndView addEmployee(String nameStr, Employee employee) {
        employee.setCreateBy(TokenManager.getUserId());
        employee.setCreateTime(new Date());
        employee.setUpdateBy(TokenManager.getUserId());
        employee.setUpdateTime(new Date());
        employee.setDeleted(0);
        boolean result = employeeService.insert(employee);
        if (result) {
            result = employeeService.batchInsertProcedure(nameStr,employee.getWorkNo());
        }
        if (result) {
            return new ModelAndView("redirect:employeeList.htm");
        } else {
            return new ModelAndView("redirect:addEmployee.htm");
        }
    }

    @RequestMapping("/importEmployee")
    private ModelAndView toImportEmployee(){
        return new ModelAndView("employee/employee_import");
    }

    @RequestMapping(value = "/importEmployee",method = RequestMethod.POST)
    public void importEmployee(HttpServletRequest request, HttpServletResponse response) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message", "导入成功");
        jsonObject.put("url", "/employee/employeeList.htm");
        try {
            //获取上传的文件
            MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
            MultipartFile file = multipart.getFile("fileToUpload");
            InputStream in = file.getInputStream();
            //数据导入
            boolean result = employeeService.importEmployee(in, file);
            in.close();

            jsonObject.put("result",result);
            response.setContentType("text/plain");
            response.setHeader("Cache-Control", "no-cache");
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.print(jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/editEmployee")
    public ModelAndView toEditEmployee(Integer id){
        Employee employee = employeeService.getById(id);
        return new ModelAndView("employee/employee_edit")
                .addObject("employee",employee);
    }

    @RequestMapping(value = "/editEmployee",method = RequestMethod.POST)
    public ModelAndView editEmployee(Employee employee,String nameStr){
        employee.setUpdateBy(TokenManager.getUserId());
        employee.setUpdateTime(new Date());
        boolean result = employeeService.updateEmployee(employee);
        if(result){
            result = employeeService.deleteEmployeeProcedure(employee.getWorkNo());
            if(result){
                result = employeeService.batchInsertProcedure(nameStr,employee.getWorkNo());
            }
        }
        if (result) {
            return new ModelAndView("redirect:employeeList.htm");
        } else {
            return new ModelAndView("redirect:editEmployee.htm?id="+employee.getId());
        }
    }

    @RequestMapping("/deleteEmployee")
    public ModelAndView deleteEmployee(Integer id){
        Employee employee = new Employee();
        employee.setDeleted(1);
        employee.setId(id);
        employeeService.updateEmployee(employee);

        employee = employeeService.getById(id);
        employeeService.deleteEmployeeProcedure(employee.getWorkNo());
        return new ModelAndView("redirect:employeeList.htm");
    }

    @RequestMapping("/batchDeleteEmployee")
    public ModelAndView batchDeleteEmployee(String ids){
        List<String> workNoList = employeeService.queryWorkNoByIds(ids);
        employeeService.batchDeleteEmployee(ids);
        employeeService.batchDeleteEmployeeProcedure(workNoList);
        return new ModelAndView("redirect:employeeList.htm");
    }

    @RequestMapping("/checkEmployee")
    @ResponseBody
    public Object checkEmployee(String workNo, Integer id) {
        Map map = new HashMap();
        map.put("workNo", workNo);
        if(id != null){
            map.put("notSelf",id);
        }
        List<Employee> employeeList = employeeService.getEmployeeListByParam(map);
        return employeeList.size() > 0 ? false : true;
    }
}
