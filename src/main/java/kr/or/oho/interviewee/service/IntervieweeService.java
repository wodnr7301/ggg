package kr.or.oho.interviewee.service;

import java.util.List;

import kr.or.oho.vo.IntervieweeVO;
import kr.or.oho.vo.ReserveFounderVO;

public interface IntervieweeService {

	/**
	 * 전체 면접자 리스트 받아오는 서비스
	 * @return
	 */
	public List<IntervieweeVO> getList();
	
	/**
	 * 예비창업자 등록 서비스
	 * @param data
	 * @return
	 */
	public int insertReserveFounder(ReserveFounderVO data);

}
