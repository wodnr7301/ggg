package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FrcOrderDtlVO {
	private String fodNo; // 발주상세번호
	private String gdsNo; // 상품번호
	private String foNo; // 발주번호
	private int fodUnit; // 단위
	private int fodQnt; // 수량
	private int fodPrc; // 가격
	private int fodAmt; // 금액
	private String fodGdsNm; // 상품명
	
	// DB에 없는 값	
	private Date foOdt; // 발행일
	private String foPrcsYn; // 진행여부
	private String foRequest; // 반려사유
	private String frcsNm; // 가맹점 이름
	private Date foDeliveryDt; // 납기요청일
}
