package kr.or.oho.biz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.biz.service.BizService;
import kr.or.oho.salary.service.SalaryService;
import kr.or.oho.vo.BizVO;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/biz")
public class BizController {
	
	@Autowired
	BizService bizService;
	
	@Autowired
	SalaryService salaryService;
	
	@GetMapping("/list")
	public String bizList(Model model) {
		log.debug("biz/list에 왔다.");
		
		List<BizVO> bizVOList = this.bizService.getBizVOList();
		List<EmployeeVO> employeeVOList = this.salaryService.getName();
		log.debug("employeeVOList : "+ employeeVOList);
		
		model.addAttribute("employeeVOList",employeeVOList);
		model.addAttribute("bizVOList", bizVOList);
		
		return "biz/list";
	}
	
	@ResponseBody
	@PostMapping("/create")
	public List<BizVO> create(@RequestBody BizVO bizVO) {
		log.debug("biz/create에 왔다.");
		log.debug("bizVO : "+bizVO);
		
		int cnt = this.bizService.create(bizVO);
		log.debug("cnt ="+cnt);
		List<BizVO> bizVOList = this.bizService.getBizVOList();
		
		return bizVOList;
	}
	
	@ResponseBody
	@PostMapping("/detail")
	public BizVO detail(@RequestBody BizVO bizVO) {
		log.debug("biz/detail에 왔다.");
		log.debug("bizVO: "+bizVO);
		
		BizVO result = this.bizService.detail(bizVO);
		log.debug("result :"+result);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/update")
	public List<BizVO> update(@RequestBody BizVO bizVO){
		log.debug("biz/update에 왔다.");
		log.debug("bizVO : "+bizVO);
		
		int cnt = this.bizService.update(bizVO);
		log.debug("biz/update-cnt : "+cnt);
		
		List<BizVO> bizVOList = this.bizService.getBizVOList();
		
		return bizVOList;
	}
	
	@ResponseBody
	@PostMapping("/updateStatus")
	public List<BizVO> updateStatus(@RequestBody BizVO bizVO){
		log.debug("biz/updateStatus에 왔다.");
		log.debug("bizVO : "+bizVO);
		
		int cnt = this.bizService.updateStatus(bizVO);
		log.debug("biz/updateStatus-cnt : "+cnt);
		
		List<BizVO> bizVOList = this.bizService.getBizVOList();
		
		return bizVOList;
	}
	
	@ResponseBody
	@PostMapping("/updateStatusN")
	public List<BizVO> updateStatusN(@RequestBody BizVO bizVO){
		log.debug("biz/updateStatus에 왔다.");
		log.debug("bizVO : "+bizVO);
		
		int cnt = this.bizService.updateStatusN(bizVO);
		log.debug("biz/updateStatus-cnt : "+cnt);
		
		List<BizVO> bizVOList = this.bizService.getBizVOList();
		
		return bizVOList;
	}
	
}
