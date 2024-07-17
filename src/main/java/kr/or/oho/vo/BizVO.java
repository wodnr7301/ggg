package kr.or.oho.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BizVO {
	private String bizNo;
	private String bizNm;
	private String bizCn;
	private String bizCmptnYn;
	private Date bizStdt;
	private Date bizEdt;
	
	private List<BizMemberVO> bizMemberVOList;
}
