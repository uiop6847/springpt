package com.demo.domain;

import java.util.Date;

/*
 * �ֹ� ���̺� VO ��ü
 */
public class OrderVO {

	private int		odr_code;
	private String 	mem_id;
	private String 	odr_name;
	private String 	odr_zipcode;
	private String 	odr_addr;
	private String 	odr_addr_d;
	private String 	odr_phone;
	private int 	odr_total_price;
	private Date 	odr_date;
	
	/* Getter and Setter */
	public int getOdr_code() {
		return odr_code;
	}
	public void setOdr_code(int odr_code) {
		this.odr_code = odr_code;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getOdr_name() {
		return odr_name;
	}
	public void setOdr_name(String odr_name) {
		this.odr_name = odr_name;
	}
	public String getOdr_zipcode() {
		return odr_zipcode;
	}
	public void setOdr_zipcode(String odr_zipcode) {
		this.odr_zipcode = odr_zipcode;
	}
	public String getOdr_addr() {
		return odr_addr;
	}
	public void setOdr_addr(String odr_addr) {
		this.odr_addr = odr_addr;
	}
	public String getOdr_addr_d() {
		return odr_addr_d;
	}
	public void setOdr_addr_d(String odr_addr_d) {
		this.odr_addr_d = odr_addr_d;
	}
	public String getOdr_phone() {
		return odr_phone;
	}
	public void setOdr_phone(String odr_phone) {
		this.odr_phone = odr_phone;
	}
	public int getOdr_total_price() {
		return odr_total_price;
	}
	public void setOdr_total_price(int odr_total_price) {
		this.odr_total_price = odr_total_price;
	}
	public Date getOdr_date() {
		return odr_date;
	}
	public void setOdr_date(Date odr_date) {
		this.odr_date = odr_date;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "OrderVO [odr_code=" + odr_code + ", mem_id=" + mem_id + ", odr_name=" + odr_name + ", odr_zipcode="
				+ odr_zipcode + ", odr_addr=" + odr_addr + ", odr_addr_d=" + odr_addr_d + ", odr_phone=" + odr_phone
				+ ", odr_price=" + odr_total_price + ", odr_date=" + odr_date + "]";
	}
	
	
}
