package kr.or.oho;

import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.frcorder.service.FrcsMainPageService;
import kr.or.oho.frcowner.service.NtcBbsService;
import kr.or.oho.frcowner.service.RevenueService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.FrcsStockVO;
import kr.or.oho.vo.NtcBbsVO;
import kr.or.oho.vo.RevenueVO;
import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	NtcBbsService ntcBbsService;
	
	@Autowired
	FrcsMainPageService frcsMainPageService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Autowired
	FrcorderService frcorderService;
	
	@Autowired
	RevenueService revenueService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(FrcOrderVO frcOrderVO, Model model, Principal principal, ComcdVO comcdVO) {
		log.info("가맹점주 메인페이지");
		EmployeeVO emp = new EmployeeVO();
		// 가맹점 번호 구하기
		if(this.employeeMapper.detail(principal.getName()) != null) {
			emp = this.employeeMapper.detail(principal.getName());
		}
		log.debug("로그인한 정보 emp : " + emp);
		String empNo = emp.getEmpNo();
		String frcsNo = this.frcorderService.getFrcsNo(empNo);
		comcdVO.setFrcsNo(frcsNo);
		
		String frcsNm = this.frcorderService.getFrcsNm(frcsNo);
		log.debug("frcsNm : " + frcsNm);
		
		// 재고계산
		int allStockCnt = 0;
		int insufStockCnt = 0;
		
		// 발주내역 종류 계산
		int countN = 0;
		int countA = 0;
		int countD = 0;
		int countF = 0;
		int countE = 0;
		
		// 공지사항 가져오기
		List<NtcBbsVO> ntcBbsList = this.ntcBbsService.list();
		log.info("점주 공지사항 -> ntcBbsList : " + ntcBbsList);
		
		// 해당 가맹점 재고내역
		List<FrcsStockVO> allStockList = this.frcorderService.getAllStock(comcdVO);
		log.debug("allStockList : " + allStockList);
		
		for (FrcsStockVO frcsStockVO : allStockList) {
			allStockCnt++;
			if(frcsStockVO.getFrcssCnt() < frcsStockVO.getMinGdsStock()) {
				insufStockCnt++;
			}
		}
		
		log.debug("allStockCnt : " + allStockCnt);
		log.debug("insufStockCnt : " + insufStockCnt);
		
		// 해당 가맹점 발주내역
		frcOrderVO.setFrcsNo(frcsNo);
		List<FrcOrderVO> frcorderVOList = this.frcorderService.getAllFrcorder(frcOrderVO);
		for (FrcOrderVO frcOrderVO2 : frcorderVOList) {
			if (frcOrderVO2.getFoPrcsYn().equals("N")) {
				countN++;
			} else if (frcOrderVO2.getFoPrcsYn().equals("A")) {
				countA++;
			} else if (frcOrderVO2.getFoPrcsYn().equals("D")) {
				countD++;
			} else if (frcOrderVO2.getFoPrcsYn().equals("F")) {
				countF++;
			} else {
				countE++;
			}
		}

		// 모든 매출 정보 가져오기
		int monthAmt = 0;
		int preMonthAmt = 0;
		int qtAmt = 0;
		int yearAmt = 0;
		int preYearAmt = 0;
		int totalFsAmt = 0; // 매출액
		int totalFsEarn = 0; // 매출 총 이익
		
		// 현재 날짜 객체 생성
        Date date = new Date();

        SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
        SimpleDateFormat monthFormat = new SimpleDateFormat("MM");

        String yearStr = yearFormat.format(date);
        String monthStr = monthFormat.format(date);
        
        // Calendar 객체 생성 및 현재 날짜 설정
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        
        // 현재 연도를 가져옴
        int currentYear = calendar.get(Calendar.YEAR);

        // 이전 년도를 계산
        int previousYear = currentYear - 1;
        String previousYearStr = String.valueOf(previousYear);
        log.debug("previousYear : " + previousYear);

        // 현재 월에서 1을 빼서 이전 달로 설정
        calendar.add(Calendar.MONTH, -1);

        // 이전 달의 연도와 월을 가져옴
        int preYear = calendar.get(Calendar.YEAR);
        int preMonth = calendar.get(Calendar.MONTH) + 1; // Calendar.MONTH는 0부터 시작하므로 +1 해줘야 함

        // 이전 달의 연도와 월을 문자열로 변환
        String preYearStr = String.valueOf(preYear);
        String preMonthStr = String.format("%02d", preMonth);
        
        // String을 int로 변환
        int month = Integer.parseInt(monthStr);
        int qt;
        if(month == 1 || month == 2 || month ==3) {
        	qt = 1;
        }
        if(month == 4 || month == 5 || month ==6) {
        	qt = 2;
        }
        if(month == 7 || month == 8 || month ==9) {
        	qt = 3;
        }else {
        	qt = 4;
        }
        
		List<RevenueVO> revenueVOList = this.frcsMainPageService.getAllRevenue(frcsNo);
		log.debug("revenueVOList : " + revenueVOList);
		for (RevenueVO revenueVO : revenueVOList) {
			// 매출액
			totalFsAmt += revenueVO.getFsAmt();
			// 매출 총 이익
			totalFsEarn += revenueVO.getFsEarn();
			
			// 저번달 매출
			if(month != 1) {
				if(yearStr.equals(revenueVO.getFsWrtYear()) && preMonth == revenueVO.getFsMonthly()) {
					preMonthAmt += revenueVO.getFsAmt();
				}
			}else if(month == 1) {
				if(preYearStr.equals(revenueVO.getFsWrtYear()) && preMonth == revenueVO.getFsMonthly()) {
					preMonthAmt += revenueVO.getFsAmt();
				}
			}
			
			// 저번연도 매출
			if(previousYearStr.equals(revenueVO.getFsWrtYear())) {
				preYearAmt += revenueVO.getFsAmt();
			}
			
			// 이번달 매출
			if(yearStr.equals(revenueVO.getFsWrtYear()) && month == revenueVO.getFsMonthly()) {
				monthAmt += revenueVO.getFsAmt();
			}
			// 이번분기 매출
			if(qt == revenueVO.getFsWrtQy()) {
				qtAmt += revenueVO.getFsAmt();
			}
			// 이번연도 매출
			if(yearStr.equals(revenueVO.getFsWrtYear())) {
				yearAmt += revenueVO.getFsAmt();
			}
		}
		
		// 전월대비
		int pms = (int)((monthAmt/(float)preMonthAmt)*100);
		log.debug("pms : " + pms);
		// 전년대비
		int yms = (int)((yearAmt/(float)preYearAmt)*100);
		log.debug("preYearAmt : " + preYearAmt);
		log.debug("yearAmt : " + yearAmt);
		log.debug("yms : " + yms);
		
		// 매출 총 이익률
		int gpm = (int)((totalFsEarn/ (float) totalFsAmt) * 100);
		log.debug("totalFsAmt : " + totalFsAmt);
		log.debug("totalFsEarn : " + totalFsEarn);
		log.debug("gpm : " + gpm);
		
		log.debug("monthAmt : " + monthAmt);
		log.debug("qtAmt : " + qtAmt);
		log.debug("yearAmt : " + yearAmt);
		
		// 월별 매출 현황
		RevenueVO revenue = new RevenueVO();
		revenue.setFsWrtYear(yearStr);
		revenue.setFrcsNo(frcsNo);
		List<RevenueVO> revenueList = revenueService.list(revenue);
		log.info("이번년도 월별 매출 list -> revenueList: " + revenueList);
		
		// 월별 매출 현황
		RevenueVO revenue2 = new RevenueVO();
		revenue2.setFsWrtYear("2023");
		revenue2.setFrcsNo(frcsNo);
		List<RevenueVO> revenueList2 = revenueService.list(revenue2);
		log.info("전년도 월별 매출 list -> revenueList2: " + revenueList2);
		
		// 월별 매출 현황
		model.addAttribute("revenueList", revenueList);
		model.addAttribute("revenueList2", revenueList2);
		
		// 재고현황 카운트
		model.addAttribute("allStockCnt" , allStockCnt);
		model.addAttribute("insufStockCnt" , insufStockCnt);
		model.addAttribute("ntcBbsList" , ntcBbsList);
		
		// 발주현황 카운트
		model.addAttribute("countN", countN);
		model.addAttribute("countA", countA);
		model.addAttribute("countD", countD);
		model.addAttribute("countF", countF);
		model.addAttribute("countE", countE);
		
		// 월 분기 년 매출
		model.addAttribute("monthAmt", monthAmt);
		model.addAttribute("qtAmt", qtAmt);
		model.addAttribute("yearAmt", yearAmt);
		model.addAttribute("pms", pms);
		model.addAttribute("yms", yms);
		model.addAttribute("gpm", gpm);
		
		model.addAttribute("frcsNm", frcsNm);
		
		return "home";
	}
	
	@GetMapping("/socketTest")
	public String socketTest() {
		return "socketTest";
	}
}
