package kr.or.oho.vo;

import java.text.DecimalFormat;

import lombok.Data;

@Data
public class DdcVO {
	private String ddcNo;
	private int ddcInsrnc;
	private int ddcInctx;
	
	public String getComma(int money) {
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		String comma = formatter.format(money);
		return comma;
	}
}
