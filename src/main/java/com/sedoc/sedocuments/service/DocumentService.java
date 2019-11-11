package com.sedoc.sedocuments.service;

import com.sedoc.sedocuments.model.Document;
import com.sedoc.sedocuments.vo.DocumentVo;
import com.sedoc.sedocuments.vo.ProjectVo;

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

    /**
     * 添加文档
     */
    void addDocument(DocumentVo documentVo);

    /**
     * 修改文档信息
     */
    void updateDocument(DocumentVo documentVo);

    /**
     * 根据项目删除文档
     */
    void deleteDocumentByProjectId(ProjectVo projectVo);

    /**
     * 根据projectid查询未删除文档的数量
     */
    Integer queryDocnumberByProjectId(Integer projectid);

    /**
     * 查询项目中文档的最大doctype
     */
    Integer queryMaxDoctype(Integer projectid);
}
