package kr.or.oho.vo;

import java.text.DecimalFormat;
import java.util.Date;

import lombok.Data;

@Data
public class SalaryVO {
	private String amlNo;
	private Date amlDt;
	private int amlAmt;
	private String empNo;
	private String giveNo;
	private String ddcNo;
	
	//사원명 출력용
	private String empNm;
	
	//ACNT_MNG_LDGR의 VO임
	
	//insert용 giveVO값
	private int giveAmt;
	private int giveExts;
	private int giveNight;
	private int giveHldy;
	
	//insert용 ddcVO값
	private int ddcInsrnc;
	private int ddcInctx;
	
	
	public String getComma(int money) {
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		String comma = formatter.format(money);
		return comma;
	}
}
