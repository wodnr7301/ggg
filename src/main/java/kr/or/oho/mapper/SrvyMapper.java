package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.AnsMcVO;
import kr.or.oho.vo.ExampleVO;
import kr.or.oho.vo.QstnMcVO;
import kr.or.oho.vo.SrvyVO;

public interface SrvyMapper {
	public String srvyNoSelect();
	public int srvyAdd(SrvyVO srvyVO);
	public String qmNoSelect();
	public int qmcAdd(QstnMcVO qstnMcVO);
	public int expAdd(ExampleVO exampleVO);
	public List<SrvyVO> list();
	public int expDelete(SrvyVO srvyVO);
	public int qmcDelete(SrvyVO srvyVO);
	public int srvyDelete(SrvyVO srvyVO);
	public int updateSurvey(SrvyVO srvyVO);
	public SrvyVO surveyDetail(SrvyVO srvyVO);
	public List<QstnMcVO> qmcDetail(SrvyVO srvyVO);
	public List<ExampleVO> expDetail(Map<String,String> map);
	public int submitAns(AnsMcVO ansMcVO);
	public List<SrvyVO> ableSrvyList(Map<String,String> map);
	public List<SrvyVO> srvyMngList(String empNo);
	public List<SrvyVO> srvyMngFinList(String empNo);
}
