package com.demo.service;

import java.util.List;

import com.demo.domain.ReviewVO;
import com.demo.util.Criteria;

public interface ReviewService {

	// 상품후기 총 개수
	public int countReview(int pdt_num) throws Exception;
	
	// 상품후기 쓰기
	public void writeReview(ReviewVO vo, String mem_id) throws Exception;
	
	// 상품후기 리스트(페이지포함)
	public List<ReviewVO> listReview(int pdt_num, Criteria cri) throws Exception;
	
	// 상품후기 삭제
	public void deleteReview(int rv_num) throws Exception;
	
	// 상품후기 수정
	public void modifyReview(ReviewVO vo) throws Exception;
		
}
