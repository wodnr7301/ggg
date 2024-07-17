package kr.or.oho.mtgRoom.service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.MtgRoomVO;
import kr.or.oho.vo.MtgrMngLdgrVO;

public interface MtgRoomService {

List<MtgRoomVO> getMtgRoomAjax();
List<MtgrMngLdgrVO> listAjax();
int createAjax(MtgrMngLdgrVO mtgrMngLdgrVO);
int updateAjax(MtgrMngLdgrVO mtgrMngLdgrVO);
MtgrMngLdgrVO getMtgRoomDetail(MtgrMngLdgrVO mtgrMngLdgrVO);

//기본키 얻기
String getMmlNo();

//삭제
int deleteAjax(MtgrMngLdgrVO mtgrMngLdgrVO);

//본인확인용 기본키 매개변수로 보내서 empNo 얻기
String getEmp2(Map<String, Object> map);



	
	
}
