package kr.or.oho.frcorder.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.vo.CartDtlVO;
import kr.or.oho.vo.CartVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.FrcsStockVO;
import kr.or.oho.vo.GdsVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/frcorder")
public class FrcorderController {
	
	 @Autowired
	 private EmployeeMapper employeeMapper;
	
	@Autowired
	FrcorderService frcorderService;
	
	/**
	 * 가맹점 발주 페이지 
	 * @param comcdVO
	 * @param model
	 * @param principal(로그인 회원 정보가져오기)
	 */
	@GetMapping("/create")
	public String getAllLoc(ComcdVO comcdVO, Model model, Principal principal) {
		log.info("getAllLoc로 왔다");
		
		// 모든 식재료 구분
		List<ComcdVO> gdsGuList = this.frcorderService.getAllGdsGu();
		log.info("gdsGuList -> gdsGuList : " + gdsGuList);
		
		// 모든 식재료 정보 가져오기
		List<GdsVO> gdsVOList = this.frcorderService.getAllGds(comcdVO);
		log.info("gdsVOList : " + gdsVOList);
		
		// 발주계획 가져오기
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.debug("로그인한 정보 emp : " + emp);
		String empNo = emp.getEmpNo();
		
		// 해당 사원의 가맹점 정보 가져오기
		FranchiseVO getFranchiseVO = this.frcorderService.getFranchise(empNo);
		log.debug("getFranchiseVO : " + getFranchiseVO);
		
		// 미달품목 가져오기
		List<FrcsStockVO> insufStockList = new ArrayList<FrcsStockVO>();
		List<FrcsStockVO> insufStockList1 = this.frcorderService.getAllStock();
		log.debug("insufStockList1 : " +insufStockList1);
		
		for (FrcsStockVO frcsStockVO : insufStockList1) {
			if(frcsStockVO.getFrcssCnt() < frcsStockVO.getMinGdsStock()) {
				insufStockList.add(frcsStockVO);
			}
		}
		log.debug("insufStockList : " +insufStockList);
		
		model.addAttribute("gdsVOList", gdsVOList);
		model.addAttribute("gdsGuList", gdsGuList);
		model.addAttribute("getFranchiseVO", getFranchiseVO);
		model.addAttribute("insufStockList", insufStockList);
		
		return "frcorder/create";
	}
	
	
	/**
	 * 모든 식재료 정보 가져오기
	 * @param comcdVO.comcdGroupcd(식재료 구분 공통코드 번호)
	 * @return List<GdsVO>
	 */
	@ResponseBody
	@PostMapping("/getAllGds")
	public List<GdsVO> getAllGds(@RequestBody ComcdVO comcdVO){
		log.info("getAllGds로 왔다");
		log.info("getAllGds -> comcdVO : " + comcdVO);
		
		// 모든 식재료 정보 가져오기 or comcdVO(구분코드)가 있으면 일치하는 식재료 정보 가져오기
		List<GdsVO> gdsVOList = this.frcorderService.getAllGds(comcdVO);
		log.info("gdsVOList : " + gdsVOList);
		
		
		return gdsVOList;
	}
	
	/**
	 * 모든 지역 정보 가져오기
	 * @param comcdVO
	 * @return frcNmList(가맹점 이름 리스트) 
	 */
	@ResponseBody
	@PostMapping("/locFrn")
	public List<FranchiseVO> locFrn(@RequestBody ComcdVO comcdVO){
		log.info("locFrn로 왔다");
		log.info("locFrn -> comcdVO : " + comcdVO);
		
		// 모든 지역 정보 가져오기 or comcdVO(구분코드)가 있으면 일치하는 지역 정보 가져오기
		List<FranchiseVO> frcNmList = this.frcorderService.locFrn(comcdVO);
		log.info("frcNmList : " + frcNmList);
		
		
		return frcNmList;
	}
	
	/**
	 * 가맹점 발주 상세 정보 가져오기
	 * @param franchiseVO.frcsNo(가맹점 번호)
	 * @return List<FrcOrderVO>
	 */
	@ResponseBody
	@PostMapping("/getFrcGdsDtl")
	public List<FrcOrderVO> getFrcGdsDtl(@RequestBody FrcOrderVO frcOrderVO){
		log.info("getFrcGdsDtl로 왔다");
		log.info("getFrcGdsDtl -> frcOrderVO : " + frcOrderVO);
		
		// 가맹점 발주 상세 정보 가져오기
		List<FrcOrderVO> getFrcVOList = this.frcorderService.getFrcGdsDtl(frcOrderVO);
		log.info("getFrcVOList : " + getFrcVOList);
		
		
		return getFrcVOList;
	}
	
