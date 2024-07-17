package kr.or.oho.openmng.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.devmng.service.FrcCnsltService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.openmng.service.CtrtService;
import kr.or.oho.openmng.service.FrcService;
import kr.or.oho.security.CustomUser;
import kr.or.oho.utils.UploadController;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.CtrtVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcsTypeVO;
import kr.or.oho.vo.ReserveFounderVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 신규 가맹점 등록 및 계약 관리 컨트롤러
 * @author PC-08
 */
@Slf4j
@RequestMapping("/ctrt")
@Controller
public class CtrtController {
	
	@Autowired
	CtrtService ctrtService;
	
	@Autowired
	FrcService frcService;
	
	@Autowired
	FrcCnsltService frcCnsltService;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * 가맹점 전체 계약 목록
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model) {
		List<CtrtVO> ctrtList = this.ctrtService.list();
		log.debug("ctrtList : "+ctrtList);
		
		List<FrcsTypeVO> frcsTypeCnt = this.ctrtService.getFtCnt();
		log.debug("frcsTypeCnt : "+frcsTypeCnt);
		
		FrcsTypeVO totalFrcsType = frcsTypeCnt.get(0);
		totalFrcsType.setFtNo("0");
		totalFrcsType.setFtNm("전체");
		frcsTypeCnt.set(0, totalFrcsType);
		log.debug("frcsTypeCnt 전체추가 : "+frcsTypeCnt);
		
		Map<String, String> mapY = new HashMap<String, String>();
		mapY.put("frcsClsYn", "Y");
		Map<String, String> mapN = new HashMap<String, String>();
		mapN.put("frcsClsYn", "N");
		
		int cntY = this.ctrtService.getClsYnCnt(mapY);
		int cntN = this.ctrtService.getClsYnCnt(mapN);
		log.debug("영업상태 : "+cntN+", "+cntY);
		
		model.addAttribute("ctrtList", ctrtList);
		model.addAttribute("frcsTypeCnt", frcsTypeCnt);
		model.addAttribute("cntY", cntY);
		model.addAttribute("cntN", cntN);

		return "openmng/ctrt";
	}
	
	/**
	 * 가맹점 유형 별 계약 목록
	 * @param frcsTypeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getList")
	public List<CtrtVO> getListAjax(@RequestBody FrcsTypeVO frcsTypeVO) {
		log.debug("입력값 frcsTypeVO ftNo : "+frcsTypeVO);
		
		List<CtrtVO> ctrtList = this.ctrtService.list(frcsTypeVO);
		log.debug("ctrtList : "+ctrtList);
		
		return ctrtList;
	}
	
	@ResponseBody
	@PostMapping("/getClsCnt")
	public Map<String, Object> getClsCntAjax(@RequestBody FrcsTypeVO frcsTypeVO) {
		log.debug("입력값 frcsTypeVO ftNo : "+frcsTypeVO);
		
		Map<String, String> mapY = new HashMap<String, String>();
		mapY.put("ftNo", frcsTypeVO.getFtNo());
		mapY.put("frcsClsYn", "Y");
		Map<String, String> mapN = new HashMap<String, String>();
		mapN.put("ftNo", frcsTypeVO.getFtNo());
		mapN.put("frcsClsYn", "N");
		
		int cntY = this.ctrtService.getClsYnCnt(mapY);
		int cntN = this.ctrtService.getClsYnCnt(mapN);
		log.debug("영업상태 : "+cntN+", "+cntY);
		
		Map<String, Object> result = new HashMap<>();
		result.put("cntY", cntY);
		result.put("cntN", cntN);
		
		return result;
	}
	
	/**
	 * 가맹점 계약 상세 화면 이동
	 * @return
	 */
	@GetMapping("/detail")
	public String detail(Model model, CtrtVO ctrtVO, Principal principal) {
		log.debug("파라미터로 받은 ctrtVO : "+ctrtVO);
		ctrtVO = this.ctrtService.detail(ctrtVO);
		log.debug("상세정보 담은 ctrtVO : "+ctrtVO);

		model.addAttribute("ctrtVO", ctrtVO);
		
		//오호쌤 고맙습니당~!
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		log.info("로그인 한 emp 정보 : " + emp);
		
		model.addAttribute("loginEmpNo", emp.getEmpNo());
		
		return "openmng/ctrtDetail";
	}
	
	/**
	 * 신규 가맹점 등록 화면 이동
	 * @return
	 */
	@GetMapping("/createFrc")
	public String createFranchise(Model model) {
		//지역구분 리스트
		List<ComcdVO> regionList = this.frcService.regionSelect();
		log.debug("regionList : " + regionList);
		
		//상담완료자 리스트
		List<ReserveFounderVO> cnsltYList = this.frcCnsltService.cnsltYList();
		log.debug("cnsltYList : "+cnsltYList);
		
		//프랜차이즈유형 리스트
		List<FrcsTypeVO> FrcsTypeList = this.ctrtService.frcsTypeSelect();
		log.debug("FrcsTypeList : "+FrcsTypeList);
		
		model.addAttribute("regionList", regionList);
		model.addAttribute("cnsltYList", cnsltYList);
		model.addAttribute("FrcsTypeList", FrcsTypeList);
		
		return "openmng/newFrcForm";
	}
	
	/**
	 * 가맹점코드 마지막번호 가져오기
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getFrcsNo")
	public String getFranchiseNo() {
		return this.frcService.frcsNoSelect();
	}
	
	/**
	 * 상담완료자 선택 시 해당 예비창업자 정보 불러오기
	 * @param reserveFounderVO 예비창업자 지원번호
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getCnsltYOne")
	public ReserveFounderVO getCnsltYOne(@RequestBody ReserveFounderVO reserveFounderVO) {
		log.debug("reserveFounderVO rfNo : "+reserveFounderVO);
		return this.frcCnsltService.cnsltYOne(reserveFounderVO);
	}
	
	/**
	 * 가맹점주 신규 사원 등록 처리
	 * @param employeeVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/addEmp")
	public String addEmp(EmployeeVO employeeVO) {
		log.debug("입력값 employeeVO : "+employeeVO);
		
		employeeVO.setEmpImg(employeeVO.getUploadFileOne().getOriginalFilename());
		log.debug("프로필사진 세팅 : "+employeeVO.getEmpImg());
		
		employeeVO.setEmpNo(this.frcService.empNoSelect());
		log.debug("사원번호 세팅 : "+employeeVO.getEmpNo());

		String empId = "frc" + employeeVO.getEmpNo();
		employeeVO.setEmpId(empId);
		log.debug("사원아이디 세팅 : "+employeeVO.getEmpId());
		
		//비밀번호 암호화
		String pwd = employeeVO.getEmpPswd();
		String encodedPwd = this.passwordEncoder.encode(pwd);
		employeeVO.setEmpPswd(encodedPwd);
		
		int result = this.frcService.addFrcEmp(employeeVO);
		log.debug("사원 등록 결과 : " + result);
		
		result += this.uploadController.uploadOne(employeeVO.getUploadFileOne(), employeeVO.getEmpNo());
		log.debug("사원 등록, 프로필사진 파일 업로드 결과 : " + result);
		
		if(result == 2) {
			return employeeVO.getEmpNo();
		}else {
			return "fail";
		}
	}
	
	/**
	 * 신규 가맹점 등록 처리
	 * @param franchiseVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/addFrc")
	public String addFrc(@RequestBody FranchiseVO franchiseVO) {
		log.debug("입력값 franchiseVO : "+franchiseVO);
		
		int result = this.frcService.add(franchiseVO);
		log.debug("가맹점 등록 결과 : " + result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 가맹점 계약 등록 처리
	 * @param ctrtVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/addCtrt")
	public String addCtrt(CtrtVO ctrtVO, Principal principal) {
		log.debug("입력값 ctrtVO : "+ctrtVO);
		
		//양자바쌤 고맙습니댱~!
		UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
		CustomUser cu = (CustomUser) a.getPrincipal();
		EmployeeVO emp = cu.getEmployeeVO();
		log.debug("로그인 사원번호 : "+emp.getEmpNo());
		
		ctrtVO.setEmpNo(emp.getEmpNo());
		log.debug("사원번호 세팅 : "+ctrtVO.getEmpNo());
		
		ctrtVO.setCtrtNo(this.ctrtService.ctrtNoSelect());
		log.debug("계약번호 세팅 : "+ctrtVO.getCtrtNo());

		int result = this.ctrtService.add(ctrtVO);
		log.debug("계약 등록 결과 : " + result);
		
		//계약명으로 계약서파일이름 세팅
		String newName = ctrtVO.getCtrtNm()+".pdf";
		result += this.uploadController.renameUploadOne(ctrtVO.getUploadFile(), ctrtVO.getCtrtNo(), newName);
		log.debug("계약 등록, 계약서 파일 업로드 결과 : " + result);
		
		if(result == 2) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 계약명, 계약일, 계약내용 수정 처리
	 * @param ctrtVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/updateCtrt")
	public String updateCtrt(@RequestBody CtrtVO ctrtVO) {
		log.debug("입력값 ctrtVO : "+ctrtVO);
		
		int result = this.ctrtService.update(ctrtVO);
		log.debug("계약 수정 결과 : " + result);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
}
