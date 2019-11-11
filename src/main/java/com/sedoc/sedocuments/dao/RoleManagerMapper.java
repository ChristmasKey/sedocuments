package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.model.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.Serializable;
import java.util.List;

/**
 * 角色管理 汪松
 */
@Mapper
@Repository
public interface RoleManagerMapper {

    /**
     * 查询角色并模糊查询
     * @param role
     * @return
     */
    List<Role>QueryAllRoleAndByRoleName(Role role);

    /**
     * 查询所有权限
     * @param access
     * @return
     */
    List<Access>queryAllAccessTree(Access access);

    /**
     * 根据角色id查询角色拥有的权限
     * @param roleid
     * @return
     */
    List<Access>queryRoleAccessIdsByRid(Integer roleid);

    /**
     * 添加角色
     * @param role
     */
    void addRole(Role role);

    /**
     * 根据id删除角色（软删（改变isDel的状态值 1：存在，0：删除））
     * @param roleid
     * @return
     */
    int deleteRoleById(Integer roleid);

    /**
     * 根据角色id修改角色信息
     * @param role
     */
    void updateRoleByRoleId(Role role);

    /**
     * 清空该角色所拥有的权限
     * @param roleId
     */
    void deleteRoleAccessByRoleId(@Param("roleid")Integer roleId);

    /**
     * 保存角色和权限的关系
     * @param roleid
     * @param accessid
     */
    void saveRoleIdAndAccessId(@Param("roleid")Integer roleid,@Param("accessid")Integer accessid);
}
