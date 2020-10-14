package com.demo.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.demo.dao.AdminDAO;
import com.demo.domain.AdminVO;
import com.demo.dto.AdminDTO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO dao;
	
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	// 관리자 로그인
	@Override
	public AdminVO login(AdminDTO dto) throws Exception {
		
		AdminVO vo = dao.login(dto);
		
		// 로그인 정보와 일치하는 값이 존재하면,
		if(vo!= null) {
			// 비밀번호가 암호화 된 비밀번호와 일치하는지 확인
			/*
			if(crptPassEnc.matches(dto.getAdmin_pw(), vo.getAdmin_pw())) {
				dao.loginUpdate(dto.getAdmin_id());
			} else { 
			
				vo = null;
			}
			*/
			dao.loginUpdate(dto.getAdmin_id());
			
		}
		return vo;
	}

}
