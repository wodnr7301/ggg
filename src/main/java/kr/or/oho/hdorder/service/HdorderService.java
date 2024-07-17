package kr.or.oho.hdorder.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.CnptVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.GdsVO;
import kr.or.oho.vo.HdorderDtlVO;
import kr.or.oho.vo.HdorderVO;

public interface HdorderService {

	public List<CnptVO> getCntpInfo();

	public List<GdsVO> getCnptGds(CnptVO cnptVO);

	public List<HdorderVO> getOrderDt(HdorderDtlVO hdorderDtlVO);

	public int createPost(HdorderVO hdorderVO);

	public List<HdorderVO> getAllHdorder(HdorderVO hdorderVO);
	
	public List<HdorderVO> getAllHdorder();

	public List<HdorderDtlVO> getOrderDt2(HdorderVO hdorderVO);

	public int deleteHdorder(HdorderVO hdorderVO);

	public int updateYn(FrcOrderVO frcOrderVO);

	public List<FrcOrderDtlVO> getOrderDetail(FrcOrderVO frcOrderVO);

	public List<ComcdVO> getAllWrhs();

	public List<GdsVO> getAllStock();

	public int updateSave(List<Map<String, Object>> gdsList);

	public List<GdsVO> getAllStock(ComcdVO comcdVO);

	public List<GdsVO> getWrhsGds(GdsVO gdsVO);

	public List<FrcOrderVO> getAllFrcorder(FrcOrderVO frcOrderVO);

	public List<FrcOrderDtlVO> getfrcOrderDtl(FrcOrderVO frcOrderVO);

	public List<FranchiseVO> locFrn(ComcdVO comcdVO);



}
