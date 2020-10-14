package com.demo.domain;

/*
 * 장바구니에 담긴 상품목록을 위한 VO 객체
 */
public class CartProductVO {

	private int 	cart_code;
	private int		cart_amount;
	private int		pdt_num; 
	private String 	pdt_name;
	private int		pdt_price;
	private int 	pdt_discount;
	private String	pdt_img;
	
	/* Getter and Setter */
	public int getCart_code() {
		return cart_code;
	}
	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}
	public int getCart_amount() {
		return cart_amount;
	}
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public String getPdt_name() {
		return pdt_name;
	}
	public void setPdt_name(String pdt_name) {
		this.pdt_name = pdt_name;
	}
	public int getPdt_price() {
		return pdt_price;
	}
	public void setPdt_price(int pdt_price) {
		this.pdt_price = pdt_price;
	}
	public int getPdt_discount() {
		return pdt_discount;
	}
	public void setPdt_discount(int pdt_discount) {
		this.pdt_discount = pdt_discount;
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
		return "CartProductVO [cart_code=" + cart_code + ", cart_amount=" + cart_amount + ", pdt_num=" + pdt_num
				+ ", pdt_name=" + pdt_name + ", pdt_price=" + pdt_price + ", pdt_discount=" + pdt_discount
				+ ", pdt_img=" + pdt_img + "]";
	}
	
	
	
}
