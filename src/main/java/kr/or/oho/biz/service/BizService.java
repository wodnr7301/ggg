package kr.or.oho.biz.service;

import java.util.List;

import kr.or.oho.vo.BizVO;

public interface BizService {
	
	/**
	 * 전체 프로젝트 리스트 출력
	 * @return List<BizVO>
	 */
	public List<BizVO> getBizVOList();
	
	/**
	 * 프로젝트 생성
	 * @param bizVO
	 * @return
	 */
	public int create(BizVO bizVO);

	/**
	 * 프로젝트 상세보기
	 * @return
	 */
	public BizVO detail(BizVO bizVO);
	
	/**
	 * 프로젝트 상세보기에서 수정하는 서비스
	 * @param bizVO
	 * @return
	 */
	public int update(BizVO bizVO);

	/**
	 * 프로젝트 상세보기에서 진척도 변경하는 서비스
	 * @param bizVO
	 * @return
	 */
	public int updateStatus(BizVO bizVO);

	/**
	 * 프로젝트 중단처리
	 * @param bizVO
	 * @return
	 */
	public int updateStatusN(BizVO bizVO);

}
