package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.UserMapper;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(User user) {
        System.out.println("-----------------------");
        return userMapper.login(user);
    }
}
