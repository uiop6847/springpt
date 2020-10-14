package com.demo.domain;

import java.util.Date;

public class MemberVO {


/*
1)테이블의 컬럼명과 VO클래스의 필드명(변수)를 같게하는 경우
  mapper파일에서 parameterType,returnType 속성에 클래스를 사용 가능 -- 기준

포트폴리오 진행하면서 , 추가 설명 할것임.
2)테이블의 컬럼명과 VO클래스의 필드명(변수)를 다르게 하는 경우
 resultMap 작업을 해줘야한다.
*/

	private String 	mem_id;
	private String 	mem_name;
	private String 	mem_pw;
	private String 	mem_email;
	private String 	mem_zipcode;
	private String 	mem_addr;
	private String 	mem_addr_d;
	private String 	mem_phone;
	private String 	mem_nick;
	private String 	mem_accept_e;
	private int		mem_point;
	private Date	mem_date_sub;
	private Date	mem_date_up;
	private Date	mem_date_last;
	private String 	mem_authcode;
	private String  mem_session_key;
	private Date	mem_session_limit;
	
	
	/* Getter and Setter */
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_zipcode() {
		return mem_zipcode;
	}
	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}
	public String getMem_addr() {
		return mem_addr;
	}
	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}
	public String getMem_addr_d() {
		return mem_addr_d;
	}
	public void setMem_addr_d(String mem_addr_d) {
		this.mem_addr_d = mem_addr_d;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getMem_accept_e() {
		return mem_accept_e;
	}
	public void setMem_accept_e(String mem_accept_e) {
		this.mem_accept_e = mem_accept_e;
	}
	public int getMem_point() {
		return mem_point;
	}
	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	public Date getMem_date_sub() {
		return mem_date_sub;
	}
	public void setMem_date_sub(Date mem_date_sub) {
		this.mem_date_sub = mem_date_sub;
	}
	public Date getMem_date_up() {
		return mem_date_up;
	}
	public void setMem_date_up(Date mem_date_up) {
		this.mem_date_up = mem_date_up;
	}
	public Date getMem_date_last() {
		return mem_date_last;
	}
	public void setMem_date_last(Date mem_date_last) {
		this.mem_date_last = mem_date_last;
	}
	public String getMem_authcode() {
		return mem_authcode;
	}
	public void setMem_authcode(String mem_authcode) {
		this.mem_authcode = mem_authcode;
	}
	public String getMem_session_key() {
		return mem_session_key;
	}
	public void setMem_session_key(String mem_session_key) {
		this.mem_session_key = mem_session_key;
	}
	public Date getMem_session_limit() {
		return mem_session_limit;
	}
	public void setMem_session_limit(Date mem_session_limit) {
		this.mem_session_limit = mem_session_limit;
	}
	
	
	/* toString() */
	@Override
	public String toString() {
		return "MemberVO [mem_id=" + mem_id + ", mem_name=" + mem_name + ", mem_pw=" + mem_pw + ", mem_email="
				+ mem_email + ", mem_zipcode=" + mem_zipcode + ", mem_addr=" + mem_addr + ", mem_addr_d=" + mem_addr_d
				+ ", mem_phone=" + mem_phone + ", mem_nick=" + mem_nick + ", mem_accept_e=" + mem_accept_e
				+ ", mem_point=" + mem_point + ", mem_date_sub=" + mem_date_sub + ", mem_date_up=" + mem_date_up
				+ ", mem_date_last=" + mem_date_last + ", mem_authcode=" + mem_authcode + ", mem_session_key="
				+ mem_session_key + ", mem_session_limit=" + mem_session_limit + "]";
	}
	
}
