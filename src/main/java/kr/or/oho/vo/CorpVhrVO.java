package kr.or.oho.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

// 법인차량, 관리대장 VO
@Data
public class CorpVhrVO {

	// 법인차량
	private String cvNo;					// 법인차량 번호
	private String cvMdlNm;					// 법인차량 모델명
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date cvPrchsYmd;				// 법인차량 구매일자
	private String cvUseYn;					// 법인차량 사용여부
	
	// 법인차량 관리대장
	private String cvmlNo;					// 관리대장 번호
	private String empNo;					// 관련 사원번호
	private Date cvmlRentYmd;				// 법인차량 대여일자
	private Date cvmlRtnYmd;				// 법인차량 반납일자
	private String cvmlUsePrps;				// 대여목적
	private String cvmlUser;				// 사용한 사원
	
	// 사원번호
	private String deptNo;					// 일정캘린더에 넣기 위해 필요
}
