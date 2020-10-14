package com.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.demo.domain.CategoryVO;
import com.demo.domain.ProductVO;
import com.demo.service.AdProductService;
import com.demo.util.FileUtils;
import com.demo.util.PageMaker;
import com.demo.util.SearchCriteria;

@Controller
@RequestMapping("/admin/product/*")
public class AdProductController {

	@Autowired
	private AdProductService service;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	private static final Logger logger = LoggerFactory.getLogger(AdProductController.class);
	 
	/* 
	 * 1차 카테고리에 따른 2차 카테고리 출력
	 * 
	 * @Params
	 * 	@PathVariable("cg_code")
	 * 	: path로 들어온 1차카테고리
	 * 
	 * @return ResponseEntity<List<CategoryVO>>
	 * 	: REST 방식에 따른 HttpStatus를 같이 보내주기 위함
	 */
    // ARC :Advanced Rest Client 프로그램 테스트 먼저 확인
	//  "/admin/product/subCGList/" + mainCGCode
	@ResponseBody
	@RequestMapping(value="subCGList/{cg_code}", method=RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCGListPOST(@PathVariable("cg_code") String cg_code){
		
		logger.info("===== subCGListGET() execute.....");
		
		// 2차 카테고리 리스트
		ResponseEntity<List<CategoryVO>> entity = null;
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCGList(cg_code), HttpStatus.OK);
		} catch(Exception e){
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity; 
	}
	
	
	/* 
	 * 파일 출력 
	 * 저장된 파일을 가져와 반환 
	 */
	@ResponseBody
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	
	
	/* 이미지 파일 삭제 */
	public void deleteFile(String fileName) {
		logger.info("delete FileName : " + fileName);
		
		FileUtils.deleteFile(uploadPath, fileName);
	}
	
	
	/* 상품 등록(GET) */
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public void productInsertGET(Model model)  throws Exception{
		// 1차 카테고리 리스트 전송
		model.addAttribute("cateList", service.mainCGList());
	}
	
	/* 
	 * 상품 등록(POST) 
	 * 
	 * 1. 파일 업로드 : 일반적인 방식 <input type="file" /> , Ajax방식(Drag & Drop)
	 * 2. DB 작업
	 */
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String productInsertPOST(ProductVO vo, RedirectAttributes rttr)  throws Exception{
		
		logger.info("=====insertPOST() execute..."); 
		logger.info(vo.toString());
		
		// pdt_img를 업로드 된 이미지 파일로 설정
		// 날짜폴더명/UUID특수한 문자열_실제파일명 
		vo.setPdt_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
		
		service.insertProduct(vo);//상품테이블 데이터 삽입
		rttr.addFlashAttribute("msg", "INSERT_SUCCESS");
		
		// 상품리스트로 이동
		return "redirect:/admin/product/list";
	}
	
	
	/* 
	 * 상품 상세(ckEditor) - 파일 업로드 
	 * 웹 프로젝트 영역 상의 폴더에 업로드
	 * 
	 * @Params
	 * MultipartFile upload: 이미 지정된 이름/ 바꾸면 안돼
	 */
	@RequestMapping(value="imgUpload", method=RequestMethod.POST)
	public void imgUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		
		logger.info("=====imgUpload() execute..."); 
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		// 설정
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");
		
