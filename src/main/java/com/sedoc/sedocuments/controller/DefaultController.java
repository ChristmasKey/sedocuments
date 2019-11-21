package com.sedoc.sedocuments.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 项目启动后输入访问url：localhost:8080/SEDocument
 * 即可访问登录页面
 *
 * 丁佳男
 */
@Controller
public class DefaultController {

    @RequestMapping("/")
    public String toLogin(){
        return "login";
    }


    @RequestMapping("/toUserInfo")
    public String toUserInfo(){
        return "user/userInfo";
    }
}
