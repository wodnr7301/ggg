package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.InterviewerVO;
import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;

public interface PreFrcMapper {
	public List<ReserveFounderVO> list();
	public String ibiNoSelect();
	public int ymdInsert(ItvBscInfoVO itvBscInfoVO);
	public int interviewerInsert(InterviewerVO interviewerVO);
	public int listCnt();
}
