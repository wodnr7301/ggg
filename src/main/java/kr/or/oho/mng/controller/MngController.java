package kr.or.oho.mng.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.mng.service.MngService;
import kr.or.oho.salary.service.SalaryService;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.MngVO;
import kr.or.oho.vo.SalaryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mng")
public class MngController {
	
	@Autowired
	MngService mngService;
	
	@Autowired
	SalaryService salaryService;
	
	@Autowired
	FrcorderService frcorderService;
	
	@GetMapping("/list")
	public String list(Model model) {
		log.debug("mng/list에 왔다.");
		
		List<MngVO> mngVOList = this.mngService.getList();
		
		MngVO count = this.mngService.getCount();
		
		List<EmployeeVO> employeeVOList = this.salaryService.getName();
		log.debug("employeeVOList : "+ employeeVOList);
		
		// 모든 지역 정보
		List<ComcdVO> locationVOList = this.frcorderService.getAllLoc();
		log.info("locationVOList -> locationVOList : " + locationVOList);
		
		model.addAttribute("employeeVOList",employeeVOList);
		model.addAttribute("locationVOList",locationVOList);
		model.addAttribute("mngVOList",mngVOList);
		model.addAttribute("count",count);
		
		return "mng/list";
	}
	
	@ResponseBody
	@PostMapping("/create")
	public List<MngVO> createMng(@RequestBody MngVO mngVO){
		
		int cnt = this.mngService.createMng(mngVO);
		log.debug("cnt :"+cnt );
		
		List<MngVO> mngVOList = this.mngService.getList();
		log.debug("mngVOList : " + mngVOList);
		
		return mngVOList;
	}
	@ResponseBody
	@PostMapping("/oneMng")
	public List<MngVO> oneMng(@RequestBody MngVO mngVO){
		
		List<MngVO> mngVOList = this.mngService.getOneDay(mngVO);
		log.debug("mngVOList : " + mngVOList);
		
		return mngVOList;
	}
	
	@ResponseBody
	@PostMapping("/detail")
	public MngVO detail(@RequestBody String mngNo) {
		
		MngVO mngVO = this.mngService.detail(mngNo);
		log.debug("mngVO : "+mngVO);
		
		return mngVO;
	}
	
	@ResponseBody
	@PostMapping("/getCount")
	public MngVO getCount() {
		
		MngVO mngVO = this.mngService.getCount();
		log.debug("mngVO : "+mngVO);
		
		return mngVO;
	}
	
	@ResponseBody
	@PostMapping("/update")
	public List<MngVO> update(@RequestBody MngVO mngVO){
		log.debug("mngVO :"+ mngVO);
		
		int cnt = this.mngService.update(mngVO);
		
		List<MngVO> mngVOList = this.mngService.getList();
		log.debug("mngVOList : " + mngVOList);
		
		return mngVOList;
	}
	
	@ResponseBody
	@PostMapping("/done")
	public List<MngVO> done(@RequestBody String mngNo){
		log.debug("mngNo :"+ mngNo);
		
		int cnt = this.mngService.done(mngNo);
		
		List<MngVO> mngVOList = this.mngService.getList();
		log.debug("mngVOList : " + mngVOList);
		
		return mngVOList;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public List<MngVO> delete(@RequestBody String mngNo){
		log.debug("mngNo :"+ mngNo);
		
		int cnt = this.mngService.delete(mngNo);
		
		List<MngVO> mngVOList = this.mngService.getList();
		log.debug("mngVOList : " + mngVOList);
		
		return mngVOList;
	}
	
	@ResponseBody
	@PostMapping("getMax")
	public String getMax() {
		
		String max = this.mngService.getMax();
		
		return max;
	}
}
