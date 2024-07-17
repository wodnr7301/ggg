<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
#trnPrgrsTable td:nth-child(1), td:nth-child(5), td:nth-child(7){
	text-align: center;
	width: 9%;
}
#trnPrgrsTable td:nth-child(2){
	text-align: center;
	width: 6%;
}
#trnPrgrsTable td:nth-child(3){
	width: 30%;
}
#trnPrgrsTable td:nth-child(4){
	width: 15%;
}
#trnPrgrsTable td:nth-child(6){
	width: 20%;
}

#newTable td:nth-child(1), td:nth-child(5), td:nth-child(7){
	text-align: center;
	width: 9%;
}
#newTable td:nth-child(2){
	text-align: center;
	width: 6%;
}
#newTable td:nth-child(3){
	width: 30%;
}
#newTable td:nth-child(4){
	width: 15%;
}
#newTable td:nth-child(6){
	width: 20%;
}

.radioBtn {
	opacity: 0;
}

.form-check-label {
	padding: 5px 10px;
	border: 1px solid #c5ccd6;
	border-radius: 0.35rem;
	font-size: 0.875rem;
	margin-bottom: 2px;
}

input[name=epNm1]+.form-check-label {
	width: 330px;
}

input[name=epNm2]+.form-check-label {
	width: 270px;
}

input[name=frcsNo]+.form-check-label {
	width: 210px;
}

input[type=radio]:checked+.form-check-label {
	background: #f1aeb5;
	border: 1px solid white;
	color: white;
}

input[type=checkbox]:checked+.form-check-label {
	background: #f1aeb5;
	border: 1px solid white;
	color: white;
}
</style>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
	<div class="container-xl px-4">
		<div class="page-header-content">
			<div class="row align-items-center justify-content-between pt-3">
				<div class="col-auto mb-3">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-book-fill" viewBox="0 0 16 16">
							  <path
									d="M8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783" />
							</svg>
						</div>
						교육 이수 현황
					</h1>
				</div>
				<div class="col-12 col-xl-auto mb-3">
					<button class="btn btn-sm btn-light text-primary" type="button"
						data-bs-toggle="modal" data-bs-target="#createGroupModal">
						<i class="me-1" data-feather="plus"></i> 개별 교육 일정 등록
					</button>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<!-- 개점 관리 페이지 탭 -->
<nav class="nav nav-borders">
    <a class="nav-link ms-0" href="/trnMng/list">교육 프로그램 관리</a>
    <a class="nav-link ms-0 active" href="/trnPrgrs/list">교육 이수 현황</a>
</nav>
<hr class="mt-0 mb-4" />
	<!-- 카드배너 -->
	<div class="row">
		<c:forEach var="ednPrgrmNm" items="${ednPrgrmNmList}" varStatus="stat">
			<div class="col-xl-4 mb-4">
				<a class="card lift h-100" href="#" onclick="fCard(this)"
					data-epnm="${ednPrgrmNm.epNm1}">
					<div class="card-body d-flex justify-content-center flex-column">
						<div class="d-flex align-items-center justify-content-between">
							<div class="me-2">
								<h5>${ednPrgrmNm.epNm1}</h5>
