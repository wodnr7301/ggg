package kr.or.oho.devmng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.devmng.service.PreFrcService;
import kr.or.oho.mapper.PreFrcMapper;
import kr.or.oho.vo.InterviewerVO;
import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;

@Service
public class PreFrcServiceImpl implements PreFrcService {

	@Autowired
	PreFrcMapper preFrcMapper;
	
	@Override
	public List<ReserveFounderVO> list() {
		return this.preFrcMapper.list();
	}
	
	@Override
	public String ibiNoSelect() {
		return this.preFrcMapper.ibiNoSelect();
	}

	@Override
	public int ymdInsert(ItvBscInfoVO itvBscInfoVO) {
		return this.preFrcMapper.ymdInsert(itvBscInfoVO);
	}

	@Override
	public int interviewerInsert(InterviewerVO interviewerVO) {
		return this.preFrcMapper.interviewerInsert(interviewerVO);
	}

	@Override
	public int listCnt() {
		return this.preFrcMapper.listCnt();
	}

}
