package kr.or.oho.survey.controller;

import java.security.Principal;
import java.util.ArrayList;
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

import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.survey.service.SrvyService;
import kr.or.oho.vo.AnsMcVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.ExampleVO;
import kr.or.oho.vo.QstnMcVO;
import kr.or.oho.vo.SrvyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/survey")
@Controller
public class SurveyController {
	
	@Autowired
	SrvyService srvyService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 설문조사 관리 페이지 이동
	 */
	@GetMapping("/list")
	public String list(Model model, Principal principal) {
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		
		List<SrvyVO> srvyList = this.srvyService.srvyMngList(emp.getEmpNo());
		List<SrvyVO> srvyFinList = this.srvyService.srvyMngFinList(emp.getEmpNo());
		
		model.addAttribute("srvyList", srvyList);
		model.addAttribute("srvyFinList", srvyFinList);
		
		return "survey/surveyMng";
	}
	
	/**
	 * 새 설문 생성 페이지 이동
	 */
	@GetMapping("/createSrv")
	public String createSurvey(Model model) {
		return "survey/newSrvForm";
	}
	
	@ResponseBody
	@PostMapping("/add")
	public String addSurvey(@RequestBody SrvyVO srvyVO, Principal principal) {
		log.debug("입력된 srvyVO : "+srvyVO);
		
		boolean result = this.srvyService.srvyAdd(srvyVO, principal);
		log.debug("result : "+result);
		
		if(result) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public String deleteSurvey(@RequestBody SrvyVO srvyVO) {
		log.debug("입력된 srvyNo : "+srvyVO);
		
		int result = this.srvyService.srvyDelete(srvyVO);
		log.debug("result : "+result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@PostMapping("/update")
	public String updateSurvey(@RequestBody SrvyVO srvyVO) {
		log.debug("입력된 srvyVO : "+srvyVO);
		
		int result = this.srvyService.updateSurvey(srvyVO);
		log.debug("result : "+result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 선택한 설문조사 화면으로 이동 
	 */
	@GetMapping("/doSurvey")
	public String doSurvey(Model model, SrvyVO srvyVO) {
		log.debug("받은 srvyNo : "+srvyVO);
		
		SrvyVO srvy = this.srvyService.surveyDetail(srvyVO);
		log.debug("상세정보 담은 SrvyVO : "+srvy);
		
		List<QstnMcVO> qstnList = this.srvyService.qmcDetail(srvyVO);
		log.debug("질문 리스트 : "+qstnList);
		
		for (QstnMcVO qstnMcVO : qstnList) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("srvyNo", srvy.getSrvyNo());
			map.put("qmNo", qstnMcVO.getQmNo());
			
			List<ExampleVO> expList = this.srvyService.expDetail(map);
			log.debug("해당 질문의 보기 리스트 : "+expList);
			
			qstnMcVO.setExampleList(expList);
		}
		
		srvy.setQstnMcList(qstnList);
		
		log.debug("srvy! : "+srvy);
		
		model.addAttribute("srvy", srvy);
		
		return "survey/surveyForm";
	}
	
	@ResponseBody
	@PostMapping("/submit")
	public String submitSurvey(@RequestBody List<AnsMcVO> expNoList, Principal principal) {
		log.debug("넘어온 expNoList : "+expNoList);

		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		
		int result = 0;
		for (AnsMcVO ansMcVO : expNoList) {
			ansMcVO.setEmpNo(emp.getEmpNo());
			result += this.srvyService.submitAns(ansMcVO);
		}
		log.debug("result : "+result);
		
		if(expNoList.size() == result) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 메인헤더에 로그인한 사람이 참여할 수 있는 설문 리스트
	 * @param principal 로그인한 회원정보
	 * @return
	 */
	@ResponseBody
	@PostMapping("/header")
	public List<List<SrvyVO>> headerSrvyList(Principal principal) {
		List<SrvyVO> empSrvyList = this.srvyService.ableSrvyList("1",principal);
		List<SrvyVO> frcSrvyList = this.srvyService.ableSrvyList("2",principal);
		log.debug("empSrvyList : "+empSrvyList);
		log.debug("frcSrvyList : "+frcSrvyList);
		
		List<List<SrvyVO>> list = new ArrayList<List<SrvyVO>>();
		list.add(empSrvyList);
		list.add(frcSrvyList);
		
		return list;
	}
	
	/**
	 * 설문 결과 페이지 이동
	 */
	@GetMapping("/surveyResult")
	public String surveyResult(Model model, SrvyVO srvyVO) {
		log.debug("받은 srvyNo : "+srvyVO);
		
		SrvyVO srvyDetail = this.srvyService.surveyDetail(srvyVO);
		List<QstnMcVO> qstnList = this.srvyService.qmcDetail(srvyVO);
		
		for (QstnMcVO qstnMcVO : qstnList) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("srvyNo", srvyDetail.getSrvyNo());
			map.put("qmNo", qstnMcVO.getQmNo());
			
			List<ExampleVO> expList = this.srvyService.expDetail(map);
			
			qstnMcVO.setExampleList(expList);
		}
		
		model.addAttribute("srvyDetail", srvyDetail);
		model.addAttribute("qstnList", qstnList);
		
		return "survey/surveyResult";
	}
	
	/**
	 * 특정 설문의 특정 문항의 보기들 가져오기
	 * @param qstnNo, srvyNo 담긴 qstnMcVO
	 * @return 보기 리스트
	 */
	@ResponseBody
	@PostMapping("/getExp")
	public List<ExampleVO> getExp(@RequestBody QstnMcVO qstnMcVO) {
		log.debug("받은 qstnNo, srvyNo : "+qstnMcVO);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("srvyNo", qstnMcVO.getSrvyNo());
		map.put("qmNo", qstnMcVO.getQmNo());
		
		List<ExampleVO> expList = this.srvyService.expDetail(map);
		log.debug("expList : "+expList);
		
		return expList;
	}
	
}
