package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

/**
 * 면접 기본 정보 VO
 * @author PC-08
 */
@Data
public class ItvBscInfoVO {
	private String ibiNo;		//면접 일련 번호
	private Date ibiYmd;		//면접일
	private String ibiPassYn;	//합격여부
	private String ibiSeCd;		//구분
	private String ibiCon;		//면접 내용
	private String itveeNo;		//면접자 지원번호
	private String rfNo;		//예비창업자 지원번호
}
