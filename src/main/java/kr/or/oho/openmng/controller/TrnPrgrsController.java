package kr.or.oho.openmng.controller;

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

import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.openmng.service.EdnCndtnService;
import kr.or.oho.vo.EdnCndtnVO;
import kr.or.oho.vo.EdnPrgrmVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 교육 현황 관리 컨트롤러
 * @author PC-08
 */
@Slf4j
@RequestMapping("/trnPrgrs")
@Controller
public class TrnPrgrsController {
	
	@Autowired
	EdnCndtnService ednCndtnService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 교육 현황 리스트 화면 이동
	 * @param model
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model) {
		List<EdnCndtnVO> ednCndtnList = this.ednCndtnService.list();
		log.debug("ednCndtnList : "+ednCndtnList);
		
		List<EdnPrgrmVO> ednPrgrmNmList = this.ednCndtnService.getEpNmList();
		log.debug("ednPrgrmNmList : "+ednPrgrmNmList);
		
		Map<String, String> mapN = new HashMap<String, String>();
		mapN.put("ecYn", "N");
		mapN.put("epNm1", "");
		Map<String, String> mapY = new HashMap<String, String>();
		mapY.put("ecYn", "Y");
		mapY.put("epNm1", "");
		Map<String, String> mapF = new HashMap<String, String>();
		mapF.put("ecYn", "F");
		mapF.put("epNm1", "");
		
		int cntN = this.ednCndtnService.getEcYnfCnt(mapN);
		int cntY = this.ednCndtnService.getEcYnfCnt(mapY);
		int cntF = this.ednCndtnService.getEcYnfCnt(mapF);
		log.debug("이수현황서머리 : "+cntN+", "+cntY+", "+cntF);
		
		List<List<EdnCndtnVO>> list = this.ednCndtnService.getEcYnfCntFirst();
		log.debug("교육별 ynf 리스트 : "+list);
		
		model.addAttribute("ednCndtnList", ednCndtnList);
		model.addAttribute("ednPrgrmNmList", ednPrgrmNmList);
		model.addAttribute("cntN", cntN);
		model.addAttribute("cntY", cntY);
		model.addAttribute("cntF", cntF);
		model.addAttribute("ynfList", list);
		
		return "openmng/trnPrgrs";
	}
	
	/**
	 * 교육명 별 교육 현황 리스트
	 * @param ednPrgrmVO 교육명 담은 VO
	 * @return 해당 교육명 별 EdnCndtnVO 리스트
	 */
	@ResponseBody
	@PostMapping("/getList")
	public List<EdnCndtnVO> getListAjax(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 ednPrgrmVO : "+ednPrgrmVO);
		
		List<EdnCndtnVO> ecList = this.ednCndtnService.getList(ednPrgrmVO);
		log.debug("ecList : "+ecList);
		
		return ecList;
	}
	
	@ResponseBody
	@PostMapping("/getEcCntAjax")
	public Map<String, Object> getEcCntAjax(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 ednPrgrmVO epNm1 : "+ednPrgrmVO);
		
		Map<String, String> mapN = new HashMap<String, String>();
		mapN.put("ecYn", "N");
		mapN.put("epNm1", ednPrgrmVO.getEpNm1());
		Map<String, String> mapY = new HashMap<String, String>();
		mapY.put("ecYn", "Y");
		mapY.put("epNm1", ednPrgrmVO.getEpNm1());
		Map<String, String> mapF = new HashMap<String, String>();
		mapF.put("ecYn", "F");
		mapF.put("epNm1", ednPrgrmVO.getEpNm1());
		
		int cntN = this.ednCndtnService.getEcYnfCnt(mapN);
		int cntY = this.ednCndtnService.getEcYnfCnt(mapY);
		int cntF = this.ednCndtnService.getEcYnfCnt(mapF);
		log.debug("이수현황서머리 : "+cntN+", "+cntY+", "+cntF);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cntY", cntY);
		result.put("cntN", cntN);
		result.put("cntF", cntF);
		
		return result;
	}
	
	/**
	 * 교육현황 삭제
	 * @param ednCndtnVO 교육현황번호 ecNo 담은 교육현황 VO
	 * @return 삭제 성공 : success 실패 : fail
	 */
	@ResponseBody
	@PostMapping("/delete")
	public String delete(@RequestBody EdnCndtnVO ednCndtnVO) {
		log.debug("입력값 ednCndtnVO : "+ednCndtnVO);
		
		int result = this.ednCndtnService.delete(ednCndtnVO);
		log.debug("삭제 처리 결과 : "+result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 교육현황 등록
	 * @param ednCndtnVO 교육 현황 등록 정보 담은 교육현황 VO
	 * @return 등록 성공 : success 실패 : fail
	 */
	@ResponseBody
	@PostMapping("/add")
	public String add(@RequestBody EdnCndtnVO ednCndtnVO) {
		log.debug("입력값 ednCndtnVO : "+ednCndtnVO);
		
		int result = this.ednCndtnService.add(ednCndtnVO);
		log.debug("등록 처리 결과 : "+result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 교육현황 변경
	 * @param ednCndtnVO 교육 현황 수정 정보 담은 교육현황 VO
	 * @return 변경 성공 : success 실패 : fail
	 */
	@ResponseBody
	@PostMapping("/update")
	public String update(@RequestBody EdnCndtnVO ednCndtnVO) {
		log.debug("입력값 ednCndtnVO : "+ednCndtnVO);
		
		int result = this.ednCndtnService.update(ednCndtnVO);
		log.debug("변경 처리 결과 : "+result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 교육명 별 교육 프로그램 상세정보 리스트
	 * @param ednPrgrmVO 넘어온 교육명(epNm1)값
	 * @return ep_no, ep_nm, ep_nm1, ep_nm2 들어있는 교육 프로그램 VO
	 */
	@ResponseBody
	@PostMapping("/getEpNm2List")
	public List<EdnPrgrmVO> getEpNm2List(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 ednPrgrmVO : "+ednPrgrmVO);
		
		List<EdnPrgrmVO> epList = this.ednCndtnService.getEpNmDetailList(ednPrgrmVO);
		log.debug("epList : "+epList);
		
		return epList;
	}
	
	/**
	 * 폐업하지 않은 가맹점 중 해당 교육 받지 않은 가맹점 리스트
	 * @param ednPrgrmVO 교육 프로그램 번호 담은 vo
	 * @return 해당하는 가맹점 리스트
	 */
	@ResponseBody
	@PostMapping("/getTrnFrcList")
	public List<FranchiseVO> getTrnFrcList(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 ednPrgrmVO : "+ednPrgrmVO);
		
		List<FranchiseVO> trnFrcList = this.ednCndtnService.getTrnFrcList(ednPrgrmVO);
		log.debug("trnFrcList : "+trnFrcList);
		
		return trnFrcList;
	}
	
	/**
	 * 가맹점주가 본인 교육 조회 화면 이동
	 * @param model
	 * @param principal
	 * @return
	 */
	@GetMapping("/trnList")
	public String trnList(Model model, Principal principal) {
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		String empNo = emp.getEmpNo();
		log.info("로그인 한 empNo : " + empNo);
		
		List<EdnCndtnVO> ednCndtnList = this.ednCndtnService.trnList(empNo);
		log.debug("ednCndtnList : " + ednCndtnList);
		
		Map<String, String> mapN = new HashMap<String, String>();
		mapN.put("ecYn", "N");
		mapN.put("empNo", empNo);
		Map<String, String> mapY = new HashMap<String, String>();
		mapY.put("ecYn", "Y");
		mapY.put("empNo", empNo);
		Map<String, String> mapF = new HashMap<String, String>();
		mapF.put("ecYn", "F");
		mapF.put("empNo", empNo);
		
		int cntN = this.ednCndtnService.myEcYnfCnt(mapN);
		int cntY = this.ednCndtnService.myEcYnfCnt(mapY);
		int cntF = this.ednCndtnService.myEcYnfCnt(mapF);
		log.debug("이수현황서머리 : "+cntN+", "+cntY+", "+cntF);
		
		model.addAttribute("ednCndtnList", ednCndtnList);
		model.addAttribute("cntN", cntN);
		model.addAttribute("cntY", cntY);
		model.addAttribute("cntF", cntF);
		
		return "openmng/trnList";
	}

}
