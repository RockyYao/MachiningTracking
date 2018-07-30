package com.oechsler.controller;

import com.oechsler.common.page.PageResult;
import com.oechsler.model.Role;
import com.oechsler.service.RoleService;
import com.oechsler.shiro.token.manager.TokenManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Date;

/**
 * author:kriswang
 * date:2017/11/2 0002上午 9:15
 **/
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @RequestMapping("/roleList")
    public ModelAndView roleList(@RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                 Role roleParam){
        //当前用户角色
        Role role = roleService.getRoleByUserId(TokenManager.getUserId());
        PageResult<Role> rolePageResult = roleService.getRoleList(roleParam,currentPage,pageSize);
        return new ModelAndView("role/role_list")
                .addObject("rolePageResult",rolePageResult)
                .addObject("userRole",role);
    }

    @RequestMapping("/addRole")
    public ModelAndView toAddRole(){
        return new ModelAndView("role/role_add");
    }

    @RequestMapping(value = "/addRole",method = RequestMethod.POST)
    public ModelAndView addRole(Role role){
        role.setCreateBy(TokenManager.getUserId());
        role.setCreateTime(new Date());
        role.setUpdateBy(TokenManager.getUserId());
        role.setUpdateTime(new Date());
        role.setDeleted(0);
        roleService.addRole(role);
        return new ModelAndView("redirect:roleList.htm");
    }

    @RequestMapping("/editRole")
    public ModelAndView toEditRole(Integer id){
        Role role = roleService.getRoleById(id);
        return new ModelAndView("role/role_edit")
                .addObject("role",role);
    }

    @RequestMapping(value = "/editRole",method = RequestMethod.POST)
    public ModelAndView editRole(Role role){
        role.setUpdateBy(TokenManager.getUserId());
        role.setUpdateTime(new Date());
        roleService.updateRole(role);
        return new ModelAndView("redirect:roleList.htm");
    }

    @RequestMapping("/deleteRole")
    public ModelAndView deleteRole(Role role){
        role.setDeleted(1);
        roleService.updateRole(role);
        //删除用户角色关系数据
        roleService.deleteUserRoleByRoleId(role.getId());
        //删除角色权限关系数据
        roleService.deletePermissionByRoleId(role.getId());
        return new ModelAndView("redirect:roleList.htm");
    }

    @RequestMapping("/batchDeleteRole")
    public ModelAndView batchDeleteRole(String ids){
        roleService.batchDeleteRole(ids);
        //删除用户角色关系数据
        roleService.batchDeleteUserRoleByRoleIds(ids);
        //删除角色权限关系数据
        roleService.batchDeletePermissionByRoleIds(ids);
        return new ModelAndView("redirect:roleList.htm");
    }

    @RequestMapping("/checkRoleInfo")
    public void checkRoleInfo(HttpServletResponse response,Role role){
        try{
            boolean result = true;
            role = roleService.checkRoleInfo(role);
            if(role != null){
                result = false;
            }
            PrintWriter writer = response.getWriter();
            writer.print(result);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
