package kr.or.oho.vo;

import java.util.List;

import lombok.Data;

@Data
public class HldySeVO {
	
	private String hsNo; 
	private String hsNm; 
	
	//hsNo : 1. 휴가 	2. 출장 -> 중첩된 자바빈 1:N
	private List<HldyMngLdgrVO> HldyMngLdgrVOList;
	
}
