package com.oechsler.service.impl;

import com.oechsler.mapper.PermissionMapper;
import com.oechsler.model.Permission;
import com.oechsler.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * author:kriswang
 * date:2017/11/6 0006下午 13:28
 **/
@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Permission> findAllByRoleId(Map map) {
        return permissionMapper.findAllByRoleId(map);
    }

    @Override
    public Set<String> getPermissionByUserId(Integer userId) {
        return permissionMapper.getPermissionByUserId(userId);
    }

    @Override
    public List<Permission> getUserLeftNavByUserId(Integer userId) {
        return permissionMapper.getUserLeftNavByUserId(userId);
    }
}
