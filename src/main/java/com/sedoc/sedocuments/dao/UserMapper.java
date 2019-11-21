package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * 丁佳男
 */
@Mapper
@Repository
public interface UserMapper {

    User login(User user);

    void register(User user);
}
