package kr.or.oho.frcorder.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.mapper.FrcorderMapper;
import kr.or.oho.vo.CartDtlVO;
import kr.or.oho.vo.CartVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.FrcsStockVO;
import kr.or.oho.vo.GdsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FrcorderServiceImpl implements FrcorderService {

	@Autowired
	FrcorderMapper frcorderMapper;
	
	/**
	 * 모든 구분 코드 가져오기
	 */
	@Override
	public List<ComcdVO> getAllGdsGu() {
		return this.frcorderMapper.getAllGdsGu();
	}

	/**
	 * 모든 상품 가져오기
	 * @param comcdVO
	 */
	@Override
	public List<GdsVO> getAllGds(ComcdVO comcdVO) {
		return this.frcorderMapper.getAllGds(comcdVO);
	}

	/**
	 * 상품 상세 정보 가져오기
	 * @param frcOrderVO
	 */
	@Override
	public List<FrcOrderVO> getFrcGdsDtl(FrcOrderVO frcOrderVO) {
		return this.frcorderMapper.getFrcGdsDtl(frcOrderVO);
	}

	/**
	 * 발주 등록하기
	 * @param frcOrderVO
	 */
	@Override
	public int createPost(FrcOrderVO frcOrderVO) {
		
		int result = this.frcorderMapper.createPostFo(frcOrderVO);
		
		List<FrcOrderDtlVO> frcOrderDtlVOList = frcOrderVO.getFrcOrderDtlVOList();
		for (FrcOrderDtlVO frcOrderDtlVO : frcOrderDtlVOList) {
			if(frcOrderDtlVO.getGdsNo() == null) {
				continue;
			}
			log.info("createPost -> frcOrderDtlVO : " + frcOrderDtlVO);
			result += this.frcorderMapper.createPostFoDtl(frcOrderDtlVO);
			
		}
		
		
		return result;
	}

	/**
	 * 모든 발주 정보 가져오기(파라미터 있을 때)
	 * @param frcOrderVO
	 */
	@Override
	public List<FrcOrderVO> getAllFrcorder(FrcOrderVO frcOrderVO) {
		return this.frcorderMapper.getAllFrcorder(frcOrderVO);
	}
	
	/**
	 * 모든 발주 정보 가져오기(파라미터 없을 때)
	 */
	@Override
	public List<FrcOrderVO> getAllFrcorder() {
		return this.frcorderMapper.getAllFrcorder();
	}
	
	/**
	 * 발주상세 가져오기
	 * @param frcOrderVO
	 */
	@Override
	public List<FrcOrderDtlVO> getfrcOrderDtl(FrcOrderVO frcOrderVO) {
		return this.frcorderMapper.getfrcOrderDtl(frcOrderVO);
	}

	/**
	 * 발주 삭제(발주 상세와 발주 동시 삭제)
	 * @param frcOrderVO
	 */
	@Override
	public int deleteFrcOrder(FrcOrderVO frcOrderVO) {
		int result = this.frcorderMapper.deleteFrcOrderDtl(frcOrderVO);
		
		log.debug("result1 : " + result);
		if(result > 0) {
			result += this.frcorderMapper.deleteFrcOrder(frcOrderVO);
			log.debug("result2 : " + result);
		}
		
		return result;
	}

	/**
	 * 해당 회원의 가맹점 번호 가져오기
	 * @param empNo
	 */
	@Override
	public String getFrcsNo(String empNo) {
		return this.frcorderMapper.getFrcsNo(empNo);
	}

	/**
	 * 모든 구분 코드 가져오기
	 */
	@Override
	public List<GdsVO> getAllGds() {
		return this.frcorderMapper.getAllGds();
	}

	/**
	 * 장바구니 등록 ----- 기능 X
	 * @param cartVO
	 */
	@Override
	public int createCart(CartVO cartVO) {
		int result = this.frcorderMapper.createCart(cartVO);
		List<CartDtlVO> cartVODtlList = cartVO.getCartVODtlList();
		for (CartDtlVO cartDtlVO : cartVODtlList) {
			if(cartDtlVO.getGdsNo() == null) {
				continue;
			}
			log.info("cartDtlVO : "+cartDtlVO);
			result += this.frcorderMapper.createCartDtl(cartDtlVO);
		}
		
		return result;
	}

	/**
	 * ajax로 delete 처리
	 * @param cartVO
	 */
	@Override
	public int deleteAjax(CartVO cartVO) {
		int result = this.frcorderMapper.deleteDtlAjax(cartVO);
		
		result += this.frcorderMapper.deleteAjax(cartVO);
		
		return result;
	}

	/**
	 * 장바구니 상세 가져오기 ----- 기능 X
	 * @param cartVO
	 */
	@Override
	public List<CartDtlVO> getCartDtl(CartVO cartVO) {
		return this.frcorderMapper.getCartDtl(cartVO);
	}

	/**
	 * 가맹점 정보 가져오기
	 * @param empNo
	 */
	@Override
	public FranchiseVO getFranchise(String empNo) {
		return this.frcorderMapper.getFranchise(empNo);
	}

	/**
	 * 모든 지역 가져오기
	 */
	@Override
	public List<ComcdVO> getAllLoc() {
		return this.frcorderMapper.getAllLoc();
	}

	/**
	 * 지역별 가맹점 정보 가져오기
	 * @param comcdVO
	 */
	@Override
	public List<FranchiseVO> locFrn(ComcdVO comcdVO) {
		return this.frcorderMapper.locFrn(comcdVO);

	}

	/**
	 * 입고 처리 시 재고 수 증가
	 * @param gdsList
	 */
	@Override
	public int updateSave(List<Map<String, Object>> gdsList) {
		log.info("updateSave에 왔다");
		int result = 0;
		for (Map<String, Object> gdsMap : gdsList) {
			log.info("gdsMap : " + gdsMap);
			String foNo = (String) gdsMap.get("foNo");
			log.info("foNo : " + foNo);
			result += this.frcorderMapper.updateSave(gdsMap);
			if (result > 0) {
				result += this.frcorderMapper.updatePrcsYn(foNo);
			}
		}
		return result;
	}

	/**
	 * 모든 재고 정보 가져오기(파라미터 없을 때)
	 */
	@Override
	public List<FrcsStockVO> getAllStock() {
		return this.frcorderMapper.getAllStock();
	}

	/**
	 * 모든 재고 정보 가져오기(파라미터 있을 때)
	 */
	@Override
	public List<FrcsStockVO> getAllStock(ComcdVO comcdVO) {
		return this.frcorderMapper.getAllStock(comcdVO);
	}

	/**
	 * 가맹점 이름 가져오기
	 * @param frcsNo
	 */
	@Override
	public String getFrcsNm(String frcsNo) {
		return this.frcorderMapper.getFrcsNm(frcsNo);
	}


}
