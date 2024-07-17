package kr.or.oho.corpvhr.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.corpvhr.service.CorpVhrService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.vo.CorpVhrVO;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/corpvhr")
public class CorpVhrController {
	
	@Autowired
	CorpVhrService corpVhrService;

	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 법인차량 리스트
	 * @param model
	 * @return
	 */
	@GetMapping("/list")
	public String corpvhrList(Model model, Principal principal) {
		
		int cnt = 0;
		
		log.info("법인차량 리스트");
		
		List<CorpVhrVO> carList = this.corpVhrService.corpVhrList();
		log.debug("carList : " + carList);
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.debug("emp : " + emp);
		String empNo = emp.getEmpNo();
		
		List<CorpVhrVO> corpvhrVO = this.corpVhrService.mngLedgerList();
		log.debug("corpvhrVO : " + corpvhrVO);
		
		for (CorpVhrVO corpVhrVO2 : corpvhrVO) {
			log.debug("corpVhrVO2 : " + corpVhrVO2.getEmpNo());
			if(empNo.equals(corpVhrVO2.getEmpNo())) {
				cnt++;
			}
		}
		
		model.addAttribute("carList", carList);
		model.addAttribute("empNo", empNo);
		model.addAttribute("cnt", cnt);
//		model.addAttribute("corpVO", corpVO);
		return "corpvhr/list";
	}
	
	/**
	 * 법인차량 등록
	 * @param model
	 * @param corpVhrVO
	 * @return
	 */
	@GetMapping("/register")
	public String registerCorpVhr(Model model, CorpVhrVO corpVhrVO) {
		model.addAttribute("corpVhrVO", corpVhrVO);
		log.debug("create 도착");
		
		return "corpvhr/register";
	}
	
	/**
	 * 법인차량 등록 ajax
	 * @param corpVhrVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/registerFormData")
	public String registerFormdata(CorpVhrVO corpVhrVO) {
		log.debug("register 드가자~~");
		log.debug("corpVhrVO : " + corpVhrVO);
		
		int result = this.corpVhrService.registerCorpVhr(corpVhrVO);
		
		log.debug("result : ", result);
		
		return corpVhrVO.getCvNo();
		}
	
	/**
	 * 법인차량 관리대장 리스트
	 * @param model
	 * @param corpVhrVO
	 * @return	
	 */
	@GetMapping("/mngldgr")
	public String mngLedgerList(Model model) {
		log.debug("법인차량 관리대장 도착");
		
		List<CorpVhrVO> ledger = this.corpVhrService.mngLedgerList();
		log.debug("ledger : " + ledger);
		
		model.addAttribute("ledger", ledger);
		
		return "corpvhr/mngLedger";
	}
	
	/**
	 * 법인차량 관리대장 리스트(관리자용)
	 * @param corpVhrVO
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping("/reserveAjax")
	public int reserveCorpVhr(@RequestBody CorpVhrVO corpVhrVO, Principal principal) {
		
		log.debug("법인차량 예약드가자~~");
		log.debug("corpVhrVO : " + corpVhrVO);
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.debug("emp : " + emp);
		String empNo = emp.getEmpNo();
		String deptNo = emp.getDeptNo();
		
		corpVhrVO.setEmpNo(empNo);
		corpVhrVO.setCvmlUser(empNo);
		corpVhrVO.setDeptNo(deptNo);
		
		int cnt = this.corpVhrService.reserveCorpVhr(corpVhrVO);
		
		return cnt;
	}
	
	/**
	 * 법인차량관리대장 리스트
	 * @param model
	 * @return
	 */
	@GetMapping("/ldgrlist")
	public String cvMngLdgr(Model model) {
		
		log.info("차량관리대장 도착");
		
		List<CorpVhrVO> ldgrList = this.corpVhrService.cvMngLdgr();
		log.debug("ldgrList : " + ldgrList);
		
		model.addAttribute("ldgrList", ldgrList);
		
		return "corpvhr/cvMngLdgr";
		
	}
	
	/**
	 * 법인차량관리대장에서 차량을 빌린 직원의 상세정보 보기
	 * @param employeeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/cvEmpDetail")
	public EmployeeVO cvEmpDetail(@RequestBody EmployeeVO employeeVO) {
		
		log.debug("detail 도착");
		
		employeeVO = this.corpVhrService.cvEmpDetail(employeeVO);
		
		log.debug("employeeVO : " + employeeVO);
		
		
		return employeeVO;
	}
	

	
	
}
