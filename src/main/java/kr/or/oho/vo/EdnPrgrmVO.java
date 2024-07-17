package kr.or.oho.vo;

import lombok.Data;

/**
 * 교육 프로그램 vo
 * @author PC-08
 */
@Data
public class EdnPrgrmVO {
	private String epNo;		// 교육 프로그램 번호
	private String epNm;		// 프로그램명
	private int epTm;			// 교육 소요시간
	private String epEsntlYn;	// 필수 / 선택
	private String epPlcNm;		// 교육 장소
	private String epContent;	// 교육 내용
	
	private String epNm1;	// 프로그램명1 (ex. 안전교육)
	private String epNm2;	// 프로그램명2 (ex. 1차)
	private String epNm3;	// 프로그램명3 (ex. 5개 교육은 프로그램명1과 동일, 나머지는 모두 기타교육)
		
	private int epNm1Count;	// 프로그램명1 개수
	private int epEcYCnt;	// 교육 참여자 수
}