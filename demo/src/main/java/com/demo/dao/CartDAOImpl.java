package com.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.domain.CartProductVO;
import com.demo.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Autowired
	SqlSession session;
	public final static String NS="com.demo.mappers.CartMapper";
	
	
	// 장바구니 추가
	@Override
	public void addCart(CartVO vo) throws Exception {
		session.insert(NS+ ".addCart", vo);
	}

	// 장바구니 삭제
	@Override
	public void deleteCart(int cart_code) throws Exception {
		session.delete(NS+ ".deleteCart", cart_code);
	}
	
	// 장바구니 수량 변경
	@Override
	public void updateCart(Map map) throws Exception {
		session.update(NS+ ".updateCart", map);
	}

	// 장바구니 가져오기
	@Override
	public List<CartProductVO> getCart(String mem_id) throws Exception {
		return session.selectList(NS+ ".getCart", mem_id);
	}

	// 장바구니 삭제(주문완료)
	@Override
	public void deleteCartOrder(Map map) throws Exception {
		session.delete(NS+ ".deleteCartOrder", map);
	}

	
}
