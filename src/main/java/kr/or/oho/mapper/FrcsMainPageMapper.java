package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.RevenueVO;

public interface FrcsMainPageMapper {

	List<RevenueVO> getAllRevenue(String frcsNo);

}
