package com.oechsler.service;

import com.oechsler.model.Permission;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * author:kriswang
 * date:2017/11/6 0006下午 13:27
 **/
public interface PermissionService {

    List<Permission> findAllByRoleId(Map map);

    Set<String> getPermissionByUserId(Integer userId);

    List<Permission> getUserLeftNavByUserId(Integer userId);
}
