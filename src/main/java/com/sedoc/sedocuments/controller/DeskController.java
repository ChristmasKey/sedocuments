package com.sedoc.sedocuments.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面跳转控制器  作用：路由
 *
 * 丁佳男
 */
@Controller
@RequestMapping("desk")
public class DeskController {
    /**
     * 跳转到平台的首页面
     */
    @RequestMapping("toDeskManager")
    public String toDeskManager(){
        return "deskManager";
    }

    /**
     * 跳转到权限管理
     */
    @RequestMapping("toAccessManager")
    public String toAccessManager(){
        return "manager/accessManager";
    }

    /**
     * 跳转用户管理
     * @return
     */
    @RequestMapping("/toUserManager")
    public String toUserManager(){
        return "userManager";
    }
    /**
     * 跳转到模板管理
     */
    @RequestMapping("toTemplateManager")
    public String toTemplateManager(){
        return "manager/templateManager";
    }

    /**
     * 跳转角色管理
     * @return
     */
    @RequestMapping("toRoleManager")
    public String toRoleManager(){
        return "manager/roleManager";
    }
}
