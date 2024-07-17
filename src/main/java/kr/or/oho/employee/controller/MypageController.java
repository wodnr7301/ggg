package kr.or.oho.employee.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.corpvhr.service.CorpVhrService;
import kr.or.oho.employee.service.MypageService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.CorpVhrVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.SalaryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MypageController {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Autowired
	CorpVhrService corpVhrService;
	
	@Autowired
	MypageService mypageservice;
	
	/**
	 * 직원 프로필
	 * 
	 * @author PC-01
	 *
	 */
	@GetMapping("/profile")
	public String profile(@RequestParam("empNo") String empNo,Model model, Principal principal) {
		log.info("프로필(GET)에 진입!");
		
		EmployeeVO employee = this.mypageservice.profile(empNo);
		log.info("프로필 잘 들어있는지 확인 : " + employee);
		
		List<EmployeeVO> franEmployee = this.mypageservice.franProfile(empNo);
		log.info(" 점주 프로필 잘 들어있는지 확인 : " + franEmployee);
		model.addAttribute("franEmployee",franEmployee);
		
		model.addAttribute("employee", employee);
		
		log.info("나의 법인차량 대여이력 조회하기");
		
		EmployeeVO empNm = this.employeeMapper.detail(principal.getName());
		log.debug("emp : " + empNm);
		
		String empNo1 = empNm.getEmpNo();
		
		List<CorpVhrVO> corpVhrVO = this.corpVhrService.mycvMngLdgr(empNo1);
		log.debug("corpVhrVO : " + corpVhrVO);
		
		model.addAttribute("corpVhrVO", corpVhrVO);
		
		List<SalaryVO> salaryVOList = this.mypageservice.getSalary(empNo);
		log.debug("salaryVOList : " + salaryVOList);
		model.addAttribute("salaryVOList",salaryVOList);
		
		List<FranchiseVO> franchiseVOList = this.mypageservice.getFranchise(empNo);
		log.debug("franchiseVOList : " + franchiseVOList);
		model.addAttribute("franchiseVOList",franchiseVOList);
		
		if (principal != null) {
	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser cu = (CustomUser) a.getPrincipal();
	        if (cu != null) {
	            EmployeeVO emp = cu.getEmployeeVO();
	            if (emp != null) {
	                model.addAttribute("empNo", emp.getEmpNo());
	            }
	        }
	    }
		
		return "employee/profile";
	}
	
	@ResponseBody
	@PostMapping("/returnAjax")
	public int returnAjax(@RequestBody CorpVhrVO corpVhrVO) {
		log.debug("차량 반납");
		log.debug("corpVhrVO : " + corpVhrVO);
		
		int cnt = this.corpVhrService.rtnVhr(corpVhrVO);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/updateProfile")
	public int profile(@RequestBody EmployeeVO employee) {
	    log.info("프로필(POST)에 진입!");

	    int cnt = this.mypageservice.profileUpdate(employee);
	    log.info("프로필 업데이트 내역 -> " + cnt);

	    return cnt; 
	}
	
	@ResponseBody
	@PostMapping("/updateDetailProfile")
	public int detailProfile(@RequestBody EmployeeVO employee) {
	    log.info("상세보기(POST)에 진입!");

	    int cnt = this.mypageservice.detailProfileUpdate(employee);
	    log.info("상세보기 업데이트 내역 -> " + cnt);

	    return cnt; 
	}
	
	
	/**
	 * EmployeeVO 정보 가져오기
	 * @author PC-01
	 * @return 
	 *
	 */
	@ResponseBody
	@GetMapping("/getEmp")
	public ResponseEntity<EmployeeVO> GetEmp(Principal principal) {
	    if (principal == null) {
	        log.error("Principal is null");
	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    }

	    UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	    
	    CustomUser cu;
	    
	    try {
	        cu = (CustomUser) a.getPrincipal();
	    } catch (ClassCastException e) {
	        log.error("Failed to cast principal to CustomUser", e);
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }

	    if (cu == null) {
	        log.error("CustomUser is null");
	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    }

	    EmployeeVO emp = cu.getEmployeeVO();
	    log.info("EmployeeVO emp 잘 나오는지 확인 --> " + emp);
	    
	    if (emp == null) {
	        log.error("EmployeeVO is null");
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }

	    log.info("empVO : " + emp);
	    return new ResponseEntity<>(emp, HttpStatus.OK);
	}	
}
