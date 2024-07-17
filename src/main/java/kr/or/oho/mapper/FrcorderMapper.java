package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.CartDtlVO;
import kr.or.oho.vo.CartVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.FrcsStockVO;
import kr.or.oho.vo.GdsVO;

public interface FrcorderMapper {

	/**
	 * 모든 구분 코드 가져오기
	 */
	public List<ComcdVO> getAllGdsGu();

	/**
	 * 모든 상품 가져오기
	 * @param comcdVO
	 */
	public List<GdsVO> getAllGds(ComcdVO comcdVO);
	public List<GdsVO> getAllGds();
	
	/**
	 * 상품 상세 정보 가져오기
	 * @param frcOrderVO
	 */
	public List<FrcOrderVO> getFrcGdsDtl(FrcOrderVO frcOrderVO);

	/**
	 * 발주 등록하기
	 * @param frcOrderVO
	 */
	public int createPostFo(FrcOrderVO frcOrderVO);
	
	/**
	 * 발주 등록하기
	 * @param frcOrderDtlVO
	 */
	public int createPostFoDtl(FrcOrderDtlVO frcOrderDtlVO);

	/**
	 * 모든 발주 정보 가져오기(파라미터 있을 때)
	 * @param frcOrderVO
	 */
	public List<FrcOrderVO> getAllFrcorder(FrcOrderVO frcOrderVO);
	public List<FrcOrderVO> getAllFrcorder();
	
	/**
	 * 발주상세 가져오기
	 * @param frcOrderVO
	 */
	public List<FrcOrderDtlVO> getfrcOrderDtl(FrcOrderVO frcOrderVO);

	/**
	 * 발주 삭제(발주 상세와 발주 동시 삭제)
	 * @param frcOrderVO
	 */
	public int deleteFrcOrder(FrcOrderVO frcOrderVO);
	public int deleteFrcOrderDtl(FrcOrderVO frcOrderVO);
	
	/**
	 * 해당 회원의 가맹점 번호 가져오기
	 * @param empNo
	 */
	public String getFrcsNo(String empNo);

	/**
	 * 장바구니 등록 ----- 기능 X
	 * @param cartVO
	 */
	public int createCart(CartVO cartVO);
	public List<CartVO> getCartList(String empNo);
	public int createCartDtl(CartDtlVO cartDtlVO);
	public List<CartDtlVO> getCartDtl(CartVO cartVO);

	/**
	 * ajax로 delete 처리
	 * @param cartVO
	 */
	public int deleteAjax(CartVO cartVO);
	public int deleteDtlAjax(CartVO cartVO);

	/**
	 * 가맹점 정보 가져오기
	 * @param empNo
	 */
	public FranchiseVO getFranchise(String empNo);

	/**
	 * 모든 지역 가져오기
	 */
	public List<ComcdVO> getAllLoc();

	/**
	 * 지역별 가맹점 정보 가져오기
	 * @param comcdVO
	 */
	public List<FranchiseVO> locFrn(ComcdVO comcdVO);

	/**
	 * 입고 처리 시 재고 수 증가
	 * @param gdsList
	 */
	public int updateSave(Map<String, Object> gdsMap);
	public int updatePrcsYn(String foNo);

	/**
	 * 모든 재고 정보 가져오기
	 */
	public List<FrcsStockVO> getAllStock();
	public List<FrcsStockVO> getAllStock(ComcdVO comcdVO);

	/**
	 * 가맹점 이름 가져오기
	 * @param frcsNo
	 */
	public String getFrcsNm(String frcsNo);


}
