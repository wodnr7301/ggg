package kr.or.oho.corpvhr.service.impl;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.corpvhr.service.CorpVhrService;
import kr.or.oho.mapper.CorpVhrMapper;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.mapper.TodoListMapper;
import kr.or.oho.vo.CorpVhrVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.TodoListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CorpVhrServiceImpl implements CorpVhrService{

	@Autowired
	CorpVhrMapper corpVhrMapper;
	
	@Autowired
	TodoListMapper todoListMapper;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Override
	public List<CorpVhrVO> corpVhrList() {
		return this.corpVhrMapper.corpVhrList();
	}

	/**
	 * 법인차량 등록
	 */
	@Override
	public int registerCorpVhr(CorpVhrVO corpVhrVO) {
		return this.corpVhrMapper.registerCorpVhr(corpVhrVO);
	}

	/**
	 * 법인차량 관리대장 리스트
	 */
	@Override
	public List<CorpVhrVO> mngLedgerList() {
		return this.corpVhrMapper.mngLedgerList();
	}

	@Override
	public int reserveCorpVhr(CorpVhrVO corpVhrVO) {
		//2) 차량 예약 정보를 개인일정 캘린더에 추가
		//법인차량 cvNo=297구1349, cvMdlNm=카니발, cvPrchsYmd=null, cvUseYn=null
		//법인차량 관리대장 cvmlNo=null(자동생성), empNo=A101, cvmlRentYmd=Wed Jul 03 09:00:00(대여일) KST 2024, cvmlRtnYmd=Thu Jul 04 09:00:00 KST 2024(반납일), cvmlUsePrps=테스트, cvmlUser=A101
		log.info("법인차량 예약 시 개인 일정 캘린더에 추가하기 위한 값 중간체크:" + corpVhrVO);
		
		TodoListVO todoListVO = new TodoListVO();
		
		todoListVO.setEmpNo(corpVhrVO.getEmpNo());
		todoListVO.setTdlTtl(corpVhrVO.getCvMdlNm()+"["+corpVhrVO.getCvNo()+"] 예약 완료");
		todoListVO.setTdlCn(corpVhrVO.getCvmlUsePrps()+"목적으로  예약");
		
		log.info("법인차량 예약 시 todoListVO:" + todoListVO);
		Date rentDateStrCorp = corpVhrVO.getCvmlRentYmd(); 
		Date rentDateEndCorp = corpVhrVO.getCvmlRtnYmd();  
		
		log.info("법인차량 예약 시 rentDateStrCorp:"+rentDateStrCorp); //Wed Jul 03 09:00:00 KST 2024
		log.info("법인차량 예약 시 rentDateEndCorp:"+rentDateEndCorp); //Thu Jul 04 09:00:00 KST 2024
		
		SimpleDateFormat dateFormatRentDate = new SimpleDateFormat("yyyy-MM-dd"); 
		String rentDateStrCorp2 = dateFormatRentDate.format(rentDateStrCorp);
		String rentDateEndCorp2 = dateFormatRentDate.format(rentDateEndCorp);
		
		log.info("법인차량 예약 시(String) rentDateStrCorp2:"+rentDateStrCorp2); //2024-07-03
		log.info("법인차량 예약 시(String) rentDateEndCorp2:"+rentDateEndCorp2); //2024-07-04
		
		todoListVO.setTdlStrDt(rentDateStrCorp2); // 2024/07/03 HH:mm:ss
		todoListVO.setTdlEndDt(rentDateEndCorp2); // 2024/07/04 HH:mm:ss
		todoListVO.setDeptNo(corpVhrVO.getDeptNo());
		todoListVO.setTdlCmptnYn("#EA6676");
		
		//tdlNo(자동생성), tdlTtl, tdlCn, tdlStrDt, tdlEntDt, empNo, deptNo
		log.info("회의실 예약 후 개인 일정 캘린더에 추가할 VO 값:" + todoListVO);
		
		int cnt = corpVhrMapper.reserveCorpVhr(corpVhrVO);
		
		cnt += todoListMapper.createPost(todoListVO);

		return cnt;
	}

	/**
	 * 법인차량 관리대장 리스트	
	 */
	@Override
	public List<CorpVhrVO> cvMngLdgr() {
		return this.corpVhrMapper.cvMngLdgr();
	}

	/**
	 * 차량을 대여한 사원의 상세정보보기
	 */
	@Override
	public EmployeeVO cvEmpDetail(EmployeeVO employeeVO) {
		EmployeeVO employeeVO1 = this.corpVhrMapper.cvEmpDetail1(employeeVO);
		String cvmlUsePrps = this.corpVhrMapper.cvEmpDetail2(employeeVO);
		employeeVO1.setCvmlUsePrps(cvmlUsePrps);
		
		return employeeVO1;
	}

	/**
	 * (마이페이지)
	 *  나의 법이차량 대여 현황
	 */
	@Override
	public List<CorpVhrVO> mycvMngLdgr(String empNo) {
		return this.corpVhrMapper.mycvMngLdgr(empNo);
	}

	/**
	 * (마이페이지)
	 *  법인차량 반납하기 
	 */
	@Override
	public int rtnVhr(CorpVhrVO corpVhrVO) {
		return this.corpVhrMapper.rtnVhr(corpVhrVO);
	}



}
