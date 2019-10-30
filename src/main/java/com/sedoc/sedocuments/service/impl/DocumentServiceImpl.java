package com.sedoc.sedocuments.service.impl;

import com.sedoc.sedocuments.dao.DocumentMapper;
import com.sedoc.sedocuments.model.Document;
import com.sedoc.sedocuments.service.DocumentService;
import com.sedoc.sedocuments.vo.DocumentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 丁佳男
 */
@Service
public class DocumentServiceImpl implements DocumentService {
    @Autowired
    private DocumentMapper documentMapper;

    @Override
    public List<Document> queryAllDocumentForList(DocumentVo documentVo) {
        return documentMapper.queryAllDocument(documentVo);
    }
}
