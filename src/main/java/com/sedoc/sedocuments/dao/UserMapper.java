package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface UserMapper {
    User login(User user);
}
