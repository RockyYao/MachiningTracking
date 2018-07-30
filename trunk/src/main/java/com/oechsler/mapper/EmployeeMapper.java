package com.oechsler.mapper;

import com.oechsler.model.Employee;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Employee record);

    int insertSelective(Employee record);

    Employee selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);

    List<Employee> queryEmployeeList(Employee employee);

    Employee getOneEmployeeByParam(Map map);

    int batchInsertProcedure(Map map);

    List<Employee> getEmployeeListByParam(Map map);

    int deleteEmployeeProcedure(String workNo);

    List<String> queryWorkNoByIds(String ids);

    int batchDeleteEmployee(String ids);

    int batchDeleteEmployeeProcedure(List list);

    List<String> queryProcedureByWorkNo(Map map);

    int batchInsertEmployee(List list);

    int batchUpdateEmployee(List list);
}