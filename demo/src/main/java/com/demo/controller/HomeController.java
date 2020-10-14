package com.demo.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		// left.jsp 에서 표시되는 1차카테고리 Model작업이 포함되지 않음
		
		return "home";
	}
	
	/* jdbc 연결 테스트 */
	@Test
    public void testConnect() throws Exception{
	   
	   	String DRIVER ="oracle.jdbc.driver.OracleDriver";
	    String URL ="jdbc:oracle:thin:@localhost:1521:orcl"; 
	    String USER ="spring";
	    String PW ="spring";
        
        Class.forName(DRIVER);
        
        try(Connection con = DriverManager.getConnection(URL, USER, PW)){
            
            System.out.println(con);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
	
}
