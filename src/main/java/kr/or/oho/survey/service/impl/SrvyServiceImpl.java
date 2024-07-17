package kr.or.oho.survey.service.impl;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.mapper.SrvyMapper;
import kr.or.oho.survey.service.SrvyService;
import kr.or.oho.vo.AnsMcVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.ExampleVO;
import kr.or.oho.vo.QstnMcVO;
import kr.or.oho.vo.SrvyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SrvyServiceImpl implements SrvyService{

	@Autowired
	SrvyMapper srvyMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Override
	public String srvyNoSelect() {
		return this.srvyMapper.srvyNoSelect();
	}
	
	@Override
	public String qmNoSelect() {
		return this.srvyMapper.qmNoSelect();
	}

	@Override
	public boolean srvyAdd(SrvyVO srvyVO, Principal principal) {
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());
		String empNo = emp.getEmpNo();
		
		String srvyNo = this.srvyMapper.srvyNoSelect();
		
		srvyVO.setEmpNo(empNo);
		srvyVO.setSrvyNo(srvyNo);
		log.debug("조사자 사원번호, 설문번호 세팅한 srvyVO : " + srvyVO);
		
		int resultSrvy = this.srvyMapper.srvyAdd(srvyVO);
		log.debug("srvy result : " + resultSrvy);
		
		int resultQstn = 0;
		int resultExp = 0;
		List<QstnMcVO> qstnMcList = srvyVO.getQstnMcList();
		for (QstnMcVO qstnMcVO : qstnMcList) {
			String qmNo = this.srvyMapper.qmNoSelect();
			
			qstnMcVO.setSrvyNo(srvyNo);
			qstnMcVO.setQmNo(qmNo);
			log.debug("설문번호, 질문번호 세팅한 qstnMcVO : " + qstnMcVO);
			
			resultQstn += this.srvyMapper.qmcAdd(qstnMcVO);
			
			List<ExampleVO> exampleList = qstnMcVO.getExampleList();
			for (ExampleVO exampleVO : exampleList) {
				exampleVO.setSrvyNo(srvyNo);
				exampleVO.setQmNo(qmNo);
				log.debug("설문번호, 질문번호 세팅한 exampleVO : " + exampleVO);
				
				resultExp += this.srvyMapper.expAdd(exampleVO);
			}
			log.debug("exp result : " + resultExp);
		}
		log.debug("qstn result : " + resultQstn);
		
		if(resultSrvy > 0 && resultQstn == qstnMcList.size() && resultExp == qstnMcList.size()*4) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public List<SrvyVO> list() {
		return this.srvyMapper.list();
	}

	@Override
	public int srvyDelete(SrvyVO srvyVO) {
		int result = this.srvyMapper.expDelete(srvyVO);
		result += this.srvyMapper.qmcDelete(srvyVO);
		result += this.srvyMapper.srvyDelete(srvyVO);
		return result;
	}

	@Override
	public int updateSurvey(SrvyVO srvyVO) {
		return this.srvyMapper.updateSurvey(srvyVO);
	}

	@Override
	public SrvyVO surveyDetail(SrvyVO srvyVO) {
		return this.srvyMapper.surveyDetail(srvyVO);
	}

	@Override
	public List<QstnMcVO> qmcDetail(SrvyVO srvyVO) {
		return this.srvyMapper.qmcDetail(srvyVO);
	}

	@Override
	public List<ExampleVO> expDetail(Map<String,String> map) {
		return this.srvyMapper.expDetail(map);
	}

	@Override
	public int submitAns(AnsMcVO ansMcVO) {
		return this.srvyMapper.submitAns(ansMcVO);
	}

	@Override
	public List<SrvyVO> ableSrvyList(String srvyTrgt, Principal principal) {
		
		EmployeeVO emp = this.employeeMapper.detail(principal.getName());

		Map<String, String> map = new HashMap<String, String>();
		map.put("srvyTrgt", srvyTrgt);
		map.put("empNo", emp.getEmpNo());
		
		List<SrvyVO> srvyList = this.srvyMapper.ableSrvyList(map);
		
		for (SrvyVO srvyVO : srvyList) {
			
			Date endDate = srvyVO.getSrvyEndDate();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	 
	        String endYmd = sdf.format(endDate);
	        log.debug("endYmd : "+endYmd);
	        
	        srvyVO.setSrvyEndDateStr(endYmd);
		}
		
		return srvyList;
	}

	@Override
	public List<SrvyVO> srvyMngList(String empNo) {
		return this.srvyMapper.srvyMngList(empNo);
	}

	@Override
	public List<SrvyVO> srvyMngFinList(String empNo) {
		return this.srvyMapper.srvyMngFinList(empNo);
	}

}
