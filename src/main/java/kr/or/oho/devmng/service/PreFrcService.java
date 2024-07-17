package kr.or.oho.devmng.service;

import java.util.List;

import kr.or.oho.vo.InterviewerVO;
import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;

public interface PreFrcService {
	public List<ReserveFounderVO> list();
	public String ibiNoSelect();
	public int ymdInsert(ItvBscInfoVO itvBscInfoVO);
	public int interviewerInsert(InterviewerVO interviewerVO);
	public int listCnt();
}
