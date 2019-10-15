package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserService;
import com.sedoc.sedocuments.utils.WebUtils;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 登录控制器
 *
 * 丁佳男
 */
@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private UserService userService;

    /**
     * 登录方法
     * @param userVo 登录数据
     * @param model 信息
     * @return 跳转页面
     */
    @RequestMapping("/login")
    public String login(UserVo userVo, Model model){
        User user = userService.login(userVo);
        if(null!=user){
            //放到session
            WebUtils.getHttpSession().setAttribute("user",user);

            return "index";
        }else{
            model.addAttribute("error", SysConstast.USER_LOGIN_ERROR_MSG);
            return "login";
        }
    }
}
