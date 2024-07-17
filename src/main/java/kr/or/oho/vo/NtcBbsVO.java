package kr.or.oho.vo;

import java.sql.Date;
import java.util.List;

import javax.validation.Valid;

import lombok.Data;

@Data
public class NtcBbsVO {
	private String nbNo;
	private String nbTtl;
	private String nbCn;
	private Date nbPstdt;
	private String nbImp;
	private String empNo;
	private String nbDelYn;
	private int nbCount;
	private int displayNo;
	private String deptNo;
	private String empNm;
	
	@Valid
	private List<NtcBbsVO> ntcBbsList;
	
	@Valid
	private List<ComentVO> comentList;

}