<%-- 								<div class="text-muted small">${ednPrgrmNm.epNm1Count}건 진행중</div> --%>
								<div>
									<span class="badge text-black" style="background-color: #dddddd;">이수 전 : <span id="cntNSpanllll">${ynfList[stat.index][1].ecYnfCnt}</span></span>
									<span class="badge bg-blue-soft text-blue">이수 완료 : <span id="cntYSpanllll">${ynfList[stat.index][0].ecYnfCnt}</span></span>
									<span class="badge bg-red-soft text-red">이수 불가 : <span id="cntFSpanllll">${ynfList[stat.index][2].ecYnfCnt}</span></span>
								</div>
							</div>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
	<div class="card">
		<div class="card-body">
			<h3 id="ednTitle" style="text-align: center; font-weight: 500;">전체 이수 현황</h3>
			<!-- 해당 교육 이수 서머리(디폴트 : 전체) -->
			<div class="row">
				<div style="text-align:end;">
					<span class="badge text-black" style="background-color: #dddddd;">이수 전 : <span id="cntNSpan">${cntN}</span></span>
					<span class="badge bg-blue-soft text-blue">이수 완료 : <span id="cntYSpan">${cntY}</span></span>
					<span class="badge bg-red-soft text-red">이수 불가 : <span id="cntFSpan">${cntF}</span></span>
				</div>
			</div>
			<hr class="mb-4" />
			<div id="tableStart">
			<table id="trnPrgrsTable">
				<thead>
					<tr>
						<th>교육일</th>
						<th>구분</th>
						<th>프로그램명</th>
						<th>가맹점</th>
						<th>이수여부</th>
						<th>비고</th>
						<th>수정 | 삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ednCndtn" items="${ednCndtnList}" varStatus="stat">
						<tr>
							<td id="ecYmdStr"><fmt:formatDate value="${ednCndtn.ecYmd}"
									pattern="yyyy-MM-dd" /></td>
							<td><span style="color:
<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'Y'}">red</c:if>
<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'N'}">blue</c:if>
	                        								;">
	                        	<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'Y'}">필수</c:if>
	                        	<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'N'}">선택</c:if>
	                        </span></td>
							<td>${ednCndtn.ednPrgrmVO.epNm}</td>
							<td>${ednCndtn.franchiseVO.frcsNm}</td>
							<td>
								<div class="badge 
				<c:if test="${ednCndtn.ecYn eq 'N'}">text-black" style="background-color: #dddddd;</c:if>
				<c:if test="${ednCndtn.ecYn eq 'Y'}">bg-blue-soft text-blue" style="</c:if>
				<c:if test="${ednCndtn.ecYn eq 'F'}">bg-red-soft text-red" style="</c:if>
                       																width: 60%;height: 20px;align-content: center;">
									<c:if test="${ednCndtn.ecYn eq 'N'}">이수 전</c:if>
									<c:if test="${ednCndtn.ecYn eq 'Y'}">이수 완료</c:if>
									<c:if test="${ednCndtn.ecYn eq 'F'}">이수 불가</c:if>
								</div>
							</td>
							<td>${ednCndtn.ecBlank}</td>
							<td>
								<button class="btn btn-datatable btn-icon btn-transparent-dark me-2"
									id="editBtn" type="button" data-bs-toggle="modal"
									data-bs-target="#editGroupModal" data-ecno="${ednCndtn.ecNo}"
									data-ecymdf="${ednCndtn.ecYmdF}" data-ecyn="${ednCndtn.ecYn}"
									data-ecblank="${ednCndtn.ecBlank}">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
								        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
								        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
								    </svg>
		      					</button> <a class="btn btn-datatable btn-icon btn-transparent-dark" id="delBtn" href="#!" data-ecno="${ednCndtn.ecNo}">
		      						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
						        	    <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
						        	    <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
						        	</svg></a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</div>
	</div>
</div>
<!-- 등록 모달 -->
<div class="modal fade" id="createGroupModal" tabindex="-1"
	role="dialog" aria-labelledby="createGroupModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content" style="width: 1000px;">
			<div class="modal-header">
				<h5 class="modal-title" id="createGroupModalLabel">개별 교육 일정 등록</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form>
					<div class="mb-0">
						<label class="mb-1 small text-muted" for="newEcYmd">교육일</label> <input
							class="form-control" id="newEcYmd" type="date" />
					</div>
					<br />
					<div class="mb-0">
						<div class="row">
							<div class="col-sm-5">
								<label class="mb-1 small text-muted" for="epNm1">프로그램명</label>
								<c:forEach var="ednPrgrmNm" items="${ednPrgrmNmList}"
									varStatus="stat">
									<input class="radioBtn" type="radio" name="epNm1"
										id="${ednPrgrmNm.epNm1}" value="${ednPrgrmNm.epNm1}">
									<label class="form-check-label" for="${ednPrgrmNm.epNm1}">${ednPrgrmNm.epNm1}</label>
								</c:forEach>
							</div>
							<div class="col-sm-4" id="epNm2Div">
								<!-- 동적생성 -->
							</div>
							<div class="col-sm-3" id="trnFrcDiv">
								<!-- 동적생성 -->
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary-soft text-primary" id="addBtn"
					type="button">등록</button>
				<button class="btn btn-danger-soft text-danger" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 수정 모달 -->
