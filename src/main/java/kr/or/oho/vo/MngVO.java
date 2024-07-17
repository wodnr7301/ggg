package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MngVO {
	private String empNo;
	private String frcsNo;
	private String mngNo;
	private Date mngDt;
	private String mngYn;
	private String mngPp;
	
	private int total;
	private int success;
	private int ing;
	
	private String empNm;
	private String frcsNm;
	private String frcsAddr;
	private String loc;
}
