package kr.or.oho.frcowner.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.frcowner.service.RevenueService;
import kr.or.oho.mapper.RevenueMapper;
import kr.or.oho.vo.RevenueVO;

@Service
public class RevenueServiceImpl implements RevenueService {

	@Autowired
	RevenueMapper revenueMapper;
	
	@Override
	public List<RevenueVO> list(String fsWrtYear, String empNo) {
		List<RevenueVO> revenueList = this.revenueMapper.revenueList(fsWrtYear, empNo);
		
		return revenueList;
	}

	@Override
	public int createRvn(RevenueVO revenueVO) {
		return this.revenueMapper.createRvn(revenueVO);
	}

	@Override
	public int updateRvn(RevenueVO revenueVO) {
		return this.revenueMapper.updateRvn(revenueVO);
	}

	@Override
	public int deleteRvn(RevenueVO revenueVO) {
		return this.revenueMapper.deleteRvn(revenueVO);
	}

	@Override
	public List<RevenueVO> data(String fsWrtYear, String empNo) {
		List<RevenueVO> revenueData = this.revenueMapper.revenueData(fsWrtYear, empNo);
		
		return revenueData;
	}

	@Override
	public List<RevenueVO> monthList(String fsWrtYear, String empNo) {
		return this.revenueMapper.monthList(fsWrtYear, empNo);
	}

	@Override
	public List<RevenueVO> yearList(RevenueVO revenueVO, String empNo) {
		return this.revenueMapper.yearList(revenueVO, empNo);
	}

	@Override
	public List<RevenueVO> quaterList(String fsWrtYear, String empNo) {
		return this.revenueMapper.quaterList(fsWrtYear, empNo);
	}

	@Override
	public List<RevenueVO> list(RevenueVO revenue) {
		return this.revenueMapper.revenueList2(revenue);
	}

}
