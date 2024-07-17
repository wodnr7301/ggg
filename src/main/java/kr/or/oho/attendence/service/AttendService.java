package kr.or.oho.attendence.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.AttendVO;

public interface AttendService {
	
	List<AttendVO> getAttendList(String empNo);
	int getCountList(Map<String, Object> map);
	int createPost(AttendVO attendVO);
	int updatePost(AttendVO attendVO);
	
	/**
	 * 로그인 한 사람 출근 날짜 받아오기
	 * @param map(empNo, waNo)
	 * @return waNo, waYmd
	 */
	AttendVO getWaYmd(Map<String, Object> map);
	/**
	 * 퇴근 시간 받아오기
	 * @param map(empNo, waNo)
	 * @return waNo, eaOutTime
	 */
	AttendVO geteaOutTime(Map<String, Object> map);
	/**
	 * 조퇴 문제 때문에 내림차순 정렬 후 퇴근시간 받아오기
	 * @param map(empNo, waNo)
	 * @return waNo, eaOutTime 
	 */
	AttendVO geteaOutTime2(String empNo);







}
