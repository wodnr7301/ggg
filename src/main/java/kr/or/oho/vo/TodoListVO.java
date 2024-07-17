package kr.or.oho.vo;


import lombok.Data;

@Data
public class TodoListVO {
	
	private String tdlNo;	 	//할 일 번호
	private String tdlTtl;      //제목
	private String tdlCn;       //내용
	private String tdlStrDt;    //시작날짜
	private String tdlEndDt;    //종료날짜
	private String tdlCmptnYn;  //완료여부
	private String empNo;       //사원번호
	private String deptNo;      //부서번호
	
	private String empNm; //사원명
	private String deptNm;	//부서명
	
	EmployeeVO employeeVO;

	DeptVO deptVO;
	
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	
//	console.log("datedatedatedatedate:", date1);
//	console.log("datedatedatedatedate:", date2);
	
//let formattedDate1 = date1.getFullYear() + '-' + ('0' + (date1.getMonth() + 1)).slice(-2)+ '-'
//+ ('0' + date1.getDate()).slice(-2) + 'T'
//+ ('0' + date1.getHours()).slice(-2) + ':' + date1.getMinutes()
    
//let formattedDate2 = date2.getFullYear() + '-' + ('0' + (date2.getMonth() + 1)).slice(-2)+ '-'
//+ ('0' + date2.getDate()).slice(-2) + 'T'
//+ ('0' + date2.getHours()).slice(-2) + ':' + date2.getMinutes()
	
}
