package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AlarmVO {
	private String alrGlocd;
	private int alrSeq;
	private String alrSrc;
	private String alrIdnty;
	private String alrInfo;
	private Date alrTm;
	private String alrTg;
	private String alrSd;
}
