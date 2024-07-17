package kr.or.oho.mng.service;

import java.util.List;

import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.MngVO;

public interface MngService {

	/**
	 * 전체 일정 리스트 서비스
	 * @return
	 */
	public List<MngVO> getList();
	
	/**
	 * 현황 출력용 카운트된 일정 수 가져오는 기능
	 * @return
	 */
	public MngVO getCount();
	
	/**
	 * 일정 생성 메소드
	 * @param mngVO
	 * @return
	 */
	public int createMng(MngVO mngVO);
	
	/**
	 * 일자별 일정 조회
	 * @param mngVO
	 * @return
	 */
	public List<MngVO> getOneDay(MngVO mngVO);

	/**
	 * 상세 정보 조회
	 * @param mngNo
	 * @return
	 */
	public MngVO detail(String mngNo);
	
	/**
	 * 방문일정 수정
	 * @param mngVO
	 * @return
	 */
	public int update(MngVO mngVO);

	/**
	 * 방문일정 삭제
	 * @param mngNo
	 * @return
	 */
	public int delete(String mngNo);
	
	/**
	 * 방문일정 완료처리
	 * @param mngNo
	 * @return
	 */
	public int done(String mngNo);

	/**
	 * 알람용 기본키 최대값 가져오는 코드
	 * @return
	 */
	public String getMax();


}
