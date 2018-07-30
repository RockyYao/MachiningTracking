package com.oechsler.controller;

import com.oechsler.common.utils.Md5Encrypt;
import com.oechsler.model.User;
import com.oechsler.shiro.token.manager.TokenManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * author:Kris
 * date:2017/10/20
 */
@Controller
@RequestMapping("/login")
public class LoginController {

    @RequestMapping("/toLoginView")
    public ModelAndView toLoginView(){
        return new ModelAndView("index/login");
    }

    @RequestMapping("/doLogin")
    public ModelAndView doLogin(String userName,String password){
        ModelAndView mv = new ModelAndView("redirect:/index/index.htm");
        try {
            User user = new User();
            user.setUserName(userName);
            user.setPassword(Md5Encrypt.md5(password));
            TokenManager.login(user, false);
        }catch (Exception e){
            e.printStackTrace();
            mv.setViewName("redirect:/login/toLoginView.htm");
        }
        return mv;
    }

    @RequestMapping("/logout")
    public ModelAndView logout(){
        TokenManager.logout();
        return new ModelAndView("redirect:/login/toLoginView.htm");
    }
}