		try {
			// 전송할 파일 정보를 가져옴
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			
			// 폴더 경로 설정
			String uploadPath = req.getSession().getServletContext().getRealPath("/");
			uploadPath = uploadPath + "resources\\upload\\" + fileName;
			
			logger.info("=====uploadPath: " + uploadPath);
			
			// 출력 스트림 생성
			out = new FileOutputStream(new File(uploadPath));
			// 파일 쓰기
			out.write(bytes);
			
			printWriter = res.getWriter();
			String fileUrl = "/upload/" + fileName;
			
			// ckeditor 4에서 제공하는 형식
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송 (return과 같은 역할: 클라이언트로 보냄)
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			if(out!= null) { // 출력스트림 종료
				try {out.close(); }catch(Exception e) {e.printStackTrace();} 
			}
			if(printWriter!= null) { // printWriter 종료
				try {printWriter.close(); }catch(Exception e) {e.printStackTrace();} 
			}
		}
	}
	
	
	/* 
	 * 상품 리스트 (페이징, 검색 조건 포함)
	 * 
	 * # JSP로 전달
	 * 1. 검색 조건에 해당하는 상품리스트
	 * 2. PageMaker
	 */

	// url 이 처음 요청 받았을 경우  SearchCriteria cri 기본값을 가지게 됨. 
	// this.page = 1; // 현재 페이지 번호. this.perPageNum = 10; // 페이지에 출력 게시물 개수
	// searchType = null,  keyword = null
	@RequestMapping(value="list", method=RequestMethod.GET)
	public void productList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		
		logger.info("=====productList() execute...");
		logger.info("=====cri : " + cri.toString());
		
		// 페이징기능이 적용된 상품데이타.(검색기능 포함 선택적)
		model.addAttribute("productList", service.searchListProduct(cri)); 

		// PageMaker 생성
		PageMaker pm = new PageMaker();  //  1  2  3   4   5
		pm.setCri(cri);  /// 페이징정보, 검색정보


		int count = service.searchListCount(cri);


		logger.info("=====일치하는 상품개수 :" + count);
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);
	}
	
	
	/* 상품 상세정보 페이지 읽기 */
	@RequestMapping(value="read", method=RequestMethod.GET)
	public void productReadGET(@ModelAttribute("cri") SearchCriteria cri, 
								@RequestParam("pdt_num") int pdt_num, Model model) throws Exception{
		
		logger.info("=====productReadGET() execute...");
		
		// 선택한 상품 정보의 날짜 변환
		ProductVO vo = service.readProduct(pdt_num);
		
		//logger.info("=====dateFormat: " + DateFormatUtils.kstToDate(vo.getPdt_date_sub()).toString());
		logger.info("=====Product Detail: "+ vo.toString());
		
		// 썸네일 파일 이름 수정
		vo.setPdt_img(vo.getPdt_img().substring(vo.getPdt_img().lastIndexOf("_")+1));
		
		logger.info("=====changed Product Detail: "+ vo.toString());
		model.addAttribute("vo", vo);
		
		// PageMaker 생성 - 상품목록으로 돌아가기 클릭 시 이동하기 위해서
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
	}

	
	/* 
	 * 상품 수정(GET)
	 * 
	 * # JSP로 전달
	 * 1. 선택한 상품 정보
	 * 2. 1차카테고리 리스트
	 * 3. 현재 선택된 2차 카테고리 리스트
	 * 4. PageMaker
	 * 5. 원래 저장되어 있던 파일명
	 */
	@RequestMapping(value="edit", method=RequestMethod.GET)
	public void productEditGET(@ModelAttribute("cri") SearchCriteria cri, 
								@RequestParam("pdt_num") int pdt_num, Model model) throws Exception{
		
		logger.info("=====productEditGET() execute...");
		
		// 선택한 상품 정보의 날짜 변환
		ProductVO vo = service.readProduct(pdt_num);
		//vo.setPdt_date_sub(DateFormatUtils.kstToDate(vo.getPdt_date_sub()));		
		//vo.setPdt_date_up(DateFormatUtils.kstToDate(vo.getPdt_date_up()));		
		
		//logger.info("=====dateFormat: " + DateFormatUtils.kstToDate(vo.getPdt_date_sub()).toString());
		logger.info("=====Product Detail: "+ vo.toString());
		
		List<CategoryVO> subCateList = service.subCGList(vo.getCg_code_prt());
		String originFile = vo.getPdt_img().substring(vo.getPdt_img().lastIndexOf("_")+1);
		
		model.addAttribute("vo", vo);
		model.addAttribute("originFile", originFile);
		model.addAttribute("cateList", service.mainCGList());
		model.addAttribute("subCateList", service.subCGList(vo.getCg_code_prt()));
		
		// PageMaker 생성 - 상품목록으로 돌아가기 클릭 시 이동하기 위해서
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
	}
	
	/* 상품 수정(POST) */
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String productEditPOST(ProductVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("=====productEditPOST() execute...");
		logger.info("=====editted info: "+vo.toString());
		logger.info("=====cri info: "+cri.toString());
		
		// 파일 사이즈로 새로운 파일 등록 여부 확인
		// 파일을 새로 등록하지 않은 경우, null이 아닌 비어있는 쓰레기 파일이 넘어옴
		if(vo.getFile1().getSize() > 0) {
			// 파일이 변경 된 경우, pdt_img를 업로드 된 파일 정보로 설정
			logger.info("=====file not zero size");
			vo.setPdt_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
		} 
		logger.info("=====changed info: "+vo.toString());
		service.editProduct(vo);
		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "EDIT_SUCCESS");
		
		return "redirect:/admin/product/list";
	}
	
	
	/* 상품 삭제(POST) */
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String productDeletePOST(SearchCriteria cri, 
									@RequestParam("pdt_num") int pdt_num, 
									@RequestParam("pdt_img") String pdt_img,
									RedirectAttributes rttr) throws Exception{
		logger.info("=====delete(POST) executed...");
		
		// 이미지 삭제
		deleteFile(pdt_img);
		
		// 상품 삭제
		service.deleteProduct(pdt_num);
		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "DELETE_SUCCESS");
		// 시작했던 리스트 (선택한 페이지정보, 검색기능 사용)
		return "redirect:/admin/product/list";
	}
	
	
	/* 선택된 상품 수정 */
	@ResponseBody
	@RequestMapping(value="editChecked", method=RequestMethod.POST)
	public ResponseEntity<String> editChecked(@RequestParam("checkArr[]") List<Integer> checkArr,
											  @RequestParam("amountArr[]") List<Integer> amountArr,
											  @RequestParam("buyArr[]") List<String> buyArr){
		logger.info("===== editChecked() execute.....");
		
		ResponseEntity<String> entity = null;
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			for(int i=0; i<checkArr.size(); i++) {
				map.put("pdt_num", checkArr.get(i));
				map.put("pdt_amount", amountArr.get(i));
				map.put("pdt_buy", buyArr.get(i));
				
				service.editChecked(map);
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e){
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		entity = new ResponseEntity<String> (HttpStatus.OK);
		return entity; 
	}
	
	/* 선택된 상품 삭제 */
	@ResponseBody
	@RequestMapping(value="deleteChecked", method=RequestMethod.POST)
	public ResponseEntity<String> deleteChecked(@RequestParam("checkArr[]") List<Integer> checkArr,
												@RequestParam("imgArr[]") List<String> imgArr) {
		logger.info("===== deleteChecked() execute.....");
		
		ResponseEntity<String> entity = null;
		try {
			// 체크 된 상품의 이미지와 상품을 삭제
			for(int i=0; i<checkArr.size(); i++) {
				deleteFile(imgArr.get(i));
				service.deleteProduct(checkArr.get(i));
			}
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		} catch(Exception e){
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity; 
	}
	
	
	
}
