package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.vo.ProjectVo;

import java.util.List;

/**
 *项目管理的服务接口
 *
 * 丁佳男
 */
public interface ProjectService {

    /**
     * 查询所有项目返回List<Project>
     */
    List<Project> queryAllProjectForList(ProjectVo projectVo);
}
