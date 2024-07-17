package kr.or.oho.devmng.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 가맹 상담 관리 컨트롤러
 * @author PC-08
 */
@Slf4j
@RequestMapping("/frcCnslt")
@Controller
public class FrcCnsltController {
	
	@Autowired
	FrcCnsltService frcCnsltService;
	
	@Autowired
	PreFrcService preFrcService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 로그인한 사원 담당 가맹 상담 리스트 화면 이동
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model, Principal principal) {
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		String empNo = emp.getEmpNo();
		
		List<ReserveFounderVO> preFrcList = this.frcCnsltService.list(empNo);
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
		
		return "devmng/frcCnslt";
	}
	
	/**
	 * 가맹 상세 상담 관리 화면 이동
	 * @return
	 */
	@GetMapping("/detail")
	public String detail(Model model, ItvBscInfoVO itvBscInfoVO) {
		log.debug("받은 ibiNo : "+itvBscInfoVO);
		ReserveFounderVO reserveFounderVO = this.frcCnsltService.detail(itvBscInfoVO);
		log.debug("상세정보 담은 reserveFounderVO : "+reserveFounderVO);
		
		model.addAttribute("preFrcDetail", reserveFounderVO);
		
		return "devmng/frcCnsltDetail";
	}
	
	/**
	 * ajax 면접 기본정보 수정 처리
	 * @param itvBscInfoVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/update")
	public String itvUpdateAjax(@RequestBody ItvBscInfoVO itvBscInfoVO) {
		log.debug("아작스로 받은 itvBscInfoVO : " + itvBscInfoVO);
		int result = this.frcCnsltService.update(itvBscInfoVO);
		log.debug("result : " + result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * ajax 면접 기본정보 삭제 처리
	 * @param itvBscInfoVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/cancel")
	public String cancelAjax(@RequestBody ItvBscInfoVO itvBscInfoVO) {
		log.debug("아작스로 받은 itvBscInfoVO : " + itvBscInfoVO);
		boolean result = this.frcCnsltService.cancel(itvBscInfoVO);
		log.debug("result : " + result);
		
		if(result) {
			return "success";
		}else {
			return "fail";
		}
	}
	
}
