<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>


$(function() {
    const datatablesSimple = document.getElementById('datatablesSimple1');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple,{
        		labels: {
        		    placeholder: "Search...",
        		    searchTitle: "Search within table",
        		    pageTitle: "Page {page}",
        		    perPage: "",
        		    noRows: "No entries found",
        		    info: " ",
        		    noResults: "No results match your search query",
        		}		
        	}
        );
    }
    
    $(function() {
        let empNo;
        
        $(".empNo").on("click", function() {
            empNo = $(this).val();
            console.log("empNo : ", empNo);
            
            let data = {
                "empNo": empNo
            };
            
            console.log("data : ", data);
            
            $.ajax({
                url: "/employee/detail",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify(data),
                type: "post",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    console.log("result : ", result);
                    
                    // 성별값 변환
                    let gender = result.empGen === 'M' ? '남' : '여';
                    
                    // 부서번호값 변환
                    let department;
                	switch(result.deptNo) {
                    case 'A001':
                        department = '개발부';
                        break;
                    case 'A002':
                        department = '영업부';
                        break;
                    case 'A003':
                        department = '인사부';
                        break;
                    case 'A004':
                        department = '회계부';
                        break;
                    case 'A005':
                        department = '기획부';
                        break;
                    default:
                    	department = '-';
                	}
                	
                	// 직위값 변환
                	let jbgd;
                	switch(result.empJbgdNm) {
                	case 'A102':
                		jbgd = '부장';
                		break;
                	case 'A103':
                		jbgd = '과장';
                		break;
                	case 'A104':
                		jbgd = '대리';
                		break;
                	case 'A105':
                		jbgd = '사원';
                		break;
                	 default:
                		 jbgd = '-';
                	}
                	
                	// 직책값 변환
                	let jbttl;
                	switch(result.empJbttlNm) {
                	case 'A201':
                		jbttl = '팀장';
                		break;
                	case 'A202':
                		jbttl = '부서장';
                		break;
                	case 'A203':
                		jbttl = '사업부장';
                		break;
                	default:
                		jbttl = '-';
                	}
                	
                	const timestamp = parseInt(result.empEmpymd);
                	const date = new Date(timestamp);
                	
                	const empEmpYmd = date.toLocaleDateString('ko-KR');
                    
                	let str = "";
                   str += `<div class='card card-header-actions'>
                   <div class='card-header'>
                   \${result.empNm}
                   			</div>
                   <div class='card-body'>
                   <table class='datatablesSimple2'>
                   	<thead>
                   		<tr>
                   			<th>항목</th><th>상세정보</th>
                   		</tr>
                   </thead>
                   <tbody>
                   		<tr>
                   			<td>성별</td><td>\${gender}</td>
                   		</tr>
                   		<tr>
                   			<td>기혼여부</td><td>\${result.empMrgYn === 'Y' ? '기혼' : '미혼'}</td>
                   		</tr>
                   		<tr>
                   			<td>입사 / 가맹 일자</td><td>\${empEmpYmd}</td>
                   		</tr>
                   		<tr>
                   			<td>은행명</td><td>\${result.empJncmpYmd}</td>
                   		</tr>
                   		<tr>
                   			<td>계좌번호</td><td>\${result.empActno}</td>
                   		</tr>
                   		<tr>
                           <td>직책</td><td>\${jbttl}</td>
                        </tr>
                   		<tr>
                   			<td>직위</td><td>\${jbgd}</td>
                   		</tr>
                        <tr>
                            <td>부서</td><td>\${department}</td>
                        </tr>
                     </tbody>
                    </table></div></div>`;
                    
                    $(".modal-body-detail").html(str);
                    
                    const datatablesSimple2 = document.querySelector('.datatablesSimple2');
                    if (datatablesSimple2) {
                        new simpleDatatables.DataTable(datatablesSimple2,{
                            searchable: false,
                            perPageSelect: false,
                            sortable: false,
                            labels: {
                                pageTitle: "Page {page}",
                                info: "",
                            }      
                        });
                    }
                }
            });
        });
		
        $(".edito").on("click", function() {
        	empNo = $(this).val();	
        });
        	$(document).on('click', '.edit', function() {
        		console.log("empNo : " + empNo); 
        	
        		location.href = "/employee/update?empNo=" + empNo;
        	});
        	
        	$(".delo").on('click', function() {
				empNo = $(this).val();
        	});
        	
        	$(document).on('click', '.del', function() {
        		console.log("empNo : " + empNo);
        		
        		let data = {
        			"empNo" : empNo	
        		};
        		console.log("data : ", data);
        		
        		$.ajax({
        			url : "/employee/deleteEmpAjax",
        			contentType: "application/json;charset=utf-8",
        			dataType: "json",
                    data: JSON.stringify(data),
                    type: "post",
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                        success: function(result) {
                            console.log("result : ", result);
                            let success = "success";
                            let data ={
                            		"success":success
                            }
                            swal("퇴직처리 되었습니다.","","success");
                            
                            $.ajax({
                            	url : "/employee/listAjax",
                            	contentType: "application/json;charset=utf-8",
                                dataType: "json",
                                data: JSON.stringify(data),
                                type: "post",
                                beforeSend: function(xhr) {
                                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                },
                                success: function(result2) {
                                	console.log("result2 : ", result2);
                                	
                                	let str = "";
	                                		str += `
	                                			<table id="datatablesSimple1">
	                            				<thead>
	                            					<tr>
	                            						<th>사원번호</th>
	                            						<th>사원명</th>
	                            						<th>주소</th>
	                            						<th>상세주소</th>
	                            						<th>전화번호</th>
	                            						<th>수정</th>
	                            					</tr>
	                            				</thead>
	                            				<tbody>`;
				                                	$.each(result2, function(idx, empVO){
				                                	if(empVO.empClsf != 'A302') {
	                            					str += `<tr>
	                            						<td><button class="btn btn-outline-dark empNo" type="button" data-bs-toggle="modal"	data-bs-target="#exampleModalCenter" value="\${empVO.empNo}">\${empVO.empNo}</button></td>
	                            								<td>\${empVO.empNm}</td>
	                            								<td>\${empVO.empAddr}</td>
	                            								<td>\${empVO.empDaddr}</td>
	                            								<td>\${empVO.empTelno}</td>
	                            								<td>
	                            									<button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#exampleModalCenter2" value="\${empVO.empNo}">
	                            										<svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg="">
	                            											<path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg>
	                            									</button>
	                            									<button	class="btn btn-datatable btn-icon btn-transparent-dark delo" data-bs-toggle="modal" data-bs-target="#exampleModalCenter3" value="\${empVO.empNo}">
	                            										<svg class="svg-inline--fa fa-trash-can" aria-hidden="true"	focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg"	viewBox="0 0 448 512" data-fa-i2svg="">
	                            											<path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg>
	                            									</button>
	                            								</td>
	                            							</tr>`;
						                                	};
					                                	});
	                            					str += `</tbody>
	                            			</table>`;
                                	$(".dtl").html(str);
                                    const datatablesSimple = document.getElementById('datatablesSimple1');
                                    if (datatablesSimple) {
                                        new simpleDatatables.DataTable(datatablesSimple,{
                                        		labels: {
                                        		    placeholder: "Search...",
                                        		    searchTitle: "Search within table",
                                        		    pageTitle: "Page {page}",
                                        		    perPage: "",
                                        		    noRows: "No entries found",
                                        		    info: " ",
                                        		    noResults: "No results match your search query",
                                        		}		
                                        	}
                                        );
                                    }
                                }
                            });
	                  	 }
		       		});
		  	   	});
		     });
		 });
