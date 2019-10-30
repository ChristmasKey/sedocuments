package com.sedoc.sedocuments.vo;

import com.sedoc.sedocuments.model.Role;

/**
 * 汪松
 */

public class RoleVo extends Role {

	private static final long serialVersionUID = 1L;
	private Integer page=1;
	private Integer limit=10;

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
