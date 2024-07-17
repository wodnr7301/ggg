
package kr.or.oho.attendence.service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.attendence.service.HldyMngService;
import kr.or.oho.mapper.HldyMngMapper;
import kr.or.oho.vo.HldyMngLdgrVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HldyMngServiceImpl implements HldyMngService{

	@Autowired
	HldyMngMapper hldyMngMapper;
	
	@Override
	public List<HldyMngLdgrVO> list(String empNo){
		
		return hldyMngMapper.list(empNo);
	}

	@Override
	public List<HldyMngLdgrVO> btList(String empNo) {
		return hldyMngMapper.btList(empNo);
	} 
}
