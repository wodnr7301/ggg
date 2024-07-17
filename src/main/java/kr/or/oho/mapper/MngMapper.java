package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.MngVO;

public interface MngMapper {

	public List<MngVO> getList();

	public MngVO getCount();

	public int createMng(MngVO mngVO);

	public List<MngVO> getOneDay(MngVO mngVO);

	public MngVO detail(String mngNo);

	public int update(MngVO mngVO);

	public int delete(String mngNo);

	public int done(String mngNo);

	public String getMax();


}
