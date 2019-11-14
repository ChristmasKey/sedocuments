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
     */
    @RequestMapping("/toUserManager")
    public String toUserManager(){
        return "manager/userManager";
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

    /**
     * 跳转到用户的新建项目页面
     */
    @RequestMapping("toCreateProject")
    public String toCreateProject(){
        return "user/createProject";
    }

    /**
     * 跳转到用户的我的项目页面
     */
    @RequestMapping("toMyProjects")
    public String toMyProjects(){
        return "user/myProjects";
    }

    /**
     * 跳转回收站页面
     */
    @RequestMapping("toRecycleBin")
    public String toRecycleBin(){
        return "recycleBin";
    }

    /**
     * 跳转到注册页面
     */
    @RequestMapping("toRegister")
    public String toRegister(){
        return "register";
    }
}
