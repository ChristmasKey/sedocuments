package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.utils.DataGridView;
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

    /**
     * 添加项目
     */
    void addProject(ProjectVo projectVo);

    /**
     * 修改项目信息
     */
    void updateProject(ProjectVo projectVo);

    /**
     * 删除项目
     */
    void deleteProject(ProjectVo projectVo);

    /**
     * 更新项目的文档数自动加1
     */
    void updateDocnumber(Integer projectid);

    /**
     * 更新项目的文档数自动减1
     */
    void updateDocnumberMinus(Integer projectid);

    DataGridView queryTempProjects(ProjectVo projectVo);


    /**
     * 回收站功能 查询已删除项目
     * @param uid
     * @return
     */
    List<Project>selectProjectByUid(Integer uid);

    /**
     * 回收站功能 恢复
     * @param projectid
     */
    void restoreProByProId(Integer projectid);
}
