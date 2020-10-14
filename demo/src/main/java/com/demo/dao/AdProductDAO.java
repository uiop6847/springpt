package com.demo.dao;

import java.util.List;
import java.util.Map;

import com.demo.domain.CategoryVO;
import com.demo.domain.ProductVO;
import com.demo.util.SearchCriteria;

public interface AdProductDAO {

	// 1차 카테고리
	public List<CategoryVO> mainCGList() throws Exception;
	
	// 1차 카테고리에 따른 2차 카테고리
	public List<CategoryVO> subCGList(String cg_code) throws Exception;
	
	// 상품 등록
	public void insertProduct(ProductVO vo) throws Exception;
	
	// 상품 리스트
	public List<ProductVO> searchListProduct(SearchCriteria cri) throws Exception;
	
	// 검색조건에 해당하는 상품 개수 
	public int searchListCount(SearchCriteria cri) throws Exception;
	
	// 상품 정보
	public ProductVO readProduct(int pdt_num) throws Exception;
	
	// 상품 수정
	public void editProduct(ProductVO vo) throws Exception;
	
	// 상품 삭제
	public void deleteProduct(int pdt_num) throws Exception;
	
	// 선택한 상품 수정
	public void editChecked(Map<String, Object> map) throws Exception;
} 
