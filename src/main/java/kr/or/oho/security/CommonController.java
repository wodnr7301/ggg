package kr.or.oho.security;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {

	@Autowired
	PasswordEncoder passwordEncoder;
	
	@GetMapping("/accessError")
	public String accessError(Authentication auth, Model model) {
		log.info("accessError -> auth : " + auth);
		model.addAttribute("msg", "Access Denied");
		
		return "login/login/accessError";
	}
	
	@GetMapping("/login")
	public String login(String error, String logout, Model model) {
		
		if(error != null) {
			model.addAttribute("/login/login/accessError", "Login Error");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout");
		}
		
		return "login/login/loginForm";
	}
}
