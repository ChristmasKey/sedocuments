package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserInfoMapper {
    /**
     * 编辑用户信息
     * @param user
     * @return
     */
    int updateUserById(User user);
    List<User> showAllUser(User user);
}
