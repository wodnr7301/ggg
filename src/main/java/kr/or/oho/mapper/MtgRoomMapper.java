package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.MtgRoomVO;
import kr.or.oho.vo.MtgrMngLdgrVO;

public interface MtgRoomMapper {

	List<MtgrMngLdgrVO> listAjax();

//	List<MtgrMngLdgrVO> listAjax(Map<String, Object> map);
	
	List<MtgRoomVO> getMtgRoomAjax();
	
//	List<MtgRoomVO> getMmlRsvtYNAjax();
	
	int createAjax(MtgrMngLdgrVO mtgrMngLdgrVO);

	int updateAjax(MtgrMngLdgrVO mtgrMngLdgrVO);

	MtgrMngLdgrVO getMtgRoomDetail(MtgrMngLdgrVO mtgrMngLdgrVO);

	String getMmlNo();

	int deleteAjax(MtgrMngLdgrVO mtgrMngLdgrVO);

	String getEmp2(Map<String, Object> map);

	

}