<div class="modal fade" id="editGroupModal" tabindex="-1" role="dialog"
	aria-labelledby="editGroupModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="editGroupModalLabel">개별 교육 일정 수정</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form>
					<div class="mb-0">
						<label class="mb-1 small text-muted" for="ecYmd">교육일</label> <input
							class="form-control" id="ecYmd" type="date" />
					</div>
					<div class="mb-0">
						<label class="mb-1 small text-muted" for="ecYn">이수여부</label> <select
							class="form-control" id="ecYn" name="ecYn">
							<option value="-1" selected>선택</option>
							<option value="N">이수 전</option>
							<option value="Y">이수 완료</option>
							<option value="F">이수 불가</option>
						</select>
					</div>
					<div class="mb-0">
						<label class="mb-1 small text-muted" for="ecBlank">비고</label>
						<input class="form-control" id="ecBlank" type="text" placeholder="ex. 불참사유" maxlength="100" />
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary-soft text-primary" id="udtBtn"
					type="button">수정</button>
				<button class="btn btn-danger-soft text-danger" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	const trnPrgrsTable = document.getElementById('trnPrgrsTable');
	if (trnPrgrsTable) {
		new simpleDatatables.DataTable(trnPrgrsTable, {
			perPage : 10,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "가맹점 교육 현황 정보가 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
});

//수정아이콘 클릭시 교육현황번호 저장용
let clkEcNo;

//배너 클릭
function fCard(nm){	
	let epNm1 = $(nm).data("epnm");
	
	$("#ednTitle").text(epNm1);
	
	if(epNm1 == '기타 교육'){
		epNm1 = 'etc';
	}
	
	let epNmObject = {
		"epNm1":epNm1
	}
    console.log("epNmObject : ", epNmObject);
	
	$.ajax({
		url:"/trnPrgrs/getList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(epNmObject),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			
			//리스트 바꿔주기
			$("#tableStart").empty();
			
			let str = `<table id="newTable">`;
			str += `<thead>`;
			str += `<tr>`;
			str += `<th>교육일</th>`;
			str += `<th>구분</th>`;
			str += `<th>프로그램명</th>`;
			str += `<th>가맹점</th>`;
			str += `<th>이수여부</th>`;
			str += `<th>비고</th>`;
			str += `<th>수정 | 삭제</th>`;
			str += `</tr>`;
			str += `</thead>`;
			str += `<tbody>`;
		    
		    let ecYnBadgeClass = '';
		    let ecYnText = '';
		    let ecBlank = '';
		    let epEsntlYnColor = '';
		    let epEsntlYnText = '';
			
			$.each(resp, function(i, v){
				
			    if (v.ecYn === 'N') {
			        ecYnBadgeClass = `class="badge text-black" style="background-color: #dddddd;`;
			        ecYnText = '이수 전';
			    } else if (v.ecYn === 'Y') {
			        ecYnBadgeClass = `class="badge bg-blue-soft text-blue" style="`;
					ecYnText = '이수 완료';
			    } else if (v.ecYn === 'F') {
			        ecYnBadgeClass = `class="badge bg-red-soft text-red" style="`;
			        ecYnText = '이수 불가';
			    }
			    
			    if (v.ecBlank) {
			    	ecBlank = v.ecBlank;
			    } else {
			    	ecBlank = '';
			    }
			    
			    if (v.ednPrgrmVO.epEsntlYn === 'N') {
			    	epEsntlYnColor = 'red';
			    	epEsntlYnText = '선택';
			    } else {
			    	epEsntlYnColor = 'blue';
			        epEsntlYnText = '필수';
			    }
			    
			    
				str += `<tr>`;
		        str += `    <td id="ecYmdStr">`+new Date(v.ecYmd).toISOString().split('T')[0]+`</td>`;
		        str += `<td><span style="color:`;
		        str += epEsntlYnColor;
		        str += `;">`;
		        str += epEsntlYnText;
			    str += `</span></td>`;
		        str += `    <td>`+v.ednPrgrmVO.epNm+`</td>`;
		        str += `    <td>`+v.franchiseVO.frcsNm+`</td>`;
		        str += `    <td>`
		        str += `    	<div `
		        str += ecYnBadgeClass
		        str += ` width: 60%;height: 20px;align-content: center;">`
		        str += ecYnText
		        str += `</div>`;
		        str += `    </td>`;
		        str += `    <td>`+ecBlank+`</td>`;
		        str += `    <td>`;
		        str += `        <button class="btn btn-datatable btn-icon btn-transparent-dark me-2" id="editBtn" type="button" data-bs-toggle="modal" data-bs-target="#editGroupModal" data-ecno="` + v.ecNo + `" data-ecymdf="` + v.ecYmdF + `" data-ecyn="` + v.ecYn + `" data-ecblank="` + v.ecBlank + `"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
			        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
			        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
			      </svg></button>`;
		        str += `        <a class="btn btn-datatable btn-icon btn-transparent-dark" id="delBtn" href="#!" data-ecno="` + v.ecNo + `"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
		        	  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
		        	  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
		        	</svg></a>`;
		        str += `    </td>`;
		        str += `</tr>`;				
			});
			
	        str += `</tbody>`;
	        str += `</table>`;
            
			$('#tableStart').html(str);
			
			if($('#newTable').length){
				const insert = document.getElementById('newTable');
	    	    if (insert) {
	    	        new simpleDatatables.DataTable(insert,{
	    				perPage : 5,
	    				labels : {
	    					placeholder : "Search...",
	    					searchTitle : "Search within table",
	    					pageTitle : "Page {page}",
	    					perPage : "",
	    					noRows : "가맹점 교육 현황 정보가 없습니다.",
	    					info : "",
	    					noResults : "검색결과가 없습니다.",
	    				}		
	    	        });
	    	    }
			}
		}//end success
	});//end ajax
	
	$.ajax({
		url:"/trnPrgrs/getEcCntAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(epNmObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			$("#cntNSpan").text(resp.cntN);
			$("#cntYSpan").text(resp.cntY);
			$("#cntFSpan").text(resp.cntF);
		}//end success
	});//end ajax
}

