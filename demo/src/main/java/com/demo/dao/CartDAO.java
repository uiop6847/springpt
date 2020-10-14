package com.demo.dao;

import java.util.List;
import java.util.Map;

import com.demo.domain.CartProductVO;
import com.demo.domain.CartVO;

public interface CartDAO {

	// 장바구니 추가
	public void addCart(CartVO vo) throws Exception;
	
	// 장바구니 삭제
	public void deleteCart(int cart_code) throws Exception;
	
	// 장바구니 수량 변경
	public void updateCart(Map map) throws Exception;
	
	// 장바구니 가져오기
	public List<CartProductVO> getCart(String mem_id) throws Exception;
	
	// 장바구니 삭제(주문완료)
	public void deleteCartOrder(Map map) throws Exception;
}
