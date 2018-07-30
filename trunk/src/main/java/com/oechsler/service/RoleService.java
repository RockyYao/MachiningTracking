package com.oechsler.service;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.Role;

import java.util.List;
import java.util.Map;

/**
 * author:kriswang
 * date:2017/11/2 0002上午 9:23
 **/
public interface RoleService {

    PageResult<Role> getRoleList(Role role,int pageIndex,int pageSize);

    Role getRoleByParam(Role role);

    int addRole(Role role);

    int updateRole(Role role);

    Role getRoleById(Integer id);

    Role checkRoleInfo(Role role);

    List<Role> getAllRole();

    int deleteUserRoleByRoleId(Integer id);

    Integer getRoleIdByUserId(Integer userId);

    int editRolePermission(String [] ids,Integer roleId);

    int deletePermissionByRoleId(Integer roleId);

    Role getRoleByUserId(Integer userId);

    int batchDeleteRole(String ids);

    int batchDeleteUserRoleByRoleIds(String ids);

    int batchDeletePermissionByRoleIds(String ids);
}
