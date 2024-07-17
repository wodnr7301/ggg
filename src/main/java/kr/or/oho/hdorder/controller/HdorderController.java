package kr.or.oho.hdorder.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.hdorder.service.HdorderService;
import kr.or.oho.vo.CnptVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.FrcsStockVO;
import kr.or.oho.vo.GdsVO;
import kr.or.oho.vo.HdorderDtlVO;
import kr.or.oho.vo.HdorderVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/hdorder")
public class HdorderController {
	
	@Autowired
	HdorderService hdorderService;
	
	@Autowired
	FrcorderService frcorderService;
	
	
	// 거래처 리스트
	@GetMapping("/create")
	public String create(HdorderVO hdorderVO, FrcOrderVO frcOrderVO, Model model) {
		log.info("create로 왔다");
		// 거래처 정보가져오기
		List<CnptVO> cnptVOList = this.hdorderService.getCntpInfo();
		log.info("create -> cnptVOList : " + cnptVOList);
		
		frcOrderVO.setFoPrcsYn("D");
		log.info("frcOrderVO : " + frcOrderVO);
		List<FrcOrderVO> frcorderVOList = this.frcorderService.getAllFrcorder(frcOrderVO);
		log.info("frcorderVOList : " + frcorderVOList);
		
		// 입고창고 가져오기
		List<ComcdVO> getAllWrhsList = this.hdorderService.getAllWrhs();
		log.info("getAllWrhsList : " + getAllWrhsList);
		
		// 미달품목 가져오기
		List<GdsVO> insufStockList = new ArrayList<GdsVO>();
		List<GdsVO> gdsVOList = this.hdorderService.getAllStock();
		log.debug("gdsVOList : " +gdsVOList);
		
		for (GdsVO gdsVO : gdsVOList) {
			if(gdsVO.getGdsStock() < gdsVO.getMinGdsStock()) {
				insufStockList.add(gdsVO);
			}
		}
		log.debug("insufStockList : " +insufStockList);
		
		model.addAttribute("cnptVOList", cnptVOList);
		model.addAttribute("getAllWrhsList", getAllWrhsList);
		model.addAttribute("frcorderVOList", frcorderVOList);
		model.addAttribute("insufStockList", insufStockList);
		return "hdorder/create";
	}
	
		// create 페이지 주문버튼 관련 메소드
		@ResponseBody
		@PostMapping("/getOrderDetail")
		public List<FrcOrderDtlVO> getOrderDetail(@RequestBody FrcOrderVO frcOrderVO) {
			log.info("getOrderDetail로 왔다");
			log.info("getOrderDetail -> frcOrderVO : " + frcOrderVO);
			
			List<FrcOrderDtlVO> frcOrderDtlVOList = this.hdorderService.getOrderDetail(frcOrderVO);
			log.info("frcOrderDtlVOList : " + frcOrderDtlVOList);
			
			return frcOrderDtlVOList;
		}
	
	/**
	 * @param cnptVO
	 * @return 거래처별 품목 리스트
	 */
	@ResponseBody
	@PostMapping("/getCnptGds")
	public List<GdsVO> getCnptGds(@RequestBody CnptVO cnptVO) {
		log.info("getCnptGds로 왔다");
		log.info("getCnptGds -> cnptVO : " + cnptVO);
		
		List<GdsVO> cnptGdsList = this.hdorderService.getCnptGds(cnptVO);
		log.info("getCnptGds -> cnptGdsList : " + cnptGdsList);
		
		return cnptGdsList;
	}
	
