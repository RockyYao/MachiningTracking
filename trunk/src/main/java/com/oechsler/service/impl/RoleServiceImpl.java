package com.oechsler.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.oechsler.common.page.PageResult;
import com.oechsler.mapper.RoleMapper;
import com.oechsler.model.Role;
import com.oechsler.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * author:kriswang
 * date:2017/11/2 0002上午 9:23
 **/
@Service("roleService")
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public PageResult<Role> getRoleList(Role role, int pageIndex, int pageSize) {
        PageHelper.startPage(pageIndex, pageSize);
        List<Role> data = roleMapper.queryRoleListByParam(role);
        PageInfo<Role> pageInfo = new PageInfo<Role>(data);
        PageResult<Role> pageResult = new PageResult<>(data, pageIndex, pageSize, (int) pageInfo.getTotal());
        return pageResult;
    }

    @Override
    public Role getRoleByParam(Role role) {
        return roleMapper.getRoleByParam(role);
    }

    @Override
    @Transactional
    public int addRole(Role role) {
        return roleMapper.insertSelective(role);
    }

    @Override
    @Transactional
    public int updateRole(Role role) {
        return roleMapper.updateRole(role);
    }

    @Override
    public Role getRoleById(Integer id) {
        return roleMapper.getRoleById(id);
    }

    @Override
    public Role checkRoleInfo(Role role) {
        return roleMapper.checkRoleInfo(role);
    }

    @Override
    public List<Role> getAllRole() {
        return roleMapper.getAllRole();
    }

    @Override
    public int deleteUserRoleByRoleId(Integer id) {
        return roleMapper.deleteUserRoleByRoleId(id);
    }

    @Override
    public Integer getRoleIdByUserId(Integer userId) {
        return roleMapper.getRoleIdByUserId(userId);
    }

    @Override
    public int editRolePermission(String [] ids,Integer roleId) {
        List<Map> mapList = new ArrayList<>();
        Map map;
        for(String id :ids){
            map = new HashMap();
            map.put("roleId",roleId);
            map.put("permissionId",id);
            mapList.add(map);
        }
        return roleMapper.editRolePermission(mapList);
    }

    @Override
    @Transactional
    public int deletePermissionByRoleId(Integer roleId) {
        return roleMapper.deletePermissionByRoleId(roleId);
    }

    @Override
    public Role getRoleByUserId(Integer userId) {
        return roleMapper.getRoleByUserId(userId);
    }

    @Override
    public int batchDeleteRole(String ids) {
        return roleMapper.batchDeleteRole(ids);
    }

    @Override
    public int batchDeleteUserRoleByRoleIds(String ids) {
        return roleMapper.batchDeleteUserRoleByRoleIds(ids);
    }

    @Override
    public int batchDeletePermissionByRoleIds(String ids) {
        return roleMapper.batchDeletePermissionByRoleIds(ids);
    }
}
