package com.demo.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.demo.dto.MemberDTO;
import com.demo.service.MemberService;

/*
 * 로그인 정보를 확인하는 인터셉터
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Inject
	private MemberService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	/*
	 * preHandler : 컨트롤러보다 먼저 수행
	 * @return
	 * true: 컨트롤러 동작을 진행
	 * false: 컨트롤러의 동작을 실행하지 않음
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO user = (MemberDTO) session.getAttribute("user");
		
		// 세션에 유저 정보가 없을 경우, 로그인 화면으로 이동
		if(user == null) {
			logger.info("=====This user is not logined.");
			response.sendRedirect("/member/login");
			return false;
		}
		
		// 쿠키 확인
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		if(loginCookie != null) {
			//MemberDTO userBefore = service.
		}
		
		return true;
	}

	
}
