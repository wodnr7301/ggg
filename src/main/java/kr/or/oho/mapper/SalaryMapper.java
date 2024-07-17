package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.DdcVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.GiveVO;
import kr.or.oho.vo.SalaryVO;

public interface SalaryMapper {
	
	public List<SalaryVO> allList();

	public SalaryVO getSalary(String amlNo);

	public GiveVO getGive(String giveNo);

	public DdcVO getDdc(String ddcNo);

	public List<EmployeeVO> getName();

	public int createGive(SalaryVO salaryVO);
	
	public int createDdc(SalaryVO salaryVO);
	
	public int createSalary(SalaryVO salaryVO);

	public int deleteSalary(SalaryVO salaryVO);

	public int deleteGive(SalaryVO salaryVO);

	public int deleteDdc(SalaryVO salaryVO);

	public int updateSalary(SalaryVO salaryVO);

	public int updateGive(SalaryVO salaryVO);

	public int updateDdc(SalaryVO salaryVO);



}
