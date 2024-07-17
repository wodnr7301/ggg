package kr.or.oho.attendence.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.attendence.service.AttendService;
import kr.or.oho.attendence.service.HldyMngService;
import kr.or.oho.eatrzt.service.EatrztService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.vo.AtrzlnVO;
import kr.or.oho.vo.EatrztVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.HldyMngLdgrVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/hldy")
@Slf4j
@Controller
public class HldyController {
	
	@Autowired
	HldyMngService hldyMngService;
	
	@Autowired
	AttendService attendService;
	
	//로그인한 회원정보 꺼내기
	@Autowired
	private EmployeeMapper employeeMapper;
//	EmployeeVO emp = this.employeeMapper.detail(principal.getName());
//	log.info("로그인 한 emp 정보 : " + emp);
	
/*
	UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
    CustomUser cu = (CustomUser) a.getPrincipal();
    EmployeeVO emp = cu.getEmployeeVO();
    
    아이디만 꺼낼거면 principal.getName인가 그거로 하면됩니당
*/
	@Autowired
	EatrztService eatrztService ;
	
	@GetMapping("/list")
	public String list(Model model, Principal principal, Map<String, Object> map, EatrztVO eatrztVO, AtrzlnVO atrzlnVO) {
		
		//로그인 필수
		if(principal == null) {
			return "redirect:/login";
		}
		
		log.info("principal:"+principal);
		
//		UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
//		CustomUser cu = (CustomUser) a.getPrincipal();
//		EmployeeVO emp = cu.getEmployeeVO();
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		
		String empNo = emp.getEmpNo();
		map.put("empNo", empNo);
		
		List<HldyMngLdgrVO> hldyMngLdgrVOList = this.hldyMngService.list(empNo);
		log.info("hldyMngLdgrVOList :" + hldyMngLdgrVOList);
		
		List<HldyMngLdgrVO> hldyMngLdgrVOList2 = this.hldyMngService.btList(empNo);
		log.info("hldyMngLdgrVOList2 :" + hldyMngLdgrVOList2);
		
		model.addAttribute("hldyMngLdgrVOList", hldyMngLdgrVOList);
		model.addAttribute("hldyMngLdgrVOList2", hldyMngLdgrVOList2);
		
		map.put("waStatus", "퇴근");
		int totalWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->totalWork : " + totalWork);
		model.addAttribute("totalWork",totalWork);
		
		map.put("waStatus", "조퇴");
		int outWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->outWork : " + outWork);
		model.addAttribute("outWork",outWork);
		
		map.put("waStatus", "지각");
		int lateWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->lateWork : " + lateWork);
		model.addAttribute("lateWork",lateWork);
		
		return "attend/hldymngList";
	}
	
	@ResponseBody
	@PostMapping("/listAjax3")
	public String listAjax3(HttpSession session,
			@RequestBody Map<String, Object> map) {
		log.info("받은 정보 gtWorkString:"+map);
		
		session.setAttribute("gtWork", map);
		
		return "SUCCESS";
	}
	
	@ResponseBody
	@PostMapping("/listAjax4")
	public String listAjax4(HttpSession session,
			@RequestBody Map<String, Object> map) {
		log.info("받은 정보 dnWorkString:"+map);
		
		session.setAttribute("dnWork", map);
		
		return "SUCCESS";
	}
	
	
	
	
	@GetMapping("/list2")
	public String getVacationList(Model model, Principal principal) {
		
		//로그인 필수
		if(principal == null) {
			return "redirect:/login";
		}
		
		log.info("principal:"+principal);

		
		
		return "attend/hldymngList";
	}
	
	
}
