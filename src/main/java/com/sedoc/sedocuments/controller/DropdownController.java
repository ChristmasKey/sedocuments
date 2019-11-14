package com.sedoc.sedocuments.controller;

import com.sedoc.sedocuments.constast.SysConstast;
import com.sedoc.sedocuments.model.Major;
import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.model.School;
import com.sedoc.sedocuments.model.User;
import com.sedoc.sedocuments.service.MajorService;
import com.sedoc.sedocuments.service.ProjectService;
import com.sedoc.sedocuments.service.SchoolService;
import com.sedoc.sedocuments.utils.WebUtils;
import com.sedoc.sedocuments.vo.ProjectVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 模板项目下拉框渲染控制器
 *
 * 丁佳男
 */
@RestController
@RequestMapping("dropdown")
public class DropdownController {

    @Autowired
    ProjectService projectService;

    @Autowired
    SchoolService schoolService;

    @Autowired
    MajorService majorService;

    /**
     * 查询官方模板
     * @return 模板集合
     */
    @RequestMapping("queryOfficialTemp")
    public List<Project> queryOfficialTemp(){
        ProjectVo projectVo=new ProjectVo();
        projectVo.setIsTemplate(0);
        projectVo.setIsOfficial(0);
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        return projectService.queryAllProjectForList(projectVo);
    }

    /**
     * 查询自己模板
     * @return 模板集合
     */
    @RequestMapping("queryMyTemplate")
    public List<Project> queryMyTemplate(){
        User user=(User) WebUtils.getHttpSession().getAttribute("user");
        ProjectVo projectVo=new ProjectVo();
        projectVo.setIsTemplate(0);
        projectVo.setUid(user.getUid());
        projectVo.setIsDel(SysConstast.AVAILABLE_TRUE);
        return projectService.queryAllProjectForList(projectVo);
    }

    @RequestMapping("queryAllSchools")
    public List<School> queryAllSchools(){
        return schoolService.queryAllSchools();
    }

    @RequestMapping("queryMajorBySchoolId")
    public List<Major> queryMajorBySchoolId(School school){
        school.setIsDel(SysConstast.AVAILABLE_TRUE);
        return majorService.queryMajorBySchoolId(school);
    }
}
