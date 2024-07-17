package kr.or.oho.vo;

import lombok.Data;

/**
 * 가맹점 VO
 * @author PC-08
 */
@Data
public class FranchiseVO {
	private String frcsNo;			//가맹점코드
	private String frcsNm;			//가맹지점명
	private String frcsAddr;		//가맹점 주소
	private String frcsDaddr;		//가맹점 상세주소
	private int frcsZip;			//가맹점 우편번호
	private String frcsTelno;		//가맹점 전화번호
	private String empNo;			//사원번호(가맹점주)
	private String ftNo;			//프랜차이즈 유형 번호
	private String ftRgnNm;			//지역구분
	private String frcsClsbizYn;	//폐업여부 (Y:폐업 N:정상영업)
	
	private String ftNm;		//프랜차이즈 유형명
	private String comcdCdnm;	//지역구분명	
}
