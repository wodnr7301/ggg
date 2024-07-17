package kr.or.oho.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class CartVO {
	private String cartNo;
	private Date cartDt;
	private String cartPrcsYn;
	private String empNo;
	private String cartMemo;
	
	List<CartDtlVO> cartVODtlList;
}
