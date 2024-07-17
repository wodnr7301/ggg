package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.CtrtVO;
import kr.or.oho.vo.FrcsTypeVO;

public interface CtrtMapper {
	public List<CtrtVO> list();//전체계약조회
	public List<CtrtVO> list(FrcsTypeVO frcsTypeVO);//각가맹점유형별계약조회
	public CtrtVO detail(CtrtVO ctrtVO);
	public String ctrtNoSelect();
	public int add(CtrtVO ctrtVO);
	public List<FrcsTypeVO> frcsTypeSelect();
	public int update(CtrtVO ctrtVO);
	public List<String> goodFrc();
	public List<FrcsTypeVO> getFtCnt();
	public int getClsYnCnt(Map<String,String> map);
}
