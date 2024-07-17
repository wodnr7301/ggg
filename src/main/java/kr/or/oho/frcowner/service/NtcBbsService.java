package kr.or.oho.frcowner.service;

import java.util.List;

import kr.or.oho.vo.ComentVO;
import kr.or.oho.vo.NtcBbsVO;

public interface NtcBbsService {

	public List<NtcBbsVO> list();
	
	public NtcBbsVO detail(String nbNo);
	
	public void count(String nbNo);
	
	public int create(NtcBbsVO ntcBbsVO);
	
	public int update(NtcBbsVO ntcBbsVO);

	public void delete(String nbNo);
	
	public List<ComentVO> comentList(String nbNo);
	
	public int createCmt(ComentVO comentVO);
	
	public int updateCmt(ComentVO comentVO);
	
	public int deleteCmt(ComentVO comentVO);

	public List<NtcBbsVO> ntcEmpList();



}
