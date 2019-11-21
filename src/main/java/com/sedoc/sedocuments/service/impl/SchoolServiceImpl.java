package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.SchoolMapper;
import com.sedoc.sedocuments.model.School;
import com.sedoc.sedocuments.service.SchoolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SchoolServiceImpl implements SchoolService {
    @Autowired
    private SchoolMapper schoolMapper;
    @Override
    public List<School> queryAllSchools() {
        return schoolMapper.queryAllSchools();
    }

    @Override
    public String querySchoolNameBySchoolId(Integer schoolid) {
        return schoolMapper.querySchoolNameBySchoolId(schoolid);
    }
}
