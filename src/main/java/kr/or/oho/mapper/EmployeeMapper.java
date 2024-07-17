package kr.or.oho.mapper;


import kr.or.oho.vo.EmployeeVO;

// 로그인
public interface EmployeeMapper {
	
	public EmployeeVO detail (String username);
	
	public EmployeeVO getDetpNo (String username);
	
	// 비밀번호 찾기전 한번더 확인하기
	public String getPw(EmployeeVO employeeVO);
	
	public int updatePw (EmployeeVO empPswd);
	
}
