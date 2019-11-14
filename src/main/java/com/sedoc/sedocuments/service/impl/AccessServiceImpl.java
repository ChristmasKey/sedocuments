package com.sedoc.sedocuments.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sedoc.sedocuments.dao.AccessMapper;
import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.service.AccessService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.AccessVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 丁佳男
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class AccessServiceImpl implements AccessService {

    @Autowired
    private AccessMapper accessMapper;

    @Override
    public List<Access> queryAllAccessForList(AccessVo accessVo) {
        return accessMapper.queryAllAccess(accessVo);
    }

    @Override
    public List<Access> queryAccessByRoleidForList(AccessVo accessVo, Integer roleid) {

        return accessMapper.queryAccessByRoleid(accessVo.getIsDel(),roleid);
    }

    @Override
    public DataGridView queryAllAccess(AccessVo accessVo){
        Page<Object> page = PageHelper.startPage(accessVo.getPage(),accessVo.getLimit());
        List<Access> data = accessMapper.queryAllAccess(accessVo);
        return new DataGridView(page.getTotal(),data);
    }

    @Override
    public Integer queryAccessByPid(Integer pid){
        return accessMapper.queryAccessByPid(pid);
    }

    @Override
    public void addAccess(AccessVo accessVo) {
        accessMapper.insertSelective(accessVo);
    }

    @Override
    public void updateAccess(AccessVo accessVo) {
        accessMapper.updateByPrimaryKeySelective(accessVo);
    }

    @Override
    public void deleteAccess(AccessVo accessVo) {
        //删除权限表的数据
        accessMapper.deleteByPrimaryKey(accessVo.getAccessid());
        //根据权限id删除role_access里面的数据
        accessMapper.deleteRoleAccessByAid(accessVo.getAccessid());
    }
}
