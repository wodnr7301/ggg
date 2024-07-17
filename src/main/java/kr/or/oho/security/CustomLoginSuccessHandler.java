package kr.or.oho.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.oho.employee.service.EmployeeService;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler extends 
	SavedRequestAwareAuthenticationSuccessHandler{
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse resp,
			Authentication auth) throws ServletException, IOException {
	
		User customUser = (User) auth.getPrincipal();
		log.info("username : " + customUser.getUsername());
		
		List<String> roleNames = new ArrayList<String>();
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.info("roleNames : " + roleNames);
		
		// 로그인 사용자 정보를 세션에 저장
	    req.getSession().setAttribute("login", customUser);
		
		if(roleNames.contains("ROLE_ADMIN")) {
			resp.sendRedirect("/dashboard/home");
			return;
		}
		
		if(roleNames.contains("ROLE_MEMBER")) {
			resp.sendRedirect("/dashboard/home");
			return;
		}
		
		if(roleNames.contains("ROLE_FRCS")) {
			resp.sendRedirect("/");
			return;
		}
		
		super.onAuthenticationSuccess(req, resp, auth);
	}

}
