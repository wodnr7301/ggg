package kr.or.oho.openmng.service;

import java.util.List;

import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;

public interface FrcService {
	public String frcsNoSelect();
	public List<ComcdVO> regionSelect();
	public int add(FranchiseVO franchiseVO);
	public String empNoSelect();
	public int addFrcEmp(EmployeeVO employeeVO);
	public List<FranchiseVO> frcsRegionList();
	public List<ComcdVO> countRegion();
	public List<ComcdVO> countRegionYear();
}
