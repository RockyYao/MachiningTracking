package com.oechsler.mapper;

import com.oechsler.model.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Repository
public interface PermissionMapper {
    int insert(Permission record);

    int insertSelective(Permission record);

    List<Permission> findAllByRoleId(Map map);

    Set<String> getPermissionByUserId(Integer userId);

    List<Permission> getUserLeftNavByUserId(Integer userId);
}