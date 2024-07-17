package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.AttendVO;

public interface AttendMapper {

	List<AttendVO> getAttendList(String empNo);
	
	int getCountList(Map<String, Object> map);

	int createPost(AttendVO attendVO);

	int updatePost(AttendVO attendVO);

	AttendVO getWaYmd(Map<String, Object> map);

	AttendVO geteaOutTime(Map<String, Object> map);

	AttendVO getWaNo();

	AttendVO geteaOutTime2(String empNo);
	
	
}
