package com.sedoc.sedocuments.vo;

import com.sedoc.sedocuments.model.Access;

/**
 * 丁佳男
 */
public class AccessVo extends Access {

    private Integer page;
    private Integer limit;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }
}
