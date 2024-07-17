package kr.or.oho.attendence.controller;


import java.security.Principal;
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

import kr.or.oho.attendence.service.AttendService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.vo.AttendVO;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;


@RequestMapping("/attend")
@Slf4j
@Controller
public class AttendController {
	
	@Autowired
	AttendService attendService;
	
//	로그인한 회원정보 꺼내기
	
	@Autowired
	private EmployeeMapper employeeMapper;
//	EmployeeVO emp = this.employeeMapper.detail(principal.getName());
//	log.info("로그인 한 emp 정보 : " + emp);
	
/*
	UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
    CustomUser cu = (CustomUser) a.getPrincipal();
    EmployeeVO emp = cu.getEmployeeVO();
    
         아이디만 꺼낼거면 principal.getName인가 그거로 하면됩니당
*/
	/**
	 * 로그인 후 출석 정보를 가지고 근태 화면 이동
	 * @return String
	 */
	@GetMapping("/list")
	public String getAttendList(Model model, Principal principal, Map<String, Object> map) {
		log.info("전체 행수를 가져옵니다...");
		
		//로그인 필수
		if(principal == null) {
			return "redirect:/login";
		}
		
//		UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
//	    CustomUser cu = (CustomUser) a.getPrincipal();
//	    EmployeeVO emp = cu.getEmployeeVO();
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);

		String empNo = emp.getEmpNo();
		log.info("로그인 한 empNo 정보 로그인 한 empNo 정보 로그인 한 empNo 정보: " + empNo);
		
		map.put("empNo", empNo);
		
		map.put("waStatus", "퇴근");
		int totalWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->totalWork : " + totalWork);
		model.addAttribute("totalWork",totalWork);
		
		map.put("waStatus", "조퇴");
		int outWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->outWork : " + outWork);
		model.addAttribute("outWork",outWork);
		
		map.put("waStatus", "지각");
		int lateWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->lateWork : " + lateWork);
		model.addAttribute("lateWork",lateWork);
		
