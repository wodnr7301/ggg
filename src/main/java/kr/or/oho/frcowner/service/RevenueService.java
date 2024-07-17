package kr.or.oho.frcowner.service;

import java.util.List;

import kr.or.oho.vo.RevenueVO;

public interface RevenueService {

	List<RevenueVO> list(String fsWrtYear, String empNo); 			//매출 현황 관리(리스트) 

	int createRvn(RevenueVO revenueVO);					//매출 현황 관리(등록)
	
	int updateRvn(RevenueVO revenueVO);					//매출 현황 관리(수정)
	
	int deleteRvn(RevenueVO revenueVO);					//매출 현황 관리(삭제)

	List<RevenueVO> data(String fsWrtYear, String empNo);				//매출관리 메인 페이지(통계)

	List<RevenueVO> monthList(String fsWrtYear, String empNo);		//월별 매출 리스트 
	
	List<RevenueVO> yearList(RevenueVO revenueVO, String empNo);		//연도별 매출 리스트
	
	List<RevenueVO> quaterList(String fsWrtYear, String empNo);		//분기별 매출 리스트

	List<RevenueVO> list(RevenueVO revenue);

}
