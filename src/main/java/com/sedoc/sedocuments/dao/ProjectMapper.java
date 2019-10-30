package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Project;
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
}
