package kr.or.oho.vo;

import lombok.Data;

@Data
public class CnptVO {
	private String cnptNo;
	private String cnptNm;
	private String cnptRprsv;
	private String cnptAddr;
	private String cnptDaddr;
	private int cnptZip;
	private String cnptTelno;
	private String cnptBzstat;
	private String cnptCls;
	private String cnptBzmnNo;
	private String empNo;
	
	EmployeeVO employeeVO;
}
