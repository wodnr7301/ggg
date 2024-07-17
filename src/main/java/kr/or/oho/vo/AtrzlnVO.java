package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AtrzlnVO {
	private String atrzlnNo;	//결재선번호
	private String empNo;		//사원번호
	private String eatrztNo;	//문서번호
	private Date atrzlnDt;		//결재일
	private int atrzlnPro;		//결재우선순위
	
	//연차 결재선
	private String hsNo;		//연차구분
	private String hmlUseDt;	//연차 시작일
	private String hmlEndDt;	//연차 종료일
	private String hmlRsn;		//연차 제목
}
