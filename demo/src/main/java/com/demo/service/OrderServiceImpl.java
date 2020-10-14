package com.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.dao.OrderDAO;
import com.demo.domain.OrderDetailVO;
import com.demo.domain.OrderDetailVOList;
import com.demo.domain.OrderListVO;
import com.demo.domain.OrderReadDetailVO;
import com.demo.domain.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDAO dao;
	
	@Autowired
	private CartService cartService;

	/* 
	 * 상품구매(상품상세/ 바로구매)
	 * 주문내역과 주문정보 추가 
	 */

    // 사용자 1명이 여러건의 상품을 주문했을 때 
	// 메서드에서 2가지 이상의 기능이 사용될때. insert, update, delete 경우에 해당.
	@Transactional  
	@Override
	public void addOrder(OrderVO order, OrderDetailVOList orderDetailList) throws Exception {
		
		// 시퀀스(주문 코드) 가져오기
		int odr_code = dao.readOrderCode();
		
		// 주문 정보 추가
		order.setOdr_code(odr_code);
		dao.addOrder(order);  // 주문테이블에 데이타 삽입하기
		
		// 주문 내역 추가.  주문상세테이블에 데이타 삽입하기.
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		for(int i=0; i<list.size(); i++) {
			
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOdr_code(odr_code);
			dao.addOrderDetail(orderDetail);
		}
		
	}

	/* 
	 * 상품구매(장바구니)
	 * 주문내역과 주문정보 추가 
	 * 장바구니에서 넘어온 경우, 장바구니 테이블에서 해당 상품들 삭제
	 */
	@Transactional
	@Override
	public void addOrderCart(OrderVO order, OrderDetailVOList orderDetailList, String mem_id) throws Exception {
		
		// 시퀀스(주문 코드) 가져오기
		int odr_code = dao.readOrderCode();
		
		// 주문 정보 추가
		order.setOdr_code(odr_code);
		dao.addOrder(order);
		
		// 주문 내역 추가
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		for(int i=0; i<list.size(); i++) {
			
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOdr_code(odr_code);
			dao.addOrderDetail(orderDetail);
			
			// 장바구니 테이블에서 해당 상품들 삭제
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mem_id", mem_id);
			map.put("pdt_num", orderDetail.getPdt_num());
			cartService.deleteCartOrder(map);
			
		}
		
	}
	
	// 주문 목록
	@Override
	public List<OrderListVO> orderList(String mem_id) throws Exception {
		return dao.orderList(mem_id);
	}

	// 주문 상세 정보
	@Override
	public List<OrderReadDetailVO> readOrder(int odr_code) throws Exception {
		return dao.readOrder(odr_code);
	}

	// 주문자 정보
	@Override
	public OrderVO getOrder(int odr_code) throws Exception {
		return dao.getOrder(odr_code);
	}
	
}
