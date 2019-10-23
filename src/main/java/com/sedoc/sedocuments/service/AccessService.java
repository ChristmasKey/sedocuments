package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.AccessVo;

import java.util.List;

/**
 * 权限管理的服务接口
 *
 * 丁佳男
 */
public interface AccessService {

    /**
     * 查询所有权限返回List<Access>
     */
    List<Access> queryAllAccessForList(AccessVo accessVo);

    /**
     * 根据用户id查询用户的可用权限
     */
    List<Access> queryAccessByRoleidForList(AccessVo accessVo, Integer roleid);

    /**
     * 查询所有权限
     */
    DataGridView queryAllAccess(AccessVo accessVo);

    /**
     * 根据pid查询权限数量
     */
    Integer queryAccessByPid(Integer pid);

    /**
     * 添加权限
     */
    void addAccess(AccessVo accessVo);

    /**
     * 修改权限
     */
    void updateAccess(AccessVo accessVo);

    /**
     * 删除权限
     */
    void deleteAccess(AccessVo accessVo);
}
