package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.HldyMngLdgrVO;

public interface HldyMngMapper {

	List<HldyMngLdgrVO> list(String empNo);
	
	List<HldyMngLdgrVO> btList(String empNo);
	
}