	/**
	 * 발주 등록(insert) 하기
	 * @param frcOrderVO
	 */
	@PostMapping("/createPost")
	public String createPost(FrcOrderVO frcOrderVO) {
		log.info("createPost로 왔다");
		log.info("createPost -> frcOrderVO : " + frcOrderVO);
		
		// jsp에서 넘어온 값 전달 후 insert 실행
		int result = this.frcorderService.createPost(frcOrderVO);
		log.info("result : " + result);
		
		return "redirect:/frcorder/create";
	}
	
	////////////////////////////////////// list 페이지 ///////////////////////////////////////////
	
	/**
	 * 가맹점 발주 조회 및 내역 페이지
	 * @param frcOrderVO
	 * @param model
	 * @param principal
	 * @return
	 */
	@GetMapping("/list")
	public String getAllFrcorder(FrcOrderVO frcOrderVO, Model model, Principal principal) {
		log.info("getAllFrcorder로 왔다");
		
		// 로그인 회원 정보를 이용 정보 가져오기
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		String empNo = emp.getEmpNo();
		String frcsNo = this.frcorderService.getFrcsNo(empNo);
		log.info("frcsNo : " + frcsNo);
		List<FrcOrderVO> frcorderVOList = new ArrayList<FrcOrderVO>();
		List<FrcOrderVO> frcorderVOList2 = this.frcorderService.getAllFrcorder(frcOrderVO);
		log.info("frcorderVOList2 : " + frcorderVOList2);
		
		// 발주 진행상태 카운트
		int conuntN = 0;
		int conuntA = 0;
		int conuntD = 0;
		int conuntF = 0;
		int conuntE = 0;
		for (FrcOrderVO frcOrderVO2 : frcorderVOList2) {
			if (frcsNo.equals(frcOrderVO2.getFrcsNo())) {
				frcorderVOList.add(frcOrderVO2);
				if (frcOrderVO2.getFoPrcsYn().equals("N")) {
					conuntN++;
				} else if (frcOrderVO2.getFoPrcsYn().equals("A")) {
					conuntA++;
				} else if (frcOrderVO2.getFoPrcsYn().equals("D")) {
					conuntD++;
				} else if (frcOrderVO2.getFoPrcsYn().equals("F")) {
					conuntF++;
				} else {
					conuntE++;
				}
			}
		}
		log.info("frcorderVOList : " + frcorderVOList);
		log.info("conuntN : " + conuntN);
		log.info("conuntA : " + conuntA);
		log.info("conuntD : " + conuntD);
		log.info("conuntF : " + conuntF);
		log.info("conuntE : " + conuntE);
		
		
		model.addAttribute("conuntN", conuntN);
		model.addAttribute("conuntA", conuntA);
		model.addAttribute("conuntD", conuntD);
		model.addAttribute("conuntF", conuntF);
		model.addAttribute("conuntE", conuntE);
		model.addAttribute("frcorderVOList", frcorderVOList);
		
		return "frcorder/list";
	}
	
	/**
	 * 진행상태 별 발주 내역
	 * @param frcOrderVO
	 * @param principal
	 */
	@ResponseBody
	@PostMapping("/getSelFrcorder")
	public List<FrcOrderVO> getSelFrcorder(@RequestBody FrcOrderVO frcOrderVO, Principal principal) {
		log.info("getSelFrcorder로 왔다");
		log.info("getSelFrcorder -> frcOrderVO : " + frcOrderVO);
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		String empNo = emp.getEmpNo();
		String frcsNo = this.frcorderService.getFrcsNo(empNo);
		log.info("frcsNo : " + frcsNo);
		
		// 해당 가맹점 발주 내역 가져오기
		List<FrcOrderVO> frcorderVOList = new ArrayList<FrcOrderVO>();
		List<FrcOrderVO> getSelFrcorderList = this.frcorderService.getAllFrcorder(frcOrderVO);
		log.info("getSelFrcorderList : " + getSelFrcorderList);
		for (FrcOrderVO frcOrderVO2 : getSelFrcorderList) {
			if(frcsNo.equals(frcOrderVO2.getFrcsNo())) {
				frcorderVOList.add(frcOrderVO2);
			}
		}
		
		return frcorderVOList;
	}
	
