package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.ProjectMapper;
import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.service.ProjectService;
import com.sedoc.sedocuments.vo.ProjectVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 丁佳男
 */
@Service
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    private ProjectMapper projectMapper;

    @Override
    public List<Project> queryAllProjectForList(ProjectVo projectVo) {
        return projectMapper.queryAllProject(projectVo);
    }
}
