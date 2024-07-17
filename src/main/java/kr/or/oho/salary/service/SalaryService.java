package kr.or.oho.salary.service;

import java.util.List;

import kr.or.oho.vo.DdcVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.GiveVO;
import kr.or.oho.vo.SalaryVO;

public interface SalaryService {

	/**
	 * 모든 사원의 급여관리대장 출력을 위한 메소드
	 * @return
	 */
	public List<SalaryVO> allList();

	
	/**
	 * 단일 급여 상세조회
	 * @param amlNo
	 * @return
	 */
	public SalaryVO getSalary(String amlNo);


	/**
	 * 단일 급여 지급 상세조회
	 * @param giveNo
	 * @return
	 */
	public GiveVO getGive(String giveNo);


	/**
	 * 단일 급여 공제 상세조회
	 * @param ddcNo
	 * @return
	 */
	public DdcVO getDdc(String ddcNo);

	
	/**
	 * 급여관리대장 등록에서 사용할 사원명 조회
	 * @return
	 */
	public List<EmployeeVO> getName();


	/**
	 * 급여관리대장 등록
	 * @param salaryVO
	 * @return
	 */
	public int createAjax(SalaryVO salaryVO);


	/**
	 * 급여관리대장 삭제
	 * @param salaryVO
	 * @return
	 */
	public int deleteAjax(SalaryVO salaryVO);


	/**
	 * 급여관리대장 수정
	 * @param salaryVO
	 * @return
	 */
	public int updateAjax(SalaryVO salaryVO);

}
