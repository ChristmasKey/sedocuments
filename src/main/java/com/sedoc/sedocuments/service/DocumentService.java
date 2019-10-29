package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Document;
import com.sedoc.sedocuments.vo.DocumentVo;

import java.util.List;

/**
 * 文档管理的服务接口
 *
 * 丁佳男
 */
public interface DocumentService {

    /**
     * 查询所有文档返回List<Document>
     */
    List<Document> queryAllDocumentForList(DocumentVo documentVo);

}
