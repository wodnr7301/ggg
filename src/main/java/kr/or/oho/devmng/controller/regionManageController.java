package kr.or.oho.devmng.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.oho.openmng.service.FrcService;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.FranchiseVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 영업 지역 관리 컨트롤러
 * @author PC-08
 */
@Slf4j
@RequestMapping("/region")
@Controller
public class regionManageController {
	
	@Autowired
	FrcService frcService;
	
	/**
	 * 영업 지역 통계 화면 이동
	 * @param model
	 */
	@GetMapping("/list")
	public String list(Model model) {
		
		List<FranchiseVO> frcsVORegionList = this.frcService.frcsRegionList();
		log.debug("frcsVORegionList : "+frcsVORegionList);
		
		List<ComcdVO> countRegionList = this.frcService.countRegion();
		log.debug("countRegionList : "+countRegionList);
		
		List<ComcdVO> countRegionYearList = this.frcService.countRegionYear();
		log.debug("countRegionYearList : "+countRegionYearList);
		
		model.addAttribute("frcsVORegionList", frcsVORegionList);
		model.addAttribute("countRegionList", countRegionList);
		model.addAttribute("countRegionYearList", countRegionYearList);
		
		return "devmng/region";
	}
	
	

}
