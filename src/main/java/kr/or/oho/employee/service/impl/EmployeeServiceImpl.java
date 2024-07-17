package kr.or.oho.employee.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.oho.employee.service.EmployeeService;
import kr.or.oho.mapper.AttachMapper;
import kr.or.oho.mapper.EmpRegisterMapper;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.utils.UploadController;
import kr.or.oho.vo.AttachVO;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import oracle.net.aso.a;

@Slf4j
@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	UploadController uploadController;
	
	@Autowired
	EmpRegisterMapper empregMapper;
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	AttachMapper attachMapper;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 사원등록
	 */
	@Override
	public int createPost(EmployeeVO employeeVO) {
		
		String pwd = employeeVO.getEmpPswd();		
		String encodedPwd = this.passwordEncoder.encode(pwd);
		
		log.info("encodedPwd : ", encodedPwd);
		
		employeeVO.setEmpPswd(encodedPwd);
		
		int result =  this.empregMapper.createPost(employeeVO);
		
		String maxEmpNo = this.empregMapper.maxEmpNo();
		
		MultipartFile[] upFile = employeeVO.getUploadFile();
		
		this.uploadController.uploadMulti(upFile, maxEmpNo);
		
		return result;
	}

	/**
	 * 사원목록
	 */
	@Override
	public List<EmployeeVO> empList() {
		return this.empregMapper.empList();
	}

	/**
	 * 사원 상세정보
	 */
	@Override
	public EmployeeVO empDetail(EmployeeVO employeeVO) {
		return this.empregMapper.empDetail(employeeVO);
	}

	/**
	 * 사원정보 수정 AJAX
	 */
	@Override
	public int updateAjax(EmployeeVO employeeVO) {
		
		int cnt = 0;
		
		cnt += this.empregMapper.updateEmployee(employeeVO);
		
		return cnt;
	}

	/**
	 * 사원정보 가져오기
	 */
	@Override
	public EmployeeVO getEmployeeInfo(String empNo) {
		return this.empregMapper.getEmployeeInfo(empNo);
	}

	@Override
	public int deleteEmp(EmployeeVO empNo) {
		return this.empregMapper.deleteEmp(empNo);
	}

	@Override
	public boolean checkingPw(EmployeeVO employeeVO) {
		String pass = this.employeeMapper.getPw(employeeVO);
		
		String pass2 = employeeVO.getEmpPswd();
		log.info("pass"+pass);
		log.info("pass2"+pass2);
		
		boolean check;
		if(this.passwordEncoder.matches(pass2, pass)) {
            log.info("pw 재확인 완료..");
            check = true;
        }
        else {
        	check = false;
        }
		
		return check;
	}

	@Override
	public int updatePw(EmployeeVO empPswd) {
		
		int cnt = 0;
		
		String pwd = empPswd.getEmpPswd();		
		String encodedPwd = this.passwordEncoder.encode(pwd);
		empPswd.setEmpPswd(encodedPwd);
		
		cnt += this.employeeMapper.updatePw(empPswd);
		
		return cnt;
		
	}

	@Override
	public String empNoId() {
		return this.empregMapper.empNoId();
	}

}
