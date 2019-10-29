package com.sedoc.sedocuments.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 丁佳男
 */
public class DocNode {

    private String id;
    private Integer parentId;
    private String title;
    private List<DocNode> children=new ArrayList<>();
    private String checkArr="0";//选中就是1

    /*recordData部分开始*/
    private Boolean spread=false;
    private Integer doctype;
    /*recordData部分结束*/

    public DocNode(String id, Integer parentId, String title, Integer doctype) {
        this.id = id;
        this.parentId = parentId;
        this.title = title;
        this.doctype = doctype;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<DocNode> getChildren() {
        return children;
    }

    public void setChildren(List<DocNode> children) {
        this.children = children;
    }

    public String getCheckArr() {
        return checkArr;
    }

    public void setCheckArr(String checkArr) {
        this.checkArr = checkArr;
    }

    public Boolean getSpread() {
        return spread;
    }

    public void setSpread(Boolean spread) {
        this.spread = spread;
    }

    public Integer getDoctype() {
        return doctype;
    }

    public void setDoctype(Integer doctype) {
        this.doctype = doctype;
    }
}
