package kr.or.oho.mtgRoom.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.mtgRoom.service.MtgRoomService;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.MtgRoomVO;
import kr.or.oho.vo.MtgrMngLdgrVO;
import kr.or.oho.vo.TodoListVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/mtgRoom")
@Slf4j
@Controller
public class MtgRoomController {
	
	@Autowired
	MtgRoomService mtgRoomService;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 로그인 후 회원 정보를 가지고 회의실 화면 이동
	 * @return
	 */
	@GetMapping("/list")
	public String list() {
		
		return "mtgroom/mtgRoomList";
	}
	
	/**
	 * 로그인 후 회원 정보를 가지고 회의실 화면 이동
	 * @return
	 */
	@ResponseBody
	@GetMapping("/mtgRoomAjax")
	public List<MtgRoomVO> getMtgRoomAjax() {
		log.info("mtrRoomAjax 왔다");
		
		List<MtgRoomVO> MtgrRoomVOList = this.mtgRoomService.getMtgRoomAjax();
	    log.info("가져온 이벤트 리스트: " +  MtgrRoomVOList);
		
		return MtgrRoomVOList;
	}
	
	/**
	 * ajax요청 기본키 가지고 오기
	 * @return
	 */
	@ResponseBody
	@GetMapping("/getMmlNo")
	public String getMmlNo() {
		
	    String mmlNo = this.mtgRoomService.getMmlNo();
		
	    log.info("getMmlNo mmlNo: " + mmlNo);
	    
	    return mmlNo;
	}
	
	/**
	 * ajax 리스트 가져오기
	 * @return
	 */
	@ResponseBody
	@GetMapping("/listAjax")
	public List<MtgrMngLdgrVO> getCalendarListAjax() {
		log.info("lisgAjax에 왔다");

		List<MtgrMngLdgrVO> mtgrMngLdgrVOList = this.mtgRoomService.listAjax();
	    log.info("가져온 이벤트 리스트: " +  mtgrMngLdgrVOList);
		
		return mtgrMngLdgrVOList;
	}
	
	/**
	 * ajax 상세정보 가져오기
	 * @param mtgrMngLdgrVO(mmlNo)
	 * @return mtgrMngLdgrVO
	 */
	@ResponseBody
	@PostMapping("/detailAjax")
	public MtgrMngLdgrVO detailAjax(@RequestBody MtgrMngLdgrVO mtgrMngLdgrVO) {
		log.info("detailAjax 받은 정보 mtgrMngLdgrVO :"+mtgrMngLdgrVO);
		
		mtgrMngLdgrVO = this.mtgRoomService.getMtgRoomDetail(mtgrMngLdgrVO);
		log.info("detailAjax(후)->mtgrMngLdgrVO : " + mtgrMngLdgrVO);
		
		return mtgrMngLdgrVO;
	}
	
	/**
	 * ajax 회의실 정보 등록하기
	 * @param mtgrMngLdgrVO
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/createAjax")
	public String createAjax(@RequestBody MtgrMngLdgrVO mtgrMngLdgrVO) {
		
		//HttpSession session,Authentication auth
		//log.info("재욱 체킁2 {}", ((CustomUser)auth.getPrincipal()).getEmployeeVO().getDeptNo());
		log.info("createAjax(전)->mtgrMngLdgrVO : " + mtgrMngLdgrVO);
		
		int result = this.mtgRoomService.createAjax(mtgrMngLdgrVO);
		log.info("createAjax(후)->result : " + result);
		
		return "createAjax SUCCESS";
	}
	
	/**
	 * ajax 회의실 정보 수정하기
	 * @param mtgrMngLdgrVO
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/updateAjax")
	public String updateAjax(@RequestBody MtgrMngLdgrVO mtgrMngLdgrVO) {
		log.info("updateAjax(전)->mtgrMngLdgrVO :" +mtgrMngLdgrVO);
		
		//insert, update, delete의  return타입 : int 타입
		int result = this.mtgRoomService.updateAjax(mtgrMngLdgrVO);
		log.info("updateAjax(후)->result :" +result);
		
		return "updateAjax SUCCESS";
	}
	
	/**
	 * ajax 회의실 정보 삭제하기
	 * @param mtgrMngLdgrVO(mmlNo, empNo)
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/deleteAjax")
	public MtgrMngLdgrVO deleteAjax(@RequestBody MtgrMngLdgrVO mtgrMngLdgrVO) {
		log.info("deleteAjax(전)->mtgrMngLdgrVO :" + mtgrMngLdgrVO);
		
		//insert, update, delete의  return타입 : int 타입
		int result = this.mtgRoomService.deleteAjax(mtgrMngLdgrVO);
		
		return mtgrMngLdgrVO;
	}
	
	/**
	 * principal 로그인한 회원 정보 얻기 
	 * @param
	 * @return String
	 */
	@ResponseBody
	@GetMapping("/getEmp")
	public String GetEmp(Principal principal) {
		String empId = principal.getName();
		
		log.info("GetEmp->empId : " + empId);
		
	    EmployeeVO emp = this.employeeMapper.detail(empId);
		log.info("로그인 한 emp 정보 : " + emp);
	    String empno = emp.getEmpNo();

	    return empno;
	}
	
	/**
	 * db에서 로그인한 회원 정보 얻기
	 * @param
	 * @return String
	 */
	@ResponseBody
	@PostMapping("/getEmp2")
	public String GetEmp2(@RequestBody Map<String, Object> map) {
		log.info("GetEmp2->아작스로 전송받은 map : " + map);
		
	    String empNo = this.mtgRoomService.getEmp2(map);
		log.info("GetEmp2 결과물 empNo : " + empNo);

	    return empNo;
	}
	
	/**
	 * principal 로그인한 부서 정보 얻기
	 * @param
	 * @return
	 */
	@ResponseBody
	@GetMapping("/getDept")
	public EmployeeVO GetDept(Principal principal) {
		String empId = principal.getName();
		
		log.info("GetEmp->empId : " + empId);
		
	    EmployeeVO dept = this.employeeMapper.getDetpNo(empId);
		log.info("로그인 한 dept 정보 : " + dept);
		
	    return dept;
	}

	
}
