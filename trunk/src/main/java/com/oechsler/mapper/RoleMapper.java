package com.oechsler.mapper;

import com.oechsler.model.Role;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface RoleMapper {
    int insert(Role record);

    int insertSelective(Role record);

    List<Role> queryRoleListByParam(Role role);

    Role getRoleByParam(Role role);

    Role getRoleById(Integer id);

    Role checkRoleInfo(Role role);

    int updateRole(Role role);

    List<Role> getAllRole();

    int deleteUserRoleByRoleId(Integer id);

    Integer getRoleIdByUserId(Integer userId);

    int editRolePermission(List<Map> mapList);

    int deletePermissionByRoleId(Integer roleId);

    Role getRoleByUserId(Integer userId);

    int batchDeleteRole(String ids);

    int batchDeleteUserRoleByRoleIds(String ids);

    int batchDeletePermissionByRoleIds(String ids);
}