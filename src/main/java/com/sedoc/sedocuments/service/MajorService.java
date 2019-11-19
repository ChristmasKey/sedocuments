package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Major;
import com.sedoc.sedocuments.model.School;

import java.util.List;

/**
 * 丁佳男
 */
public interface MajorService {
    List<Major> queryMajorBySchoolId(School school);

    String queryMajorNameByMajorId(Integer majorid);
}
