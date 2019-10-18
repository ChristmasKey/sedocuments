package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Access;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 丁佳男
 */
@Mapper
@Repository
public interface AccessMapper {

    /**
     * 查询所有菜单
     */
    List<Access> queryAllAccess(Access access);
}
