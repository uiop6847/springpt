package com.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/*
 * 로그인 인터셉터
 */
public class LoginInterceptor extends HandlerInterceptorAdapter  {

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.info("=====login PreHandler() execute...");
		return super.preHandle(request, response, handler);
	}


	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		logger.info("=====login PostHandler() execute...");
		
		// 쿠키 생성
//		Cookie loginCookie = new Cookie("loginCookie", session.getId());
//		loginCookie.setPath("/"); // 모든 경로에서 접근 가능 설정
//		loginCookie.setMaxAge(60*60*24*7); // 7일
//		response.addCookie(loginCookie);
		
		
		
		return;
	}

	

	
}
