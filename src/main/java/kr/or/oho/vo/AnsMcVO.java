package kr.or.oho.vo;

import lombok.Data;

@Data
public class AnsMcVO {
	private String amNo;	//답변번호
	private String empNo;	//사원번호(설문참여자)
	private String expNo;	//보기번호
	private int amCn;		//답변내용(선택한번호)
}
