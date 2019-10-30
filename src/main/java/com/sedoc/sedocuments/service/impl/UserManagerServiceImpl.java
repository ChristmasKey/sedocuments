package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.UserManagerMapper;
import com.sedoc.sedocuments.model.Role;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.UserManagerService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.RoleVo;
import com.sedoc.sedocuments.vo.UserVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;
import sun.misc.Request;

import java.util.List;

/**
 * 汪松
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class UserManagerServiceImpl implements UserManagerService {
    @Autowired
    private UserManagerMapper userManagerMapper;

    @Override
    public DataGridView queryAllUser(UserVo userVo) {
        userVo.setIsDel(1);
        Page<Object> page = PageHelper.startPage(userVo.getPage(), userVo.getLimit());
        List<User> data = this.userManagerMapper.queryAllUser(userVo);
        return new DataGridView(page.getTotal(), data);
    }

    @Override
    public int deleteUser(Integer uid) {
        int result=userManagerMapper.deleteById(uid);
        return result;
    }

    @Override
    public int addUser(UserVo userVo) {
        int result=userManagerMapper.addUser(userVo);
        return result;
    }

    @Override
    public int updateUserById(UserVo userVo) {
        return userManagerMapper.updateUserById(userVo);
    }

    @Override
    public DataGridView queryAllRole(RoleVo roleVo) {
        Page<Object> page = PageHelper.startPage(roleVo.getPage(), roleVo.getLimit());
        List<Role> data = this.userManagerMapper.queryAllRole(roleVo);
        return new DataGridView(page.getTotal(),data);
    }

    @Override
    public void updateRoleByUid(UserVo userVo) {
        Integer uid = userVo.getUid();
        Integer roleid = userVo.getRoleid();
        userManagerMapper.updateRoleByUid(uid,roleid);
    }
}