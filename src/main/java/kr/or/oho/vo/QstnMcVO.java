package kr.or.oho.vo;

import java.util.List;

import lombok.Data;

@Data
public class QstnMcVO {
	private String qmNo;	//질문번호
	private String srvyNo;	//설문번호
	private String qmTtl;	//질문제목
	
	//보기테이블 중첩빈 1 : N
	private List<ExampleVO> exampleList;
}
