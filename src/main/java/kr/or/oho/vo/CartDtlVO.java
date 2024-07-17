package kr.or.oho.vo;

import lombok.Data;

@Data
public class CartDtlVO {
	private String cdtlNo;
	private int cdtlQnt;
	private String gdsNo;
	private String cartNo;
	private String cdtlGdsNm;
	private int cdtlNtslAmt;
	private int cdtlAmt;
}
