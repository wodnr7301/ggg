package kr.or.oho.vo;

import java.text.DecimalFormat;
import java.util.Date;

import lombok.Data;

@Data
public class HdorderDtlVO {
	private String hodNo;
	private int hodQnt;
	private int hodPrc;
	private int gdsAmt;
	private String gdsNm;
	private int gdsNtslAmt;
	private int gdsStock;
	private String gdsImg;
	private String hoNo;
	private String cnptNo;
	private String gdsNo;
	private String wrhsNo;
	
	public String getComma(int money) {
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		String comma = formatter.format(money);
		return comma;
	}
	
	// DB에 없는 컬럼
	private String hoRequest;
	private String hoPrcsYn;
	private String cnptNm;
	private Date hoDeliveryDt;
	private Date hoDt;
}
