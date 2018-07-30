package com.oechsler.mapper;

import com.oechsler.model.EmployeeProcedure;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeProcedureMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(EmployeeProcedure record);

    EmployeeProcedure selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(EmployeeProcedure record);

    int batchInsertEmployeeProcedure(List list);

    List<EmployeeProcedure> queryListByParam(EmployeeProcedure employeeProcedure);
}