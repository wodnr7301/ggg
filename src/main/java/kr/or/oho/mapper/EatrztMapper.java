package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.AtrzlnVO;
import kr.or.oho.vo.AttachVO;
import kr.or.oho.vo.EatrztVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.HldyMngLdgrVO;
import kr.or.oho.vo.TmpltVO;

public interface EatrztMapper {

	//결재문서함 조회
	public List<EatrztVO> docBoxList(String empNo);
	
	public List<EatrztVO> nDocBoxList(String empNo);

	public List<EatrztVO> beforeApvBoxList(String empNo);

	public List<EatrztVO> apvBoxList(String empNo);
	
	//<select id="nApvBoxList" resultMap="eatrztMap" parameterType="String">
	public List<EatrztVO> nApvBoxList(String empNo);

	public TmpltVO createPost(TmpltVO tmpltVO);

	public List<EmployeeVO> getName();

	public List<TmpltVO> tmpltList();

	public EatrztVO comList(String empNo);

	//<insert id="eatrztPost" parameterType="hashMap">
	public int eatrztPost(EatrztVO eatrztVO);
	
	//<select id="atrzlnList" resultType="hashMap">
	public List<Map<String, Object>> atrzlnList();
	
	//<select id="getEatrzt" parameterType="kr.or.oho.vo.EatrztVO" resultType="hashMap">
	public EatrztVO getEatrzt(EatrztVO eatrztVO);
	
	//<select id="attachList" parameterType="kr.or.oho.vo.EatrztVO" resultMap="eatrztMap">
	public List<AttachVO> attachList (EatrztVO eatrztVO);

	//ATRZLN테이블에 기안자로써 insert
	public int atrzlnPost(AtrzlnVO atrzlnVO);

	//ATRZLN테이블에 결재자들을 insert
	public int atrzlnPost2(AtrzlnVO atrzlnVO);
	
	//<update id="atrUpdatePost" parameterType="kr.or.oho.vo.AtrzlnVO">
	public int atrUpdatePost(AtrzlnVO atrzlnVO);
	
	//<select id="checkFinalApproval" parameterType="String" resultType="int">
	public int checkFinalApproval(String atrzlnNo);
	
	//<update id="updateEatrztAfterApproval" parameterType="String">
	public int updateEatrztAfterApproval(String eatrztNo);

	public int finalApprovalValue(String eatrztNo);
	
	public EatrztVO checkAtr(EatrztVO eatrztVO);

	public AtrzlnVO check(AtrzlnVO chkAtrzlnVO);
	
	//<update id="eatrztUpdate" parameterType="String">
	public int eatrztUpdate(EatrztVO eatrztVO);
	
	//<update id="atrzlnUpdate" parameterType="String">
	public int atrzlnUpdate(String eatrztNo);
	
	//<update id="delUpdate" parameterType="String">
	public int delUpdate(EatrztVO eatrztVO);
	
	//<select id="stampAtr" parameterType="kr.or.oho.vo.EatrztVO">
	public List<AtrzlnVO> stampAtrList(EatrztVO eatrztVO);
	
	//<select id="stampAtrList2" parameterType="kr.or.oho.vo.EatrztVO" resultMap="eatrztMap">
	public List<AtrzlnVO> stampAtrList2(EatrztVO eatrztVO);
	
	//<select id="checkHldyTmplt" parameterType="kr.or.oho.vo.AtrzlnVO" resultMap="eatrztMap">
	public int checkHldyTmplt(AtrzlnVO atrzlnVO); 
	
	//<insert id="hldyInsert" parameterType="kr.or.oho.vo.HldyMngLdgrVO">
	public int hldyInsert(HldyMngLdgrVO hldyMngLdgrVO);
	
}
