package com.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo.domain.CartVO;
import com.demo.dto.MemberDTO;
import com.demo.service.CartService;
import com.demo.util.Criteria;

@Controller
@RequestMapping(value="/cart/*")
public class CartController {

	@Inject
	private CartService service;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);
	
	
	/* 
	 * 장바구니에 추가 (REST)
	 * 상품 1개/ 수량 1개 추가
	 */
	@ResponseBody
	@RequestMapping(value="add", method=RequestMethod.POST)
	public ResponseEntity<String> addCart(int pdt_num, HttpSession session) {
		
		logger.info("=====add() execute...");
		logger.info("=====pdt_num: " + pdt_num);
		
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		vo.setMem_id(dto.getMem_id());
		vo.setPdt_num(pdt_num);
		vo.setCart_amount(1);
		logger.info("=====vo: " + vo.toString());
		
		try {
			service.addCart(vo);
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}
	
	/* 
	 * 장바구니에 추가 (REST)
	 * 상품 1개/ 수량 여러 개
	 */
	@ResponseBody
	@RequestMapping(value="addMany", method=RequestMethod.POST)
	public ResponseEntity<String> addManyCart(int pdt_num, int pdt_amount, HttpSession session) {
		
		logger.info("=====add() execute...");
		logger.info("=====pdt_num: " + pdt_num);
		
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		// 세션으로부터 로그인 아이디정보를 참조하는 작업
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		
		vo.setMem_id(dto.getMem_id()); //사용자 아이디
		
		vo.setPdt_num(pdt_num); // 상품코드
		vo.setCart_amount(pdt_amount); // 구매수량
		
		// 3가지 파라미터를 vo로 담아서 vo로 파라미터로 사용하고 있다.
		/*
		 * vo에 해당하는 클래스의 필드가 많은 경우에는 3개 파라미터를 사용하는 것을 권장.
		 * 
		 */
		
		logger.info("=====vo: " + vo.toString());
		
		try {
			service.addCart(vo); // 장바구니 담기
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}
	
	/* 장바구니 삭제 */
	@ResponseBody
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public ResponseEntity<String> deleteCart(int cart_code) throws Exception {
		
		logger.info("=====delete() execute...");
		
		ResponseEntity<String> entity = null;
	
		try {
			service.deleteCart(cart_code);
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 장바구니 선택 삭제 */
	@ResponseBody
	@RequestMapping(value="deleteChecked", method=RequestMethod.POST)
	public ResponseEntity<String> deleteChecked(@RequestParam("checkArr[]") List<Integer> checkArr) throws Exception {
		
		logger.info("=====deleteChecked() execute...");
		
		ResponseEntity<String> entity = null;
	
		try {
			for(int cart_code : checkArr) {
				service.deleteCart(cart_code);
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	/* 장바구니 수량 수정 */
	@ResponseBody
	@RequestMapping(value="modify", method=RequestMethod.POST)
	public ResponseEntity<String> modifyCart( int cart_code, int cart_amount) {
		
		logger.info("=====modify() execute...");
		logger.info("=====cart_code: "+ cart_code);
		logger.info("=====cart_amount: "+ cart_amount);
		
		ResponseEntity<String> entity = null;
		
		// Integer 안가나 확인 좀, 안가면 CartVO로 보내
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cart_code", cart_code);
		map.put("cart_amount", cart_amount);
		
		
		try {
			service.updateCart(map);
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 장바구니 목록 (GET) */
	@RequestMapping(value="list", method=RequestMethod.GET)
	public void listCartGET(Model model, HttpSession session) throws Exception {
		
		MemberDTO dto= (MemberDTO) session.getAttribute("user");
		model.addAttribute("cartProductList", service.getCart(dto.getMem_id()));
	}
	
}
