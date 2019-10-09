package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login(User user){
        System.out.println("===================");
        System.out.println(user.getUsername()+","+user.getPassword());
        User u = userService.login(user);
        System.out.println("+++++++++++++++++++");
        System.out.println(u.getId());
        return "success";
    }

}
