package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import kr.or.oho.vo.CnptVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.GdsVO;
import kr.or.oho.vo.HdorderDtlVO;
import kr.or.oho.vo.HdorderVO;

public interface HdorderMapper {
	public List<CnptVO> getCnptInfo();

	public List<GdsVO> getCnptGds(CnptVO cnptVO);

	public List<HdorderVO> getOrderDt(HdorderDtlVO hdorderDtlVO);

	public int hdorderCreate(HdorderVO hdorderVO);

	public int hdorderDtCreate(HdorderDtlVO hdorderDtlVO);
	
	public GdsVO gdsDetail(String gdsNm);

	public List<HdorderVO> getAllHdorder(HdorderVO hdorderVO);
	
	public List<HdorderVO> getAllHdorder();
	
	public List<HdorderDtlVO> getOrderDt2(HdorderVO hdorderVO);

	public int deleteHdorder(HdorderVO hdorderVO);

	public int deleteHdorderDtl(HdorderVO hdorderVO);

	public int updateYn(FrcOrderVO frcOrderVO);

	public List<FrcOrderDtlVO> getOrderDetail(FrcOrderVO frcOrderVO);

	public int upYn(String foNo);

	public List<ComcdVO> getAllWrhs();

	public List<GdsVO> getAllStock();

	public int updateSave(Map<String, Object> gdsMap);

	public int updatePrcsYn(String hoNo);

	public List<GdsVO> getAllStock(ComcdVO comcdVO);

	public List<GdsVO> getWrhsGds(GdsVO gdsVO);

	public List<FrcOrderVO> getAllFrcorder(FrcOrderVO frcOrderVO);

	public List<FrcOrderDtlVO> getfrcOrderDtl(FrcOrderVO frcOrderVO);

	public List<FranchiseVO> locFrn(ComcdVO comcdVO);


	
	
	
}
