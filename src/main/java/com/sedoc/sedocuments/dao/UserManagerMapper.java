package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Role;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.utils.DataGridView;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/*
 *汪松
 */
@Mapper
@Repository
public interface UserManagerMapper {
    /**
     * 查询用户列表
     * @param user
     * @return
     */
    List<User> queryAllUser(User user);

    /**
     * 根据id删除用户（软删（改变isDel的状态值 1：存在，0：删除））
     * @param id
     * @return
     */
    int deleteById(Integer id);

    /**
     * 添加用户
     * @param user
     * @return
     */
    int addUser(User user);

    /**
     * 编辑用户信息
     * @param user
     * @return
     */
    int updateUserById(User user);

    /**
     * 查询角色
     * @param role
     * @return
     */
    List<Role>queryAllRole(Role role);

    /**
     * 根据用户id更改用户角色
     * @param uid
     * @param roleid
     */
    void updateRoleByUid(@Param("uid")Integer uid,@Param("roleid")Integer roleid);

    /**
     * 验证用户名（phone）为账号是否存在
     * @param phone
     * @return
     */
    int isExistPhone(@Param("phone")String phone);

    /**
     * 根据用户id查询角色id
     * @param uid
     * @param isDel
     * @return
     */
    int selectRoleIdByUid(@Param("uid")Integer uid,Integer isDel);
}
