package kr.or.oho.alarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.alarm.service.AlarmService;
import kr.or.oho.mng.service.MngService;
import kr.or.oho.vo.AlarmVO;
import kr.or.oho.vo.EdnCndtnVO;
import kr.or.oho.vo.MngVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/alarm")
public class AlarmController {
	
	@Autowired
	AlarmService alarmService;
	
	@Autowired
	MngService mngService;
	
	/**
	 * 알림 정보를 알림 테이블에 insert하는 ajax 동작을 위한 컨트롤러
	 * @param alarmVO
	 * @return int cnt 알림 인서트 처리된 결과 숫자를 리턴
	 */
	@ResponseBody
	@PostMapping("/create")
	public int alarmCreate(@RequestBody AlarmVO alarmVO) {
		int cnt =0;
		
		if(alarmVO.getAlrSrc().equals("edu")) {
			alarmVO.setAlrGlocd(this.alarmService.getMaxEdu());
			
		}
		
		cnt = this.alarmService.alarmCreate(alarmVO);
		
		return cnt;
	}
	
	/**
	 * 메인헤더에 알림을 출력하기 위해 empNo대상 알림 리스트를 출력하는 ajax 동작을 위한 컨트롤러
	 * @param empNo
	 * @return List<AlarmVO> alarmVOList empNo대상 전체 알림을 리스트에 담아 리턴
	 */
	@ResponseBody
	@PostMapping("/header")
	public List<AlarmVO> header(@RequestBody String empNo){
		log.debug("empNo : " + empNo);
		List<AlarmVO> alarmVOList = this.alarmService.header(empNo);
		
		log.debug("alarmVOList : " + alarmVOList);
		
		return alarmVOList;
	}
	
	/**
	 * 메인헤더 알림 확인 처리를 하는 ajax 동작을 위한 컨트롤러
	 * @param alarmVO
	 * @return int cnt 업데이트 처리된 숫자를 리턴
	 */
	@ResponseBody
	@PostMapping("/updateY")
	public int updateY(@RequestBody AlarmVO alarmVO) {
		log.debug("alarmVO : "+alarmVO);
		int cnt = this.alarmService.updateY(alarmVO);
		
		return cnt;
	}
	
	/**
	 * 알림 테이블 insert시 필요한 가맹점주 empNo를 가져오는 ajax를 실행하기 위한 컨트롤러
	 * @param frcsNo
	 * @return 해당 가맹점 번호에 맞는 가맹점주 String empNo를 리턴
	 */
	@ResponseBody
	@PostMapping("/getId")
	public String getId(@RequestBody String frcsNo) {
		
		String sanitizedData = frcsNo.replaceAll("^\"|\"$", "");
		log.debug("sanitizedData : "+sanitizedData);
		
		String empNo = this.alarmService.getEmpNo(sanitizedData);
		return empNo;
	}
	
	/**
	 * 메인헤더에 방문일정 알림에 대한 정보를 가져오는 ajax 동작을 위한 컨트롤러
	 * @param mngNo
	 * @return mngVO에 해당 일정에 대한 정보를 담아 리턴
	 */
	@ResponseBody
	@PostMapping("/getMngDetail")
	public MngVO getMngDetail(@RequestBody String mngNo) {
		
		MngVO mngVO = this.mngService.detail(mngNo);
		log.debug("mngVO : "+mngVO);
		return mngVO;
	}
	
	/**
	 * 교육일정 알림 insert시 교육일정 기본키를 가져오는 ajax 동작을 위한 컨트롤러
	 * @return 교육일정 기본키인 String ecNo를 리턴
	 */
	@ResponseBody
	@PostMapping("/getMax")
	public String getMax() {
		String ecNo = this.alarmService.getmax();
		log.debug("ecNo : "+ecNo);
		return ecNo;
	}
	
	/**
	 * 교육일정 알림 출력시 필요한 정보를 가져오는 ajax 동작을 위한 컨트롤러
	 * @param ecNo
	 * @return EdnCndtnVO ednCndtnVO 에 해당하는 정보를 담아서 리턴
	 */
	@ResponseBody
	@PostMapping("/getEduDetail")
	public EdnCndtnVO getEduDetail(@RequestBody String ecNo) {
		EdnCndtnVO ednCndtnVO = this.alarmService.getEduDetail(ecNo);
		log.debug("ednCndtnVO : "+ednCndtnVO);
		
		return ednCndtnVO;
	}
}
