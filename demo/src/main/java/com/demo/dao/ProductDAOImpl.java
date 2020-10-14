package com.demo.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.demo.domain.CategoryVO;
import com.demo.domain.ProductVO;
import com.demo.util.SearchCriteria;

@Repository
public class ProductDAOImpl implements ProductDAO {
	
	@Inject
	private SqlSession session;
	public final static String NS = "com.demo.mappers.ProductMapper";
	
	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		return session.selectList(NS+ ".mainCGList");
	}

	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cg_code) throws Exception {
		return session.selectList(NS+ ".subCGList", cg_code);
	}

	// 카테고리 코드에 해당하는 카테고리 명
	@Override
	public String getCGName(String cg_code) throws Exception {
		return session.selectOne(NS+ ".getCGName", cg_code);
	}
	
	// 해당 카테고리에 해당하는 상품리스트(페이지에 맞춰서)
	@Override
	public List<ProductVO> productListCG(Map map) throws Exception {
		return session.selectList(NS+ ".productListCG", map);
	}

	// 카테고리에 해당하는 상품개수
	@Override
	public int productCount(String cg_code) throws Exception {
		return session.selectOne(NS+".productCount", cg_code);
	}
	
	// 해당 검색조건에 해당하는 상품리스트(페이지에 맞춰서)
	@Override
	public List<ProductVO> produductListSearch(SearchCriteria cri) throws Exception {
		return session.selectList(NS+ ".productListSearch", cri);
	}
	
	// 해당 검색조건에 해당하는  상품 개수
	@Override
	public int productCountSearch(String keyword) throws Exception {
		return session.selectOne(NS+ ".productSearchCount", keyword);
	}
	
	// 상품 상세 정보 읽기
	@Override
	public ProductVO readProduct(int pdt_num) throws Exception {
		return session.selectOne(NS+ ".readProduct", pdt_num);
	}


	

	

}
