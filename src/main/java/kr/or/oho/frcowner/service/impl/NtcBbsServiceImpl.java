package kr.or.oho.frcowner.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.frcowner.service.NtcBbsService;
import kr.or.oho.mapper.NtcBbsMapper;
import kr.or.oho.vo.ComentVO;
import kr.or.oho.vo.NtcBbsVO;

@Service
public class NtcBbsServiceImpl implements NtcBbsService {

	@Autowired
	NtcBbsMapper ntcBbsMapper;
	
	@Override
	public List<NtcBbsVO> list() {
		List<NtcBbsVO> ntcBbsList = this.ntcBbsMapper.list();
		 
		// displayNo 설정
	       for (int i = 0; i < ntcBbsList.size(); i++) {
	           ntcBbsList.get(i).setDisplayNo(i + 1); 
	       }
		
		return ntcBbsList;
	}

	@Override
	public int create(NtcBbsVO ntcBbsVO) {
		return this.ntcBbsMapper.create(ntcBbsVO);
	}
	
	@Override
	public NtcBbsVO detail(String nbNo) {
		return ntcBbsMapper.detail(nbNo);
	}

	@Override
	public void count(String nbNo) {
		this.ntcBbsMapper.count(nbNo);
	}

	@Override
	public int update(NtcBbsVO ntcBbsVO) {
		return this.ntcBbsMapper.update(ntcBbsVO);
	}

	@Override
	public void delete(String nbNo) {
		ntcBbsMapper.delete(nbNo);
	}

	@Override
	public List<ComentVO> comentList(String nbNo) {
		return ntcBbsMapper.comentList(nbNo);
	}

	@Override
	public int createCmt(ComentVO comentVO) {
		return this.ntcBbsMapper.createCmt(comentVO);
	}

	@Override
	public int updateCmt(ComentVO comentVO) {
		return this.ntcBbsMapper.updateCmt(comentVO);
	}

	@Override
	public int deleteCmt(ComentVO comentVO) {
		return this.ntcBbsMapper.deleteCmt(comentVO);
	}

	@Override
	public List<NtcBbsVO> ntcEmpList() {
		List<NtcBbsVO> ntcBbsList = this.ntcBbsMapper.ntcEmpList();
		 
		// displayNo 설정
	       for (int i = 0; i < ntcBbsList.size(); i++) {
	           ntcBbsList.get(i).setDisplayNo(i + 1); 
	       }
		
		return ntcBbsList;
	}

}
