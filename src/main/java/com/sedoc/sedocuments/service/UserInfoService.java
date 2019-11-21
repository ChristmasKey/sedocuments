package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.vo.UserVo;

import java.util.List;

public interface UserInfoService {
    /**
     * 根据用户id修改用户
     * @param userVo
     * @return
     */
    int updateUserById(UserVo userVo);
    List<User> showAllUser(UserVo userVo);
}
