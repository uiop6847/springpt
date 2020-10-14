package com.demo.domain;

import java.util.Date;

/*
 * 상품 후기 테이블 VO 객체
 */
public class ReviewVO {
	
	private int 	rv_num;
	private String 	mem_id;
	private int		pdt_num;
	private String	rv_content;
	private int 	rv_score;
	private Date	rv_date_reg;
	
	/* Getter and Setter */
	public int getRv_num() {
		return rv_num;
	}
	public void setRv_num(int rv_num) {
		this.rv_num = rv_num;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public String getRv_content() {
		return rv_content;
	}
	public void setRv_content(String rv_content) {
		this.rv_content = rv_content;
	}
	public int getRv_score() {
		return rv_score;
	}
	public void setRv_score(int rv_score) {
		this.rv_score = rv_score;
	}
	public Date getRv_date_reg() {
		return rv_date_reg;
	}
	public void setRv_date_reg(Date rv_date_reg) {
		this.rv_date_reg = rv_date_reg;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "ReviewVO [rv_num=" + rv_num + ", mem_id=" + mem_id + ", pdt_num=" + pdt_num + ", rv_content="
				+ rv_content + ", rv_score=" + rv_score + ", rv_date_reg=" + rv_date_reg + "]";
	}
	
	
}
