package kr.or.oho.openmng.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.openmng.service.EdnCndtnService;
import kr.or.oho.openmng.service.EdnPrgrmService;
import kr.or.oho.vo.EdnPrgrmVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 교육프로그램 관리 컨트롤러
 * @author PC-08
 */
@Slf4j
@RequestMapping("/trnMng")
@Controller
public class TrnMngController {
	
	@Autowired
	EdnPrgrmService ednPrgrmService;
	
	@Autowired
	EdnCndtnService ednCndtnService;
	
	/**
	 * 교육 훈련 리스트 화면 이동
	 * @param model
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model) {
		List<EdnPrgrmVO> ednPrgrmList = this.ednPrgrmService.list();
		log.debug("ednPrgrmList : "+ednPrgrmList);
		
		List<EdnPrgrmVO> epEcYCntList = this.ednCndtnService.epEcYCnt();
		log.debug("epEcYCntList : "+epEcYCntList);
		
		for (EdnPrgrmVO ednPrgrmVO : ednPrgrmList) {
			for (EdnPrgrmVO epEcYCntVO : epEcYCntList) {
				if(ednPrgrmVO.getEpNo().equals(epEcYCntVO.getEpNo())) {
					ednPrgrmVO.setEpEcYCnt(epEcYCntVO.getEpEcYCnt());
				}
			}
		}
		
		model.addAttribute("ednPrgrmList", ednPrgrmList);
		
		return "openmng/trnMng";
	}
	
	/**
	 * 신규 교육프로그램 등록 처리
	 * @param ednPrgrmVO
	 * @return String 등록 처리 성공 여부
	 */
	@ResponseBody
	@PostMapping("/add")
	public String addAjax(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 ednPrgrmVO : "+ednPrgrmVO);
		
		int result = this.ednPrgrmService.add(ednPrgrmVO);
		log.debug("교육프로그램 등록 결과 : " + result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 교육프로그램 삭제 처리
	 * @param ednPrgrmVO
	 * @return String 삭제 처리 성공 여부
	 */
	@ResponseBody
	@PostMapping("/delete")
	public String deleteAjax(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 epNo : "+ednPrgrmVO.getEpNo());
		
		int result = this.ednPrgrmService.delete(ednPrgrmVO);
		log.debug("교육프로그램 삭제 결과 : " + result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 교육프로그램정보 변경 처리
	 * @param ednPrgrmVO
	 * @return String 변경 처리 성공 여부
	 */
	@ResponseBody
	@PostMapping("/update")
	public String updateAjax(@RequestBody EdnPrgrmVO ednPrgrmVO) {
		log.debug("입력값 ednPrgrmVO : "+ednPrgrmVO);
		
		int result = this.ednPrgrmService.update(ednPrgrmVO);
		log.debug("교육프로그램 정보수정 결과 : " + result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}

}
