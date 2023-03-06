package com.spring.green2209S_10;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/errorPage")
public class ErorrController {


	@RequestMapping(value = "/error500",method = RequestMethod.GET)
	public String error500() {
		
		
		return "errorPage/500";
	}
	@RequestMapping(value = "/error404",method = RequestMethod.GET)
	public String error404() {
		
		
		return "errorPage/error404";
	}
	@RequestMapping(value = "/error400",method = RequestMethod.GET)
	public String error400() {
		
		
		return "errorPage/400";
	}
	
}
