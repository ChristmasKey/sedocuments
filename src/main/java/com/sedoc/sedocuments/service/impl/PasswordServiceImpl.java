package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.PasswordMapper;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.PasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PasswordServiceImpl implements PasswordService {

    @Autowired
    private PasswordMapper passwordMapper;
    @Override
    public User getPasswordByUid(User user) {
        return passwordMapper.getPasswordByUid(user);
    }

    @Override
    public void updatePasswordByUid(User user) {
        passwordMapper.updatePasswordByUid(user);
    }
}
