package com.demo.controller;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.demo.service.ProductService;

/* 톰캣이 구동되면, 다음 Model작업을 DB연동구문이 실행된다.
 * 컨트롤러에서 공통적으로 참조하는 코드를 작업
 * 다른 모든 컨트롤러보다 가장 먼저 실행 돼
 * 지정해둔 패키지 내의 모든 컨트롤러에서 사용되는 JSP파일에서 해당 model 사용가능
 
 */
@ControllerAdvice(basePackages = {"com.demo.controller"})
public class GlobalControllerAdvice {
	
	@Inject
	private ProductService service;
	
	/* 1차 카테고리 메뉴 표시 */
	@ModelAttribute
	public void categoryList(Model model) throws Exception{
		model.addAttribute("userCategoryList", service.mainCGList());
	}
	
}
