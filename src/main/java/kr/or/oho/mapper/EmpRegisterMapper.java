package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.EmployeeVO;

// 멤버등록, 목록, 삭제, 수정 관련
public interface EmpRegisterMapper {

	/**
	 * 회원 등록
	 * @param employeeVO
	 * @return
	 */
	public int createPost(EmployeeVO employeeVO);
	
	/**
	 * 회원 목록
	 * @param map
	 * @return
	 */
	public List<EmployeeVO> empList ();
	
	/**
	 * 회원정보 상세
	 * @param employeeVO
	 * @return
	 */
	public EmployeeVO empDetail(EmployeeVO employeeVO);
	
	/**
	 * 사원번호(최대) 자동생성 -> 첨부파일
	 * @return
	 */
	public String maxEmpNo();
	
	/**
	 * 수정화면에서 보여줄 항목
	 * @param empNo
	 * @return
	 */
	public EmployeeVO getEmployeeInfo (String empNo);
	
	/**
	 * 회원정보 수정
	 * @return
	 */
	public int updateEmployee(EmployeeVO employeeVO);
	
	/**
	 * 사원삭제
	 * @param empNo
	 * @return
	 */
	public int deleteEmp(EmployeeVO empNo);

	// 최대 회원번호
	public String empNoId();
}
