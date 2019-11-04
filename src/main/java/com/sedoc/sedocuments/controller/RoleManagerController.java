package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.service.RoleManagerService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.utils.ResultObj;
import com.sedoc.sedocuments.utils.TreeNode;
import com.sedoc.sedocuments.vo.AccessVo;
import com.sedoc.sedocuments.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.acl.Permission;
import java.util.ArrayList;
import java.util.List;

/**
 * 角色管理控制层 汪松
 */
@RestController
@RequestMapping("/roleManager")
public class RoleManagerController {

    @Autowired
    private RoleManagerService roleManagerService;

    /**
     * 角色查询列表    模糊查询
     * @param roleVo
     * @return
     */
    @RequestMapping("/initRoleList")
    public DataGridView queryAllRole(RoleVo roleVo){
        Object obj = roleManagerService.QueryAllRoleAndByRoleName(roleVo).getData();
        return roleManagerService.QueryAllRoleAndByRoleName(roleVo);
    }

    /**
     * 添加角色
     * @param roleVo
     * @return
     */
    @RequestMapping("/addRole")
    public ResultObj addUser(RoleVo roleVo) {
        try {
            roleManagerService.addRole(roleVo);
            return ResultObj.ADD_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * 删除角色根据角色id
     * @param roleVo
     * @return
     */
    @RequestMapping("/deleteRoleById")
    public ResultObj deleteUser(RoleVo roleVo){
        try {
            roleManagerService.deleteRoleById(roleVo.getRoleid());
            return ResultObj.DELETE_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 修改角色信息根据roleid
     * @param roleVo
     * @return
     */
    @RequestMapping("/updateRoleById")
    public ResultObj updateRoleById(RoleVo roleVo){
        try{
            roleManagerService.updateRoleByRoleId(roleVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * 查询所有权限
     * @param roleid
     * @return
     */
    @RequestMapping("/loadRoleAccessTree")
    public DataGridView loadRoleAccessTree(Integer roleid){
        AccessVo accessVo=new AccessVo();
        accessVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        //所有权限
        List<Access>accesslist=roleManagerService.queryAllAccessTree(accessVo);
        /**
         * 1,根据角色ID查询当前角色拥有的所有的权限或菜单ID
         * 2,根据查询出来的菜单ID查询权限和菜单数据
         */
        List<Access>currentRoleAccesses=roleManagerService.queryRoleAccessIdsByRid(roleid);
        List<Access>carrentAcsesses=null;
        if(currentRoleAccesses.size()>0){
           carrentAcsesses=currentRoleAccesses;
        }else{
            carrentAcsesses=new ArrayList<>();
        }
        //构造LIst<TreeNode>
        List<TreeNode>nodes=new ArrayList<>();
        for(Access a1:accesslist){
            String checkarr="0";
            for (Access a2:carrentAcsesses){
                if(a1.getAccessid()==a2.getAccessid()){
                    checkarr="1";
                    break;
                }
            }
            Boolean spread=(a1.getSpread()==null||a1.getAccessid()==1)?true:false;
            nodes.add(new TreeNode(a1.getAccessid(),a1.getPid(),a1.getTitle(),spread,checkarr));
        }
        return new DataGridView(nodes);
    }

    /**
     * 保存角色和菜单权限之间的关系
     */
    @RequestMapping("/saveRoleAccess")
    public ResultObj saveRoleIdAndAccessId(Integer roleid,Integer[] ids) {
        try {
            roleManagerService.saveRoleIdAndAccessId(roleid,ids);
            return ResultObj.DISPATCH_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ResultObj.DISPATCH_ERROR;
        }
    }
}
