package kr.or.oho.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SrvyVO {
	private String srvyNo;		//설문조사번호
	private String srvyTtl;		//제목
	private String srvyCn;		//내용
	private String srvyTrgt;	//설문 대상(1:본사 2:가맹점주)
	private Date srvyYmd;		//설문 시작일
	private Date srvyEndDate;	//설문 종료일
	private String empNo;		//사원번호(조사자)
	
	private String srvyYmdStr;		//설문 시작일
	private String srvyEndDateStr;	//설문 종료일
	
	//질문테이블 중첩빈 1 : N
	private List<QstnMcVO> qstnMcList;
}
