package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.ComentVO;
import kr.or.oho.vo.NtcBbsVO;

public interface NtcBbsMapper {

	public List<NtcBbsVO> list();

	public int create(NtcBbsVO ntcBbsVO);

	public NtcBbsVO detail(String nbNo);

	void count(String nbNo);

	public int update(NtcBbsVO ntcBbsVO);

	public void delete(String nbNo);

	public List<ComentVO> comentList(String nbNo);

	public int createCmt(ComentVO comentVO);

	public int updateCmt(ComentVO comentVO);

	public int deleteCmt(ComentVO comentVO);

	public List<NtcBbsVO> ntcEmpList();

}
