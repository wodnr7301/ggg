package kr.or.oho.vo;

import java.util.Date;

import lombok.Data;

@Data
public class HldyMngLdgrVO {
	
	private String hmlNo;
	private String empNo;
	private String hsNo;
	private Date hmlUseDt1;
	private Date hmlEndDt1;
	private String hmlUseDt;
	private String hmlEndDt;
	private int hmlTd;
	private String hmlRsn;
	private String eatrztNo;
	private String atrzlnNo;
	private String tmpltCn;
	private String tmpltNo;
	private HldySeVO hldySeVO;
	
	private EatrztVO eatrztVO;
}
