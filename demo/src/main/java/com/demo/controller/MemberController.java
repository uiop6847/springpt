package com.demo.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.demo.domain.MemberVO;
import com.demo.dto.MemberDTO;
import com.demo.service.MemberService;

@Controller
@RequestMapping("/member/*") // 공통경로
public class MemberController {
	
	@Inject
	MemberService service;
	
	//spring-security.xml  BCryptPasswordEncoder클래스가 bean객체로 설정.
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	/* 로그인(GET)  /member/login   <a href="/member/login">로그인</a>   */
	@RequestMapping(value="login", method=RequestMethod.GET)
	public void loginGET() {
		// 리턴타입이 void인 경우에는 jsp파일명은 요청주소(/member/login)가 된다.
	}
	
	// RedirectAttributes 의미
	// : 이동되는 주소에 데이터를 사용하기 위하여
	
	/* 로그인(POST)  /member/loginPost */
	@RequestMapping(value="loginPost", method=RequestMethod.POST)
	public String loginPOST(MemberDTO dto, RedirectAttributes rttr, HttpSession session, 
							Model model, HttpServletResponse response) throws Exception {
		
		logger.info("=====loginPost() execute...");
	
	    // DB에서 암호화된 비밀번호가 저장
		MemberDTO memDTO = service.login(dto);  // service클래스에서 일반암호와 디비에서 가져온 암호문자열
		
		if(memDTO != null) { // 로그인 성공
			logger.info("=====로그인 성공");
			
			// 세션 작업 : 저장소 - 서버의 메모리(현재 연결된 사용자 사용이 가능)
			// memDTO : 아이디,비밀번호,  이름, 최근접속시간 
			session.setAttribute("user", memDTO);  // session.getAttribute("user")

/* 아래 쿠키작업은 여기서 하지말것 2020.10.08 */
			// 쿠키를 사용할 경우. 저장소 : 클라이언트(브라우저).
			// <input type="checkbox" name="useCookie" /> Remember me
			if(memDTO.isUseCookie()) {
				
				// 쿠키 저장
				int amount= 60*60*24*7;  //  7일

				//  System.currentTimeMillis() : 서버의 현재시간을 밀리세컨드 읽어온다.
				Date sessionLimit = new Date(System.currentTimeMillis()+(1000*amount));
				
				/* 클라이언트 쿠키 설명 : Cookie클래스 사용*/
				// 쿠키는 클라이언트의 컴퓨터에 설정된 시간에 의하여 텍스트파일로 저장이 됨
				// 브라우저에서 쿠키를 작업해준 사이트 접속을 할때에 브라우저가 쿠키를 메모리상에서 읽고
				// 해당사이트에 쿠키정보가 전송이 이루어진다.

				// 브라우저를통하여 사이트에 접속할때에 서버에서 고유한 식별자에 해당하는 값을 쿠키형태로
				// 클라이언트에게 보내준다. 세션쿠키ID  session.getId()


				// 쿠키작업이 완료되지 않음.  현재는 DB와 연동작업으로 되어있음.
				service.saveCookie(session.getId(), sessionLimit, memDTO.getMem_id());
			}
			
			
			rttr.addFlashAttribute("msg", "LOGIN_SUCCESS");
			return "redirect:/";  // 루트 주소로 이동. HomeController 에 있음. home.jsp에서 "msg" 키사용
			
		} else {		 // 로그인 실패
			logger.info("=====로그인 실패");
			
			//  RedirectAttributes 클래스 ? 주소이동시 정보를 제공하고자 할때 사용.

			// 주소이동시 "msg" 키가 노출이 안됨.
			rttr.addFlashAttribute("msg", "LOGIN_FAIL"); //로그인 페이지에서 "msg" 키가 사용됨.
			
			// return "/member/login";  jsp파일명
			return "redirect:/member/login"; // 주소이동
		}
		
	}
	
	/* 로그아웃  /member/logout  */
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		logger.info("=====logout execute()...");
		
