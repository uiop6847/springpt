package com.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.demo.domain.CategoryVO;
import com.demo.domain.ProductVO;
import com.demo.service.ProductService;
import com.demo.service.ReviewService;
import com.demo.util.Criteria;
import com.demo.util.FileUtils;
import com.demo.util.PageMaker;
import com.demo.util.SearchCriteria;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Inject
	ProductService service;
	
	@Inject
	ReviewService reviewService;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
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
	@ResponseBody
	@RequestMapping(value="subCGList/{cg_code}", method=RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCGListPOST(@PathVariable("cg_code") String cg_code){
		
		logger.info("===== subCGListGET() execute.....");
		
		// 2차 카테고리 리스트
		ResponseEntity<List<CategoryVO>> entity = null;
		try {
			logger.info("====="+ service.subCGList(cg_code));
			entity = new ResponseEntity<List<CategoryVO>>(service.subCGList(cg_code), HttpStatus.OK);
		} catch(Exception e){
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity; 
	}
	
	/* 카테고리에 해당하는 상품 리스트 출력 */
	@RequestMapping(value="list", method=RequestMethod.GET)
	public void list(@ModelAttribute("cri") Criteria cri, 
					 @ModelAttribute("cg_code") String cg_code,
					 Model model) throws Exception{
		
		logger.info("=====list() executed...");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cg_code", cg_code);
		map.put("rowStart", cri.getRowStart());
		map.put("rowEnd", cri.getRowEnd());
		
		List<ProductVO> list = service.productListCG(map);
		model.addAttribute("productList", list);
		model.addAttribute("cg_name", service.getCGName(cg_code));
		
		// PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		int count = service.productCount(cg_code);
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);
	}
	
	/* 검색조건에 해당하는 상품 리스트 출력 */
	@RequestMapping(value="listSearch", method=RequestMethod.GET)
	public void listSearch(@ModelAttribute("scri") SearchCriteria scri, 
					 		Model model) throws Exception{
		
		logger.info("=====listSearch() executed...");
		logger.info("=====cri: "+ scri.toString());
		
		List<ProductVO> list = service.produductListSearch(scri);
		model.addAttribute("productList", list);
		
		// PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(scri);
		int count = service.productCountSearch(scri.getKeyword());
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);
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
	
	
	/* 
	 * 카테고리 선택 -> 상품 상세정보 페이지 읽기 
	 * Criteria를 매개변수로 받는다
	 */
	@RequestMapping(value="read", method=RequestMethod.GET)
	public void productReadGET(@ModelAttribute("cri") Criteria cri, 
								@RequestParam("pdt_num") int pdt_num, Model model) throws Exception{
		
		logger.info("=====productReadGET() execute...");
		
		// 선택한 상품 정보의 이미지를 썸네일에서 원본으로 변경
		ProductVO vo = service.readProduct(pdt_num);
		vo.setPdt_img(FileUtils.thumbToOriginName(vo.getPdt_img()));
		
		//logger.info("=====dateFormat: " + DateFormatUtils.kstToDate(vo.getPdt_date_sub()).toString());
		logger.info("=====Product Detail: "+ vo.toString());
		model.addAttribute("vo", vo);
		
		// PageMaker 생성 - 상품목록으로 돌아가기 클릭 시 이동하기 위해서
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
		
		// 해당 상품에 달린 상품 후기 개수를 함께 보냄
		model.addAttribute("totalReview", reviewService.countReview(vo.getPdt_num()));
		
		//방법1 : 현재소스 - 상품후기 정보 없음. 클라이언트 코드쪽에서 ajax 요청에 의하여 처리가 되어짐
		//방법2 : 처음부터 상품후기정보를 Model 작업처리한다.
	}

	/* 
	 * 검색리스트 -> 상품 상세정보 페이지 읽기
	 * SearchCriteria를 매개변수로 받는다
	 */
	@RequestMapping(value="readSearch", method=RequestMethod.GET)
	public void productReadSearch(@ModelAttribute("scri") SearchCriteria scri, 
								  @RequestParam("pdt_num") int pdt_num, Model model) throws Exception{
		
		logger.info("=====productReadGET() execute...");
		
		// 선택한 상품 정보의 이미지를 썸네일에서 원본으로 변경
		ProductVO vo = service.readProduct(pdt_num);
		vo.setPdt_img(FileUtils.thumbToOriginName(vo.getPdt_img()));
		
		//logger.info("=====dateFormat: " + DateFormatUtils.kstToDate(vo.getPdt_date_sub()).toString());
		logger.info("=====Product Detail: "+ vo.toString());
		model.addAttribute("vo", vo);
		
		// PageMaker 생성 - 상품목록으로 돌아가기 클릭 시 이동하기 위해서
		PageMaker pm = new PageMaker();
		pm.setCri(scri);
		
		model.addAttribute("pm", pm);
		
		// 해당 상품에 달린 상품 후기 개수를 함께 보냄
		model.addAttribute("totalReview", reviewService.countReview(vo.getPdt_num()));
	}
	
}
