package kr.or.oho.openmng.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.EdnCndtnVO;
import kr.or.oho.vo.EdnPrgrmVO;
import kr.or.oho.vo.FranchiseVO;

/**
 * 교육 현황 서비스
 * @author PC-08
 */
public interface EdnCndtnService {
	
	/**
	 * 모든 교육 현황 리스트
	 */
	public List<EdnCndtnVO> list();
	
	/**
	 * 교육명 별 이름, 건수 리스트 (카드배너에 들어갈거)
	 */
	public List<EdnPrgrmVO> getEpNmList();
	
	/**
	 * 교육명 별 교육 프로그램 상세정보 리스트
	 * @param ednPrgrmVO 교육명(epNm1) 들어있는 교육 프로그램 VO
	 * @return ep_no, ep_nm, ep_nm1, ep_nm2 들어있는 교육 프로그램 VO
	 */
	public List<EdnPrgrmVO> getEpNmDetailList(EdnPrgrmVO ednPrgrmVO);
	
	/**
	 * 교육명 별 모든 교육 현황 리스트
	 * @param ednPrgrmVO 교육명(epNm1) 들어있는 교육 프로그램 VO
	 */
	public List<EdnCndtnVO> getList(EdnPrgrmVO ednPrgrmVO);
	
	/**
	 * 교육 현황 삭제
	 * @param ednCndtnVO 교육현황번호 ecNo 담은 교육현황 VO
	 * @return 삭제 성공 : 1 실패 : 0
	 */
	public int delete(EdnCndtnVO ednCndtnVO);
	
	/**
	 * 교육 현황 등록
	 * @param ednCndtnVO 교육 현황 등록 정보 담은 교육현황 VO
	 * @return 등록 성공 : 1 실패 : 0
	 */
	public int add(EdnCndtnVO ednCndtnVO);
	
	/**
	 * 교육 현황 변경
	 * @param ednCndtnVO 교육 현황 수정 정보 담은 교육현황 VO
	 * @return 변경 성공 : 1 실패 : 0
	 */
	public int update(EdnCndtnVO ednCndtnVO);
	
	/**
	 * 폐업하지 않은 가맹점 중 해당 교육 받지 않은 가맹점 리스트
	 * @param ednPrgrmVO 교육 프로그램 번호 담은 vo
	 * @return 해당하는 가맹점 리스트
	 */
	public List<FranchiseVO> getTrnFrcList(EdnPrgrmVO ednPrgrmVO);
	
	/**
	 * 각 교육 프로그램 별 교육 참여 완료자 수
	 * @return
	 */
	public List<EdnPrgrmVO> epEcYCnt();
	
	/**
	 * 전체, 각 교육 프로그램 별 교육 이수 상태 별 카운트
	 * @param map
	 * @return
	 */
	public int getEcYnfCnt(Map<String,String> map);
	
	/**
	 * 가맹점주가 본인 교육 조회
	 * @param empNo
	 * @return
	 */
	public List<EdnCndtnVO> trnList(String empNo);
	
	/**
	 * 가맹점주 본인 교육 이수 상태 별 카운트
	 * @param map
	 * @return
	 */
	public int myEcYnfCnt(Map<String,String> map);
	
	/**
	 * 각 교육별 교육이수현황 Y,N,F 카운트 한번에 가져오기
	 * @return Y,N,F 별 카운트 들어있는 EdnCndtnVO 리스트 6개 리스트
	 */
	public List<List<EdnCndtnVO>> getEcYnfCntFirst();
}
