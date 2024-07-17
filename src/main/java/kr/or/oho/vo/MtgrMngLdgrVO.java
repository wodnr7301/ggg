package kr.or.oho.vo;

import lombok.Data;

@Data
public class MtgrMngLdgrVO {

	private String mmlNo;			//회의실 관리번호 2
	private String mmlUsePrps;		//사용목적 2
	private String mmlRsvtYN;       //예약여부 2
	private String mmlRsvtYmd;      //예약일자 sysdate2
	private String mmlRsvtStrdt;    //예약시작시간 2
	private String mmlRsvtEnddt;    //예약종료시간 2
	private String mtgrNo;			//회의실 번호 2
	private String empNo;			//사원 번호 2
	private String deptNo;			//아작스 전송용
	
	private String empNm; //서브쿼리로 가져올 사용자 이름
	
	private String mtgrNm;	//서브쿼리로 가져올수도 있는 회의실 이름
	private String mtgrUseYN; //서브쿼리로 가져올수도 있는 회의실 사용 여부
	
	
	
	
}
