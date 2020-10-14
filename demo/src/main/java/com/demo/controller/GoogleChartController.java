//package com.demo.controller;
//
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Random;
//
//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.demo.domain.CartDTO;
//import com.demo.service.GoogleChartService;
//
//
//
//@RestController
//@RequestMapping("/chart/*")
//public class GoogleChartController {
//
//	@Autowired
//	private GoogleChartService googleChartService;
//	
//	@RequestMapping("chart1")
//	public ModelAndView chart1() {
//		
//		return new ModelAndView("chart/chart01");
//	}
//	
//	
//	@RequestMapping("cart_money_list")
//    public JSONObject cart_money_list() {
//        return googleChartService.getChartData();
//    }
//	
//	
//	/*	 구글 차트 JSON 데이터의 형식 -   {"key" : "value", "key": "value"}
//	 * 
//	 keys : "cols", "rows"
//	 values : [{}, {}]  - 배열형태
//	 
//	===============================================================  
//	{
//	    "cols": [
//	        {"label":"Topping","type":"string"},
//	        {"label":"Slices","type":"number"}
//	    ],        
//	    "rows": [
//	        {"c":[{"v":"Mushrooms"},{"v":3}]},
//	        {"c":[{"v":"Onions"},{"v":1}]},
//	        {"c":[{"v":"Olives"},{"v":1}]},
//	        {"c":[{"v":"Zucchini"},{"v":1}]},
//	        {"c":[{"v":"Pepperoni"},{"v":2}]}
//	    ]
//	}
//	===============================================================
//	*/
//	
//	// 클라이언트로 보낼 JSON 데이터 형식의 작업구문
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value="/cart_money_list_2" ,method=RequestMethod.GET)
//	public ResponseEntity<JSONObject> money_list(){
//		ResponseEntity<JSONObject>  entity=null;
//		
//		// Service 호출
//		
//		//1) 원본데이타 : List<CartDTO> items
//		List<CartDTO> items = new ArrayList<CartDTO>();
//        
//        Random rand = new Random();
//        
//        for(int i=0;i < 5; i++) {
//        	CartDTO cart = new CartDTO();
//        	int price = rand.nextInt(10000 - 1000 + 1) + 1000;
//        	cart.setMoney(price);
//        	cart.setProduct_name("전자제품" + i);
//        	
//        	items.add(cart);
//        }
//        
//        
//        //2) List<CartDTO> items => JSON 형식의 문자열작업
//		
//        // *** [ key: "cols" 작업 ] ***
//        //리스트 형태를 json 형태로 만들어서 리턴. HashMap 클래스상속
//        
//        
//        
//		JSONObject data =new JSONObject();
//		
//		//컬럼객체
//		//2-1  {"label":"Topping","type":"string"}
//		JSONObject col1 =new JSONObject();
//		col1.put("label", "상품명");
//		col1.put("type", "string");
//		//2-2  {"label":"Topping","type":"string"}
//		JSONObject col2 =new JSONObject();
//		col2.put("label", "금액");
//		col2.put("type" , "number");
//		
//		//2-3 배열에 데이타를 저장하는 구문
//		/*
//		[
//	        {"label":"Topping","type":"string"},
//	        {"label":"Slices","type":"number"}
//	    ]
//		*/
//		JSONArray title =new JSONArray();
//		title.add(col1);
//		title.add(col2);
//		
//		
//		//JSON객체에 저장.
//		/*
//		"cols": [
//	        {"label":"Topping","type":"string"},
//	        {"label":"Slices","type":"number"}
//	    ]
//		*/
//		data.put("cols", title);
///*		
//		"rows": [
//			        {"c":[{"v":"Mushrooms"},{"v":3}]},
//			        {"c":[{"v":"Onions"},{"v":1}]},
//			       ]
//			       
//		rows : [ 배열 (객체 :배열[객체])]
//		
//*/ 	
//		
//		
//		// =============================================================
//		
//		/*
//		key : "rows"
//		value : [ ] 배열
//		 
//		  - 하위구조(배열모습) : {"c":[{"v":"Mushrooms"},{"v":3}]}
//		   key : "c"
//		   value : []
//		   
//		     - 하위구조(배열모습) : [{"v":"Mushrooms"},{"v":3}]
//		     key : "v"
//		     value : "Mushrooms"
//		
//		
//		"rows": [
//	        {"c":[{"v":"Mushrooms"},{"v":3}]},
//	        {"c":[{"v":"Onions"},{"v":1}]},
//	        {"c":[{"v":"Olives"},{"v":1}]},
//	        {"c":[{"v":"Zucchini"},{"v":1}]},
//	        {"c":[{"v":"Pepperoni"},{"v":2}]}
//	    ]
//		
//		*/
//		//들어갈 형태  ->  rows 객체 에 배열  <- 
//		//  <- [  c 라는 객체에 배열 <- 객체
//		//  data 객체 -> rows 배열 <-  c 객체  ->배열  <- v 객체 2개/
//		
//		// ***[ key: "rows" 작업 ] ***
//		
//		
//		
//		// "rows" : [] 배열
//		JSONArray  body =new JSONArray();
//		
//		for(CartDTO  dto : items){
//			// {"v":"Mushrooms"}
//			JSONObject name =new JSONObject();
//			name.put("v", dto.getProduct_name()); //상품이름 -> v 객체 
//			// {"v":3}
//			JSONObject price =new JSONObject(); 
//			price.put("v", dto.getMoney()); //가격 ->v 객체
//
//			// 배열모습 :  [{"v":"Mushrooms"},{"v":3}] 
//			//  v객체를 row 배열을 만든후 추가한다.
//			JSONArray row =new JSONArray();
//			row.add(name);
//			row.add(price);   
// 
//			//   {"c":[{"v":"Mushrooms"},{"v":3}]}
//			//   c 객체 를 만든후 row 배열을 담는다.
//			JSONObject c =new JSONObject();
//			c.put("c", row);		
//			
//			/*
//			 [
//	        {"c":[{"v":"Mushrooms"},{"v":3}]},
//	        {"c":[{"v":"Onions"},{"v":1}]},
//	        {"c":[{"v":"Olives"},{"v":1}]},
//	        {"c":[{"v":"Zucchini"},{"v":1}]},
//	        {"c":[{"v":"Pepperoni"},{"v":2}]}
//	         ]
//			*/
//			// c 객체를 배열 형태의 body 에 담는다.
//			body.add(c);		
//		}
//		
//		/*
//		
//		"rows": [
//	        {"c":[{"v":"Mushrooms"},{"v":3}]},
//	        {"c":[{"v":"Onions"},{"v":1}]},
//	        {"c":[{"v":"Olives"},{"v":1}]},
//	        {"c":[{"v":"Zucchini"},{"v":1}]},
//	        {"c":[{"v":"Pepperoni"},{"v":2}]}
//	    ]
//		
//		*/
//		// 배열 형태의 body 를 rows 키값으로 객체 data 에 담는다.
//		data.put("rows", body);
//		
//		try{
//			 entity =new ResponseEntity<JSONObject>(data, HttpStatus.OK);
//		}catch (Exception e) {
//			System.out.println(" 에러            -- ");
//			entity =new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	}
//	
//	// 클라이언트로 보낼 JSON 데이터 형식의 작업구문
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/cart_money_array" ,method=RequestMethod.GET)
//		public ResponseEntity<JSONObject> money_array(){
//			ResponseEntity<JSONObject>  entity=null;
//			
//			// Service 호출
//			
//			//1) 원본데이타 : List<CartDTO> items
//			List<CartDTO> items = new ArrayList<CartDTO>();
//	        
//	        Random rand = new Random();
//	        
//	        for(int i=0;i < 5; i++) {
//	        	CartDTO cart = new CartDTO();
//	        	int price = rand.nextInt(10000 - 1000 + 1) + 1000;
//	        	cart.setMoney(price);
//	        	cart.setProduct_name("전자제품" + i);
//	        	
//	        	items.add(cart);
//	        }
//	        
//	        
//			JSONObject data =new JSONObject();
//			
//			//컬럼객체
//			//2-1  {"label":"Topping","type":"string"}
//			JSONObject col1 =new JSONObject();
//			col1.put("label", "상품명");
//			col1.put("type", "string");
//			//2-2  {"label":"Topping","type":"string"}
//			JSONObject col2 =new JSONObject();
//			col2.put("label", "금액");
//			col2.put("type" , "number");
//			
//			//2-3 배열에 데이타를 저장하는 구문
//			/*
//			[
//		        {"label":"Topping","type":"string"},
//		        {"label":"Slices","type":"number"}
//		    ]
//			*/
//			JSONArray title =new JSONArray();
//			title.add(col1);
//			title.add(col2);
//			
//			
//			//JSON객체에 저장.
//			/*
//			"cols": [
//		        {"label":"Topping","type":"string"},
//		        {"label":"Slices","type":"number"}
//		    ]
//			*/
//			data.put("cols", title);
//	/*		
//			"rows": [
//				        {"c":[{"v":"Mushrooms"},{"v":3}]},
//				        {"c":[{"v":"Onions"},{"v":1}]},
//				       ]
//				       
//			rows : [ 배열 (객체 :배열[객체])]
//			
//	*/ 	
//			
//			
//			// =============================================================
//			
//			/*
//			key : "rows"
//			value : [ ] 배열
//			 
//			  - 하위구조(배열모습) : {"c":[{"v":"Mushrooms"},{"v":3}]}
//			   key : "c"
//			   value : []
//			   
//			     - 하위구조(배열모습) : [{"v":"Mushrooms"},{"v":3}]
//			     key : "v"
//			     value : "Mushrooms"
//			
//			
//			"rows": [
//		        {"c":[{"v":"Mushrooms"},{"v":3}]},
//		        {"c":[{"v":"Onions"},{"v":1}]},
//		        {"c":[{"v":"Olives"},{"v":1}]},
//		        {"c":[{"v":"Zucchini"},{"v":1}]},
//		        {"c":[{"v":"Pepperoni"},{"v":2}]}
//		    ]
//			
//			*/
//			//들어갈 형태  ->  rows 객체 에 배열  <- 
//			//  <- [  c 라는 객체에 배열 <- 객체
//			//  data 객체 -> rows 배열 <-  c 객체  ->배열  <- v 객체 2개/
//			
//			// ***[ key: "rows" 작업 ] ***
//			
//			
//			
//			// "rows" : [] 배열
//			JSONArray  body =new JSONArray();
//			
//			for(CartDTO  dto : items){
//				// {"v":"Mushrooms"}
//				JSONObject name =new JSONObject();
//				name.put("v", dto.getProduct_name()); //상품이름 -> v 객체 
//				// {"v":3}
//				JSONObject price =new JSONObject(); 
//				price.put("v", dto.getMoney()); //가격 ->v 객체
//
//				// 배열모습 :  [{"v":"Mushrooms"},{"v":3}] 
//				//  v객체를 row 배열을 만든후 추가한다.
//				JSONArray row =new JSONArray();
//				row.add(name);
//				row.add(price);   
//	 
//				//   {"c":[{"v":"Mushrooms"},{"v":3}]}
//				//   c 객체 를 만든후 row 배열을 담는다.
//				JSONObject c =new JSONObject();
//				c.put("c", row);		
//				
//				/*
//				 [
//		        {"c":[{"v":"Mushrooms"},{"v":3}]},
//		        {"c":[{"v":"Onions"},{"v":1}]},
//		        {"c":[{"v":"Olives"},{"v":1}]},
//		        {"c":[{"v":"Zucchini"},{"v":1}]},
//		        {"c":[{"v":"Pepperoni"},{"v":2}]}
//		         ]
//				*/
//				// c 객체를 배열 형태의 body 에 담는다.
//				body.add(c);		
//			}
//			
//			/*
//			
//			"rows": [
//		        {"c":[{"v":"Mushrooms"},{"v":3}]},
//		        {"c":[{"v":"Onions"},{"v":1}]},
//		        {"c":[{"v":"Olives"},{"v":1}]},
//		        {"c":[{"v":"Zucchini"},{"v":1}]},
//		        {"c":[{"v":"Pepperoni"},{"v":2}]}
//		    ]
//			
//			*/
//			// 배열 형태의 body 를 rows 키값으로 객체 data 에 담는다.
//			data.put("rows", body);
//			
//			try{
//				 entity =new ResponseEntity<JSONObject>(data, HttpStatus.OK);
//			}catch (Exception e) {
//				System.out.println(" 에러            -- ");
//				entity =new ResponseEntity<JSONObject>(HttpStatus.BAD_REQUEST);
//			}
//			return entity;
//		}
//	
//	@RequestMapping(value="getArray", method=RequestMethod.GET)
//	public ModelAndView getArray(){
//			
//		ModelAndView modelAndView=new ModelAndView();
//		
//		// Service 호출
//		
//		List<CartDTO> items = new ArrayList<CartDTO>();
//		
//		Random rand = new Random();
//        
//        for(int i=0;i < 5; i++) {
//        	CartDTO cart = new CartDTO();
//        	int price = rand.nextInt(10000 - 1000 + 1) + 1000;
//        	cart.setMoney(price);
//        	cart.setProduct_name("전자제품" + i);
//        	
//        	items.add(cart);
//        }
//		
//		modelAndView.addObject("list", items);
//		modelAndView.setViewName("/chart/googleChart_4");;
//		
//		System.out.println(" 리스트 사이즈  : " + items.size());
//		
//		String str ="[";
//		str +="['상품명' , '가격'] ,";
//		int num =0;
//		for(CartDTO  dto : items){
//			
//			str +="['";
//			str  += dto.getProduct_name();
//			str +="' , ";
//			str += dto.getMoney();
//			str +=" ]";
//			
//			num ++;
//			if(num<items.size()){
//				str +=",";
//			}		
//		}
//		str += "]";
//		modelAndView.addObject("str", str);
//		return modelAndView;
//				
//	}
//	
//	@ResponseBody
//	@RequestMapping(value="getArray2", method=RequestMethod.GET)
//	public ResponseEntity<String[][]> getArray2(){
//			
//		ResponseEntity<String[][]> entity = null;
//		// Service 호출
//		
//		List<CartDTO> items = new ArrayList<CartDTO>();
//		
//		Random rand = new Random();
//        
//        for(int i=0;i < 5; i++) {
//        	CartDTO cart = new CartDTO();
//        	int price = rand.nextInt(10000 - 1000 + 1) + 1000;
//        	cart.setMoney(price);
//        	cart.setProduct_name("전자제품" + i);
//        	
//        	items.add(cart);
//        }
//        
//        String[][] arr = new String[1][items.size()];
//        
//        for (int i = 0; i < items.size(); i++) {
//			//arr[0][i] = items.get(i).
//		}
//        
//		
//        //modelAndView.addObject("list", items);
//		//modelAndView.setViewName("/chart/googleChart_4");;
//		
//		// "rows" : [] 배열
//		JSONArray  row =new JSONArray();
//		
//		JSONObject name =new JSONObject();
//		name.put("상품명", "가격");
//		
//		row.add(name);
//		
//		for(CartDTO  dto : items){
//			JSONObject cell =new JSONObject();
//			cell.put(dto.getProduct_name(),dto.getMoney()); //상품이름 -> v 객체 
//			
//			row.add(cell);
//		}
//		
//		
//		entity = new ResponseEntity<String[][]>(arr, HttpStatus.OK);
//		
//		return entity;
//	}
//	
//	
//
//}