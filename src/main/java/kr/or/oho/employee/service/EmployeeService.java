package kr.or.oho.employee.service;

import java.util.List;

import kr.or.oho.vo.EmployeeVO;

public interface EmployeeService {

	/**
	 * 멤버 등록
	 * @param employeeVO
	 * @return
	 */
	public int createPost(EmployeeVO employeeVO);

	/**
	 * 멤버 목록
	 * @param map
	 * @return
	 */
	public List<EmployeeVO> empList();
	
	/**
	 * 멤버 상세
	 * @param employeeVO
	 * @return
	 */
	public EmployeeVO empDetail(EmployeeVO employeeVO);
	
	/**
	 * 멤버 수정
	 * @param employeeVO
	 * @return
	 */
	public int updateAjax(EmployeeVO employeeVO);
	
	/**
	 * 수정화면에서 보여줄 항목
	 * @param employeeVO
	 * @return
	 */
	public EmployeeVO getEmployeeInfo(String empNo);

	/**
	 * 사원 삭제
	 * @param empNo
	 * @return
	 */
	public int deleteEmp(EmployeeVO empNo);
	
	/**
	 * 비밀번호 확인
	 * @param employeeVO
	 * @return
	 */
	public boolean checkingPw(EmployeeVO employeeVO);
	
	/**
	 * 비밀번호 수정
	 * @param empPswd
	 * @return
	 */
	public int updatePw(EmployeeVO empPswd);
	
	/**
	 * 회원 최대번호
	 * @return
	 */
	public String empNoId();
}
