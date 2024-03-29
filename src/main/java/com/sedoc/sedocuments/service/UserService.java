package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.vo.UserVo;

/**
 * 用户服务接口
 *
 * 丁佳男
 */
public interface UserService {

    User login(UserVo userVo);

    void register(UserVo userVo);

    Integer checkDuplicate(UserVo userVo);
}
