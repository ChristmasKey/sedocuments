package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.AccessService;
import com.sedoc.sedocuments.utils.TreeNode;
import com.sedoc.sedocuments.utils.TreeNodeBuilder;
import com.sedoc.sedocuments.utils.WebUtils;
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
            list=accessService.queryAccessByUidForList(accessVo,user.getUid());
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
}
