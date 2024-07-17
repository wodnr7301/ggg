package kr.or.oho.vo;

import lombok.Data;

/**
 * 프랜차이즈 유형 VO
 * @author PC-08
 */
@Data
public class FrcsTypeVO {
	private String ftNo;	//프랜차이즈 유형번호
	private String ftNm;	//프랜차이즈 유형명
	
	private int ftCnt;		//프랜차이즈 유형 개수
}
