package com.demo.service;

import java.util.List;

import com.demo.domain.OrderDetailVOList;
import com.demo.domain.OrderListVO;
import com.demo.domain.OrderReadDetailVO;
import com.demo.domain.OrderVO;

public interface OrderService {

	// 주문정보 추가(상품 상세/ 바로구매)
	public void addOrder(OrderVO order, OrderDetailVOList orderDetailList) throws Exception;
	
	// 주문정보 추가(장바구니)
	public void addOrderCart(OrderVO order, OrderDetailVOList orderDetailList, String mem_id) throws Exception;
	
	// 주문목록
	public List<OrderListVO>  orderList(String mem_id) throws Exception;
	
	// 주문 상세 정보
	public List<OrderReadDetailVO> readOrder(int odr_code) throws Exception;
		
	// 주문자 정보
	public OrderVO getOrder(int odr_code) throws Exception;
}
