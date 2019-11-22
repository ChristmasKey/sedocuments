package com.sedoc.sedocuments.service.impl;


import com.sedoc.sedocuments.dao.UserInfoMapper;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserInfoService;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.nio.charset.StandardCharsets;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class UserInfoServiceImpl implements UserInfoService {
    @Autowired
    private UserInfoMapper userInfoMapper;

    @Override
    public int updateUserById(UserVo userVo) {
        try{
            String pwd= DigestUtils.md5DigestAsHex(userVo.getPassword().getBytes(StandardCharsets.UTF_8));
            userVo.setPassword(pwd);
        }catch (Exception e){
            e.printStackTrace();
        }
        return userInfoMapper.updateUserById(userVo);
    }

    @Override
    public List<User> showAllUser(UserVo userVo) {
        return userInfoMapper.showAllUser(userVo);
    }
}