		return "attend/attendList";
	}
	
	/**
	 * 이벤트 발생하면서 페이지 바뀔 때 출석 정보를 가지고 리스트 받아오기
	 * @param map(요청파라미터 : empId)
	 * @return map(출퇴근 정보  가지고 있음)
	 */
	@ResponseBody
	@PostMapping("/listAjax2")
	public Map<String, Object> listAjax2(@RequestBody Map<String, Object> map) {				
		log.info("listAjax2->map : " + map);		
		
		String empId = (String)map.get("empId");
		log.info("listAjax2->empId : " + empId);
		
		EmployeeVO emp = this.employeeMapper.detail(empId);
		log.info("로그인 한 emp 정보 : " + emp);
		
		String empNo = emp.getEmpNo();
		log.info("로그인 한 empNo 정보 로그인 한 empNo 정보 로그인 한 empNo 정보: " + empNo);
		
		//2)
		map.put("empNo", empNo);
		//3)
		map.put("waStatus", "퇴근");
		int totalWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->totalWork : " + totalWork);
		//4)
		map.put("totalWork",totalWork);
		//5)
		map.put("waStatus", "조퇴");
		int outWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->outWork : " + outWork);
		//6)
		map.put("outWork",outWork);
		//7)
		map.put("waStatus", "지각");
		int lateWork = this.attendService.getCountList(map);
		log.info("getCountList 결과->lateWork : " + lateWork);
		//8)
		map.put("lateWork",lateWork);
		
		return map;
	}
	
	/**
	 * db 저장된 리스트 가져오기
	 * @param map(요청파라미터 : empNo)
	 * @return attendVOList
	 */
	@ResponseBody
	@PostMapping("/listAjax")
	public List<AttendVO> getCalendarListAjax(@RequestBody Map<String, Object> map) {
		log.info("받은 데이터 확인..." + map);
		
		String empNo = (String)map.get("empNo");
		List<AttendVO> attendVOList = this.attendService.getAttendList(empNo);
	    log.info("가져온 이벤트 리스트: " +  attendVOList);
		
		return attendVOList;
	}
	
	/**
	 * ajax 출근 정보 입력 처리
	 * @param attendVO
	 * @return attendVOList
	 */
	@ResponseBody
	@PostMapping("/createAjax")
	public List<AttendVO> createAjax(@RequestBody AttendVO attendVO) {
		
	log.info("createAjax(전)->attendVO : " + attendVO);
	  
	//출퇴근 등록
	int result = this.attendService.createPost(attendVO);
	log.info("createAjax(후)->result : " + result);
	
	String empNo = attendVO.getEmpNo();
	
	List<AttendVO> attendVOList = this.attendService.getAttendList(empNo);
    log.info("createAjax->가져온 이벤트 리스트: " +  attendVOList);
	
	return attendVOList;
	}
	
	/**
	 * ajax 출퇴근 정보 수정 처리
	 * @param attendVO
	 * @return attendVOList
	 */
	@ResponseBody
	@PostMapping("/updateAjax")
	public List<AttendVO> updateAjax(@RequestBody AttendVO attendVO) {
	log.info("updateAjax(전)->AttendVO :" +attendVO);
	
	//insert, update, delete의  return타입 : int 타입
	int result = this.attendService.updatePost(attendVO);
	log.info("updateAjax(후)->result :" +result);
	
	String empNo = attendVO.getEmpNo();
	
	List<AttendVO> attendVOList = this.attendService.getAttendList(empNo);
    log.info("updateAjax->가져온 이벤트 리스트: " +  attendVOList);
	
    return attendVOList;
	}
	
	/**
	 * ajax 기본키 매개변수로 로그인한 사람 출근 날짜 가져오기
	 * @param map(waNo, empNo)
	 * @return attendVO
	 */
	@ResponseBody
	@PostMapping("/getWaYmd")
	public AttendVO getWaYmd(@RequestBody Map<String, Object> map) {
		log.info("아작스로 전송받은 getWaNo..."+map);
		
		AttendVO attendVO = this.attendService.getWaYmd(map);
		log.info("getWaYmd 결과 값 : " + attendVO);

	    return attendVO;
	}
	
	/**
	 * 요청ajax db에 저장된 로그인한 사람 정보 가져오기
	 * @param 
	 * @return String
	 */
	@ResponseBody
	@GetMapping("/getEmp")
	public String getEmp(Principal principal) {
		if(principal == null) {
			return "error";
		}
		
		String empId = principal.getName();
		
		log.info("GetEmp->empId : " + empId);
		
	    EmployeeVO emp = this.employeeMapper.detail(empId);
		log.info("로그인 한 emp 정보 : " + emp);
	    String empno = emp.getEmpNo();

	    return empno;
	}
	
	/**
	 * ajax db에 저장된 로그인한 사람 기본정보,퇴근시간 가져오기
	 * @param map(waNo, empNo)
	 * @return attendVO
	 */
	@ResponseBody
	@PostMapping("/geteaOutTime")
	public AttendVO geteaOutTime(@RequestBody Map<String, Object> map) {
		log.info("아작스로 전송받은 geteaOutTime..."+map);
		
		AttendVO attendVO = this.attendService.geteaOutTime(map);
		log.info("geteaOutTime 결과 값 : " + attendVO);

	    return attendVO;
	}
	
	/**
	 * ajax db에 저장된 로그인한 사람 기본정보,퇴근시간 가져오기
	 * @param map(waNo, empNo)
	 * @return attendVO
	 */
	@ResponseBody
	@GetMapping("/geteaOutTime2")
	public AttendVO geteaOutTime2(Principal principal) {
		log.info("조퇴 문제 때문에 왔다....");
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.debug("emp : " + emp);
		String empNo = emp.getEmpNo();
		
		AttendVO attendVO = this.attendService.geteaOutTime2(empNo);
		log.info("조퇴 문제 geteaOutTime2 결과 값 : " + attendVO);

	    return attendVO;
	}
}
