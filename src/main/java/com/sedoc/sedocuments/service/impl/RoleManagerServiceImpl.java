package com.sedoc.sedocuments.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sedoc.sedocuments.dao.RoleManagerMapper;
import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.model.Role;
import com.sedoc.sedocuments.service.RoleManagerService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.AccessVo;
import com.sedoc.sedocuments.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.BeanDefinitionDsl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 角色服务接口实现 汪松
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class RoleManagerServiceImpl implements RoleManagerService {

    @Autowired
    private RoleManagerMapper roleManagerMapper;
    /**
     * 查询角色并模糊查询
     * @param roleVo
     * @return
     */
    @Override
    public DataGridView QueryAllRoleAndByRoleName(RoleVo roleVo) {
        roleVo.setIsDel(1);
        Page<Object> page = PageHelper.startPage(roleVo.getPage(), roleVo.getLimit());
        List<Role> data = roleManagerMapper.QueryAllRoleAndByRoleName(roleVo);
        return new DataGridView(page.getTotal(), data);
    }

    @Override
    public List<Access> queryAllAccessTree(AccessVo accessVo) {
        return roleManagerMapper.queryAllAccessTree(accessVo);
    }

    /**
     *根据角色ID查询当前角色拥有的所有的权限或菜单ID
     *
     * @param roleid
     * @return
     */
    @Override
    public List<Access> queryRoleAccessIdsByRid(Integer roleid) {
        return roleManagerMapper.queryRoleAccessIdsByRid(roleid);
    }

    /**
     * 添加角色
     * @param roleVo
     */
    @Override
    public void addRole(RoleVo roleVo) {
        roleManagerMapper.addRole(roleVo);
    }

    /**
     * 删除角色
     * @param roleid
     */
    @Override
    public void deleteRoleById(Integer roleid) {
        roleManagerMapper.deleteRoleById(roleid);
    }

    /**
     * 根据角色id修改角色信息
     * @param roleVo
     */
    @Override
    public void updateRoleByRoleId(RoleVo roleVo) {
        roleManagerMapper.updateRoleByRoleId(roleVo);
    }

    /**
     * 保存角色和权限的关系
     * @param roleId
     * @param ids
     */
    @Override
    public void saveRoleIdAndAccessId(Integer roleId, Integer[] ids) {
        //删除角色已经拥有的权限
        roleManagerMapper.deleteRoleAccessByRoleId(roleId);
        if(ids!=null&&ids.length>0) {
            for (Integer accessid : ids) {
                roleManagerMapper.saveRoleIdAndAccessId(roleId,accessid);
            }
        }
    }

}
