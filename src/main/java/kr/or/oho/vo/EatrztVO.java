package kr.or.oho.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
	public class EatrztVO {
	private String eatrztNo; 		    // 문서번호
	private String empNo; 			    // 사원번호
	private String empId; 			    // 사원아이디
	private String tmpltNo; 		    // 서식번호
	private String eatrztTtl; 		    // 제목
	private String eatrztCn; 		    // 내용
	private Date eatrztRepdt; 		    // 작성일
	private Date eatrztAtrzdt; 		    // 결재일
	private String eatrztPrcsYn; 	    // 처리상태
	private String deptNo; 			    // 부서번호
	private String deptNm; 			    // 부서명
	private String comcdCdnm; 		    // 직위
	private String empNm; 			    // 사원명
	private String tmpltTtl; 		    // 서식제목
	private String atrzlnNo;			// 결재선 번호
	private String atrzlnPro;			// 결재순서
	private Date atrzlnDt;			// 결재일자
		                                    
	private TmpltVO tmpltVO; 		    // 서식VO
	private EmployeeVO employeeVO;      // 사원VO
	private DeptVO deptVO; 			    // 부서VO
	private AtrzlnVO atrzlnVO;			// 결재선VO
	
	// atrzlnVOList[0].empNo
	// atrzlnVOList[1].empNo
	private List<AtrzlnVO> atrzlnVOList;// 결재선

	private MultipartFile[] file;		// 스프링 파일 객체 배열 타입
	
	private List<AttachVO> attachVOList;//첨부파일 
}
