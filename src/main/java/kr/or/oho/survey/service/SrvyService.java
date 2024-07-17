package kr.or.oho.survey.service;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import kr.or.oho.vo.AnsMcVO;
import kr.or.oho.vo.ExampleVO;
import kr.or.oho.vo.QstnMcVO;
import kr.or.oho.vo.SrvyVO;

public interface SrvyService {
	public String srvyNoSelect();
	public String qmNoSelect();
	public boolean srvyAdd(SrvyVO srvyVO, Principal principal);
	public List<SrvyVO> list();
	public int srvyDelete(SrvyVO srvyVO);
	public int updateSurvey(SrvyVO srvyVO);
	public SrvyVO surveyDetail(SrvyVO srvyVO);
	public List<QstnMcVO> qmcDetail(SrvyVO srvyVO);
	public List<ExampleVO> expDetail(Map<String,String> map);
	public int submitAns(AnsMcVO ansMcVO);
	public List<SrvyVO> ableSrvyList(String srvyTrgt, Principal principal);
	public List<SrvyVO> srvyMngList(String empNo);
	public List<SrvyVO> srvyMngFinList(String empNo);
}
