package kr.or.oho.vo;

import java.sql.Date;
import java.util.List;

import javax.validation.Valid;

import lombok.Data;

@Data
public class FreeBbsVO {
	private String fbNo;
	private String fbTtl;
	private String fbCn;
	private Date fbPstdt;
	private String empNo;
	private String fbDelYn;
	private int fbCount;
	private int displayNo;
	
	private String empNm;
	private String string;
	private String empJbgdNm;
	
	@Valid
	private List<FreeBbsVO> freeBbsList;
	
	@Valid
	private List<ComentVO> comentList;


	
}
