package kr.or.oho.interviewee.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.interviewee.service.IntervieweeService;
import kr.or.oho.mapper.IntervieweeMapper;
import kr.or.oho.vo.IntervieweeVO;
import kr.or.oho.vo.ReserveFounderVO;

@Service
public class IntervieweeServiceImpl implements IntervieweeService{

	@Autowired
	IntervieweeMapper intervieweeMapper;

	@Override
	public List<IntervieweeVO> getList() {
		return this.intervieweeMapper.getList();
	}

	@Override
	public int insertReserveFounder(ReserveFounderVO data) {
		return this.intervieweeMapper.insertReserveFounder(data);
	}
	
}
