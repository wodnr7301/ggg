package kr.or.oho.salary.controller;

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

import kr.or.oho.salary.service.SalaryService;
import kr.or.oho.vo.DdcVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.GiveVO;
import kr.or.oho.vo.SalaryVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/salary")
public class SalaryController {

	@Autowired
	SalaryService salaryService;

	@GetMapping("/all")
	public String selectAllSalaryList(Model model) {
		log.info("selectAllSalary메소드 도착");

		List<SalaryVO> salaryVOList = this.salaryService.allList();
		log.debug("salaryVOList : "+ salaryVOList);
		
		model.addAttribute("salaryVOList", salaryVOList);

		
		
		return "salary/allList";
	}
	
	@ResponseBody
	@PostMapping("/allAjax")
	public List<SalaryVO> selectAllSalaryListAjax() {
		log.info("selectAllSalaryAjax메소드 도착");
		
		List<SalaryVO> salaryVOList = this.salaryService.allList();
		log.debug("salaryVOList : "+ salaryVOList);
		
		return salaryVOList;
	}
	
	@ResponseBody
	@PostMapping("/detail")
	public Map<String,Object> detailSalary(@RequestBody SalaryVO salaryVO) {
		log.debug("detail메소드 시작");
		log.debug("salaryVO: "+salaryVO);
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		SalaryVO salary = this.salaryService.getSalary(salaryVO.getAmlNo());
		GiveVO giveVO = this.salaryService.getGive(salaryVO.getGiveNo());
		DdcVO ddcVO = this.salaryService.getDdc(salaryVO.getDdcNo());
		
		map.put("salary", salary);
		map.put("giveVO", giveVO);
		map.put("ddcVO", ddcVO);
		
		log.debug("map : "+ map);
		return map;
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		log.debug("create.jsp에 왔다.");
		
		List<EmployeeVO> employeeVOList = this.salaryService.getName();
		log.debug("employeeVOList : "+ employeeVOList);
		
		model.addAttribute("employeeVOList",employeeVOList);
		
		return "salary/create";
	}
	
	@ResponseBody
	@PostMapping("/createAjax")
	public int createAjax(@RequestBody SalaryVO salaryVO) {
		log.debug("createAjax 도착");
		log.debug("salaryVO : " + salaryVO);
		
		int cnt = this.salaryService.createAjax(salaryVO);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/updateAjax")
	public int updateAjax(@RequestBody SalaryVO salaryVO) {
		log.debug("updateAjax 도착");
		log.debug("salaryVO : " + salaryVO);
		
		int cnt = this.salaryService.updateAjax(salaryVO);
		
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public int deleteAjax(@RequestBody SalaryVO salaryVO) {
		log.debug("deleteAjax에 왔다.");
		log.debug("salaryVO : " + salaryVO);
		
		int cnt = this.salaryService.deleteAjax(salaryVO);
		
		return cnt;
	}
	
	@GetMapping("/update")
	public String update(String amlNo, String giveNo, String ddcNo, Model model) {
		log.debug("update에 왔다.");
		log.debug("amlNo : "+amlNo);
		log.debug("giveNo : "+giveNo);
		log.debug("ddcNo : "+ddcNo);
		
		
		SalaryVO salary = this.salaryService.getSalary(amlNo);
		GiveVO giveVO = this.salaryService.getGive(giveNo);
		DdcVO ddcVO = this.salaryService.getDdc(ddcNo);
		List<EmployeeVO> employeeVOList = this.salaryService.getName();
		
		model.addAttribute("salary",salary);
		model.addAttribute("giveVO",giveVO);
		model.addAttribute("ddcVO",ddcVO);
		model.addAttribute("employeeVOList",employeeVOList);
		
		return "salary/update";
	}
	
}
