package kr.or.oho.mng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.MngMapper;
import kr.or.oho.mng.service.MngService;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.MngVO;

@Service
public class MngServiceImpl implements MngService {

	@Autowired
	MngMapper mngMapper;

	@Override
	public List<MngVO> getList() {
		return this.mngMapper.getList();
	}

	@Override
	public MngVO getCount() {
		return this.mngMapper.getCount();
	}

	@Override
	public int createMng(MngVO mngVO) {
		return this.mngMapper.createMng(mngVO);
	}

	@Override
	public List<MngVO> getOneDay(MngVO mngVO) {
		return this.mngMapper.getOneDay(mngVO);
	}

	@Override
	public MngVO detail(String mngNo) {
		return this.mngMapper.detail(mngNo);
	}

	@Override
	public int update(MngVO mngVO) {
		return this.mngMapper.update(mngVO);
	}

	@Override
	public int delete(String mngNo) {
		return this.mngMapper.delete(mngNo);
	}

	@Override
	public int done(String mngNo) {
		return this.mngMapper.done(mngNo);
	}

	@Override
	public String getMax() {
		return this.mngMapper.getMax();
	}

	
	
}
