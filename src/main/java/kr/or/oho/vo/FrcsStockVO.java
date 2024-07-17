package kr.or.oho.vo;

import lombok.Data;

@Data
public class FrcsStockVO {
	private String gdsNo;
	private String frcsNo;
	private int frcssCnt;
	private int minGdsStock;
	private int maxGdsStock;
	
	// DB에 없는 값
	private String gdsNm;
	private int gdsNtslAmt;
	private String comcdCdnm;
}
