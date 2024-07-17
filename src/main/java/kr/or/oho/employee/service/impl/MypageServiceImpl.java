package kr.or.oho.employee.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.employee.service.MypageService;
import kr.or.oho.mapper.MypageMapper;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.SalaryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MypageServiceImpl implements MypageService {
   
   @Autowired
   MypageMapper mypageMapper;

	@Override
	public EmployeeVO profile(String empNo) {
		return this.mypageMapper.profile(empNo);
	}

	@Override
	public int profileUpdate(EmployeeVO employee) {
		return this.mypageMapper.profileUpdate(employee);
	}

	@Override
	public EmployeeVO detailProfile(String empNo) {
		return this.mypageMapper.detailProfile(empNo);
	}

	@Override
	public int detailProfileUpdate(EmployeeVO employee) {
		return this.mypageMapper.detailProfileUpdate(employee);
	}

	@Override
	public List<SalaryVO> getSalary(String empNo) {
		return this.mypageMapper.getSalary(empNo);
	}

	@Override
	public List<FranchiseVO> getFranchise(String empNo) {
		return this.mypageMapper.getFranchise(empNo);
	}

	@Override
	public List<EmployeeVO> franProfile(String empNo) {
		return this.mypageMapper.franProfile(empNo);
	}

}
