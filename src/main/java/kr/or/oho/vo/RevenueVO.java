package kr.or.oho.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class RevenueVO {
	
	private String frcsNo;				//가맹점 코드
	private int fsAmt;					//매출액
	private int fsCost;					//매출원가
	private int fsEarn;					//매출 총 액
	private int fsOp;					//순이익
	private Date fsWrtDt; 				//작성일
	private Date fsMdfcnDt;				//수정일
	private int fsLbrco;				//인건비
	private int fsNtslAmt;				//판매비
	private int fsMngAmt;				//관리비
	private int fsExpense;				//총 지출
	private String fsWrtYear;			//연도
	private int fsMonthly;				//월
	private int fsWrtQy;				//분기
	
	private int totalFsAmt;				//연도별 매출액
	private int totalFsCost;			//연도별 매출원가
	private int totalFsEarn;			//연도별 매출 총 액
	private int totalFsOp;				//연도별 순이익
	private int totalFsLbrco;			//연도별 인건비
	private int totalFsNtslAmt;			//연도별 판매비
	private int totalFsMngAmt;			//연도별 관리비
	private int totalFsExpense;			//연도별 총 지출
	
	private int totalQuaterFsAmt;		//분기별 매출액
	private int totalQuaterFsCost;		//분기별 제품원가
	private int totalQuaterFsEarn;		//분기별 매출 총 액
	private int totalQuaterFsOp;		//분기별 순이익
	private int totalQuaterFsLbrco;		//분기별 인건비
	private int totalQuaterFsNtslAmt;	//분기별 판매비
	private int totalQuaterFsMngAmt;	//분기별 관리비
	private int totalQuaterFsExpense;	//분기별 총 지출
	
	private String frcsNm;				//가맹지점명
	private String frcsAddr;			//가맹 지역
	private String frcsDaddr;			//가맹 상세 지역
	private String frcsTelNo;			//가맹지점 번호
}