	/**
	 * 거래 상세 내역
	 * @param frcOrderVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getfrcOrderDtl")
	public List<FrcOrderDtlVO> getfrcOrderDtl(@RequestBody FrcOrderVO frcOrderVO) {
		log.info("getfrcOrderDtl로 왔다");
		log.info("getfrcOrderDtl -> hdorderDtlVO : " + frcOrderVO);
		
		// 거래 상세 내역 가져오기
		List<FrcOrderDtlVO> getfrcorderDtlList = this.frcorderService.getfrcOrderDtl(frcOrderVO);
		log.info("getfrcOrderDtl -> getfrcorderDtlList : " + getfrcorderDtlList);
		
		return getfrcorderDtlList;
	}
	
	/**
	 * 제거 + toast 기능
	 * @param frcOrderVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deleteFrcOrder")
	public int deleteFrcOrder(@RequestBody FrcOrderVO frcOrderVO) {
		log.info("deleteFrcOrder로 왔다");
		log.info("deleteFrcOrder -> frcOrderVO : " + frcOrderVO);
		
		// delete 실행
		int result = this.frcorderService.deleteFrcOrder(frcOrderVO);
		log.info("result : " + result);
		
		return result;
	}
	
	/**
	 * 제거 후 전체 리스트 가져오기
	 * @param result
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping("/listAjax")
	public List<FrcOrderVO> listAjax(@RequestBody String result, Principal principal) {
		log.info("listAjax로 왔다");
		log.info("listAjax -> result : " + result);
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		String empNo = emp.getEmpNo();
		String frcsNo = this.frcorderService.getFrcsNo(empNo);
		log.info("frcsNo : " + frcsNo);
		
		// 해당 가맹점 발주 내역 가져오기
		List<FrcOrderVO> frcorderVOList = new ArrayList<FrcOrderVO>();
		List<FrcOrderVO> getSelFrcorderList = this.frcorderService.getAllFrcorder();
		log.info("getSelFrcorderList : " + getSelFrcorderList);
		for (FrcOrderVO frcOrderVO2 : getSelFrcorderList) {
			if(frcsNo.equals(frcOrderVO2.getFrcsNo())) {
				frcorderVOList.add(frcOrderVO2);
			}
		}
		return frcorderVOList;
	}
	
	/**
	 * 입고 처리 시 재고 수 증가
	 * @param gdsList
	 * @return
	 */
	@ResponseBody
	@PostMapping("/updateSave")
	public int updateSave(@RequestBody List<Map<String, Object>> gdsList) {
		log.info("updateSave로 왔다");
		log.info("updateSave -> gdsList : " + gdsList);
		
		int result = this.frcorderService.updateSave(gdsList);
		log.info("result : " + result);
		
		return result;
	}
	
	////////////////////////////////////// stockMng 페이지 ///////////////////////////////////////////
	
