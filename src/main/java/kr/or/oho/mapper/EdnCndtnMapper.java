package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.EdnCndtnVO;
import kr.or.oho.vo.EdnPrgrmVO;
import kr.or.oho.vo.FranchiseVO;

public interface EdnCndtnMapper {
	public List<EdnCndtnVO> list();
	public List<EdnCndtnVO> getList(EdnPrgrmVO ednPrgrmVO);
	public int delete(EdnCndtnVO ednCndtnVO);
	public int add(EdnCndtnVO ednCndtnVO);
	public int update(EdnCndtnVO ednCndtnVO);
	public List<FranchiseVO> getTrnFrcList(EdnPrgrmVO ednPrgrmVO);
	public List<EdnPrgrmVO> epEcYCnt();
	public int getEcYnfCnt(Map<String,String> map);
	public List<EdnCndtnVO> trnList(String empNo);
	public int myEcYnfCnt(Map<String,String> map);
	public List<EdnCndtnVO> getEcYnfCntFirst(String epNm1);
}
