<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<style>
#srvyTable td:nth-child(1), td:nth-child(4), td:nth-child(5), #srvyFinTable td:nth-child(1), td:nth-child(4), td:nth-child(5){
 	text-align: center;
 	width: 12%;
}

#srvyTable td:nth-child(3), #srvyFinTable td:nth-child(3){
	text-align: center;
	width: 20%;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ui-checks" viewBox="0 0 16 16">
								<path d="M7 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zM2 1a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm0 8a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2zm.854-3.646a.5.5 0 0 1-.708 0l-1-1a.5.5 0 1 1 .708-.708l.646.647 1.646-1.647a.5.5 0 1 1 .708.708zm0 8a.5.5 0 0 1-.708 0l-1-1a.5.5 0 0 1 .708-.708l.646.647 1.646-1.647a.5.5 0 0 1 .708.708zM7 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zm0-5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 8a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5"/>
							</svg>
                        </div>
                        	설문조사
                    </h1>
                </div>
                <div class="col-12 col-xl-auto mb-3">
                    <button class="btn btn-sm btn-light text-primary" type="button" onclick="location.href='/survey/createSrv'">
                        <i class="me-1" data-feather="plus"></i>
                        	새 설문지 만들기
                    </button>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<pre>내가 올린 설문조사를 관리할 수 있습니다.</pre>
    <div class="card">
	    <div class="card-header">
			진행중인 설문
		</div>
        <div class="card-body">
            <table id="srvyTable">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>설문 제목</th>
                        <th>설문 기간</th>
                        <th>설문 대상</th>
                        <th>기간변경 | 삭제</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="srvy" items="${srvyList}" varStatus="stat">
                    <tr>
                        <td>${srvy.srvyNo}</td>
                        <td>${srvy.srvyTtl}</td>
                        <td id="srvyDateList"><fmt:formatDate value="${srvy.srvyYmd}" pattern="yyyy-MM-dd" />&nbsp;~&nbsp;<fmt:formatDate value="${srvy.srvyEndDate}" pattern="yyyy-MM-dd" /></td>
                        <td>
                        	<c:if test="${srvy.srvyTrgt eq '1'}">본사직원</c:if>
                        	<c:if test="${srvy.srvyTrgt eq '2'}">가맹점주</c:if>
                        </td>
                        <td>
                            <button class="btn btn-datatable btn-icon btn-transparent-dark me-2" id="editBtn" type="button" data-bs-toggle="modal" data-bs-target="#editGroupModal" data-srvyno="${srvy.srvyNo}" data-title="${srvy.srvyTtl}" data-strdate="<fmt:formatDate value="${srvy.srvyYmd}" pattern="yyyy-MM-dd" />" data-enddate="<fmt:formatDate value="${srvy.srvyEndDate}" pattern="yyyy-MM-dd" />"><i data-feather="edit"></i></button>
                            <a class="btn btn-datatable btn-icon btn-transparent-dark" id="delBtn" href="#!" data-srvyno="${srvy.srvyNo}"><i data-feather="trash-2"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<br/>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<pre>완료된 설문조사의 결과를 확인할 수 있습니다.</pre>
    <div class="card">
	    <div class="card-header">
			완료된 설문
		</div>
        <div class="card-body">
            <table id="srvyFinTable">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>설문 제목</th>
                        <th>설문 기간</th>
                        <th>설문 대상</th>
                        <th>결과</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="srvyF" items="${srvyFinList}" varStatus="stat">
                    <tr>
                        <td>${srvyF.srvyNo}</td>
                        <td>${srvyF.srvyTtl}</td>
                        <td id="srvyFinDateList"><fmt:formatDate value="${srvyF.srvyYmd}" pattern="yyyy-MM-dd" />&nbsp;~&nbsp;<fmt:formatDate value="${srvyF.srvyEndDate}" pattern="yyyy-MM-dd" /></td>
                        <td>
                        	<c:if test="${srvyF.srvyTrgt eq '1'}">본사직원</c:if>
                        	<c:if test="${srvyF.srvyTrgt eq '2'}">가맹점주</c:if>
                        </td>
                        <td>
                            <button class="btn btn-outline-primary btn-sm" type="button" onclick="location.href='/survey/surveyResult?srvyNo=${srvyF.srvyNo}'">조회</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- 수정 모달 -->
