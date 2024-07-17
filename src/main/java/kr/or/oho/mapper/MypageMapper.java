package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.SalaryVO;

public interface MypageMapper {

	public EmployeeVO profile(String empNo);
	
	public int profileUpdate(EmployeeVO employee);

	public EmployeeVO detailProfile(String empNo);

	public int detailProfileUpdate(EmployeeVO employee);

	public List<SalaryVO> getSalary(String empNo);

	public List<FranchiseVO> getFranchise(String empNo);

	public List<EmployeeVO> franProfile(String empNo);

}
