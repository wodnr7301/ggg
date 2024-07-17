package kr.or.oho.devmng.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.devmng.service.FrcCnsltService;
import kr.or.oho.devmng.service.PreFrcService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.InterviewerVO;
import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 예비 창업자 관리 컨트롤러
 * @author PC-08
 */
@Slf4j
@RequestMapping("/preFrc")
@Controller
public class PreFrcController {
	
	@Autowired
	PreFrcService preFrcService;
	
	@Autowired
	FrcCnsltService frcCnsltService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 예비 창업자 신청 목록 리스트
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model, Principal principal) {
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		String empNo = emp.getEmpNo();
		
		List<ReserveFounderVO> preFrcList = this.preFrcService.list();
		log.debug("preFrcList : "+preFrcList);
		
		int listCnt = this.preFrcService.listCnt();
		log.debug("listCnt : "+listCnt);
		
		Map<String, String> mapY = new HashMap<String, String>();
		mapY.put("empNo", empNo);
		mapY.put("ibiPassYn", "Y");
		
		int cntY = this.frcCnsltService.listCnt(mapY);
		
		Map<String, String> mapN = new HashMap<String, String>();
		mapN.put("empNo", empNo);
		mapN.put("ibiPassYn", "N");
		
		int cntN = this.frcCnsltService.listCnt(mapN);
		
		model.addAttribute("preFrcList", preFrcList);
		model.addAttribute("listCnt", listCnt);
		model.addAttribute("cntY", cntY);
		model.addAttribute("cntN", cntN);
		
		return "devmng/preFrc";
	}
	
	/**
	 * 비동기로 상담일 등록하는 메서드
	 * @return
	 */
	@ResponseBody
	@PostMapping("/insert")
	public String cnsltDateInsertAjax(@RequestBody ItvBscInfoVO itvBscInfoVO, Principal principal) {
		log.debug("아작스로 받은 itvBscInfoVO : " + itvBscInfoVO);
		
		itvBscInfoVO.setIbiNo(this.preFrcService.ibiNoSelect());
		log.debug("면접번호 세팅 : " + itvBscInfoVO.getIbiNo());
		
		int result = this.preFrcService.ymdInsert(itvBscInfoVO);
		log.debug("면접기본정보 인서트 결과 : " + result);
		
		UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
		CustomUser cu = (CustomUser) a.getPrincipal();
		EmployeeVO emp = cu.getEmployeeVO();
		
		InterviewerVO interviewerVO = new InterviewerVO();
		interviewerVO.setEmpNo(emp.getEmpNo());
		interviewerVO.setIbiNo(itvBscInfoVO.getIbiNo());
		result += this.preFrcService.interviewerInsert(interviewerVO);
		log.debug("면접기본정보, 면접관 인서트 결과 : " + result);
		
		if(result == 2) {
			return "success";
		}else {
			return "fail";
		}
	}

}
