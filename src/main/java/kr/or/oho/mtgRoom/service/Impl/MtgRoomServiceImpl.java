package kr.or.oho.mtgRoom.service.Impl;


import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.mapper.MtgRoomMapper;
import kr.or.oho.mapper.TodoListMapper;
import kr.or.oho.mtgRoom.service.MtgRoomService;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.MtgRoomVO;
import kr.or.oho.vo.MtgrMngLdgrVO;
import kr.or.oho.vo.TodoListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MtgRoomServiceImpl implements MtgRoomService{

	@Autowired
	MtgRoomMapper mtgRoomMapper;
	
	@Autowired
	TodoListMapper todoListMapper;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Override
	public List<MtgRoomVO> getMtgRoomAjax() {

		return mtgRoomMapper.getMtgRoomAjax();
	}
	
//	@Override
//	public List<MtgrMngLdgrVO> listAjax(Map<String, Object> map) {
//
//		return mtgRoomMapper.listAjax(map);
//	}
	
	@Override
	public List<MtgrMngLdgrVO> listAjax() {

		return mtgRoomMapper.listAjax();
	}
	
//	@Override
//	public List<MtgRoomVO> getMmlRsvtYNAjax() {
//		
//		return mtgRoomMapper.getMmlRsvtYNAjax();
//	}
	
	@Override
	public int createAjax(MtgrMngLdgrVO mtgrMngLdgrVO) {

		//2) 회의실 예약 정보를 개인일정 캘린더에 추가
		log.info("회의실 예약 시 개인 일정 캘린더에 추가하기 위한 값 중간체크:" + mtgrMngLdgrVO);
		//mmlNo=null(자동생성), mmlUsePrps=1, mmlRsvtYN=Y, mmlRsvtYmd=null(자동생성), 
		//mmlRsvtStrdt=2024.07.02(화) 11:00, mmlRsvtEnddt=2024.07.02(화) 12:00, 
		//mtgrNo=MTR004, mtgrNm=null empNo=A102, empNm=null(서브쿼리), mtgrUseYN=null(서브쿼리)
		
		TodoListVO todoListVO = new TodoListVO();
		todoListVO.setEmpNo(mtgrMngLdgrVO.getEmpNo());
		todoListVO.setTdlTtl("회의실 "+mtgrMngLdgrVO.getMtgrNm()+" 예약 완료");
//		todoListVO.setTdlTtl("회의실 예약 완료");
//		todoListVO.setTdlCn("회의실 ["+mtgrMngLdgrVO.getMmlUsePrps()+"] 목적으로 예약");
		todoListVO.setTdlCn("회의 목적으로 예약");
		
		log.info("회의실 예약 시 todoListVO:" + todoListVO);
		
		String rentDateStrMtgRoom = mtgrMngLdgrVO.getMmlRsvtStrdt();	// 2024.07.01(월) 14:00
		String rentDateEndMtgRoom = mtgrMngLdgrVO.getMmlRsvtEnddt();	// 2024.07.01(월) 15:00
		log.info("회의실 예약 시 rentDateStrMtgRoom:" + rentDateStrMtgRoom);
		log.info("회의실 예약 시 rentDateEndMtgRoom:" + rentDateEndMtgRoom);
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy.MM.dd(E) HH:mm");
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		//입력 형식으로 날짜 파싱
		Date rentStrDate;
		Date rentEndDate;
		String rentStrDateMtgRoom2 = null;
		String rentEndDateMtgRoom2 = null;
		
		try {
			rentStrDate = inputFormat.parse(rentDateStrMtgRoom);
			rentEndDate = inputFormat.parse(rentDateEndMtgRoom);
			
			//출력 형식으로 날짜 파싱
			rentStrDateMtgRoom2 = outputFormat.format(rentStrDate);
			rentEndDateMtgRoom2 = outputFormat.format(rentEndDate);
			
		} catch (ParseException e) {

			e.printStackTrace();
		}
		
		//Date rentDate = inputFormat.parse(rentDateMtgRoom);
		todoListVO.setTdlStrDt(rentStrDateMtgRoom2); // 2024/07/01 HH:mm:ss
		todoListVO.setTdlEndDt(rentEndDateMtgRoom2); // 2024/07/01 HH:mm:ss
		todoListVO.setDeptNo(mtgrMngLdgrVO.getDeptNo());
		todoListVO.setTdlCmptnYn("#66648B");
		
		//tdlNo(자동생성), tdlTtl, tdlCn, tdlStrDt, tdlEntDt, empNo, deptNo(null 됨)
		log.info("회의실 예약 후 개인 일정 캘린더에 추가할 VO 값:" + todoListVO);
		
		int result = mtgRoomMapper.createAjax(mtgrMngLdgrVO);
		
		result += todoListMapper.createPost(todoListVO);
		
		return result;
	}

	@Override
	public int updateAjax(MtgrMngLdgrVO mtgrMngLdgrVO) {

		return mtgRoomMapper.updateAjax(mtgrMngLdgrVO);
	}

	@Override
	public MtgrMngLdgrVO getMtgRoomDetail(MtgrMngLdgrVO mtgrMngLdgrVO) {

		return mtgRoomMapper.getMtgRoomDetail(mtgrMngLdgrVO);
	}

	@Override
	public String getMmlNo() {

		return mtgRoomMapper.getMmlNo();
	}

	@Override
	public int deleteAjax(MtgrMngLdgrVO mtgrMngLdgrVO) {
		
		//2) 회의실 예약 정보를 개인일정 캘린더에 삭제
//		log.info("회의실 예약 시 개인 일정 캘린더에 삭제하기 위한 값 중간체크:" + mtgrMngLdgrVO);
		//mmlNo=MML050(자동생성), mmlUsePrps=null, mmlRsvtYN=null, mmlRsvtYmd=null(자동생성), 
		//mmlRsvtStrdt=null, mmlRsvtEnddt=null, 
		//mtgrNo=null, mtgrNm=null empNo=EMP144, empNm=null(서브쿼리), mtgrUseYN=null(서브쿼리)		
		
//		TodoListVO todoListVO = new TodoListVO();
//		todoListVO.setTdlNo(mtgrMngLdgrVO.getMmlNo());
//		
//		int result = mtgRoomMapper.deleteAjax(mtgrMngLdgrVO);
//		
//		result += todoListMapper.deletePost(todoListVO);
		
		return mtgRoomMapper.deleteAjax(mtgrMngLdgrVO);
	}

	@Override
	public String getEmp2(Map<String, Object> map) {

		return mtgRoomMapper.getEmp2(map);
	}

	

	
	
}
