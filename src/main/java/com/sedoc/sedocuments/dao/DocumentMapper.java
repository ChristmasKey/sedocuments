package com.sedoc.sedocuments.dao;

import com.sedoc.sedocuments.model.Document;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 丁佳男
 */
@Mapper
@Repository
public interface DocumentMapper {
    List<Document> queryAllDocument(Document document);

    void insertSelective(Document document);

    void updateByPrimaryKeySelective(Document document);

    void deleteDocumentByProjectId(Integer projectid);

    Integer queryDocnumberByProjectId(Integer projectid);

    Integer queryMaxDoctype(Integer projectid);

    /**
     * 恢复项目下文档
     */
    void restoreDocByProId(Integer projectid);
}
