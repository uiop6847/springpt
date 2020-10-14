package com.demo.service;

import com.demo.domain.AdminVO;
import com.demo.dto.AdminDTO;

public interface AdminService {

	// 로그인
	public AdminVO login(AdminDTO dto) throws Exception;
	
}
