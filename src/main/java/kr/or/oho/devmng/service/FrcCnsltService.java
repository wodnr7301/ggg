package kr.or.oho.devmng.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;

public interface FrcCnsltService {
	public List<ReserveFounderVO> list(String empNo);
	public ReserveFounderVO detail(ItvBscInfoVO itvBscInfoVO);
	public int update(ItvBscInfoVO itvBscInfoVO);
	/**
	 * 면접관 삭제, 면접기본정보 삭제 처리
	 * @param itvBscInfoVO
	 * @return 삭제성공시 true
	 */
	public boolean cancel(ItvBscInfoVO itvBscInfoVO);
	public List<ReserveFounderVO> cnsltYList();
	public ReserveFounderVO cnsltYOne(ReserveFounderVO reserveFounderVO);
	public int listCnt(Map<String,String> map);
}