//삭제버튼
$(document).on("click", "#delBtn", function(){
	let ecNo = $(this).data("ecno");
    console.log("클릭된 ecNo: ", ecNo);
    
	Swal.fire({
		title: "정말 삭제하시겠습니까?",
		text: "삭제하면 복구할 수 없습니다",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "네",
		cancelButtonText: "아니오"
	}).then((result) => {
		if (result.isConfirmed) {
			let ecNoObject = {
				"ecNo":ecNo
			}
			  
			$.ajax({
				url:"/trnPrgrs/delete",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(ecNoObject),
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(resp){
					console.log(resp);
					if(resp=="success"){
					    Swal.fire({
							title: "프로그램이 삭제되었습니다.",
							icon: "success"
					    }).then((result) => {
							if (result.isConfirmed) {
								location.href="/trnPrgrs/list";
							}
						});
					}else{
						Swal.fire({
							title: "삭제에 실패하였습니다.",
							icon: "error"
		                });
					}
				}
			});
		}
	});
});

//수정아이콘
$(document).on("click", "#editBtn", function(){
	clkEcNo = $(this).data("ecno");
    let ecYmdF = $(this).data("ecymdf");
    let ecYn = $(this).data("ecyn");
    let ecBlank = $(this).data("ecblank");
    
    $("#ecYmd").val(ecYmdF);
    $("#ecYn").val(ecYn).prop("selected", true);
    $("#ecBlank").val(ecBlank);
});

