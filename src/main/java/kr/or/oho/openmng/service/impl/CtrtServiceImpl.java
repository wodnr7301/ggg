package kr.or.oho.openmng.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.CtrtMapper;
import kr.or.oho.openmng.service.CtrtService;
import kr.or.oho.vo.CtrtVO;
import kr.or.oho.vo.FrcsTypeVO;

@Service
public class CtrtServiceImpl implements CtrtService{

	@Autowired
	CtrtMapper ctrtMapper;
	
	@Override
	public List<CtrtVO> list() {
		List<CtrtVO> ctrtList = this.ctrtMapper.list();
		List<String> goodFrcList = this.ctrtMapper.goodFrc();
		
		for (CtrtVO ctrtVO : ctrtList) {
			for (String goodFrc : goodFrcList) {
				if(ctrtVO.getFrcsNo().equals(goodFrc)) {
					ctrtVO.setGoodFrc("Y");
				}
			}
		}
		
		return ctrtList;
	}
	
	@Override
	public List<CtrtVO> list(FrcsTypeVO frcsTypeVO) {
		List<CtrtVO> ctrtList = this.ctrtMapper.list(frcsTypeVO);
		List<String> goodFrcList = this.ctrtMapper.goodFrc();
		
		for (CtrtVO ctrtVO : ctrtList) {
			for (String goodFrc : goodFrcList) {
				if(ctrtVO.getFrcsNo().equals(goodFrc)) {
					ctrtVO.setGoodFrc("Y");
				}
			}
		}
		
		return ctrtList;
	}

	@Override
	public CtrtVO detail(CtrtVO ctrtVO) {
		return this.ctrtMapper.detail(ctrtVO);
	}
	
	@Override
	public String ctrtNoSelect() {
		return this.ctrtMapper.ctrtNoSelect();
	}

	@Override
	public int add(CtrtVO ctrtVO) {
		return this.ctrtMapper.add(ctrtVO);
	}

	@Override
	public List<FrcsTypeVO> frcsTypeSelect() {
		return this.ctrtMapper.frcsTypeSelect();
	}

	@Override
	public int update(CtrtVO ctrtVO) {
		return this.ctrtMapper.update(ctrtVO);
	}

	@Override
	public List<FrcsTypeVO> getFtCnt() {
		return this.ctrtMapper.getFtCnt();
	}

	@Override
	public int getClsYnCnt(Map<String, String> map) {
		return this.ctrtMapper.getClsYnCnt(map);
	}

}
