package kr.or.oho.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {

	@GetMapping("/error400")
	public String error400() {
		//400에러 발생시 보내는 페이지
		
		return "error/error400";
	}
	@GetMapping("/error401")
	public String error401() {
		//401에러 발생시 보내는 페이지
		
		return "error/error401";
	}
	@GetMapping("/error403")
	public String error403() {
		//403에러 발생시 보내는 페이지
		
		return "error/error403";
	}
	@GetMapping("/error404")
	public String error404() {
		//404에러 발생시 보내는 페이지
		
		return "error/error404";
	}
	@GetMapping("/error500")
	public String error500() {
		//500에러 발생시 보내는 페이지
		
		return "error/error500";
	}
	@GetMapping("/error503")
	public String error503() {
		//503에러 발생시 보내는 페이지
		
		return "error/error503";
	}
	@GetMapping("/error504")
	public String error504() {
		//400에러 발생시 보내는 페이지
		
		return "error/error504";
	}
	
}
