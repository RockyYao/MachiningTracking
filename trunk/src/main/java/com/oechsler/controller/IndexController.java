package com.oechsler.controller;

import com.oechsler.common.utils.Md5Encrypt;
import com.oechsler.model.Permission;
import com.oechsler.model.User;
import com.oechsler.service.PermissionService;
import com.oechsler.service.UserService;
import com.oechsler.shiro.token.manager.TokenManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

/**
 * author:Kris
 * date:2017/10/20
 */
@Controller
@RequestMapping("/index")
public class IndexController {

    @Autowired
    private UserService userService;

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("/index")
    public ModelAndView index(){
        return new ModelAndView("index/index");
    }

    @RequestMapping("/editPassword")
    public ModelAndView editPassword(){
        return new ModelAndView("index/password_edit");
    }

    @RequestMapping("/doEditPassword")
    public ModelAndView doEditPassword(String password){
        User user = new User();
        user.setId(TokenManager.getUserId());
        user.setPassword(Md5Encrypt.md5(password));
        userService.updateUser(user);
        return new ModelAndView("redirect:index.htm");
    }

    @RequestMapping("/checkOldPassword")
    public void checkOldPassword(HttpServletResponse response,String oldPassword){
        User user = new User();
        user.setId(TokenManager.getUserId());
        user.setPassword(Md5Encrypt.md5(oldPassword));
        user = userService.getUserByParam(user);
        boolean result = true;
        if(user == null){
            result = false;
        }
        try {
            PrintWriter writer = response.getWriter();
            writer.print(result);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @RequestMapping("/head")
    public ModelAndView head(){
        Integer userId = TokenManager.getUserId();
        User user = userService.getUserById(userId);
        return new ModelAndView("common/head")
                .addObject("user",user);
    }

    @RequestMapping("/leftNav")
    public ModelAndView leftNav(){
        Integer userId = TokenManager.getUserId();
        List<Permission> permissionList = permissionService.getUserLeftNavByUserId(userId);
        return new ModelAndView("common/leftNav")
                .addObject("permissionList",permissionList);
    }

    @RequestMapping("/personalInfo")
    public ModelAndView personalInfo(){
        User user = userService.getUserById(TokenManager.getUserId());
        return new ModelAndView("index/personal_info")
                .addObject("user",user);
    }

    @RequestMapping("/noPermission")
    public ModelAndView noPermission(){
        return new ModelAndView("common/no_permission");
    }
}
