package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.model.Role;
import com.sedoc.sedocuments.service.UserManagerService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.utils.ResultObj;
import com.sedoc.sedocuments.vo.RoleVo;
import com.sedoc.sedocuments.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 汪松 用户管理
 */
@RestController
@RequestMapping("/userManager")
public class UserManagerController {
    @Autowired
    private UserManagerService userManagerService;

    /**
     * 用户列表查询
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/findUserList")
    public DataGridView findUserList(UserVo userVo) {
        Object obj = userManagerService.queryAllUser(userVo).getData();
        return this.userManagerService.queryAllUser(userVo);
    }

    /**
     * 用户列表查询
     *
     * @param uid
     * @return
     */
    @RequestMapping("/initRoleList")
    public DataGridView queryAllRole(Integer uid) {
        UserVo userVo = new UserVo();
        RoleVo roleVo = new RoleVo();
        userVo.setIsDel(1);
        roleVo.setIsDel(1);
        //查询role的使用角色
        List<Role> list = userManagerService.queryAllRole(roleVo);
        //查询该用户拥有的roleid角色
        int result = userManagerService.selectRoleIdByUid(uid, userVo.getIsDel());
        for (Role ch : list) {
            Integer roleId = ch.getRoleid();
            if (result == roleId) {
                ch.setChecked("1");
                break;
            }
        }
        return new DataGridView(Long.valueOf(list.size()), list);
    }

    /**
     * 删除用户
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/deleteUser")
    public ResultObj deleteUser(UserVo userVo) {
        try {
            int result = userManagerService.deleteUser(userVo.getUid());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 批量删除
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/deleteBatchUser")
    public ResultObj deleteBatchUser(UserVo userVo) {
        try {
            userManagerService.deleteBatchUser(userVo.getIds());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 添加用户
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/addUser")
    public ResultObj addUser(UserVo userVo) {
        try {
            userManagerService.addUser(userVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * 根据用户id修改用户信息
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/updateUser")
    public ResultObj updateUserById(UserVo userVo) {
        try {
            userManagerService.updateUserById(userVo);
            return ResultObj.UPDATE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * 根据用户id修改角色id
     *
     * @param userVo
     * @return
     */
    @RequestMapping("/updateRoleByUid")
    public ResultObj updateRoleByUid(UserVo userVo) {
        try {
            userManagerService.updateRoleByUid(userVo);
            return ResultObj.DISPATCH_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DISPATCH_ERROR;
        }
    }

    /**
     * 判断账号是否重复
     *
     * @param userVo
     * @return
     */
    @RequestMapping("isExistPhone")
    public ResultObj isExistPhone(UserVo userVo) {
        int result = userManagerService.isExistPhone(userVo.getPhone());
        ResultObj resultObj = null;
        if (result > 0) {
            resultObj = ResultObj.ISEXISTPPHONE;
        }
        return resultObj;
    }
}
