package com.demo.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.domain.MemberVO;
import com.demo.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;
	public final static String NS = "com.demo.mappers.MemberMapper";
	
	// memberVO 가져오기
	@Override
	public MemberVO readUserInfo(String mem_id) throws Exception {
		return session.selectOne(NS+ ".readUserInfo", mem_id);
	}
	
	// 로그인
	@Override
	public MemberDTO login(MemberDTO dto) throws Exception {
		return session.selectOne(NS+ ".login", dto);
	}

	// 로그인 시간 업데이트
	@Override
	public void loginUpdate(String mem_id) throws Exception {
		session.update(NS+ ".loginUpdate", mem_id);
	}

	// 회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		session.insert(NS+ ".join", vo);
	}

	// 아이디 중복 체크
	@Override
	public int checkIdDuplicate(String mem_id) throws Exception {
		return session.selectOne(NS+ ".checkIdDuplicate", mem_id);
	}

	// 회원정보 수정
	@Override
	public void modifyUserInfo(MemberVO vo) throws Exception {
		session.update(NS+ ".modifyUserInfo", vo);
	}

	// 비밀번호 변경
	@Override
	public void changePw(MemberDTO dto) throws Exception {
		session.update(NS+ ".changePw", dto);
	}

	// 회원 탈퇴
	@Override
	public void deleteUser(String mem_id) throws Exception {
		session.delete(NS+ ".deleteUser", mem_id);
	}

	// 로그인 정보 쿠키 저장
	@Override
	public void saveCookie(Map<String, Object> map) throws Exception {
		

		// map 컬렉션 구문을 여기서 해도 된다.(권장)
		// key 이름을 sql mapper구문에서 참조하기 때문에 이전단계에서 작업하는 것이 좀더 참조가 편리하다.


		session.update(NS+ ".saveCookie", map);
	}

	// 쿠키에 저장된 세션값으로 로그인 정보 가져옴
	@Override
	public MemberVO checkUserSession(String value) throws Exception {
		return session.selectOne(NS+ ".checkUserSession", value);
	}

	

}
