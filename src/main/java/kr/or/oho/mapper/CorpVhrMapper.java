package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.CorpVhrVO;
import kr.or.oho.vo.EmployeeVO;

// 법인차량 관련 매퍼
public interface CorpVhrMapper {

	// 법인차량 리스트
	public List<CorpVhrVO> corpVhrList();
	
	// 법인차량 등록
	public int registerCorpVhr(CorpVhrVO corpVhrVO);
	
	// 법인차량 관리대장 리스트
	public List<CorpVhrVO> mngLedgerList();
	
	// 법인차량 예약
	public int reserveCorpVhr(CorpVhrVO corpVhrVO);
	
	// 법인차량 관리대장 리스트(관리자용)
	public List<CorpVhrVO> cvMngLdgr();
	
	// 대여사원 정보보기
	public EmployeeVO cvEmpDetail(EmployeeVO employeeVO);
	
	// 나의 법인차량대여이력
	public List<CorpVhrVO> mycvMngLdgr(String empNo);
	
	// 법인차량 반납처리
	public int rtnVhr(CorpVhrVO corpVhrVO);

	public EmployeeVO cvEmpDetail1(EmployeeVO employeeVO);
	public String cvEmpDetail2(EmployeeVO employeeVO);

}
