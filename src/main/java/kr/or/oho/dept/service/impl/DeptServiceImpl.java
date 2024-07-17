package kr.or.oho.dept.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.dept.service.DeptService;
import kr.or.oho.mapper.DeptMapper;
import kr.or.oho.vo.DeptVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.JsTreeVO;

@Service
public class DeptServiceImpl implements DeptService {
	
	@Autowired
	DeptMapper deptMapper;

	@Override
	public List<JsTreeVO> getDept() {
		return this.deptMapper.getDept();
	}

	@Override
	public List<JsTreeVO> getEmp() {
		return this.deptMapper.getEmp();
	}

	@Override
	public DeptVO getDeptCn(JsTreeVO jsTreeVO) {
		return this.deptMapper.getDeptCn(jsTreeVO);
	}

	@Override
	public List<EmployeeVO> getEmpCn(JsTreeVO jsTreeVO) {
		return this.deptMapper.getEmpCn(jsTreeVO);
	}

	@Override
	public List<DeptVO> getAllDept() {
		return this.deptMapper.getAllDept();
	}

	@Override
	public int moveDept(EmployeeVO employeeVO) {
		return this.deptMapper.moveDept(employeeVO);
	}
}
