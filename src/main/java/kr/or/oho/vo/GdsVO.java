package kr.or.oho.vo;

import lombok.Data;

@Data
public class GdsVO {
	private String gdsNo;
	private String gdsNm;
	private int gdsPrchsAmt;
	private int gdsNtslAmt;
	private int gdsStock;
	private int minGdsStock;
	private String gdsImg;
	private String cnptNo;
	private String gdsGu;
	private String wrhsNo;
	
	// 값 가져오기 위해 추가
	private String cnptNm;
	private String comcdCdnm;
}
