package kr.or.oho.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class FrcOrderVO {
	private String foNo; // 발주번호
	private Date foOdt;	// 발주일
	private String foPrcsYn; // 진행여부
	private String foYn; // 처리여부
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date foDeliveryDt; // 납기일자
	private Date foStlmDt; // 결제일
	private String foMnm; // 결제수단명
	private Date foShippingStrdt; // 배송시작일
	private Date foShippingEnddt; // 배송완료일
	private String frcsNo; // 가맹점 코드
	private String foRequest; // 참고사항
	private int foTotal; // 합계
	List<FrcOrderDtlVO> frcOrderDtlVOList; // 발주상세
	
	// DB에 없는 컬럼
	private String frcsNm; 
	
}
