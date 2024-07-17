package kr.or.oho.openmng.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.EdnCndtnMapper;
import kr.or.oho.mapper.EdnPrgrmMapper;
import kr.or.oho.openmng.service.EdnCndtnService;
import kr.or.oho.vo.EdnCndtnVO;
import kr.or.oho.vo.EdnPrgrmVO;
import kr.or.oho.vo.FranchiseVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EdnCndtnServiceImpl implements EdnCndtnService {

	@Autowired
	EdnCndtnMapper ednCndtnMapper;
	
	@Autowired
	EdnPrgrmMapper ednPrgrmMapper;
	
	@Override
	public List<EdnCndtnVO> list() {
		List<EdnCndtnVO> ednCndtnList = this.ednCndtnMapper.list();
		
		for (EdnCndtnVO ednCndtnVO : ednCndtnList) {
			
			Date ymd = ednCndtnVO.getEcYmd();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	 
	        String newYmd = sdf.format(ymd);
	        log.debug("newYmd : "+newYmd);
	        
	        ednCndtnVO.setEcYmdF(newYmd);
		}
		
		return ednCndtnList;
	}

	@Override
	public List<EdnPrgrmVO> getEpNmList() {
		return this.ednPrgrmMapper.getEpNmList();
	}

	@Override
	public List<EdnCndtnVO> getList(EdnPrgrmVO ednPrgrmVO) {
		List<EdnCndtnVO> ednCndtnList = this.ednCndtnMapper.getList(ednPrgrmVO);
		
		for (EdnCndtnVO ednCndtnVO : ednCndtnList) {
			
			Date ymd = ednCndtnVO.getEcYmd();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	 
	        String newYmd = sdf.format(ymd);
	        log.debug("newYmd : "+newYmd);
	        
	        ednCndtnVO.setEcYmdF(newYmd);
		}
		
		return ednCndtnList;
	}

	@Override
	public int delete(EdnCndtnVO ednCndtnVO) {
		return this.ednCndtnMapper.delete(ednCndtnVO);
	}

	@Override
	public int add(EdnCndtnVO ednCndtnVO) {
		return this.ednCndtnMapper.add(ednCndtnVO);
	}

	@Override
	public int update(EdnCndtnVO ednCndtnVO) {
		return this.ednCndtnMapper.update(ednCndtnVO);
	}

	@Override
	public List<EdnPrgrmVO> getEpNmDetailList(EdnPrgrmVO ednPrgrmVO) {
		return this.ednPrgrmMapper.getEpNmDetailList(ednPrgrmVO);
	}

	@Override
	public List<FranchiseVO> getTrnFrcList(EdnPrgrmVO ednPrgrmVO) {
		return this.ednCndtnMapper.getTrnFrcList(ednPrgrmVO);
	}

	@Override
	public List<EdnPrgrmVO> epEcYCnt() {
		return this.ednCndtnMapper.epEcYCnt();
	}

	@Override
	public int getEcYnfCnt(Map<String, String> map) {
		
		
		return this.ednCndtnMapper.getEcYnfCnt(map);
	}

	@Override
	public List<EdnCndtnVO> trnList(String empNo) {
		return this.ednCndtnMapper.trnList(empNo);
	}

	@Override
	public int myEcYnfCnt(Map<String, String> map) {
		return this.ednCndtnMapper.myEcYnfCnt(map);
	}

	@Override
	public List<List<EdnCndtnVO>> getEcYnfCntFirst() {
		List<EdnCndtnVO> ynf1 = this.ednCndtnMapper.getEcYnfCntFirst("24년도 신규가맹점 개인정보 보호 교육");
		List<EdnCndtnVO> ynf2 = this.ednCndtnMapper.getEcYnfCntFirst("24년도 신규가맹점 산업 안전 보건 교육");
		List<EdnCndtnVO> ynf3 = this.ednCndtnMapper.getEcYnfCntFirst("24년도 신규가맹점 성희롱 예방 교육");
		List<EdnCndtnVO> ynf4 = this.ednCndtnMapper.getEcYnfCntFirst("24년도 신규가맹점 장애인 인식개선 교육");
		List<EdnCndtnVO> ynf5 = this.ednCndtnMapper.getEcYnfCntFirst("24년도 신규가맹점 직장 내 괴롭힘 예방 교육");
		List<EdnCndtnVO> ynf6 = this.ednCndtnMapper.getEcYnfCntFirst("etc");
		
		List<List<EdnCndtnVO>> list = new ArrayList<List<EdnCndtnVO>>();
		list.add(ynf1);
		list.add(ynf2);
		list.add(ynf3);
		list.add(ynf4);
		list.add(ynf5);
		list.add(ynf6);
		
		log.debug("서비스임플 list : " + list);
		
		return list;
	}

}
