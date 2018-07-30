package com.oechsler.controller;

import com.oechsler.model.Permission;
import com.oechsler.service.PermissionService;
import com.oechsler.service.RoleService;
import com.oechsler.shiro.token.manager.TokenManager;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * author:kriswang
 * date:2017/11/6 0006下午 13:24
 **/
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/rolePermissionEdit")
    public ModelAndView toRolePermissionEdit(Integer roleId){
        //当前登录用户
        Integer userId = TokenManager.getUserId();
        //查询角色ID
        Integer userRoleId = roleService.getRoleIdByUserId(userId);
        Map map = new HashMap();
        map.put("userRoleId",userRoleId);
        map.put("roleId",roleId);
        //查询当前操作人和被修改角色所拥有的权限
        List<Permission> permissionList = permissionService.findAllByRoleId(map);
        //转换为json格式
        String treesJson = JSONArray.fromObject(permissionList).toString();
        return new ModelAndView("role/role_permission_edit")
                .addObject("treesJson",treesJson)
                .addObject("roleId",roleId);
    }

    @RequestMapping(value = "/rolePermissionEdit",method = RequestMethod.POST)
    public ModelAndView rolePermissionEdit(String permissionIds,Integer roleId){
        roleService.deletePermissionByRoleId(roleId);
        String [] ids = permissionIds.split(",");
        roleService.editRolePermission(ids,roleId);
        return new ModelAndView("redirect:/role/roleList.htm");
    }
}
