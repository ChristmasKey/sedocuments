package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Role;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.RoleVo;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 汪松 用户管理服务接口
 */

public interface UserManagerService {
    /**
     * 查询所有用户
     * @param userVo
     * @return
     */
    DataGridView queryAllUser(UserVo userVo);

    /**
     * 根据id删除用户
     * @param uid
     */
    int deleteUser(Integer uid);

    /**
     * 批量删除用户
     * @param ids
     */
    public void deleteBatchUser(Integer [] ids);

    /**
     * 添加用户
     * @param userVo
     * @return
     */
    int addUser(UserVo userVo);

    /**
     * 根据用户id修改用户
     * @param userVo
     * @return
     */
    int updateUserById(UserVo userVo);

    /**
     * 查询角色
     * @param roleVo
     * @return
     */
    DataGridView queryAllRole(RoleVo roleVo);

    /**
     * 修改用户的角色
     * @param userVo
     */
    void updateRoleByUid(UserVo userVo);
}
