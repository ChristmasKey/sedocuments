package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.vo.AccessVo;

import java.util.List;

/**
 * 权限管理的服务接口
 *
 * 丁佳男
 */
public interface AccessService {

    /**
     * 查询所有菜单返回
     */
    public List<Access> queryAllAccessForList(AccessVo accessVo);

    /**
     * 根据用户id查询用户的可用菜单
     */
    public List<Access> queryAccessByUidForList(AccessVo accessVo,Integer uid);
}
