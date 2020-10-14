package com.demo.domain;

public class OrderReadDetailVO {

	private int odr_amount;
	private int pdt_num;
	private int odr_price;
	private int pdt_price;
	private String pdt_name;
	private String pdt_img;
	
	/* Getter and Setter */
	public int getOdr_amount() {
		return odr_amount;
	}
	public void setOdr_amount(int odr_amount) {
		this.odr_amount = odr_amount;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public int getOdr_price() {
		return odr_price;
	}
	public void setOdr_price(int odr_price) {
		this.odr_price = odr_price;
	}
	public int getPdt_price() {
		return pdt_price;
	}
	public void setPdt_price(int pdt_price) {
		this.pdt_price = pdt_price;
	}
	public String getPdt_name() {
		return pdt_name;
	}
	public void setPdt_name(String pdt_name) {
		this.pdt_name = pdt_name;
	}
	public String getPdt_img() {
		return pdt_img;
	}
	public void setPdt_img(String pdt_img) {
		this.pdt_img = pdt_img;
	}
	
	/* toString() */
	@Override
	public String toString() {
		return "OrderReadDetailVO [odr_amount=" + odr_amount + ", pdt_num=" + pdt_num + ", odr_price=" + odr_price
				+ ", pdt_price=" + pdt_price + ", pdt_name=" + pdt_name + ", pdt_img=" + pdt_img + "]";
	}
	
	
	
	
	
	
}
