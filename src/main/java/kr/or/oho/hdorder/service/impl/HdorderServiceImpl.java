package kr.or.oho.hdorder.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.hdorder.service.HdorderService;
import kr.or.oho.mapper.HdorderMapper;
import kr.or.oho.vo.CnptVO;
import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.FranchiseVO;
import kr.or.oho.vo.FrcOrderDtlVO;
import kr.or.oho.vo.FrcOrderVO;
import kr.or.oho.vo.GdsVO;
import kr.or.oho.vo.HdorderDtlVO;
import kr.or.oho.vo.HdorderVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class HdorderServiceImpl implements HdorderService {

	@Autowired
	HdorderMapper hdorderMapper;
	
	@Override
	public List<CnptVO> getCntpInfo() {
		return this.hdorderMapper.getCnptInfo();
	}

	@Override
	public List<GdsVO> getCnptGds(CnptVO cnptVO) {
		return this.hdorderMapper.getCnptGds(cnptVO);
	}

	@Override
	public List<HdorderVO> getOrderDt(HdorderDtlVO hdorderDtlVO) {
		return this.hdorderMapper.getOrderDt(hdorderDtlVO);
	}

	@Override
	public int createPost(HdorderVO hdorderVO) {
		
		int result = this.hdorderMapper.hdorderCreate(hdorderVO);
		
		if (hdorderVO.getFoNo() != null && !hdorderVO.getFoNo().equals("")) {
		    result += this.hdorderMapper.upYn(hdorderVO.getFoNo());
		}
		
		List<HdorderDtlVO> hdorderDtlVOList = hdorderVO.getHdorderDtlVOList();
		log.info("ServiceImpl -> hdorderDtlVOList : " + hdorderDtlVOList);
		
		for (HdorderDtlVO hdorderDtlVO : hdorderDtlVOList) {
			if(hdorderDtlVO.getGdsNo() == null) {
				continue;
			}
			log.debug("ServiceImpl -> hdorderDtlVO 전 : " + hdorderDtlVO);
			GdsVO gdsVODetail = this.hdorderMapper.gdsDetail(hdorderDtlVO.getGdsNo());
			log.debug("ServiceImpl -> gdsVODetail : " + gdsVODetail);
			hdorderDtlVO.setGdsNtslAmt(gdsVODetail.getGdsNtslAmt());
			hdorderDtlVO.setGdsStock(gdsVODetail.getGdsStock());
			log.debug("ServiceImpl -> hdorderDtlVO 후 : " + hdorderDtlVO);
			result += this.hdorderMapper.hdorderDtCreate(hdorderDtlVO);
		}
		
		
		return result;
	}

	@Override
	public List<HdorderVO> getAllHdorder(HdorderVO hdorderVO) {
		return  this.hdorderMapper.getAllHdorder(hdorderVO);
	}
	
	@Override
	public List<HdorderVO> getAllHdorder() {
		return this.hdorderMapper.getAllHdorder();
	}

	@Override
	public List<HdorderDtlVO> getOrderDt2(HdorderVO hdorderVO) {
		return this.hdorderMapper.getOrderDt2(hdorderVO);
	}

	@Override
	public int deleteHdorder(HdorderVO hdorderVO) {
		int result = this.hdorderMapper.deleteHdorderDtl(hdorderVO);
		log.debug("result1 : " + result);
		if(result > 0) {
			result += this.hdorderMapper.deleteHdorder(hdorderVO);
			log.debug("result2 : " + result);
		}
		return result;
	}

	@Override
	public int updateYn(FrcOrderVO frcOrderVO) {
		return this.hdorderMapper.updateYn(frcOrderVO);
	}

	@Override
	public List<FrcOrderDtlVO> getOrderDetail(FrcOrderVO frcOrderVO) {
		return this.hdorderMapper.getOrderDetail(frcOrderVO);
	}

	@Override
	public List<ComcdVO> getAllWrhs() {
		return this.hdorderMapper.getAllWrhs();
	}

	@Override
	public List<GdsVO> getAllStock() {
		return this.hdorderMapper.getAllStock();
	}

	@Override
	public int updateSave(List<Map<String, Object>> gdsList) {
		log.info("updateSave에 왔다");
		int result = 0;
		for (Map<String, Object> gdsMap : gdsList) {
			log.info("gdsMap : " + gdsMap);
			String hoNo = (String) gdsMap.get("hoNo");
			result += this.hdorderMapper.updateSave(gdsMap);
			if (result > 0) {
				result += this.hdorderMapper.updatePrcsYn(hoNo);
			}
		}
		return result;
	}

	@Override
	public List<GdsVO> getAllStock(ComcdVO comcdVO) {
		return this.hdorderMapper.getAllStock(comcdVO);
	}

	@Override
	public List<GdsVO> getWrhsGds(GdsVO gdsVO) {
		return this.hdorderMapper.getWrhsGds(gdsVO);
	}

	@Override
	public List<FrcOrderVO> getAllFrcorder(FrcOrderVO frcOrderVO) {
		return this.hdorderMapper.getAllFrcorder(frcOrderVO);
	}

	@Override
	public List<FrcOrderDtlVO> getfrcOrderDtl(FrcOrderVO frcOrderVO) {
		return this.hdorderMapper.getfrcOrderDtl(frcOrderVO);
	}

	@Override
	public List<FranchiseVO> locFrn(ComcdVO comcdVO) {
		return this.hdorderMapper.locFrn(comcdVO);
	}


}
