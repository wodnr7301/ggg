package kr.or.oho.alarm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.alarm.service.AlarmService;
import kr.or.oho.mapper.AlarmMapper;
import kr.or.oho.vo.AlarmVO;
import kr.or.oho.vo.EdnCndtnVO;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	AlarmMapper alarmMapper;
	
	/**
	 * 알림테이블에 알림등록하는 서비스
	 * @param alarmVO (등록할 알림 내용)
	 * @return
	 */
	@Override
	public int alarmCreate(AlarmVO alarmVO) {
		return this.alarmMapper.alarmCreate(alarmVO);
	}

	/**
 	 * 알림 조회해서 해당 계정 헤더에 알림 출력하는 서비스
 	 * @param empNo(회원 기본키)
 	 * @return
 	 */
	@Override
	public List<AlarmVO> header(String empNo) {
		return this.alarmMapper.header(empNo);
	}

	/**
	 * 알림 확인 처리하는 서비스
	 * @param alrNo(알림 기본키)
	 * @return
	 */
	@Override
	public int updateY(AlarmVO alarmVO) {
		return this.alarmMapper.updateY(alarmVO);
	}

	/**
	 * 교육일정 등록 알림 처리를 위한 최대값 가져오는 서비스
	 * @return
	 */
	@Override
	public String getMaxEdu() {
		return this.alarmMapper.getMaxEdu();
	}

	/**
	 * 교육일정 등록 알림 처리를 위한 사원번호 가져오는 서비스
	 * @param frcsNo(가맹점 기본키)
	 * @return
	 */
	@Override
	public String getEmpNo(String frcsNo) {
		return this.alarmMapper.getEmpNo(frcsNo);
	}

	/**
	 * 교육일정 최대값 구해오는 서비스
	 * @return
	 */
	@Override
	public String getmax() {
		return this.alarmMapper.getMax();
	}

	/**
	 * 교육정보 가져오는 서비스
	 * @param ecNo(교육정보 기본키)
	 * @return
	 */
	@Override
	public EdnCndtnVO getEduDetail(String ecNo) {
		return this.alarmMapper.getEduDetail(ecNo);
	}
}
