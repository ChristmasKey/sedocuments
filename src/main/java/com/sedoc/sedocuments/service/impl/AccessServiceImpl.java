package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.AccessMapper;
import com.sedoc.sedocuments.model.Access;
import com.sedoc.sedocuments.service.AccessService;
import com.sedoc.sedocuments.vo.AccessVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 丁佳男
 */
@Service
public class AccessServiceImpl implements AccessService {

    @Autowired
    private AccessMapper accessMapper;

    @Override
    public List<Access> queryAllAccessForList(AccessVo accessVo) {
        return accessMapper.queryAllAccess(accessVo);
    }

    @Override
    public List<Access> queryAccessByUidForList(AccessVo accessVo, Integer uid) {
        return null;
    }
}
