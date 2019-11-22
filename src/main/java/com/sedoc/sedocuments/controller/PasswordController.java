package com.sedoc.sedocuments.controller;


import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.PasswordService;
import com.sedoc.sedocuments.utils.ResultObj;
import com.sedoc.sedocuments.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/password")
public class PasswordController {


    @Autowired
    private PasswordService passwordService;
    /**
     * 修改密码
     * @param oldPassword
     * @param newPassword
     * @return
     */
    @RequestMapping("updatePassword")
    public ResultObj updatePassword(String oldPassword,String newPassword){
        //得到当前登录的用户对象
        User user = (User) WebUtils.getHttpSession().getAttribute("user");
        User passwordByUid = passwordService.getPasswordByUid(user);
        String Md5OldPwd= DigestUtils.md5DigestAsHex(oldPassword.getBytes(StandardCharsets.UTF_8));
        if(!passwordByUid.getPassword().equals(Md5OldPwd)){
            //密码不一致
            return ResultObj.UPDATE_ERROR;
        }
        //更新密码
        user.setPassword(DigestUtils.md5DigestAsHex(newPassword.getBytes(StandardCharsets.UTF_8)));
        passwordService.updatePasswordByUid(user);
        //密码更新成功
        return ResultObj.UPDATE_SUCCESS;

    }
}
