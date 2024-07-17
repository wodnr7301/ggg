package kr.or.oho.openmng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.ComcdMapper;
import kr.or.oho.mapper.FrcEmpMapper;
import kr.or.oho.mapper.FrcMapper;
import kr.or.oho.openmng.service.FrcService;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;

@Service
public class FrcServiceImpl implements FrcService {

	@Autowired
	FrcMapper frcMapper;
	
	@Autowired
	ComcdMapper comcdMapper;
	
	@Autowired
	FrcEmpMapper frcEmpMapper;
	
	@Override
	public String frcsNoSelect() {
		return this.frcMapper.frcsNoSelect();
	}
	
	@Override
	public List<ComcdVO> regionSelect(){
		return this.comcdMapper.regionSelect();
	}
	
	@Override
	public int add(FranchiseVO franchiseVO) {
		return this.frcMapper.add(franchiseVO);
	}
	
	@Override
	public String empNoSelect() {
		return this.frcEmpMapper.empNoSelect();
	}

	@Override
	public int addFrcEmp(EmployeeVO employeeVO) {
		return this.frcEmpMapper.addFrcEmp(employeeVO);
	}

	@Override
	public List<FranchiseVO> frcsRegionList() {
		return this.frcMapper.frcsRegionList();
	}

	@Override
	public List<ComcdVO> countRegion() {
		return this.frcMapper.countRegion();
	}

	@Override
	public List<ComcdVO> countRegionYear() {
		return this.frcMapper.countRegionYear();
	}

}
