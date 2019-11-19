package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.School;

import java.util.List;

/**
 * 丁佳男
 */
public interface SchoolService {
    List<School> queryAllSchools();

    String querySchoolNameBySchoolId(Integer schoolid);
}
