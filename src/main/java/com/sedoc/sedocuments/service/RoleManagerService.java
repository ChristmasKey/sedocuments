package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.model.Role;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.AccessVo;
import com.sedoc.sedocuments.vo.RoleVo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 汪松 角色管理服务接口
 */
@Service
public interface RoleManagerService {
    /**
     * 查询角色并模糊查询
     * @param roleVo
     * @return
     */
    DataGridView QueryAllRoleAndByRoleName(RoleVo roleVo);

    /**
     * 查询所有权限
     * @param accessVo
     * @return
     */
    List<Access> queryAllAccessTree(AccessVo accessVo);

    /**
     * 根据角色id查询角色拥有的权限
     * @param roleid
     * @return
     */
    List<Access>queryRoleAccessIdsByRid(Integer roleid);

    /**
     * 添加角色
     * @param roleVo
     */
    void addRole(RoleVo roleVo);

    /**
     * 根据roleid删除角色（软删（改变isDel的状态值 1：存在，0：删除））
     * @param roleid
     */
    void deleteRoleById(Integer roleid);

    /**
     * 根据角色id修改角色信息
     * @param roleVo
     */
    void updateRoleByRoleId(RoleVo roleVo);

    /**
     * 保存角色和权限的关系
     * @param roleId
     * @param ids
     */
    void saveRoleIdAndAccessId(Integer roleId, Integer[] ids);
}