<div class="modal fade" id="editGroupModal" tabindex="-1" role="dialog" aria-labelledby="editGroupModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content" style="width: 700px;">
			<div class="modal-header">
				<h5 class="modal-title" id="editGroupModalLabel">설문 기간 변경</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>설문 제목 : <span id="srvyTtl" style="font-weight: bolder;"></span></p>
				<p>현재 설문 기간 : <span id="srvyDate" style="font-weight: bolder;"></span></p>
				<br/>
				<div class="mb-0">
					<div class="row">
						<label class="mb-1 small text-muted" for="srvyYmd">변경할 설문 기간</label>
						<div class="col-sm-5">
							<input class="form-control" id="srvyYmd" type="date" />
						</div>
						<div class="col-sm-1" style="padding: 10px; text-align: center;">
							<p>~</p>
						</div>
						<div class="col-sm-5">
							<input class="form-control" id="srvyEndDate" type="date" />
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary-soft text-primary" id="udtBtn"type="button">저장</button>
				<button class="btn btn-danger-soft text-danger" type="button"data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	const srvyTable = document.getElementById('srvyTable');
	if (srvyTable) {
		new simpleDatatables.DataTable(srvyTable, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "등록한 설문조사가 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
	
	const srvyFinTable = document.getElementById('srvyFinTable');
	if (srvyFinTable) {
		new simpleDatatables.DataTable(srvyFinTable, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "완료된 설문조사가 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
	
	//진행상태세팅..
// 	let srvyDateList = $("#srvyDateList").html();
// 	console.log("srvyDateList",srvyDateList);
// 	let sYmd = ${srvy.srvyYmd};//
// 	let eYmd = ${srvy.srvyEndDate};
// 	let curYmd = new Date();
// 	let text;
// 	console.log(sYmd,"1",eYmd,"1",curYmd);
	
// 	if(curYmd>=sYmd && curYmd<=eYmd){
// 		console.log("2");
// 		text = "진행중";
// 	}else if(curYmd>eYmd){
// 		console.log("3");
// 		text = "종료";
// 	}else if(curYmd<sYmd){
// 		console.log("4");
// 		text = "진행 전";
// 	}
	
// 	console.log("5",text);
// 	$("#srvyStatus").text(text);
	
});

//수정아이콘 클릭시 설문번호 저장용
let srvyNo;
let srvyTtl;
let srvyYmd;
let srvyEndDate;

//수정아이콘
$(document).on("click", "#editBtn", function(){
	srvyNo = $(this).data("srvyno");
	srvyTtl = $(this).data("title");
	srvyYmd = $(this).data("strdate");
	srvyEndDate = $(this).data("enddate");
	let srvyDate =  srvyYmd + " ~ " + srvyEndDate;
	
	$("#srvyTtl").text(srvyTtl);
	$("#srvyDate").text(srvyDate);
	$("#srvyYmd").val(srvyYmd);
	$("#srvyEndDate").val(srvyEndDate);
});

//수정버튼
$("#udtBtn").on("click",function(){
	let newSrvyYmd = $("#srvyYmd").val();
	let newSrvyEndDate = $("#srvyEndDate").val();
    
	//유효성체크
    if(!newSrvyYmd || !newSrvyEndDate){
        Swal.fire({
            title: "기간은 반드시 입력해야 합니다.",
            icon: "warning",
            didClose: () => {
                $("#srvyYmd").focus();
            }
        });
        return;
    }

	let srvyDateObject = {
		"srvyNo":srvyNo,
		"srvyYmdStr":newSrvyYmd,
		"srvyEndDateStr":newSrvyEndDate
	}
    console.log("srvyDateObject : ", srvyDateObject);
	
	$.ajax({
		url:"/survey/update",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(srvyDateObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			if(resp=="success"){
				Swal.fire({
					title: "설문기간이 변경되었습니다.",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						$("#editGroupModal").modal('hide');
						location.href="/survey/list";
					}
				});
			}else{
				Swal.fire({
					title: "기간 변경에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});

//삭제버튼
$(document).on("click", "#delBtn", function(){
	let srvyNo = $(this).data("srvyno");
    console.log("클릭된 srvyNo: ", srvyNo);
    
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
			let srvyNoObject = {
				"srvyNo":srvyNo
			}
			
			$.ajax({
				url:"/survey/delete",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(srvyNoObject),
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(resp){
					console.log(resp);
					if(resp=="success"){
					    Swal.fire({
							title: "해당 설문이 삭제되었습니다.",
							icon: "success"
					    }).then((result) => {
							if (result.isConfirmed) {
								location.href="/survey/list";
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
</script>