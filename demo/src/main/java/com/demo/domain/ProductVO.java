package com.demo.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

/*
 *
 */
public class ProductVO {
	
	private int		pdt_num;
	private String 	cg_code;
	private String 	cg_code_prt; // 추가
	private String 	pdt_name;
	private int		pdt_price;
	private int 	pdt_discount;
	private String	pdt_company;
	private String	pdt_detail;
	private String	pdt_img;
	private int		pdt_amount;
	private String 	pdt_buy;
	private Date	pdt_date_sub;
	private Date	pdt_date_up;
	
	// 업로드 파일
	private MultipartFile file1;  // insert.jsp <input type="file" id="file1" name="file1" class="form-control" />
	
	/* Getter and Setter */
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
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
	public String getPdt_company() {
		return pdt_company;
	}
	public void setPdt_company(String pdt_company) {
		this.pdt_company = pdt_company;
	}
	public String getPdt_detail() {
		return pdt_detail;
	}
	public void setPdt_detail(String pdt_detail) {
		this.pdt_detail = pdt_detail;
	}
	public String getPdt_img() {
		return pdt_img;
	}
	public void setPdt_img(String pdt_img) {
		this.pdt_img = pdt_img;
	}
	public int getPdt_amount() {
		return pdt_amount;
	}
	public void setPdt_amount(int pdt_amount) {
		this.pdt_amount = pdt_amount;
	}
	public String getPdt_buy() {
		return pdt_buy;
	}
	public void setPdt_buy(String pdt_buy) {
		this.pdt_buy = pdt_buy;
	}
	public Date getPdt_date_sub() {
		return pdt_date_sub;
	}
	public void setPdt_date_sub(Date pdt_date_sub) {
		this.pdt_date_sub = pdt_date_sub;
	}
	public Date getPdt_date_up() {
		return pdt_date_up;
	}
	public void setPdt_date_up(Date pdt_date_up) {
		this.pdt_date_up = pdt_date_up;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	
	
	/* toString() */
	@Override
	public String toString() {
		return "ProductVO [pdt_num=" + pdt_num + ", cg_code=" + cg_code + ", cg_code_prt=" + cg_code_prt + ", pdt_name="
				+ pdt_name + ", pdt_price=" + pdt_price + ", pdt_discount=" + pdt_discount + ", pdt_company="
				+ pdt_company + ", pdt_detail=" + pdt_detail + ", pdt_img=" + pdt_img + ", pdt_amount=" + pdt_amount
				+ ", pdt_buy=" + pdt_buy + ", pdt_date_sub=" + pdt_date_sub + ", pdt_date_up=" + pdt_date_up
				+ ", file1=" + file1 + "]";
	}
	
}
