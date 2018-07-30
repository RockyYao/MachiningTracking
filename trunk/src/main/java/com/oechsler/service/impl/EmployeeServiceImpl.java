package com.oechsler.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oechsler.common.page.PageResult;
import com.oechsler.common.utils.excel.ExcelUtil;
import com.oechsler.mapper.EmployeeMapper;
import com.oechsler.mapper.EmployeeProcedureMapper;
import com.oechsler.model.Employee;
import com.oechsler.model.EmployeeProcedure;
import com.oechsler.service.EmployeeService;
import com.oechsler.shiro.token.manager.TokenManager;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;

/**
 * author:kriswang
 * date:2017/11/13 0013下午 14:26
 **/
@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private EmployeeProcedureMapper employeeProcedureMapper;
    @Override
    public PageResult<Employee> getEmployeeList(Employee employee, int pageIndex, int pageSize) {
        PageHelper.startPage(pageIndex, pageSize);
        List<Employee> data = employeeMapper.queryEmployeeList(employee);
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(data);
        PageResult<Employee> pageResult = new PageResult<>(data, pageIndex, pageSize, (int) pageInfo.getTotal());
        return pageResult;
    }

    @Override
    public Employee getOneEmployeeByParam(Map map) {
        return employeeMapper.getOneEmployeeByParam(map);
    }

    @Override
    public boolean insert(Employee employee) {
        try {
            int result = employeeMapper.insertSelective(employee);
            return result > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean batchInsertProcedure(String nameStr, String workNo) {
        try {
            String[] names = nameStr.split(",");
            Map map = new HashMap();
            map.put("workNo", workNo);
            map.put("names", names);
            int result = employeeMapper.batchInsertProcedure(map);
            return result > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Employee> getEmployeeListByParam(Map map) {
        return employeeMapper.getEmployeeListByParam(map);
    }

    @Override
    public Employee getById(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public boolean updateEmployee(Employee employee) {
        try {
            int result = employeeMapper.updateByPrimaryKeySelective(employee);
            return result > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteEmployeeProcedure(String workNo) {
        try {
            int result = employeeMapper.deleteEmployeeProcedure(workNo);
            return result > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<String> queryWorkNoByIds(String ids) {
        return employeeMapper.queryWorkNoByIds(ids);
    }

    @Override
    public boolean batchDeleteEmployee(String ids) {
        int result = employeeMapper.batchDeleteEmployee(ids);
        return result > 0 ? true : false;
    }

    @Override
    public boolean batchDeleteEmployeeProcedure(List list) {
        int result = employeeMapper.batchDeleteEmployeeProcedure(list);
        return result > 0 ? true : false;
    }

    @Override
    public List<String> queryProcedureByWorkNo(Map map) {
        return employeeMapper.queryProcedureByWorkNo(map);
    }

    @Override
    public boolean importEmployee(InputStream in, MultipartFile file) {
        try {
            //创建Excel工作薄
            Workbook work = ExcelUtil.getWorkbook(in, file.getOriginalFilename());
            if (null == work) {
                return false;
            }
            Sheet sheet = work.getSheetAt(0);
            Employee employee;
            List<Employee> employeeList = new ArrayList<>();
            List<Employee> updateEmployeeList = new ArrayList<>();
            List<EmployeeProcedure> employeeProcedureList = new ArrayList<>();
            for (int i = sheet.getFirstRowNum() + 1; i < sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                employee = new Employee();
                employee.setWorkNo(ExcelUtil.getWorkNoCellValue(row.getCell(1)).toString());
                List<Employee> resultE = employeeMapper.queryEmployeeList(employee);
                if(resultE.size()>0){
                    employee.setName(ExcelUtil.getCellValue(row.getCell(2)).toString());
                    employee.setUpdateBy(TokenManager.getUserId());
                    employee.setUpdateTime(new Date());
                    updateEmployeeList.add(employee);
                }else{
                    employee.setName(ExcelUtil.getCellValue(row.getCell(2)).toString());
                    employee.setCreateBy(TokenManager.getUserId());
                    employee.setCreateTime(new Date());
                    employee.setUpdateBy(TokenManager.getUserId());
                    employee.setUpdateTime(new Date());
                    employee.setDeleted(0);
                    employeeList.add(employee);
                }

                String procedureName = ExcelUtil.getCellValue(row.getCell(4)).toString();
                String [] names = procedureName.split(",");
                for(int j=0;j<names.length;j++){
                    EmployeeProcedure employeeProcedure = new EmployeeProcedure();
                    employeeProcedure.setWorkNo(employee.getWorkNo());
                    employeeProcedure.setProcedureName(names[j]);
                    List<EmployeeProcedure> resultEP = employeeProcedureMapper.queryListByParam(employeeProcedure);
                    if(resultEP.size()==0){
                        employeeProcedureList.add(employeeProcedure);
                    }
                }
            }
            if(employeeList.size()>0){
                employeeMapper.batchInsertEmployee(employeeList);
            }
            if(updateEmployeeList.size()>0){
                employeeMapper.batchUpdateEmployee(updateEmployeeList);
            }
            if(employeeProcedureList.size()>0){
                employeeProcedureMapper.batchInsertEmployeeProcedure(employeeProcedureList);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