	/**
	 * @param hdorderDtlVO
	 * @return 거래처별 거래내역 리스트
	 */
	@ResponseBody
	@PostMapping("/getOrderDt")
	public List<HdorderVO> getOrderDt(@RequestBody HdorderDtlVO hdorderDtlVO) {
		log.info("getOrderDt로 왔다");
		log.info("getOrderDt -> hdorderDtlVO : " + hdorderDtlVO);
		
		List<HdorderVO> orderDtList = this.hdorderService.getOrderDt(hdorderDtlVO);
		log.info("getOrderDt -> orderDtList : " + orderDtList);
		
		return orderDtList;
	}
	
//	list 페이지 발주내역
	@ResponseBody
	@PostMapping("/getOrderDt2")
	public List<HdorderDtlVO> getOrderDt2(@RequestBody HdorderVO hdorderVO) {
		log.info("getOrderDt2로 왔다");
		log.info("getOrderDt2 -> hdorderVO : " + hdorderVO);
		
		List<HdorderDtlVO> orderDtList2 = this.hdorderService.getOrderDt2(hdorderVO);
		log.info("getOrderDt2 -> orderDtList2 : " + orderDtList2);
		
		return orderDtList2;
	}
	
	@PostMapping("/createPost")
	public String createPost(HdorderVO hdorderVO) {
		log.info("createPost로 왔다");
		log.info("createPost -> hdorderVO : " + hdorderVO);
		
		int result = this.hdorderService.createPost(hdorderVO);
		log.info("result : " + result);
		
		return "redirect:/hdorder/create";
	}
	
	@ResponseBody
	@PostMapping("/deleteHdorder")
	public int deleteHdorder(@RequestBody HdorderVO hdorderVO) {
		log.info("deleteHdorder로 왔다");
		log.info("deleteHdorder -> hdorderVO : " + hdorderVO);
		
		int result = this.hdorderService.deleteHdorder(hdorderVO);
		log.info("result : " + result);
		
		return result;
	}
	
	////////////////////////////////////////////List 페이지/////////////////////////////
	
	//	발주별 담당자
	@GetMapping("/list")
	public String getHdorderEmp(HdorderVO hdorderVO, Model model) {
		log.info("getHdorderEmp로 왔다");
		
		int conuntI = 0;
		int conuntY = 0;
		int conuntN = 0;
		int conuntE = 0;
		
		List<HdorderVO> hdordeVOList = this.hdorderService.getAllHdorder(hdorderVO);
		log.info("hdordeVOList : " + hdordeVOList);
		
		for (HdorderVO hdorderVO2 : hdordeVOList) {
			if (hdorderVO2.getHoPrcsYn().equals("N")) {
				conuntN++;
			} else if (hdorderVO2.getHoPrcsYn().equals("I")) {
				conuntI++;
			} else if (hdorderVO2.getHoPrcsYn().equals("Y")) {
				conuntY++;
			} else if (hdorderVO2.getHoPrcsYn().equals("E")) {
				conuntE++;
			}
		}
		
		model.addAttribute("hdordeVOList", hdordeVOList);
		model.addAttribute("conuntN", conuntN);
		model.addAttribute("conuntI", conuntI);
		model.addAttribute("conuntY", conuntY);
		model.addAttribute("conuntE", conuntE);
		
		return "hdorder/list";
	}
	
	//	발주별 담당자
	@ResponseBody
	@PostMapping("/listAjax")
	public List<HdorderVO> listAjax(@RequestBody String result) {
		log.info("listAjax로 왔다");
		log.info("listAjax -> result : " + result);
		
		List<HdorderVO> hdordeVOList2 = this.hdorderService.getAllHdorder();
		log.info("hdordeVOList2 : " + hdordeVOList2);
		
		return hdordeVOList2;
	}
	
	//	진행상태 별 발주 내역
	@ResponseBody
	@PostMapping("/getAllHdorder")
	public List<HdorderVO> getAllHdorder(@RequestBody HdorderVO hdorderVO) {
		log.info("getAllHdorder로 왔다");
		log.info("getAllHdorder -> hdorderVO : " + hdorderVO);
		
		List<HdorderVO> getAllHdorderList = this.hdorderService.getAllHdorder(hdorderVO);
		log.info("getAllHdorderList : " + getAllHdorderList);
		
		return getAllHdorderList;
	}