	/**
	 * 재고관리 페이지
	 * @param model
	 * @param principal
	 * @param comcdVO
	 */
	@GetMapping("/stockMng")
	public String stockMng(Model model, Principal principal, ComcdVO comcdVO) {
		log.info("stockMng에 왔다");
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		String empNo = emp.getEmpNo();
		String frcsNo = this.frcorderService.getFrcsNo(empNo);
		log.info("frcsNo : " + frcsNo);
		
		//////////////////////// 현 재고 수량과 최소 재고 수량을 가져와서 미달 수량 및 재고 금액 구하기 시작 ////////////////////////
		int needStock = 0;
		int countA = 0;
		int countTotalA = 0;
		int countTotalPriceA = 0;
		
		int countB = 0;
		int countTotalB = 0;
		int countTotalPriceB = 0;
		
		int countC = 0;
		int countTotalC = 0;
		int countTotalPriceC = 0;
		
		int countD = 0;
		int countTotalD = 0;
		int countTotalPriceD = 0;
		
		int countE = 0;	
		int countTotalE = 0;
		int countTotalPriceE = 0;
		
		comcdVO.setFrcsNo(frcsNo);
		List<FrcsStockVO> frcsStockVOList = this.frcorderService.getAllStock(comcdVO);
		log.debug("frcsStockVOList : " + frcsStockVOList);
		
		for (FrcsStockVO frcsStockVO : frcsStockVOList) {
		    if (frcsStockVO.getFrcssCnt() < frcsStockVO.getMinGdsStock()) {
		        needStock++;
		    }
		    if((frcsStockVO.getComcdCdnm()).equals("채소류")) {
		    	countTotalPriceA +=  frcsStockVO.getFrcssCnt() *  frcsStockVO.getGdsNtslAmt();
		    	countTotalA += frcsStockVO.getFrcssCnt();
				countA++;
			}
			if((frcsStockVO.getComcdCdnm()).equals("과일류")) {
				countTotalPriceB +=  frcsStockVO.getFrcssCnt() *  frcsStockVO.getGdsNtslAmt();
				countTotalB += frcsStockVO.getFrcssCnt();
				countB++;
			}
			if((frcsStockVO.getComcdCdnm()).equals("육류")) {
				countTotalPriceC +=  frcsStockVO.getFrcssCnt() *  frcsStockVO.getGdsNtslAmt();
				countTotalC += frcsStockVO.getFrcssCnt();
				countC++;
			}
			if((frcsStockVO.getComcdCdnm()).equals("어패류")) {
				countTotalPriceD +=  frcsStockVO.getFrcssCnt() *  frcsStockVO.getGdsNtslAmt();
				countTotalD += frcsStockVO.getFrcssCnt();
				countD++;
			}
			if((frcsStockVO.getComcdCdnm()).equals("기타 식품")) {
				countTotalPriceE +=  frcsStockVO.getFrcssCnt() *  frcsStockVO.getGdsNtslAmt();
				countTotalE += frcsStockVO.getFrcssCnt();
				countE++;
			}
		}
		
		int countTotal = countTotalA + countTotalB + countTotalC + countTotalD + countTotalE;
		int countTotalPrice = countTotalPriceA + countTotalPriceB + countTotalPriceC + countTotalPriceD + countTotalPriceE;
		
		////////////////////////현 재고 수량과 최소 재고 수량을 가져와서 미달 수량 및 재고 금액 구하기 끝 ////////////////////////
		
		// 모든 식재료 구분
		List<ComcdVO> gdsGuList = this.frcorderService.getAllGdsGu();
		log.info("gdsGuList -> gdsGuList : " + gdsGuList);
		
		log.debug("countA : " + countA);
		log.debug("countB : " + countB);
		log.debug("countC : " + countC);
		log.debug("countD : " + countD);
		log.debug("countE : " + countE);
		
		log.debug("countTotalA : " + countTotalA);
		log.debug("countTotalB : " + countTotalB);
		log.debug("countTotalC : " + countTotalC);
		log.debug("countTotalD : " + countTotalD);
		log.debug("countTotalE : " + countTotalE);
		log.debug("countTotal : " + countTotal);
		
		log.debug("countTotalA : " + countTotalPriceA);
		log.debug("countTotalB : " + countTotalPriceB);
		log.debug("countTotalC : " + countTotalPriceC);
		log.debug("countTotalD : " + countTotalPriceD);
		log.debug("countTotalE : " + countTotalPriceE);
		log.debug("countTotal : " + countTotalPrice);
		
		model.addAttribute("frcsStockVOList", frcsStockVOList);
		model.addAttribute("gdsGuList", gdsGuList);
		
		// 구분종류 수 
		model.addAttribute("countA", countA);
		model.addAttribute("countB", countB);
		model.addAttribute("countC", countC);
		model.addAttribute("countD", countD);
		model.addAttribute("countE", countE);
		
		// 유형별 재고 수
		model.addAttribute("countTotalA",countTotalA);
		model.addAttribute("countTotalB",countTotalB);
		model.addAttribute("countTotalC",countTotalC);
		model.addAttribute("countTotalD",countTotalD);
		model.addAttribute("countTotalE",countTotalE);
		model.addAttribute("countTotal",countTotal);
		
		// 유형별 재고 총 금액
		model.addAttribute("countTotalPriceA",countTotalPriceA);
		model.addAttribute("countTotalPriceB",countTotalPriceB);
		model.addAttribute("countTotalPriceC",countTotalPriceC);
		model.addAttribute("countTotalPriceD",countTotalPriceD);
		model.addAttribute("countTotalPriceE",countTotalPriceE);
		model.addAttribute("countTotalPrice",countTotalPrice);
		
		model.addAttribute("frcsNo", frcsNo);
		model.addAttribute("needStock", needStock);
		
		return "frcorder/stockMng";
	}

	/**
	 * 모든 재고 정보 가져오기
	 * @param comcdVO
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getAllGdsGu")
	public List<FrcsStockVO> getAllGdsGu(@RequestBody ComcdVO comcdVO, Model model) {
		
		List<FrcsStockVO> frcsStockVOList = this.frcorderService.getAllStock(comcdVO);
		log.debug("frcsStockVOList : " + frcsStockVOList);
		
		return frcsStockVOList;
	}
		
	/**
	 * 미달 수량 품목 가져오기
	 * @param param
	 * @return
	 */
	@ResponseBody
	@PostMapping("/insufStock")
	public List<FrcsStockVO> insufStock(@RequestBody String param) {
		
		log.debug("param : " + param);
		
		List<FrcsStockVO> insufStockList = new ArrayList<FrcsStockVO>();
		List<FrcsStockVO> frcsStockVOList = this.frcorderService.getAllStock();
		log.debug("frcsStockVOList : " +frcsStockVOList);
		
		for (FrcsStockVO gdsVO : frcsStockVOList) {
			if(gdsVO.getFrcssCnt() < gdsVO.getMinGdsStock()) {
				insufStockList.add(gdsVO);
			}
		}
		return insufStockList;
	}
}
