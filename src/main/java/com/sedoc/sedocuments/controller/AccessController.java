package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.AccessService;
import com.sedoc.sedocuments.utils.*;
import com.sedoc.sedocuments.vo.AccessVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限管理控制器
 *
 * 丁佳男
 */
@RestController
@RequestMapping("access")
public class AccessController {

    @Autowired
    private AccessService accessService;

    @RequestMapping("loadLeftAccessJson")
    public List<TreeNode> loadLeftAccessJson(AccessVo accessVo){
        //得到当前登录的用户对象
        User user = (User) WebUtils.getHttpSession().getAttribute("user");
        List<Access> list = null;
        accessVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        if(user.getRoleid().equals(SysConstast.USER_TYPE_SUPER)){
            list=accessService.queryAllAccessForList(accessVo);
        }else{
            list=accessService.queryAccessByRoleidForList(accessVo,user.getRoleid());
        }
        List<TreeNode> nodes = new ArrayList<>();
        //把list里面的数据放到nodes
        for (Access access:list){
            Integer id=access.getAccessid();
            Integer pid=access.getPid();
            String title=access.getTitle();
            String icon=access.getIcon();
            String href=access.getHref();
            Boolean spread=access.getSpread().equals(SysConstast.SPREAD_TRUE);
            String target=access.getTarget();
            nodes.add(new TreeNode(id,pid,title,icon,href,spread,target));
        }
        return TreeNodeBuilder.build(nodes,0);
    }

    @RequestMapping("loadAllAccess")
    public DataGridView loadAllAccess(AccessVo accessVo){
        accessVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        return accessService.queryAllAccess(accessVo);
    }

    /**
     * 加载权限树
     */
    @RequestMapping("loadAccessManagerTreeJson")
    public DataGridView loadAccessManagerTreeJson(AccessVo accessVo){
        accessVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        List<Access> list=accessService.queryAllAccessForList(accessVo);
        List<TreeNode> nodes=new ArrayList<>();
        //把list里面的数据放到nodes
        for (Access access:list){
            Integer id=access.getAccessid();
            Integer pid=access.getPid();
            String title=access.getTitle();
            String icon=access.getIcon();
            String href=access.getHref();
            Boolean spread=access.getSpread().equals(SysConstast.SPREAD_TRUE);
            String target=access.getTarget();
            nodes.add(new TreeNode(id,pid,title,icon,href,spread,target));
        }
        return new DataGridView(nodes);
    }

    /**
     * 根据id判断当前权限有没有子节点
     * 有 返回code>=0
     * 没有 返回code<0
     */
    @RequestMapping("checkAccessHasChildren")
    public ResultObj checkAccessHasChildren(AccessVo accessVo){
        //根据pid查询权限数量
        Integer count=accessService.queryAccessByPid(accessVo.getAccessid());
        if(count>0){
            return ResultObj.STATUS_TRUE;
        }else{
            return ResultObj.STATUS_FALSE;
        }
    }

    /**
     * 添加权限
     */
    @RequestMapping("addAccess")
    public ResultObj addAccess(AccessVo accessVo){
        try {
            accessService.addAccess(accessVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * 修改权限
     */
    @RequestMapping("updateAccess")
    public ResultObj updateAccess(AccessVo accessVo){
        try{
            accessService.updateAccess(accessVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * 删除权限
     */
    @RequestMapping("deleteAccess")
    public ResultObj deleteAccess(AccessVo accessVo){
        try {
            accessService.deleteAccess(accessVo);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
}
