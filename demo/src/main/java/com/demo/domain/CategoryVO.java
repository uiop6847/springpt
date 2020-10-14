package com.demo.domain;

/*
 * 카테고리 테이블
 */
public class CategoryVO {
	
	private String cg_code;
	private String cg_code_prt;
	private String cg_name;
	
	/* Getter and Setter */
	public String getCg_code() {
		return cg_code;
	}
	public void setCg_code(String cg_code) {
		this.cg_code = cg_code;
	}
	public String getCg_code_prt() {
		return cg_code_prt;
	}
	public void setCg_code_prt(String cg_code_prt) {
		this.cg_code_prt = cg_code_prt;
	}
	public String getCg_name() {
		return cg_name;
	}
	public void setCg_name(String cg_name) {
		this.cg_name = cg_name;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "CategoryVO [cg_code=" + cg_code + ", cg_code_prt=" + cg_code_prt + ", cg_name=" + cg_name + "]";
	}
	
}
