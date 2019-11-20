package com.sedoc.sedocuments.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sedoc.sedocuments.dao.DocumentMapper;
import com.sedoc.sedocuments.dao.ProjectMapper;
import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.service.ProjectService;
import com.sedoc.sedocuments.utils.DataGridView;
import com.sedoc.sedocuments.vo.ProjectVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 丁佳男
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = false)
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    private ProjectMapper projectMapper;
    @Autowired
    private DocumentMapper documentMapper;

    @Override
    public List<Project> queryAllProjectForList(ProjectVo projectVo) {
        return projectMapper.queryAllProject(projectVo);
    }

    @Override
    public void addProject(ProjectVo projectVo) {
        projectMapper.insertSelective(projectVo);
    }

    @Override
    public void updateProject(ProjectVo projectVo) {
        projectMapper.updateByPrimaryKeySelective(projectVo);
    }

    @Override
    public void deleteProject(ProjectVo projectVo) {
        projectMapper.deleteByPrimaryKey(projectVo.getProjectid());
    }

    @Override
    public void updateDocnumber(Integer projectid) {
        projectMapper.updateDocnumber(projectid);
    }

    @Override
    public void updateDocnumberMinus(Integer projectid) {
        projectMapper.updateDocnumberMinus(projectid);
    }

    @Override
    public DataGridView queryTempProjects(ProjectVo projectVo) {
        Page<Object> page= PageHelper.startPage(projectVo.getPage(),projectVo.getLimit());
        List<Project> data=projectMapper.queryTempProjects(projectVo);
        return new DataGridView(page.getTotal(),data);
    }

    @Override
    public List<Project> selectProjectByUid(Integer uid) {
        return projectMapper.selectProjectByUid(uid);
    }

    @Override
    public void restoreProByProId(Integer projectid) {
        projectMapper.restoreProByProId(projectid);
        documentMapper.restoreDocByProId(projectid);
    }


}
