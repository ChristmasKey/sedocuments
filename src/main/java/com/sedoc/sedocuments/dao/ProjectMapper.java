package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Project;
import com.sedoc.sedocuments.vo.ProjectVo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 丁佳男
 */
@Mapper
@Repository
public interface ProjectMapper {
    List<Project> queryAllProject(Project project);

    void insertSelective(Project project);

    void updateByPrimaryKeySelective(Project project);

    void deleteByPrimaryKey(Integer projectid);

    void updateDocnumber(Integer projectid);

    void updateDocnumberMinus(Integer projectid);

    List<Project> queryTempProjects(ProjectVo projectVo);
}
