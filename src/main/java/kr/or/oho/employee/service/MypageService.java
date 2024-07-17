package kr.or.oho.employee.service;

import java.util.List;

import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.SalaryVO;

public interface MypageService {
	
	EmployeeVO profile(String empNo);

	int profileUpdate(EmployeeVO employee);

	EmployeeVO detailProfile(String empNo);

	int detailProfileUpdate(EmployeeVO employee);

	List<SalaryVO> getSalary(String empNo);

	List<FranchiseVO> getFranchise(String empNo);

	List<EmployeeVO> franProfile(String empNo);

}
