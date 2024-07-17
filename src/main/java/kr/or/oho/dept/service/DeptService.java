package kr.or.oho.dept.service;

import java.util.List;

import kr.or.oho.vo.DeptVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.JsTreeVO;

public interface DeptService {
	
	/**
	 * 조직도에 표시할 부서 조회
	 * @return
	 */
	public List<JsTreeVO> getDept();
	
	/**
	 * 조직도에 표시할 사원 조회
	 * @return
	 */
	public List<JsTreeVO> getEmp();
	
	/**
	 * 부서 선택시 표시할 부서정보 조회
	 * @param jsTreeVO
	 * @return
	 */
	public DeptVO getDeptCn(JsTreeVO jsTreeVO);
	
	/**
	 * 부서 선택시 표시할 부서내 사원 정보 조회
	 * @param jsTreeVO
	 * @return
	 */
	public List<EmployeeVO> getEmpCn(JsTreeVO jsTreeVO);
	
	/**
	 * 리스트로 갈때 부서이동 선택지 생성을 위한 부서 조회
	 * @return
	 */
	public List<DeptVO> getAllDept();

	/**
	 * 부서이동 서비스
	 * @param employeeVO
	 * @return
	 */
	public int moveDept(EmployeeVO employeeVO);

}
