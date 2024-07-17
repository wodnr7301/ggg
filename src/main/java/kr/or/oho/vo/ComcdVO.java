package kr.or.oho.vo;

import lombok.Data;

@Data
public class ComcdVO {
	private String comcdGroupcd;	//D101
	private String comcdGroupcdNm;	//지역
	private String comcdCdnmcomGc;	//D1
	private String comcdCdnm;		//서울
	private String comcdOne;
	private String comcdTwo;
	private String comcdThree;
	private String comcdUseYn;
	
	private int countRegion;		//지역별 가맹점 개수
	private String frcsNo;			// 가맹점 번호
}
