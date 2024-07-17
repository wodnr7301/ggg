package kr.or.oho.employee.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.employee.service.EmployeeService;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	@Autowired
	EmployeeService empService;
	
	/**
	 * 사원등록 양식폼 출력용
	 * @param model
	 * @param empVO
	 * @return
	 */
	@GetMapping("/register")
	public String create(Model model, EmployeeVO empVO) {
		model.addAttribute("employeeVO", empVO);
		log.debug("create에 왔다");
		
		return "employee/registerForm";
	}
	
	//formData 사용 시 RequestBody를 쓸 수 없음
	/**
	 * 사원등록 하기 
	 * @param employeeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/registerFormData")
	public String register(EmployeeVO employeeVO) {
		log.debug("register에 왔다");
		log.debug("employeeVO : " + employeeVO);
		
		int result = this.empService.createPost(employeeVO);
		
		log.info("register -> result", result);
		return employeeVO.getEmpId();
	}
	
	/**
	 * 사원 목록 출력
	 * @param model
	 * @return
	 */
	@GetMapping("/list")
	public String employeeList(Model model) {
		
		log.info("employeeList 도착");
		
		List<EmployeeVO> empList = this.empService.empList();
		log.debug("empList : " + empList);
		
		model.addAttribute("empList", empList);
		
		return "employee/employeeList";
	}
	
	/**
	 * 사원 퇴직처리후 (AJAX)
	 * 사원리스트 출력
	 * @param success
	 * @return
	 */
	@ResponseBody
	@PostMapping("/listAjax")
	public List<EmployeeVO> employeeListAjax(@RequestBody String success) {
		log.debug("listAjax 시작");
		
		List<EmployeeVO> empVOList = this.empService.empList();
		log.debug("empVOList : " + empVOList);
		
		
		return empVOList;
	}
	
	/**
	 * 사원상세정보 출력(모달)
	 * @param employeeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/detail")
	public EmployeeVO detailEmp(@RequestBody EmployeeVO employeeVO) {
		
		log.debug("detail 시작");
		log.debug("employeeVO : " + employeeVO);
		
		employeeVO = this.empService.empDetail(employeeVO);
		log.debug("employeeVO : " + employeeVO);
		
		return employeeVO;
	}
	
	/**
	 * 사원목록에서 수정화면으로 이동했을때
	 * 출력되는 수정될사항들 목록
	 * @param empNo
	 * @param model
	 * @return
	 */
	@GetMapping("/update")
	public String update(@RequestParam String empNo, Model model) {
		
	log.debug("update에 왔다 ");
	log.debug("empNo : " + empNo);
	
	EmployeeVO employeeVO = this.empService.getEmployeeInfo(empNo);
	log.debug("empNo : " + empNo);
	log.debug("employeeVO : " + employeeVO);
	
	model.addAttribute("employeeVO", employeeVO);
	
	
	return "employee/employeeUpdateList";
	}
	
	/**
	 * 사원정보 수정 AJAX
	 * @param employeeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/updateAjax")
	public int updateAjax(@RequestBody EmployeeVO employeeVO) {
		
		log.debug("updateAjax 도착");
		log.debug("employeeVO : " + employeeVO);
		
		int cnt = this.empService.updateAjax(employeeVO);
		
		return cnt;
	}
		
	/**
	 * 사원 퇴직처리 AJAX
	 * @param empNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deleteEmpAjax")
	public int deleteEmp(@RequestBody EmployeeVO empNo) {
			
		log.debug("사원 삭제 ajax");
		log.debug("empNo : " + empNo);
		
		int cnt = this.empService.deleteEmp(empNo);
		
		return cnt;
		
			}
	
	/**
	 * 비밀번호 수정할때
	 * 현재비밀번호 확인하는 메서드
	 * @param employeeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/checkingPw")
	public boolean checkingPw(@RequestBody EmployeeVO employeeVO) {
		log.debug("employeeVO :" + employeeVO);
		
		boolean check = this.empService.checkingPw(employeeVO);
		
		return check;
	}
	
	/**
	 * 비밀번호 수정 메서드
	 * @param empPswd
	 * @return
	 */
	@ResponseBody
	@PostMapping("/updatePswd")
	public int updatePw(@RequestBody EmployeeVO empPswd) {
		log.debug("비밀번호 변경");
		log.debug("empPswd : " + empPswd);
		
		
		int cnt = this.empService.updatePw(empPswd);
		
		return cnt;
	}
	
	/**
	 * 사원등록 폼에서 사원번호 자동생성하는 메서드
	 * @return
	 */
	@ResponseBody
	@PostMapping("/empNoId")
	public String empNoId() {
		return this.empService.empNoId();
	}
}
