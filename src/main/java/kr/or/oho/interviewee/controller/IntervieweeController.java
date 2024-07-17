package kr.or.oho.interviewee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.oho.devmng.service.PreFrcService;
import kr.or.oho.interviewee.service.IntervieweeService;
import kr.or.oho.vo.IntervieweeVO;
import kr.or.oho.vo.ReserveFounderVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/interviewee")
public class IntervieweeController {
	
	@Autowired
	IntervieweeService intervieweeService;
	
	@Autowired
	PreFrcService preFrcService;
	
	@GetMapping("/list")
	public String intervieweeList(Model model) {
		log.debug("intervieweeList에 왔다");
		
		List<ReserveFounderVO> preFrcList = this.preFrcService.list();
		log.debug("preFrcList : " + preFrcList);
		
		model.addAttribute("preFrcList", preFrcList);
		
		return "interviewee/list";
	}
}
