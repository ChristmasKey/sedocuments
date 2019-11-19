package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Major;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 丁佳男
 */
@Mapper
@Repository
public interface MajorMapper {

    List<Major> queryMajorBySchoolId(Integer isDel,Integer schoolid);

    String queryMajorNameByMajorId(Integer majorid);
}
