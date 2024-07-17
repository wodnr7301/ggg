package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.AlarmVO;
import kr.or.oho.vo.EdnCndtnVO;

public interface AlarmMapper {
	
	/**
	 * 알림테이블에 알림등록하는 매퍼
	 * @param alarmVO (등록할 알림 내용)
	 * @return
	 */
	public int alarmCreate(AlarmVO alarmVO);
	
	/**
 	 * 알림 조회해서 해당 계정 헤더에 알림 출력하는 매퍼
 	 * @param empNo(회원 기본키)
 	 * @return
 	 */
	public List<AlarmVO> header(String empNo);
	
	/**
	 * 알림 확인 처리하는 매퍼
	 * @param alrNo(알림 기본키)
	 * @return
	 */
	public int updateY(AlarmVO alarmVO);

	/**
	 * 교육일정 등록 알림 처리를 위한 매퍼
	 * @return
	 */
	public String getMaxEdu();

	/**
	 * 교육일정 등록 알림 처리를 위한 매퍼
	 * @param frcsNo(가맹점 기본키)
	 * @return
	 */
	public String getEmpNo(String frcsNo);

	/**
	 * 교육일정 최대값 구해오는 매퍼
	 * @return
	 */
	public String getMax();

	/**
	 * 교육정보 가져오는 매퍼
	 * @param ecNo(교육정보 기본키)
	 * @return
	 */
	public EdnCndtnVO getEduDetail(String ecNo);

}
