package kr.or.oho.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 가맹점 신규 계약 VO
 * @author PC-08
 */
@Data
public class CtrtVO {
	private String ctrtNo;		//계약번호
	private String frcsNo;		//가맹점코드
	private String empNo;		// 사원번호(계약담당자)
	private String ctrtNm;
	private String ctrtCn;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date ctrtYmd;
	private String rfNo;
	
	private String empNm;		// 사원명(계약담당자)
	
	private String frcEmpNo;	// 사원번호(가맹점주)
	private String frcEmpNm;	// 사원명(가맹점주)
	
	private String rfNm;		// 예비창업자(가맹점주)명//////
	
	private String frcsClsbizYn;	//폐업여부 (Y:폐업 N:정상영업)
	
	//계약서 첨부파일 중첩빈 1:1
	private AttachVO attachVO;
	
	//프랜차이즈유형 중첩빈 1:1
	private FrcsTypeVO frcsTypeVO;
	
	
	//파일업로드할때 담는 객체 <input type="file" />
	private MultipartFile uploadFile;
	
	//우수가맹점 체크
	private String goodFrc;
}
