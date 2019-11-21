package com.sedoc.sedocuments.controller;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserInfoService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.utils.ResultObj;
import com.sedoc.sedocuments.utils.WebUtils;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("userInfo")
public class UserInfoController {
    @Autowired
    private UserInfoService userInfoService;

    /**
     * 显示个人信息数据
     */
    @RequestMapping("showAll")
    public DataGridView findUserList(UserVo userVo){
        User user = (User) WebUtils.getHttpSession().getAttribute("user");
        userVo.setUid(user.getUid());
        List<User> data = this.userInfoService.showAllUser(userVo);
//        Object obj = userInfoService.showAllUser(userVo);
        return new DataGridView(data);
    }

    /**
     * 根据用户id修改用户信息
     * @param userVo
     * @return
     */
    @RequestMapping("userInfoUpdate")
    public ResultObj updateUserById(UserVo userVo) {
        try {
            userInfoService.updateUserById(userVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }
}
