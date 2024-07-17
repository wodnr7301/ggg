package kr.or.oho.openmng.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.EdnPrgrmMapper;
import kr.or.oho.openmng.service.EdnPrgrmService;
import kr.or.oho.vo.EdnPrgrmVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EdnPrgrmServiceImpl implements EdnPrgrmService{

	@Autowired
	EdnPrgrmMapper ednPrgrmMapper;
	
	@Override
	public List<EdnPrgrmVO> list() {
		List<EdnPrgrmVO> ednPrgrmList = this.ednPrgrmMapper.list(); 
		for (EdnPrgrmVO ednPrgrmVO : ednPrgrmList) {
			String epNm = ednPrgrmVO.getEpNm();
			String epNm1 = epNm.split("-")[0];
			String epNm2 = epNm.split("-")[1];
			log.debug("epNm,epNm1,epNm2 : "+epNm+","+epNm1+","+epNm2);
			ednPrgrmVO.setEpNm1(epNm1);
			ednPrgrmVO.setEpNm2(epNm2);
		}
		return ednPrgrmList;
	}

	@Override
	public int add(EdnPrgrmVO ednPrgrmVO) {
		return this.ednPrgrmMapper.add(ednPrgrmVO);
	}

	@Override
	public int update(EdnPrgrmVO ednPrgrmVO) {
		return this.ednPrgrmMapper.update(ednPrgrmVO);
	}

	@Override
	public int delete(EdnPrgrmVO ednPrgrmVO) {
		return this.ednPrgrmMapper.delete(ednPrgrmVO);
	}

}