	////////////////////////////////// 수주관리 페이지 //////////////////////////////////
	@GetMapping("/contract")
	public String getAllFrcorder(FrcOrderVO frcOrderVO, Model model) {
		log.info("getAllFrcorder로 왔다");
		
		List<FrcOrderVO> frcorderVOList = this.hdorderService.getAllFrcorder(frcOrderVO);
		log.info("frcorderVOList2 : " + frcorderVOList);
		
		int conuntN = 0;
		int conuntA = 0;
		int conuntD = 0;
		int conuntF = 0;
		int conuntE = 0;
	
		
		for (FrcOrderVO frcOrderVO2 : frcorderVOList) {
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
		int countEF = conuntE + conuntF;
		
		// 모든 지역 정보
		List<ComcdVO> locationVOList = this.frcorderService.getAllLoc();
		log.info("locationVOList -> locationVOList : " + locationVOList);
		
		model.addAttribute("frcorderVOList", frcorderVOList);
		model.addAttribute("locationVOList", locationVOList);
		model.addAttribute("conuntN", conuntN);
		model.addAttribute("conuntA", conuntA);
		model.addAttribute("conuntD", conuntD);
		model.addAttribute("countEF", countEF);
		
		return "hdorder/contract";
	}
	
	//	진행상태 별 발주 내역
	@ResponseBody
	@PostMapping("/getSelFrcorder")
	public List<FrcOrderVO> getSelFrcorder(@RequestBody FrcOrderVO frcOrderVO) {
		log.info("getSelFrcorder로 왔다");
		
		List<FrcOrderVO> getSelFrcorderList = this.hdorderService.getAllFrcorder(frcOrderVO);
		log.info("getSelFrcorderList : " + getSelFrcorderList);
		
		return getSelFrcorderList;
	}
	
	// 거래 상세 내역
	@ResponseBody
	@PostMapping("/getfrcOrderDtl")
	public List<FrcOrderDtlVO> getfrcOrderDtl(@RequestBody FrcOrderVO frcOrderVO) {
		log.info("getfrcOrderDtl로 왔다");
		log.info("getfrcOrderDtl -> frcOrderVO : " + frcOrderVO);
		
		List<FrcOrderDtlVO> getfrcorderDtlList = this.hdorderService.getfrcOrderDtl(frcOrderVO);
		log.info("getfrcOrderDtl -> getfrcorderDtlList : " + getfrcorderDtlList);
		
		return getfrcorderDtlList;
	}
	
	// 승인 / 반려 여부
	@ResponseBody
	@PostMapping("/updateYn")
	public int updateYn(@RequestBody FrcOrderVO frcOrderVO) {
		log.info("updateYn로 왔다");
		log.info("updateYn -> frcOrderVO : " + frcOrderVO);
		
		int result = this.hdorderService.updateYn(frcOrderVO);
		log.info("result : " + result);
		
		return result;
	}
	
	// 
	@ResponseBody
	@PostMapping("/updateSave")
	public int updateSave(@RequestBody List<Map<String, Object>> gdsList) {
		log.info("updateSave로 왔다");
		log.info("updateSave -> gdsList : " + gdsList);
		
		int result = this.hdorderService.updateSave(gdsList);
		log.info("result : " + result);
		
		return result;
	}
	
	//////////////////////////////재고 관리 페이지/////////////////////////////
	@GetMapping("/stockMng")
	public String stockMng(Model model) {
		
		int needStock = 0;
		int countA = 0;
		// 해당 품목의 재고수
		int countTotalA = 0;
		// 해당 품목의 금액
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
		
		List<GdsVO> gdsVOList = this.hdorderService.getAllStock();
		log.debug("gdsVOList : " + gdsVOList);
		
		Set<String> wrhsNoSet = new HashSet<>();

		for (GdsVO gdsVO : gdsVOList) {
		    if (gdsVO.getGdsStock() < gdsVO.getMinGdsStock()) {
		        needStock++;
		    }
		    
		    // 중복된 wrhsNo가 없는 경우에만 Set에 추가
		    if (gdsVO.getWrhsNo() != null && !gdsVO.getWrhsNo().isEmpty()) {
		        wrhsNoSet.add(gdsVO.getWrhsNo());
		    }
		    
		    if((gdsVO.getComcdCdnm()).equals("채소류")) {
		    	countTotalPriceA +=  gdsVO.getGdsStock() *  gdsVO.getGdsPrchsAmt();
		    	countTotalA += gdsVO.getGdsStock();
				countA++;
			}
			if((gdsVO.getComcdCdnm()).equals("과일류")) {
				countTotalPriceB +=  gdsVO.getGdsStock() *  gdsVO.getGdsPrchsAmt();
		    	countTotalB += gdsVO.getGdsStock();
				countB++;
			}
			if((gdsVO.getComcdCdnm()).equals("육류")) {
				countTotalPriceC +=  gdsVO.getGdsStock() *  gdsVO.getGdsPrchsAmt();
		    	countTotalC += gdsVO.getGdsStock();
				countC++;
			}
			if((gdsVO.getComcdCdnm()).equals("어패류")) {
				countTotalPriceD +=  gdsVO.getGdsStock() *  gdsVO.getGdsPrchsAmt();
		    	countTotalD += gdsVO.getGdsStock();
				countD++;
			}
			if((gdsVO.getComcdCdnm()).equals("기타 식품")) {
				countTotalPriceE +=  gdsVO.getGdsStock() *  gdsVO.getGdsPrchsAmt();
		    	countTotalE += gdsVO.getGdsStock();
				countE++;
			}
		}

		int countTotal = countTotalA + countTotalB + countTotalC + countTotalD + countTotalE;
		int countTotalPrice = countTotalPriceA + countTotalPriceB + countTotalPriceC + countTotalPriceD + countTotalPriceE;
		
		log.debug("wrhsNoSet: " + wrhsNoSet); // 원하는 방식으로 로그 출력
		// Set에 담긴 wrhsNo 확인
		for (String wrhsNo : wrhsNoSet) {
		    log.debug("wrhsNo: " + wrhsNo); // 원하는 방식으로 로그 출력
		}
		
		
		// 모든 식재료 구분
		List<ComcdVO> gdsGuList = this.frcorderService.getAllGdsGu();
		log.info("gdsGuList -> gdsGuList : " + gdsGuList); 
		
		model.addAttribute("gdsVOList", gdsVOList);
		model.addAttribute("gdsGuList", gdsGuList);
		model.addAttribute("needStock", needStock);
		model.addAttribute("wrhsNoSet", wrhsNoSet);
		
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
		
		return "hdorder/stockMng";
	}
	
	@ResponseBody
	@PostMapping("/locFrn")
	public List<FranchiseVO> locFrn(@RequestBody ComcdVO comcdVO){
		log.info("locFrn로 왔다");
		log.info("locFrn -> comcdVO : " + comcdVO);
		
		List<FranchiseVO> frcNmList = this.hdorderService.locFrn(comcdVO);
		log.info("frcNmList : " + frcNmList);
		
		
		return frcNmList;
	}
	
	@ResponseBody
	@PostMapping("/getAllGdsGu")
	public List<GdsVO> getAllGdsGu(@RequestBody ComcdVO comcdVO, Model model) {
		
		List<GdsVO> gdsVOList = this.hdorderService.getAllStock(comcdVO);
		log.debug("gdsVOList : " + gdsVOList);
		
		return gdsVOList;
	}
	
	@ResponseBody
	@PostMapping("/getWrhsGds")
	public List<GdsVO> getWrhsGds(@RequestBody GdsVO gdsVO) {
		
		log.debug("gdsVO : " + gdsVO);
		
		List<GdsVO> getWrhsGdsList = this.hdorderService.getWrhsGds(gdsVO);
		log.debug("getWrhsGdsList : " +getWrhsGdsList);
		
		return getWrhsGdsList;
	}
	
	@ResponseBody
	@PostMapping("/insufStock")
	public List<GdsVO> insufStock(@RequestBody String param) {
		
		log.debug("param : " + param);
		
		List<GdsVO> insufStockList = new ArrayList<GdsVO>();
		List<GdsVO> gdsVOList = this.hdorderService.getAllStock();
		log.debug("gdsVOList : " +gdsVOList);
		
		for (GdsVO gdsVO : gdsVOList) {
			if(gdsVO.getGdsStock() < gdsVO.getMinGdsStock()) {
				insufStockList.add(gdsVO);
			}
		}
		return insufStockList;
	}
}
