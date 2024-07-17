package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;

public interface FrcCnsltMapper {
	public List<ReserveFounderVO> list(String empNo);
	public ReserveFounderVO detail(ItvBscInfoVO itvBscInfoVO);
	public int update(ItvBscInfoVO itvBscInfoVO);
	public int interviewerDelete(ItvBscInfoVO itvBscInfoVO);
	public int cancel(ItvBscInfoVO itvBscInfoVO);
	public List<ReserveFounderVO> cnsltYList();
	public ReserveFounderVO cnsltYOne(ReserveFounderVO reserveFounderVO);	
	public int listCnt(Map<String,String> map);
}
