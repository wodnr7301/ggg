package kr.or.oho.alarm.service;

import java.util.List;

import kr.or.oho.vo.AlarmVO;
import kr.or.oho.vo.EdnCndtnVO;

public interface AlarmService {
	
	/**
	 * 알림테이블에 알림등록하는 서비스
	 * @param alarmVO (등록할 알림 내용)
	 * @return
	 */
 	public int alarmCreate(AlarmVO alarmVO);
 	
 	/**
 	 * 알림 조회해서 해당 계정 헤더에 알림 출력하는 서비스
 	 * @param empNo(회원 기본키)
 	 * @return
 	 */
	public List<AlarmVO> header(String empNo);

	/**
	 * 알림 확인 처리하는 서비스
	 * @param alrNo(알림 기본키)
	 * @return
	 */
	public int updateY(AlarmVO alarmVO);
	
	/**
	 * 교육일정 등록 알림 처리를 위한 최대값 가져옴
	 * @return
	 */
	public String getMaxEdu();
	
	/**
	 * 교육일정 등록 알림 처리를 위한 사원번호 가져옴
	 * @param frcsNo(가맹점 기본키)
	 * @return
	 */
	public String getEmpNo(String frcsNo);

	/**
	 * 교육일정 최대값 구해오기
	 * @return
	 */
	public String getmax();
	
	/**
	 * 교육정보 가져오기
	 * @param ecNo(교육정보 기본키)
	 * @return
	 */
	public EdnCndtnVO getEduDetail(String ecNo);

}
