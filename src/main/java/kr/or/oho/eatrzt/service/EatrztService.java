package kr.or.oho.eatrzt.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.AtrzlnVO;
import kr.or.oho.vo.AttachVO;
import kr.or.oho.vo.EatrztVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.TmpltVO;

public interface EatrztService {

	public List<EatrztVO> docBoxList(String empNo);
	
	public List<EatrztVO> nDocBoxList(String empNo);

	public List<EatrztVO> beforeApvBoxList(String empNo);

	public List<EatrztVO> apvBoxList(String empNo);
	
	public List<EatrztVO> nApvBoxList(String empNo);

	public TmpltVO createPost(TmpltVO tmpltVO);

	public List<EmployeeVO> getName();

	public List<TmpltVO> tmpltList();

	public EatrztVO comList(String empNo);

	public int eatrztPost(EatrztVO eatrztVO);

	public List<Map<String, Object>> atrzlnList();

	public EatrztVO getEatrzt(EatrztVO eatrztVO);

	public List<AttachVO> attachList(EatrztVO eatrztVO);
	
	public int atrUpdatePost(AtrzlnVO atrzlnVO);
	
	/**
	 * 결재 확인용 서비스
	 * @param chkAtrzlnVO
	 * @return
	 */
	public AtrzlnVO check(AtrzlnVO chkAtrzlnVO);

	public int eatrztUpdate(EatrztVO eatrztVO);
	
	public int delUpdate(EatrztVO eatrztVO);
	
	public List<AtrzlnVO> stampAtrList(EatrztVO eatrztVO);
	
	public List<AtrzlnVO> stampAtrList2(EatrztVO eatrztVO);
	

}
