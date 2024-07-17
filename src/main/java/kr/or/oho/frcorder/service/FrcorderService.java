package kr.or.oho.frcorder.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.CartDtlVO;
import kr.or.oho.vo.CartVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.FrcsStockVO;
import kr.or.oho.vo.GdsVO;

public interface FrcorderService {

	/**
	 * 모든 구분 코드 가져오기
	 */
	List<ComcdVO> getAllGdsGu();

	/**
	 * 모든 상품 가져오기
	 * @param comcdVO
	 */
	List<GdsVO> getAllGds(ComcdVO comcdVO);
	List<GdsVO> getAllGds();
	
	/**
	 * 상품 상세 정보 가져오기
	 * @param frcOrderVO
	 */
	List<FrcOrderVO> getFrcGdsDtl(FrcOrderVO frcOrderVO);

	/**
	 * 발주 등록하기
	 * @param frcOrderVO
	 */
	int createPost(FrcOrderVO frcOrderVO);

	/**
	 * 모든 발주 정보 가져오기
	 * @param frcOrderVO
	 */
	List<FrcOrderVO> getAllFrcorder(FrcOrderVO frcOrderVO);
	List<FrcOrderVO> getAllFrcorder();

	/**
	 * 발주상세 가져오기
	 * @param frcOrderVO
	 */
	List<FrcOrderDtlVO> getfrcOrderDtl(FrcOrderVO frcOrderVO);

	/**
	 * 발주 삭제(취소)
	 * @param frcOrderVO
	 */
	int deleteFrcOrder(FrcOrderVO frcOrderVO);

	/**
	 * 해당 회원의 가맹점 번호 가져오기
	 * @param empNo
	 */
	String getFrcsNo(String empNo);

	/**
	 * 장바구니 등록 ----- 기능 X
	 * @param cartVO
	 */
	int createCart(CartVO cartVO);

	/**
	 * ajax로 delete 처리
	 * @param cartVO
	 */
	int deleteAjax(CartVO cartVO);

	/**
	 * 장바구니 상세 가져오기 ----- 기능 X
	 * @param cartVO
	 */
	List<CartDtlVO> getCartDtl(CartVO cartVO);

	/**
	 * 가맹점 정보 가져오기
	 * @param empNo
	 */
	FranchiseVO getFranchise(String empNo);

	/**
	 * 모든 지역 가져오기
	 */
	List<ComcdVO> getAllLoc();

	/**
	 * 지역별 가맹점 정보 가져오기
	 * @param comcdVO
	 */
	List<FranchiseVO> locFrn(ComcdVO comcdVO);

	/**
	 * 입고 처리 시 재고 수 증가
	 * @param gdsList
	 */
	int updateSave(List<Map<String, Object>> gdsList);

	/**
	 * 모든 재고 정보 가져오기
	 */
	List<FrcsStockVO> getAllStock();
	List<FrcsStockVO> getAllStock(ComcdVO comcdVO);

	/**
	 * 가맹점 이름 가져오기
	 * @param frcsNo
	 */
	String getFrcsNm(String frcsNo);


}