</script>
<style>
#datatablesSimple1 td:nth-child(1),
#datatablesSimple1 td:nth-child(5),
#datatablesSimple1 td:nth-child(6) {
text-align: center;
}

</style>
<header
	class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
	<div class="container-xl px-4">
		<div class="page-header-content pt-4">
			<div class="row align-items-center justify-content-between">
				<div class="col-auto mt-4">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<i data-feather="layout"></i>
						</div>
						사원 목록
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone">사원 목록</div>
		<div class="card-body main-card dtl">
			<table id="datatablesSimple1">
				<thead>
					<tr>
						<th>사원번호</th>
						<th>사원명</th>
						<th>주소</th>
						<th>상세주소</th>
						<th>전화번호</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="empVO" items="${empList}" varStatus="stat">
						<c:if test="${empVO.empClsf != 'A302'}">
							<tr>
								<td><button class="btn btn-outline-dark empNo"
										type="button" data-bs-toggle="modal"
										data-bs-target="#exampleModalCenter" value="${empVO.empNo}">${empVO.empNo}</button></td>
								<td>${empVO.empNm}</td>
								<td>${empVO.empAddr}</td>
								<td>${empVO.empDaddr}</td>
								<td>${empVO.empTelno}</td>
								<td>
									<button
										class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito"
										data-bs-toggle="modal" data-bs-target="#exampleModalCenter2"
										value="${empVO.empNo}">
										<svg class="svg-inline--fa fa-ellipsis-vertical"
											aria-hidden="true" focusable="false" data-prefix="fas"
											data-icon="ellipsis-vertical" role="img"
											xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512"
											data-fa-i2svg="">
											<path fill="currentColor"
												d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg>
									</button>
									<button
										class="btn btn-datatable btn-icon btn-transparent-dark delo"
										data-bs-toggle="modal" data-bs-target="#exampleModalCenter3"
										value="${empVO.empNo}">
										<svg class="svg-inline--fa fa-trash-can" aria-hidden="true"
											focusable="false" data-prefix="far" data-icon="trash-can"
											role="img" xmlns="http://www.w3.org/2000/svg"
											viewBox="0 0 448 512" data-fa-i2svg="">
											<path fill="currentColor"
												d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg>
									</button>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">사원 상세정보</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body-detail">
			
			</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModalCenter2" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">수정</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">수정화면으로 이동하시겠습니까?</div>
			<div class="modal-footer">
				<button class="btn btn-secondary edit" data-bs-dismiss="modal"
					type="button">수정</button>
				<button class="btn btn-primary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModalCenter3" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">삭제</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">퇴직처리 하시겠습니까?</div>
			<div class="modal-footer">
				<button class="btn btn-danger del" data-bs-dismiss="modal"
					type="button">퇴직처리</button>
				<button class="btn btn-primary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
