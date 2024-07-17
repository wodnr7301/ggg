package kr.or.oho.vo;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class HdorderVO {
	private String hoNo;
	private Date hoDt;
	private String hoPrcsYn;
	private String empNo;
	private int hoTotalAmt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hoDeliveryDt;
	private String hoRequest;
	private String hoMnm;
	private Date hoShippingStrdt;
	private Date hoShippingEnddt;
	private Date hoStlmDt;
	
	// hdorder/create페이지에서 값을 받기 위해 생성
	private String foNo;
	
	List<HdorderDtlVO> hdorderDtlVOList;
	
	EmployeeVO employeeNm;
	
	public String getComma(int money) {
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		String comma = formatter.format(money);
		return comma;
	}
}
