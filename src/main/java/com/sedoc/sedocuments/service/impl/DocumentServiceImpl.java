package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.DocumentMapper;
import com.sedoc.sedocuments.model.Document;
import com.sedoc.sedocuments.service.DocumentService;
import com.sedoc.sedocuments.vo.DocumentVo;
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
public class DocumentServiceImpl implements DocumentService {
    @Autowired
    private DocumentMapper documentMapper;

    @Override
    public List<Document> queryAllDocumentForList(DocumentVo documentVo) {
        return documentMapper.queryAllDocument(documentVo);
    }

    @Override
    public void addDocument(DocumentVo documentVo) {
        documentMapper.insertSelective(documentVo);
    }

    @Override
    public void updateDocument(DocumentVo documentVo) {
        documentMapper.updateByPrimaryKeySelective(documentVo);
    }

    @Override
    public void deleteDocumentByProjectId(ProjectVo projectVo) {
        documentMapper.deleteDocumentByProjectId(projectVo.getProjectid());
    }

    @Override
    public Integer queryDocnumberByProjectId(Integer projectid) {
        return documentMapper.queryDocnumberByProjectId(projectid);
    }

    @Override
    public Integer queryMaxDoctype(Integer projectid) {
        return documentMapper.queryMaxDoctype(projectid);
    }
}
