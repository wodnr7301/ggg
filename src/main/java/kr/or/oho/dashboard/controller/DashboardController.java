package kr.or.oho.dashboard.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.oho.attendence.service.AttendService;
import kr.or.oho.dashboard.service.DashboardService;
import kr.or.oho.eatrzt.service.EatrztService;
import kr.or.oho.employee.service.EmployeeService;
import kr.or.oho.employee.service.MypageService;
import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.frcowner.service.NtcBbsService;
import kr.or.oho.hdorder.service.HdorderService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.mapper.TodoListMapper;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.EatrztVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.GdsVO;
import kr.or.oho.vo.HdorderVO;
import kr.or.oho.vo.NtcBbsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dashboard")
public class DashboardController {

	@Autowired
	DashboardService dashboardService;

	@Autowired
	EmployeeService empService; // 직원

	@Autowired
	NtcBbsService ntcBbsService; // 공지사항
	
	@Autowired
	TodoListMapper todoListMapper;

	@Autowired
	private EmployeeMapper employeeMapper; // 로그인 정보

	@Autowired
	MypageService mypageservice; // 프로필

	@Autowired
	FrcorderService frcorderService; // 수주

	@Autowired
	HdorderService hdorderService; // 발주

	@Autowired
	AttendService attendService; // 당월 근태현황

	@Autowired
	EatrztService eatrztService; // 전자 결재

	@GetMapping("/home")
	public String home(Model model, Principal principal, Map<String, Object> map) {
		log.info("dashboard home에 왔당, principal : " + principal);

		EmployeeVO employeeVO1 = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + employeeVO1.getEmpNo());
		log.info("로그인 한 emp명 : " + employeeVO1.getEmpNm());

		EmployeeVO employeeVO2 = this.mypageservice.profile(employeeVO1.getEmpNo());
		log.info("프로필 확인 전: " + employeeVO2);

		model.addAttribute("employeeVO2", employeeVO2);
		log.info("프로필 확인 후 : " + employeeVO2);

		List<NtcBbsVO> ntcBbsList = this.ntcBbsService.ntcEmpList();
		log.info("점주 공지사항 list전 -> ntcBbsList : " + ntcBbsList);

		model.addAttribute("ntcBbsList", ntcBbsList);
		log.info("점주 공지사항 list후 -> ntcBbsList : " + ntcBbsList);

		String empNo = employeeVO1.getEmpNo();
		log.info("로그인 한 empNo 정보 로그인 한 empNo 정보 로그인 한 empNo 정보: " + empNo);

		map.put("empNo", empNo);
	
		map.put("waStatus", "퇴근");
		int totalWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->totalWork : " + totalWork);
		model.addAttribute("totalWork", totalWork);

		map.put("waStatus", "조퇴");
		int outWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->outWork : " + outWork);
		model.addAttribute("outWork", outWork);

		map.put("waStatus", "지각");
		int lateWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->lateWork : " + lateWork);
		model.addAttribute("lateWork", lateWork);
		
		int getCountWork = this.todoListMapper.getCalendarCount(empNo);
		log.info("getCountWork 결과 -> getCountWork : " + getCountWork);
		model.addAttribute("getCountWork", getCountWork);

		// 수주 카운트
		List<FrcOrderVO> frcorderVOList = this.frcorderService.getAllFrcorder();

		int conuntN = 0;
		int conuntA = 0;
		int conuntD = 0;
		int conuntF = 0;
		int conuntE = 0;
		int conuntEF = 0;

		for (FrcOrderVO frcOrderVO : frcorderVOList) {
			if (frcOrderVO.getFoPrcsYn().equals("N")) {
				conuntN++;
			} else if (frcOrderVO.getFoPrcsYn().equals("A")) {
				conuntA++;
			} else if (frcOrderVO.getFoPrcsYn().equals("D")) {
				conuntD++;
			} else if (frcOrderVO.getFoPrcsYn().equals("F")) {
				conuntF++;
			} else {
				conuntE++;
			}
		}
		conuntEF = conuntE + conuntF;

		if (principal != null) {
			UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) a.getPrincipal();
			if (cu != null) {
				EmployeeVO emp = cu.getEmployeeVO();
				if (emp != null) {
					model.addAttribute("empNo", emp.getEmpNo());
				}
			}
		}

		// 발주 카운트
		int countI = 0;
		int countY = 0;
		int countN = 0;
		int countE = 0;

		List<HdorderVO> hdordeVOList = this.hdorderService.getAllHdorder();

		for (HdorderVO hdorderVO : hdordeVOList) {
			if (hdorderVO.getHoPrcsYn().equals("N")) {
				countN++;
			} else if (hdorderVO.getHoPrcsYn().equals("I")) {
				countI++;
			} else if (hdorderVO.getHoPrcsYn().equals("Y")) {
				countY++;
			} else if (hdorderVO.getHoPrcsYn().equals("E")) {
				countE++;
			}
		}

		// 재고관리현황 카운트
		int needStock = 0;
		int countAA = 0;
		int countBB = 0;
		int countCC = 0;
		int countDD = 0;
		int countEE = 0;
		List<GdsVO> gdsVOList = this.hdorderService.getAllStock();

		for (GdsVO gdsVO : gdsVOList) {
			if (gdsVO.getGdsStock() < gdsVO.getMinGdsStock()) {
				needStock++;
			}

			if ((gdsVO.getComcdCdnm()).equals("채소류")) {
				countAA++;
			}
			if ((gdsVO.getComcdCdnm()).equals("과일류")) {
				countBB++;
			}
			if ((gdsVO.getComcdCdnm()).equals("육류")) {
				countCC++;
			}
			if ((gdsVO.getComcdCdnm()).equals("어패류")) {
				countDD++;
			}
			if ((gdsVO.getComcdCdnm()).equals("기타 식품")) {
				countEE++;
			}
		}

		// 재고 카운트
		model.addAttribute("needStock", needStock);
		model.addAttribute("countAA", countAA);
		model.addAttribute("countBB", countBB);
		model.addAttribute("countCC", countCC);
		model.addAttribute("countDD", countDD);
		model.addAttribute("countEE", countEE);

		// 수주 카운트
		model.addAttribute("conuntN", conuntN);
		model.addAttribute("conuntA", conuntA);
		model.addAttribute("conuntD", conuntD);
		model.addAttribute("conuntEF", conuntEF);

		// 발주 카운트
		model.addAttribute("countN", countN);
		model.addAttribute("countI", countI);
		model.addAttribute("countY", countY);
		model.addAttribute("countE", countE);

		List<EatrztVO> beforeApvBoxList = this.eatrztService.beforeApvBoxList(employeeVO1.getEmpNo());
		log.info("결재대기 확인 전 : " + beforeApvBoxList);

		model.addAttribute("beforeApvBoxList", beforeApvBoxList);
		log.info("결재대기 확인 후 : " + beforeApvBoxList);

		return "dashboard/home";
	}

}
