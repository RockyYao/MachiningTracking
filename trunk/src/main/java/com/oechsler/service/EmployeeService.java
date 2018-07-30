package com.oechsler.service;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.Employee;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * author:kriswang
 * date:2017/11/13 0013下午 14:26
 **/
public interface EmployeeService {

    PageResult<Employee> getEmployeeList(Employee employee,int pageIndex,int pageSize);

    Employee getOneEmployeeByParam(Map map);

    boolean insert(Employee employee);

    boolean batchInsertProcedure(String nameStr,String workNo);

    List<Employee> getEmployeeListByParam(Map map);

    Employee getById(Integer id);

    boolean updateEmployee(Employee employee);

    boolean deleteEmployeeProcedure(String workNo);

    List<String> queryWorkNoByIds(String ids);

    boolean batchDeleteEmployee(String ids);

    boolean batchDeleteEmployeeProcedure(List list);

    List<String> queryProcedureByWorkNo(Map map);

    boolean importEmployee(InputStream in, MultipartFile file);
}
