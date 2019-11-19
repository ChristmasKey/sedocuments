package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.MajorMapper;
import com.sedoc.sedocuments.model.Major;
import com.sedoc.sedocuments.model.School;
import com.sedoc.sedocuments.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MajorServiceImpl implements MajorService {
    @Autowired
    private MajorMapper majorMapper;
    @Override
    public List<Major> queryMajorBySchoolId(School school) {
        return majorMapper.queryMajorBySchoolId(school.getIsDel(),school.getSchoolid());
    }

    @Override
    public String queryMajorNameByMajorId(Integer majorid) {
        return majorMapper.queryMajorNameByMajorId(majorid);
    }
}
