package kr.or.oho.attendence.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.HldyMngLdgrVO;

public interface HldyMngService {

	List<HldyMngLdgrVO> list(String empNo);
	
	List<HldyMngLdgrVO> btList(String empNo);
	
}
