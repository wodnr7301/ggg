package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AttendVO {
	
	private String waNo;
	private String waDt;
	private String EaOutTime;
	private Date waYmd;
	private String waRsn;
	private String waStatus;
	private String empNo;
	private String backColor;
	private String gubun;
}
