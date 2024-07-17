package kr.or.oho.frcorder.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.oho.frcorder.service.FrcsMainPageService;
import kr.or.oho.mapper.FrcsMainPageMapper;
import kr.or.oho.vo.RevenueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FrcsMainPageServiceImpl implements FrcsMainPageService{

	@Autowired
	FrcsMainPageMapper frcsMainPageMapper;

	@Override
	public List<RevenueVO> getAllRevenue(String frcsNo) {
		return this.frcsMainPageMapper.getAllRevenue(frcsNo);
	}
	 
}
