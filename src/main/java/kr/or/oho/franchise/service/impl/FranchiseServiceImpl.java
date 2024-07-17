package kr.or.oho.franchise.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.franchise.service.FranchiseService;
import kr.or.oho.mapper.FrcMapper;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;

@Service
public class FranchiseServiceImpl implements FranchiseService{

	@Autowired
	FrcMapper frcMapper;
	
	@Override
	public List<FranchiseVO> frcsList() {
		return this.frcMapper.frcsList();
	}

	@Override
	public EmployeeVO frcsDetail(EmployeeVO frcsVO) {
		return this.frcMapper.frcsDetail(frcsVO);
	}

	@Override
	public FranchiseVO getfrcsInfo(String frcsNo) {
		return this.frcMapper.getFranchiseInfo(frcsNo);
	}

	@Override
	public EmployeeVO getFrcsEmpInfo(String frcsNo) {
		return this.frcMapper.getFrcsEmpInfo(frcsNo);
	}

	@Override
	public int updateFranchiseInfo(FranchiseVO frcsVO) {
		return this.frcMapper.updateFranchiseInfo(frcsVO);
	}
	
	@Override
	public int updateFrcsEmpInfo(EmployeeVO employeeVO) {
		return this.frcMapper.updateFrcsEmpInfo(employeeVO);
	}

	@Override
	public int deleteFranchise(FranchiseVO frcsNo) {
		int result = this.frcMapper.deleteFranchise(frcsNo);
		result +=  this.frcMapper.deleteFrcsEmp(frcsNo);
		
		return result;
	}
	
}
