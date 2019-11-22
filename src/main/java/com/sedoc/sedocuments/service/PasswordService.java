package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.User;

public interface PasswordService {

    User getPasswordByUid(User user);

    void updatePasswordByUid(User user);
}
