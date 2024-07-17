package kr.or.oho.vo;

import java.text.DecimalFormat;

import lombok.Data;

@Data
public class GiveVO {
	private String giveNo;
	private int giveAmt;
	private int giveExts;
	private int giveNight;
	private int giveHldy;
	
	public String getComma(int money) {
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		String comma = formatter.format(money);
		return comma;
	}
	
}
