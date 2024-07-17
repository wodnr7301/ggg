package kr.or.oho.franchise.service;

import java.util.List;

import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;

public interface FranchiseService {

	/**
	 * 가맹점 목록
	 * @return
	 */
	public List<FranchiseVO> frcsList();
	
	public EmployeeVO frcsDetail(EmployeeVO frcsVO);
	
	public FranchiseVO getfrcsInfo(String frcsNo);
	
	public EmployeeVO getFrcsEmpInfo(String frcsNo);
	
	public int updateFranchiseInfo(FranchiseVO frcsVO);
	
	public int updateFrcsEmpInfo(EmployeeVO employeeVO);
	
	public int deleteFranchise(FranchiseVO frcsNo);
	
}
