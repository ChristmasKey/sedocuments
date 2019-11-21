package com.sedoc.sedocuments.controller;


import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.utils.ResultObj;
import com.sedoc.sedocuments.utils.WebUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("password")
public class PasswordController {


    /**
     * 修改密码
     * @param oldPassword
     * @param newPassword
     * @return
     */
    @RequestMapping("updatePasword")
    public ResultObj updatePassword(String oldPassword,String newPassword){
        //得到当前登录的用户对象
        User user = (User) WebUtils.getHttpSession().getAttribute("user");

    }
}
