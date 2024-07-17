<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
$(function() {
    const datatablesSimple = document.getElementById('mngLedger');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
	        	
            labels: {
                placeholder: "Search...",
                searchTitle: "Search within table",
                pageTitle: "Page {page}",
                perPage: "",
                noRows: "No entries found",
                info: "",
                noResults: "No results match your search query",
            }
        });
    }//datatablesSimple1 테이블 생성 끝
    
    $(function() { // 1
	
    	let cvmlUser;
    	
    	$(".empNo").on("click", function() { // 2
    		cvmlUser = $(this).val();
    		let cvmlNo = this.dataset.cvmlno;
    		console.log("cvmlUser : ", cvmlUser);
    		console.log("cvmlNo : ", cvmlNo);
    		
    		let data = {
    				"cvmlUser" : cvmlUser,
    				"cvmlNo" : cvmlNo
    		};
    		
    		console.log("data : ", data);
    		
    		$.ajax({ // cvEmpDetail Ajax
    			url: "/corpvhr/cvEmpDetail",
    			contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify(data),
                type: "post",
                beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                
                success: function(result) { // success function
                	console.log("result : ", result);
                	
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
                	} 
                	
                	let str = "";
                	str += 
                	`
                	<div class='card card-header-actions'>
                		<div class='card-header'>
                		
                		</div>
                		<div class='card-body'>
                			<table class='vhrEmpDetail'>
                				<thead>
                					<tr>
                						<th>항목</th><th>상세정보</th>
                					</tr>
                				</thead>
                				<tbody>
                					<tr>
                						<td>사원번호</td><td>\${result.empNo}</td>
                					</tr>
                					<tr>
                						<td>사원 명</td><td>\${result.empNm}</td>
                					</tr>
                					<tr>
                						<td>전화번호</td><td>\${result.empTelno}</td>
                					</tr>
                					<tr>
                						<td>소속부서</td><td>\${department}</td>
                					</tr>
                					<tr>
                						<td>대여목적</td><td>\${result.cvmlUsePrps}</td>
                					</tr>
                				</tbody>
                			</table>
                		</div>
                	</div>
                	`;
                	
                	$(".modal-body-detail").html(str);
                	
                	const datatablesSimple2 = document.querySelector('.vhrEmpDetail');
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
                    } // datatablesSimple2
                } // success function
    		}); // cvEmpDetail Ajax
    	}); // 2
    }); // 1
});
</script>
<style>
#mngLedger td {
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
						법인차량 관리대장
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone">목록</div>
		<div class="card-body main-card">
			<table id="mngLedger">
				<thead>
					<tr>
						<th>관리대장 번호</th>
						<th>법인차량 번호</th>
						<th>대여사원 번호</th>
						<th>대여일자</th>
						<th>반납일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ldgr" items="${ldgrList}" varStatus="stat">
						<tr>
							<td>${ldgr.cvmlNo}</td>
							<td>${ldgr.cvNo}</td>
							<td><button class="btn btn-outline-dark empNo" type="button" data-bs-toggle="modal"
							data-bs-target="#exampleModalCenter" value="${ldgr.cvmlUser}" data-cvmlno = "${ldgr.cvmlNo}">${ldgr.cvmlUser}</button></td>
							<td><fmt:formatDate value="${ldgr.cvmlRentYmd}" pattern="yyyy.MM.dd" /></td>
							<td><fmt:formatDate value="${ldgr.cvmlRtnYmd}" pattern="yyyy.MM.dd" /></td>
						</tr>
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
				<h5 class="modal-title" id="exampleModalCenterTitle">대여사원 정보</h5>
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