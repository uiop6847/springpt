package com.demo.dao;

import java.util.Map;

import com.demo.domain.MemberVO;
import com.demo.dto.MemberDTO;

public interface MemberDAO {

	// MemberVO 가져오기
	public MemberVO readUserInfo(String mem_id) throws Exception;
	
	// 로그인
	public MemberDTO login(MemberDTO dto) throws Exception; 
	
	// 로그인 시간 업데이트
	public void loginUpdate(String mem_id) throws Exception;
	
	// 회원가입
	public void join(MemberVO vo) throws Exception;

	// 아이디 중복체크
	public int checkIdDuplicate(String mem_id) throws Exception;
	
	// 회원정보 수정
	public void modifyUserInfo(MemberVO vo) throws Exception;
	
	// 비밀번호 변경
	public void changePw(MemberDTO dto) throws Exception;
	
	// 회원 탈퇴
	public void deleteUser(String mem_id) throws Exception;
	
	// 로그인 정보 쿠키 저장
	public void saveCookie(Map<String, Object> map) throws Exception;
	
	// 쿠키에 저장된 세션값으로 로그인 정보 가져옴
	public MemberVO checkUserSession(String value) throws Exception;
}
