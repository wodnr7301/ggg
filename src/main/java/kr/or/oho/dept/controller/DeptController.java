package kr.or.oho.dept.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.dept.service.DeptService;
import kr.or.oho.vo.DeptVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.JsTreeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/dept")
public class DeptController {
	
	@Autowired
	DeptService deptService;
	
	@GetMapping("/list")
	public String list() {
		log.debug("list에 왔다.");
		
		return "dept/list";
	}
	
	@ResponseBody
	@PostMapping("/getJsTree")
	public List<JsTreeVO> getJsTreeVO(){
		List<JsTreeVO> deptVOList = this.deptService.getDept();
		log.debug("deptVOList : "+deptVOList);
		List<JsTreeVO> empVOList = this.deptService.getEmp();
		log.debug("empVOList : "+empVOList);
		
		List<JsTreeVO> jsTreeVOList = new ArrayList<JsTreeVO>();
		jsTreeVOList.addAll(empVOList);
		jsTreeVOList.addAll(deptVOList);
		
		log.debug("jsTreeVOList : "+jsTreeVOList);
		
		
		return jsTreeVOList;
	}
	
	@ResponseBody
	@PostMapping("/getDeptCn")
	public DeptVO getDeptCn(@RequestBody JsTreeVO jsTreeVO) {
		log.debug("getDeptCn에 왔다.");
		log.debug("jsTreeVO :"+jsTreeVO);
			
		DeptVO deptVO = this.deptService.getDeptCn(jsTreeVO);
		log.debug("deptVO : "+ deptVO);
		
		return deptVO;
	}
	
	@ResponseBody
	@PostMapping("/getEmpCn")
	public List<EmployeeVO> getEmpCn(@RequestBody JsTreeVO jsTreeVO) {
		log.debug("getEmpCn에 왔다.");
		log.debug("jsTreeVO :"+jsTreeVO);
		
		List<EmployeeVO> employeeVOList = this.deptService.getEmpCn(jsTreeVO);
		log.debug("employeeVOList : "+ employeeVOList);
		
		return employeeVOList;
	}
	
	@ResponseBody
	@PostMapping("/getAllDept")
	public List<DeptVO> getAllDept(){
		List<DeptVO> deptVOList = this.deptService.getAllDept();
		log.debug("deptVOList : "+deptVOList);
		return deptVOList;
	}
	
	@ResponseBody
	@PostMapping("/moveDept")
	public int moveDept(@RequestBody EmployeeVO employeeVO) {
		log.debug("moveDept에 왔다.");
		log.debug("employeeVO :" + employeeVO);
		
		return this.deptService.moveDept(employeeVO);
	}
}
