package kr.or.oho.salary.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.SalaryMapper;
import kr.or.oho.salary.service.SalaryService;
import kr.or.oho.vo.DdcVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.GiveVO;
import kr.or.oho.vo.SalaryVO;

@Service
public class SalaryServiceImpl implements SalaryService {

	@Autowired
	SalaryMapper salaryMapper;
	
	@Override
	public List<SalaryVO> allList() {
		return this.salaryMapper.allList();
	}

	@Override
	public SalaryVO getSalary(String amlNo) {
		return this.salaryMapper.getSalary(amlNo);
	}

	@Override
	public GiveVO getGive(String giveNo) {
		return this.salaryMapper.getGive(giveNo);
	}

	@Override
	public DdcVO getDdc(String ddcNo) {
		return this.salaryMapper.getDdc(ddcNo);
	}

	@Override
	public List<EmployeeVO> getName() {
		return this.salaryMapper.getName();
	}

	@Override
	public int createAjax(SalaryVO salaryVO) {
		int cnt =0;
		
		//give테이블 insert
		cnt += this.salaryMapper.createGive(salaryVO);
		
		//ddc테이블 insert
		cnt += this.salaryMapper.createDdc(salaryVO);
		
		//ACNT_MNG_LDGR테이블 insert
		cnt += this.salaryMapper.createSalary(salaryVO);
		
		return cnt;
	}

	@Override
	public int deleteAjax(SalaryVO salaryVO) {
		int cnt =0;
		
		//ACNT_MNG_LDGR테이블 delete
		cnt += this.salaryMapper.deleteSalary(salaryVO);
		
		//give테이블 delete
		cnt += this.salaryMapper.deleteGive(salaryVO);
		
		//ddc테이블 delete
		cnt += this.salaryMapper.deleteDdc(salaryVO);
		
		return cnt;
	}

	@Override
	public int updateAjax(SalaryVO salaryVO) {
		int cnt = 0;
		
		//ACNT_MNG_LDGR테이블 delete
		cnt += this.salaryMapper.updateSalary(salaryVO);
		
		//give테이블 delete
		cnt += this.salaryMapper.updateGive(salaryVO);
		
		//ddc테이블 delete
		cnt += this.salaryMapper.updateDdc(salaryVO);
		
		return cnt;
	}

}
