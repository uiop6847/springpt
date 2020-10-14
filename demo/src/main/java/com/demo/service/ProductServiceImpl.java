package com.demo.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.demo.dao.ProductDAO;
import com.demo.domain.CategoryVO;
import com.demo.domain.ProductVO;
import com.demo.util.SearchCriteria;

@Service
public class ProductServiceImpl implements ProductService {

	@Inject
	private ProductDAO dao;
	
	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		return dao.mainCGList();
	}

	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cg_code) throws Exception {
		return dao.subCGList(cg_code);
	}
	
	// 카테고리 코드에 해당하는 카테고리 명
	@Override
	public String getCGName(String cg_code) throws Exception {
		return dao.getCGName(cg_code);
	}
	
	// 해당 카테고리에 해당하는 상품리스트(페이지에 맞춰서)
	@Override
	public List<ProductVO> productListCG(Map map) throws Exception {
		return dao.productListCG(map);
	}

	// 카테고리에 해당하는 상품 개수
	@Override
	public int productCount(String cg_code) throws Exception {
		return dao.productCount(cg_code);
	}
	
	// 해당 검색조건에 해당하는 상품리스트(페이지에 맞춰서)
	@Override
	public List<ProductVO> produductListSearch(SearchCriteria cri) throws Exception {
		return dao.produductListSearch(cri);
	}
	
	// 해당 검색조건에 해당하는  상품 개수
	@Override
	public int productCountSearch(String keyword) throws Exception {
		return dao.productCountSearch(keyword);
	}
	
	// 상품 상세 정보 읽기
	@Override
	public ProductVO readProduct(int pdt_num) throws Exception {
		return dao.readProduct(pdt_num);
	}


	

	

}
