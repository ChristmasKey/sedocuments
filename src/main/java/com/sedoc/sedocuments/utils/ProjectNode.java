package com.sedoc.sedocuments.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 丁佳男
 */
public class ProjectNode {
    private Integer id;
    private Integer parentId=0;
    private String title;
    private List<DocNode> children= new ArrayList<>();
    private String checkArr="0";//选中就是1

    /*recordData部分开始*/
    private Boolean spread=false;

    private String createtime;
    private String remark;
    private Integer docnumber;
    private Integer isTemplate;
    private Integer isOfficial;
    private Integer uid;
    /*recordData部分结束*/

    public ProjectNode(Integer id, String title, String createtime, String remark, Integer docnumber,Integer isTemplate,Integer isOfficial, Integer uid) {
        this.id = id;
        this.title = title;
        this.createtime = createtime;
        this.remark = remark;
        this.docnumber = docnumber;
        this.isTemplate=isTemplate;
        this.isOfficial=isOfficial;
        this.uid = uid;
    }

    public Integer getIsTemplate() {
        return isTemplate;
    }

    public void setIsTemplate(Integer isTemplate) {
        this.isTemplate = isTemplate;
    }

    public Integer getIsOfficial() {
        return isOfficial;
    }

    public void setIsOfficial(Integer isOfficial) {
        this.isOfficial = isOfficial;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getDocnumber() {
        return docnumber;
    }

    public void setDocnumber(Integer docnumber) {
        this.docnumber = docnumber;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }
}
