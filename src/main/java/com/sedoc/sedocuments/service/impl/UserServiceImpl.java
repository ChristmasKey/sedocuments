package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.UserMapper;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserService;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.nio.charset.StandardCharsets;

/**
 * 丁佳男
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(UserVo userVo) {

        String pwd = DigestUtils.md5DigestAsHex(userVo.getPassword().getBytes(StandardCharsets.UTF_8));
        userVo.setPassword(pwd);
        return userMapper.login(userVo);
    }

    @Override
    public void register(UserVo userVo) {
        String pwd = DigestUtils.md5DigestAsHex(userVo.getPassword().getBytes(StandardCharsets.UTF_8));
        userVo.setPassword(pwd);
        userMapper.register(userVo);
    }

    @Override
    public Integer checkDuplicate(UserVo userVo) {
        return userMapper.checkDuplicate(userVo);
    }
}