//수정버튼
$("#udtBtn").on("click",function(){
    let udtEcYmd = $("#ecYmd").val();
    let udtEcYn = $("select[name='ecYn'] option:selected").val();
    let udtEcBlank = $("#ecBlank").val();
    
 	//유효성체크
	if(!udtEcYmd){
		Swal.fire({
			title: "교육일은 반드시 선택해야 합니다.",
			icon: "warning",
			didClose: () => {
				$("#ecYmd").focus();
			}
		});
		return;
	}
	
	if (udtEcYn === '-1') {
	    Swal.fire({
	        title: "이수 여부는 반드시 선택해야 합니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#ecYn").focus();
	        }
	    });
	    return;
	}

	if (udtEcBlank.length > 100) {
	    Swal.fire({
	        title: "비고란의 글자수는 100자를 초과할 수 없습니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#ecBlank").focus();
	        }
	    });
	    return;
	}
    
	let udtEcObject = {
		"ecNo":clkEcNo,
		"ecYmd":udtEcYmd,
		"ecYn":udtEcYn,
		"ecBlank":udtEcBlank
	}
    console.log("udtEcObject : ", udtEcObject);
	
	$.ajax({
		url:"/trnPrgrs/update",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(udtEcObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			if(resp=="success"){
				Swal.fire({
					title: "개별 교육 일정 정보가 수정되었습니다.",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						$("#editGroupModal").modal('hide');
						location.href="/trnPrgrs/list";
					}
				});
			}else{
				Swal.fire({
					title: "작업에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});

//등록모달 프로그램명 선택 시
$("input[type=radio][name=epNm1]").on("change",function(){
	let newEpNm1 = $(this).eq(0).val();
	
	if(newEpNm1 == '기타 교육'){
		newEpNm1 = 'etc';
	}
	
	let epNm1Object = {
		"epNm1":newEpNm1,
	}
    console.log("epNm1Object : ", epNm1Object);
	
	$.ajax({
		url:"/trnPrgrs/getEpNm2List",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(epNm1Object),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);

			let str2 = `<label class="mb-1 small text-muted" for="epNm2">차수</label>`;
			
			$.each(resp, function(i, v){
				str2 += `<input class="radioBtn" type="radio" name="epNm2" id="` + v.epNo + `" value="` + v.epNo + `">`;
				str2 += `<label class="form-check-label" for="` + v.epNo + `">`;
				console.log("test",v.epNm3);
				if(v.epNm3 == '기타 교육'){
					str2 += v.epNm1 + ` `; 
				}
				str2 += v.epNm2 + `</label>`;
			});
			
			$("#epNm2Div").html(str2);
		}
	});
});

//등록모달 차수 선택 시
//해당 교육 받지 않은 가맹점 리스트 가져옴
$(document).on("change", "input[type=radio][name=epNm2]", function(){
	let newEpNo = $(this).eq(0).val();
	
	let epNoObject = {
		"epNo":newEpNo,
	}
    console.log("epNoObject : ", epNoObject);

	$.ajax({
		url:"/trnPrgrs/getTrnFrcList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(epNoObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			
			let str3 = `<label class="mb-1 small text-muted" for="frcsNo">가맹점</label>`;
			
			$.each(resp, function(i, v){
				str3 += `<input class="radioBtn" type="checkbox" name="frcsNo" id="` + v.frcsNo + `" value="` + v.frcsNo + `">`;
				str3 += `<label class="form-check-label" for="` + v.frcsNo + `">` + v.frcsNm + `</label>`;
			});
			
			$("#trnFrcDiv").html(str3);
		}
	});
});

//등록모달 닫을 때 값 초기화
$('#createGroupModal').on('hidden.bs.modal', function () {
    $("#newEcYmd").val('');
    $("#epNm2Div").empty();
    $("#trnFrcDiv").empty();
    $(this).find('input').prop("checked", false);
});

//등록버튼
$("#addBtn").on("click",function(){
	let selEpNo = $("input:radio[name=epNm2]:checked").val();
	let selFrcsNoArr = $("input:checkbox[name=frcsNo]:checked");
	let selEcYmd = $("#newEcYmd").val();
	
	//유효성체크
	if (!selEcYmd) {
	    Swal.fire({
	        title: "교육일은 반드시 선택해야 합니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#newEcYmd").focus();
	        }
	    });
	    return;
	}
	
	let selEpNm1 = $("input:radio[name=epNm1]:checked").val();
	if (selEpNm1 === undefined) {
	    Swal.fire({
	        title: "프로그램명은 반드시 선택해야 합니다.",
	        icon: "warning"
	    });
	    return;
	}
	
	if (selEpNo === undefined) {
	    Swal.fire({
	        title: "차수는 반드시 선택해야 합니다.",
	        icon: "warning"
	    });
	    return;
	}
	
	if (selFrcsNoArr.length == 0) {
	    Swal.fire({
	        title: "가맹점은 반드시 1개 이상 선택해야 합니다.",
	        icon: "warning"
	    });
	    return;
	}
	
	let selFrcsNo;
	let successCnt = 0;
	$.each(selFrcsNoArr, function(i, v){
		selFrcsNo = selFrcsNoArr.eq(i).val();
		
		let addCtnObject = {
			"epNo":selEpNo,
			"frcsNo":selFrcsNo,
			"ecYmd":selEcYmd
		};
		console.log("addCtnObject : ",addCtnObject);
		
		$.ajax({
			url:"/trnPrgrs/add",
			async:false,
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(addCtnObject),
			type:"post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(resp){
				console.log(resp);
				if(resp=="success"){
					successCnt += 1;
				}else{
					successCnt += 0;
				}
				
				console.log(selFrcsNo);
				
				
				let alrGlocd ="";
				let alrTg = "";
				$.ajax({
					url:"/alarm/getMax",
					contentType: "application/json; charset=utf-8",
					type:"post",
					dataType:"text",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success:function(result){
						console.log(result);
						alrGlocd = result;
						
						$.ajax({
							url:"/alarm/getId",
							contentType: "application/json; charset=utf-8",
							data:JSON.stringify(selFrcsNo),
							type:"post",
							dataType:"text",
							beforeSend:function(xhr){
								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
							},
							success:function(result){
								console.log("최대값:"+result);
								alrTg = result;
								console.log("적용확인:"+alrTg);
								
								let alarmVO = {
										"alrGlocd":alrGlocd,
								 		"alrTg":alrTg,
								 		"alrSrc":"edu",
								 		"alrInfo":"/trnPrgrs/trnList",
								 	}
								
								setTimeout(function() {
							 		alarm(alarmVO);
								 }, 1000);
							}
						});
						
					}
				});
			}
		});
	});//end foreach
	
	console.log("successCnt : ",successCnt);
	console.log("selFrcsNoArr length : ",selFrcsNoArr.length);
	
	if(selFrcsNoArr.length == successCnt){
		Swal.fire({
			title: "개별 교육 일정이 성공적으로 등록되었습니다.",
			icon: "success"
		}).then((result) => {
			if (result.isConfirmed) {
				$("#createGroupModal").modal('hide');
				location.href="/trnPrgrs/list";
			}
		});
	}else{
		Swal.fire({
			title: "작업에 실패하였습니다.",
			icon: "error"
		});
	}
});
</script>