package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Access;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 丁佳男
 */
@Mapper
@Repository
public interface AccessMapper {
    void deleteByPrimaryKey(Integer accessid);

    void insertSelective(Access record);

    void updateByPrimaryKeySelective(Access record);

    /**
     * 查询所有权限
     */
    List<Access> queryAllAccess(Access access);

    /**
     * 根据角色id查询权限
     */
    List<Access> queryAccessByRoleid(Integer isDel,Integer roleid);

    /**
     *根据pid查询权限数量
     */
    Integer queryAccessByPid(@Param("pid") Integer pid);

    /**
     *根据权限id删除role_access里面的数据
     */
    void deleteRoleAccessByAid(Integer accessid);
}
