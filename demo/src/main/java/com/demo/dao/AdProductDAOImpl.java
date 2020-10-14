package com.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.domain.CategoryVO;
import com.demo.domain.ProductVO;
import com.demo.util.SearchCriteria;

@Repository
public class AdProductDAOImpl implements AdProductDAO{
	
	@Autowired
	SqlSession session; 
	public final static String NS="com.demo.mappers.AdProductMapper";
	
	// 1차 카테고리
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		return session.selectList(NS+ ".mainCGList");
	}

	// 1차 카테고리에 따른 2차 카테고리
	@Override
	public List<CategoryVO> subCGList(String cg_code) throws Exception {
		return session.selectList(NS+ ".subCGList", cg_code);
	}

	// 상품 등록
	@Override
	public void insertProduct(ProductVO vo) throws Exception {
		session.insert(NS+ ".insertProduct", vo);
	}

	// 상품 리스트
	@Override
	public List<ProductVO> searchListProduct(SearchCriteria cri) throws Exception {
		return session.selectList(NS+ ".searchListProduct", cri);
	}

	// 검색 조건에 맞는 상품 개수
	@Override
	public int searchListCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NS+ ".searchListCount", cri);
	}

	// 상품 정보
	@Override
	public ProductVO readProduct(int pdt_num) throws Exception {
		return session.selectOne(NS+ ".readProduct", pdt_num);
	}

	// 상품 수정
	@Override
	public void editProduct(ProductVO vo) throws Exception {
		session.update(NS+ ".editProduct", vo);
	}

	// 상품 삭제
	@Override
	public void deleteProduct(int pdt_num) throws Exception {
		session.delete(NS+ ".deleteProduct", pdt_num);
	}

	// 선택한 상품 수정
	@Override
	public void editChecked(Map<String, Object> map) throws Exception {
		session.update(NS+ ".editChecked", map);
	}

}
