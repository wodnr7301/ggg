package kr.or.oho.openmng.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.CtrtVO;
import kr.or.oho.vo.FrcsTypeVO;

public interface CtrtService {
	public List<CtrtVO> list();
	public List<CtrtVO> list(FrcsTypeVO frcsTypeVO);
	public CtrtVO detail(CtrtVO ctrtVO);
	public String ctrtNoSelect();
	public int add(CtrtVO ctrtVO);
	public List<FrcsTypeVO> frcsTypeSelect();
	public int update(CtrtVO ctrtVO);
	public List<FrcsTypeVO> getFtCnt();
	public int getClsYnCnt(Map<String,String> map);
}
