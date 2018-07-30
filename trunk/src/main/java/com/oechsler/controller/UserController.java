package com.oechsler.controller;

import com.oechsler.common.page.PageResult;
import com.oechsler.common.utils.*;
import com.oechsler.model.Role;
import com.oechsler.model.User;
import com.oechsler.service.RoleService;
import com.oechsler.service.UserService;
import com.oechsler.shiro.token.manager.TokenManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * author:Kris Wang
 * date:2017/11/1 0001 上午 10:20
 **/
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @RequestMapping("/userList")
    public ModelAndView userList(User user,
                                 @RequestParam(value = "currentPage", defaultValue = "1") Integer currentPage,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize){
        User currentUser = TokenManager.getToken();
        user.setUserType(currentUser.getUserType());
        PageResult<User> userPageResult = userService.getUserList(user,currentPage,pageSize);
        return new ModelAndView("user/user_list")
                .addObject("userPageResult",userPageResult)
                .addObject("currentUser",currentUser)
                .addObject("user",user);
    }

    @RequestMapping("/addUser")
    public ModelAndView toAddUser(){
        return new ModelAndView("user/user_add");
    }

    @RequestMapping(value = "/addUser",method = RequestMethod.POST)
    public ModelAndView addUser(HttpServletRequest request,User user){
        user.setCreateBy(TokenManager.getUserId());
        user.setCreateTime(new Date());
        user.setCreateBy(TokenManager.getUserId());
        user.setUpdateTime(new Date());
        user.setDeleted(0);
        user.setPassword(Md5Encrypt.md5(user.getPassword()));
        user.setUserType("USER");
        FtpUtil ftpUtil = new FtpUtil();
        String headImage = ftpUtil.getImageUrl(request);
        user.setHeadPortrait(headImage);
        userService.addUser(user);
        return new ModelAndView("redirect:userList.htm");
    }

    @RequestMapping("/editUser")
    public ModelAndView toEditUser(Integer id){
        User user = userService.getUserById(id);
        return new ModelAndView("user/user_edit")
                .addObject("user",user);
    }

    @RequestMapping(value = "/editUser",method = RequestMethod.POST)
    public ModelAndView editUser(HttpServletRequest request,User user){
        user.setUpdateBy(TokenManager.getUserId());
        user.setUpdateTime(new Date());
        if(user.getPassword()!=null && !"".equals(user.getPassword())){
            user.setPassword(Md5Encrypt.md5(user.getPassword()));
        }
        //ftp操作
        FtpUtil ftpUtil = new FtpUtil();
        //上传并获取路径
        String headImage = ftpUtil.getImageUrl(request);
        if(!"".equals(headImage)){
            user.setHeadPortrait(headImage);
        }
        userService.updateUser(user);
        return new ModelAndView("redirect:userList.htm");
    }

    @RequestMapping("/addUserRole")
    public ModelAndView toAddUserRole(Integer userId){
        List<Role> roleList = roleService.getAllRole();
        Role role = roleService.getRoleByUserId(userId);
        return new ModelAndView("user/user_role_add")
                .addObject("roleList",roleList)
                .addObject("userId",userId)
                .addObject("userRole",role);
    }

    @RequestMapping(value = "/addUserRole",method = RequestMethod.POST)
    public ModelAndView addUserRole(Integer userId,Integer roleId){
        Integer rId = userService.getUserRole(userId);
        if(rId == null){
            userService.addUserRole(userId,roleId);
        }else {
            if(roleId.intValue()!=rId.intValue()){
                userService.updateUserRole(userId,roleId);
            }
        }
        return new ModelAndView("redirect:userList.htm");
    }

    @RequestMapping("/deleteUser")
    public ModelAndView deleteUser(Integer id){
        User user = new User();
        user.setId(id);
        user.setDeleted(1);
        userService.updateUser(user);
        //删除用户角色关系数据
        userService.deleteUserRoleByUserId(id);
        return new ModelAndView("redirect:userList.htm");
    }

    @RequestMapping("/batchDeleteUser")
    public ModelAndView batchDeleteUser(String ids){
        userService.batchDeleteUser(ids);
        //删除用户角色关系数据
        userService.batchDeleteUserRole(ids);
        return new ModelAndView("redirect:userList.htm");
    }

    @RequestMapping("/checkUserInfo")
    public void checkUserInfo(HttpServletResponse response,User user){
        boolean result = true;
        user = userService.checkUserInfo(user);
        if(user != null){
            result = false;
        }
        try{
            PrintWriter writer = response.getWriter();
            writer.print(result);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