		session.invalidate(); // 세션으로 처리한 정보가 서버메모리에서 제거. 로그아웃기능
		rttr.addFlashAttribute("msg", "LOGOUT_SUCCESS");
		
		
		return "redirect:/";  //  // 루트 주소로 이동. HomeController 에 있음. home.jsp에서 "msg" 키사용
	}
	
	
	/* 회원가입(GET)  /member/join    Daum 우편번호 API기능적용 */
	@RequestMapping(value="join", method=RequestMethod.GET)
	public void joinGET() {
	}
	
	/* 회원가입(POST) */
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String joinPOST(MemberVO vo, RedirectAttributes rttr) throws Exception {
		
		// 비밀번호 암호화.   "1234" -> 다른 문자로 비번으로 생성
		vo.setMem_pw(crptPassEnc.encode(vo.getMem_pw()));
		
		service.join(vo);
		rttr.addFlashAttribute("msg", "REGISTER_SUCCESS");
		
		return "redirect:/";    // 루트 주소로 이동. HomeController 에 있음. home.jsp에서 "msg" 키사용
	}
	
	
	/* 아이디 중복체크(ajax요청)   /member/checkIdDuplicate  */
	@ResponseBody
	@RequestMapping(value = "checkIdDuplicate", method=RequestMethod.POST)
	public ResponseEntity<String> checkIdDuplicate(@RequestParam("mem_id") String mem_id) throws Exception {
		
		logger.info("=====checkIdDuplicate execute()...");
		ResponseEntity<String> entity = null;
		try {
			int count = service.checkIdDuplicate(mem_id);
			// count 가 0이면 아이디 사용가능, 1d 이면 사용 불가능.

			if(count != 0) {
				// 아이디가 존재해서 사용이 불가능.
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			} else {
				// 사용가능한 아이디
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST); // 요청이 문제가 있다.
		}
		
		return entity;
	}
	
	/* 
	 * 이메일 인증 코드 확인   // /member/checkAuthcode
	 * - 입력된 인증 코드와 세션에 저장해 두었던 인증 코드가 일치하는지 확인
	 */
	@ResponseBody
	@RequestMapping(value = "checkAuthcode", method=RequestMethod.POST)
	public ResponseEntity<String> checkAuthcode(@RequestParam("code") String code, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		try {
			if(code.equals(session.getAttribute("authcode"))) {
				// 인증코드 일치
				entity= new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			} else {
				// 인증코드 불일치
				entity= new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/* 비밀번호 재확인(GET) - 회원 정보 수정을 위함 */
	/* 1)회원정보 수정 url=modify,  2)비밀번호 변경 url=changePw, 3)회원 탈퇴  url=delete */
	// @ModelAttribute("url") String url : String url 파라미터로 제공한 값을 @ModelAttribute 이 Model에 url 이름으로 저장
	@RequestMapping(value="checkPw", method=RequestMethod.GET)
	public void checkPwGET(@ModelAttribute("url") String url) {
		
	}
	
	/* 
	 * 비밀번호 재확인(POST) - 회원 정보 수정을 위함
	 * 받은 url에 해당하는 jsp를 출력
	 * 
	 * @Params
	 * String url: 이동할 jsp페이지 이름
	 * 
	 * @return
	 * String : 받은 url에 일치하는 jsp호출
	 */

	//   1)회원정보 수정 url=modify,  2)비밀번호 변경 url=changePw, 3)회원 탈퇴  url=delete 
	@RequestMapping(value="checkPw", method=RequestMethod.POST)
	public String checkPwPOST(@RequestParam("url") String url,
							  @RequestParam("mem_pw") String pw,
							  HttpSession session, Model model) throws Exception {
		
		logger.info("=====checkPw() execute..."); 
		logger.info("=====url: " + url + ", mem_pw: " + pw); 
		// 인증된 사용자
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		//logger.info("=====세션 저장 값: " + dto.toString());
		// 스프링 시큐리티(보안)
		if(crptPassEnc.matches(pw, dto.getMem_pw())) {
			// 비밀번호가 일치하는 경우, url 확인 
			if(url.equals("modify")) {
				model.addAttribute("vo", service.readUserInfo(dto.getMem_id()));
				return "/member/modify"; // 회원정보 수정 뷰
				
			} else if(url.equals("changePw")) {
				return "/member/changePw"; // 비밀번호변경 뷰
				
			} else if(url.equals("delete")) {
				return "/member/delete";  // 회원탈퇴 뷰
				
			}
		} 
		
		// 비밀번호가 일치하지 않거나, url이 정해진 url이 아닌 경우
		model.addAttribute("url", url);
		model.addAttribute("msg", "CHECK_PW_FAIL");
		return "/member/checkPw";
	}
	
	/*
	 * 비밀번호 확인 Ajax용
	 */
	@ResponseBody
	@RequestMapping("checkPwAjax")
	public ResponseEntity<String> checkPwAjax(@RequestParam("mem_pw") String mem_pw, HttpSession session) {
		
		logger.info("=====checkPwAjax() execute...");
		ResponseEntity<String> entity = null;
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		logger.info("=====mem_pw: " + mem_pw);
		logger.info("=====dto: " + dto.toString());
		
		if(crptPassEnc.matches(mem_pw, dto.getMem_pw())) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} else {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		
		return entity;
	}
	
	
	/* 회원 정보 수정(POST) */
	@RequestMapping(value="modify", method=RequestMethod.POST)
	public String modifyPOST(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {




		MemberDTO dto = new MemberDTO();
		dto.setMem_id(vo.getMem_id());
		dto.setMem_pw(vo.getMem_pw());
		
		// 비밀번호 암호화작업
		vo.setMem_pw(crptPassEnc.encode(vo.getMem_pw()));
		service.modifyUserInfo(vo); // 회원수정
		

		// 처음에 로그인시 세션에 저장했던 정보를 다른곳에서 사용이 되어질 경우(회원수정, 비번변경, 회원탈퇴)
		// 그 정보가 수정이 발생이 되면,세션정보를 갱신해주어야 한다.
		// 예> 비밀번호가 변경
		// 세션작업. 수정중에서 변경된 정보를 세션에 새로 반영하는 의미.
		session.setAttribute("user", service.login(dto));
		
		rttr.addFlashAttribute("msg", "MODIFY_USER_SUCCESS");
		
		return "redirect:/";
	}
	
	/* 비밀번호 변경(POST) */
	@RequestMapping(value="changePw", method=RequestMethod.POST)
	public String changePWPOST(MemberDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		logger.info("=====changePWPOST() execute...");
		// 비밀번호 암호화 후 변경
		dto.setMem_pw(crptPassEnc.encode(dto.getMem_pw()));
		service.changePw(dto);
		
		// 세션의 비밍번호 재설정
		MemberDTO memDTO = (MemberDTO) session.getAttribute("user");
		memDTO.setMem_pw(dto.getMem_pw());
		session.setAttribute("user", memDTO);
		
		rttr.addFlashAttribute("msg", "CHANGE_PW_SUCCESS");
		return "redirect:/";
	}
	
	/* 회원 탈퇴{POST) */
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String deletePOST(String mem_id, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		logger.info("=====deletePOST() execute...");
		
		service.deleteUser(mem_id);
		// 회원탈퇴시 세션 소멸작업
		session.invalidate();
		rttr.addFlashAttribute("msg", "DELETE_USER_SUCCESS");
		
		return "redirect:/";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
