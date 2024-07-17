package kr.or.oho.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ComentVO {
	
	private String cmntNo;
	private String cmntCd;
	private String cmntCn;
	private Date cmntWrtDt;
	private String empNo;
	private String cmntDelYn;
	
	private String empNm;
}
