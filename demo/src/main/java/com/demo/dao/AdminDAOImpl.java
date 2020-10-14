package com.demo.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.domain.AdminVO;
import com.demo.dto.AdminDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {
	
	@Autowired
	SqlSession session; 
	public final static String NS="com.demo.mappers.AdminMapper";

	// 로그인
	@Override
	public AdminVO login(AdminDTO dto) throws Exception {
		return session.selectOne(NS+ ".login", dto);
	}

	// 최근 로그인 시간 업데이트
	@Override
	public void loginUpdate(String admin_id) throws Exception {
		session.update(NS+ ".loginUpdate", admin_id);
	}

}
