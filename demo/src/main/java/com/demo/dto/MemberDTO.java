package com.demo.dto;

import java.util.Date;

public class MemberDTO {

	private String mem_id;
	private String mem_pw;
	private String mem_nick;
	private String mem_name;
	private String mem_point;
	private Date mem_date_last;
	private boolean useCookie;   // 로그인페이지  <input type="checkbox" name="useCookie" />
	
	/* Getter and Setter */
	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_nick() {
		return mem_nick;
	}

	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_point() {
		return mem_point;
	}

	public void setMem_point(String mem_point) {
		this.mem_point = mem_point;
	}

	public Date getMem_date_last() {
		return mem_date_last;
	}

	public void setMem_date_last(Date mem_date_last) {
		this.mem_date_last = mem_date_last;
	}

	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}

	/* toString() */
	@Override
	public String toString() {
		return "MemberDTO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_nick=" + mem_nick + ", mem_name="
				+ mem_name + ", mem_point=" + mem_point + ", mem_date_last=" + mem_date_last + ", useCookie="
				+ useCookie + "]";
	}
	
	
	
	
}
