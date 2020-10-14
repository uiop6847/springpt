package com.demo.domain;

import java.util.Date;

/*
 * 게시판 테이블 VO 객체
 */
public class BoardVO {

	private int		brd_name;
	private String 	mem_id;
	private String 	brd_title;
	private String 	brd_content;
	private Date 	brd_date_reg;
	
	/* Getter and Setter */
	public int getBrd_name() {
		return brd_name;
	}
	public void setBrd_name(int brd_name) {
		this.brd_name = brd_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getBrd_title() {
		return brd_title;
	}
	public void setBrd_title(String brd_title) {
		this.brd_title = brd_title;
	}
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public Date getBrd_date_reg() {
		return brd_date_reg;
	}
	public void setBrd_date_reg(Date brd_date_reg) {
		this.brd_date_reg = brd_date_reg;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "BoardVO [brd_name=" + brd_name + ", mem_id=" + mem_id + ", brd_title=" + brd_title + ", brd_content="
				+ brd_content + ", brd_date_reg=" + brd_date_reg + "]";
	}
	
	
}
