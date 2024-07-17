package kr.or.oho.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 예비 창업자 VO
 * @author PC-08
 */
@Data
public class ReserveFounderVO {
	//예비 창업자 정보
	private String rfNo;
	private String rfEmlAddr;
	private String rfNm;
	private int rfZip;
	private String rfAddr;
	private String rfDaddr;
	private String rfTelno;
	private Date rfYmd;
	private String rfHlo;
	private String ftNo;
	
	//희망지역구분
	private String comcdCdnm;
	
	//프랜차이즈유형 중첩빈 1:1
	private FrcsTypeVO frcsTypeVO;
	
	//상담기본정보 중첩빈 1:1
	private ItvBscInfoVO itvBscInfoVO;
	
	//예비창업자 등록결과 카운트
	private int result;
	private List<ReserveFounderVO> reserveFounderList;
}
