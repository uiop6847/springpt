package com.demo.domain;


/*
 * �ֹ� �� ���̺� VO ��ü
 */
public class OrderDetailVO {

	private int odr_code;
	private int pdt_num;
	private int odr_amount;
	private int odr_price;
	
	/* Getter and Setter */
	public int getOdr_code() {
		return odr_code;
	}
	public void setOdr_code(int odr_code) {
		this.odr_code = odr_code;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public int getOdr_amount() {
		return odr_amount;
	}
	public void setOdr_amount(int odr_amount) {
		this.odr_amount = odr_amount;
	}
	public int getOdr_price() {
		return odr_price;
	}
	public void setOdr_price(int odr_price) {
		this.odr_price = odr_price;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "OrderDetailVO [odr_code=" + odr_code + ", pdt_num=" + pdt_num + ", odr_amount=" + odr_amount
				+ ", odr_price=" + odr_price + "]";
	}
	
	
	
	
}
