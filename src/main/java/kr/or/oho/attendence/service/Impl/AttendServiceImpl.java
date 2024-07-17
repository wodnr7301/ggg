package kr.or.oho.attendence.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.attendence.service.AttendService;
import kr.or.oho.mapper.AttendMapper;
import kr.or.oho.vo.AttendVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AttendServiceImpl implements AttendService{
	
	@Autowired
	AttendMapper attendMapper;
	
	@Override
	public List<AttendVO> getAttendList(String empNo) {
		
		return attendMapper.getAttendList(empNo);
	}
	
	@Override
	public int getCountList(Map<String, Object> map) {
		
		return attendMapper.getCountList(map);
	}
	
	@Override
	public int createPost(AttendVO attendVO) {
		
		return attendMapper.createPost(attendVO);
	}

	@Override
	public int updatePost(AttendVO attendVO) {

		return attendMapper.updatePost(attendVO);
	}

	@Override
	public AttendVO getWaYmd(Map<String, Object> map) {
		
		return attendMapper.getWaYmd(map);
	}

	@Override
	public AttendVO geteaOutTime(Map<String, Object> map) {

		return attendMapper.geteaOutTime(map);
	}

	@Override
	public AttendVO geteaOutTime2(String empNo) {
		
		return attendMapper.geteaOutTime2(empNo);
	}

	
	
	
}
