package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.DeptVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.JsTreeVO;

public interface DeptMapper {

	public List<JsTreeVO> getDept();

	public List<JsTreeVO> getEmp();

	public DeptVO getDeptCn(JsTreeVO jsTreeVO);

	public List<EmployeeVO> getEmpCn(JsTreeVO jsTreeVO);

	public List<DeptVO> getAllDept();

	public int moveDept(EmployeeVO employeeVO);

}
