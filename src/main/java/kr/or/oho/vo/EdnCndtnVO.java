package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

/**
 * 교육 현황 vo
 * @author PC-08
 */
@Data
public class EdnCndtnVO {
	private String ecNo;	// 교육현황번호
	private String epNo;	// 교육 프로그램 번호
	private String frcsNo;	// 가맹점 코드
	private Date ecYmd;		// 교육일
	private String ecYmdF;	// 교육일(포맷 : yyyy-MM-dd)
	private String ecYn;	// 이수여부
	private String ecBlank;	// 비고(불참사유)
	
	// 교육프로그램 중첩자바빈 1 : 1
	private EdnPrgrmVO ednPrgrmVO;
	// 가맹점 중첩자바빈 1 : 1
	private FranchiseVO franchiseVO;
	
	private int ecYnfCnt;	// 이수 현황 수
	
	private String epNm; //알람용 교육이름
}
