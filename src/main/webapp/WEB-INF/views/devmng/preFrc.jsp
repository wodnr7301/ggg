<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
#preFrcTable td:nth-child(3), td:nth-child(4), td:nth-child(5){
	text-align: center;
	width: 15%;
}
#preFrcTable td:nth-child(1){
	width: 15%;
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
                        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-arms-up" viewBox="0 0 16 16">
							  <path d="M8 3a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/>
							  <path d="m5.93 6.704-.846 8.451a.768.768 0 0 0 1.523.203l.81-4.865a.59.59 0 0 1 1.165 0l.81 4.865a.768.768 0 0 0 1.523-.203l-.845-8.451A1.5 1.5 0 0 1 10.5 5.5L13 2.284a.796.796 0 0 0-1.239-.998L9.634 3.84a.7.7 0 0 1-.33.235c-.23.074-.665.176-1.304.176-.64 0-1.074-.102-1.305-.176a.7.7 0 0 1-.329-.235L4.239 1.286a.796.796 0 0 0-1.24.998l2.5 3.216c.317.316.475.758.43 1.204Z"/>
							</svg>
                        </div>
                        	예비 창업자 관리
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<!-- 개발 관리 페이지 탭 -->
<nav class="nav nav-borders">
    <a class="nav-link ms-0 active" href="/preFrc/list">예비 창업자 관리&nbsp;
    <span class="badge bg-primary">신청 ${listCnt}</span></a>
    <a class="nav-link" href="/frcCnslt/list">가맹 상담 관리&nbsp;
    <span class="badge" style="background-color: #12a512;">완료 ${cntY}</span>
    <span class="badge" style="background-color: #ffa700;">대기 ${cntN}</span></a>
</nav>
<hr class="mt-0 mb-4" />
<pre>현재 신청이 들어온 창업 상담 대기자 목록입니다.
상담일시 지정 시 가맹 상담 관리 목록에서 대기중으로 표시됩니다.</pre>
    <div class="card">
        <div class="card-body">
            <table id="preFrcTable">
                <thead>
                    <tr>
                        <th>신청자명</th>
                        <th>프랜차이즈 유형</th>
                        <th>연락처</th>
                        <th>신청일</th>
                        <th>상담일시 지정</th>
                    </tr>
                </thead>
                <tbody>
           <c:forEach var="preFrc" items="${preFrcList}" varStatus="stat">
           			<input type="hidden" id="rfNoHdn" value="${preFrc.rfNo}" />
                    <tr>
                        <td>${preFrc.rfNm}</td>
                        <td>${preFrc.frcsTypeVO.ftNm}</td>
                        <td>${preFrc.rfTelno}</td>
                        <td><fmt:formatDate value="${preFrc.rfYmd}" pattern="yyyy-MM-dd" /></td>
                        <td>
                            <button class="btn btn-outline-primary btn-sm ymdSelBtn" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" data-rfno="${preFrc.rfNo}" data-rfnm="${preFrc.rfNm}" data-ftnm="${preFrc.frcsTypeVO.ftNm}">일시 선택</button>
                        </td>
                    </tr>
           </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">상담일시 지정</h5>
                <button class="btn-close closeBtn" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            	<p>상담 신청자 : <span id="rfNm" style="font-weight: bolder;">육성재</span></p>
            	<p>프랜차이즈 유형 : <span id="ftNm" style="font-weight: bolder;">역전우동</span></p>
            	<label for="cnsltDate">상담날짜</label>
            	<input type="date" id="cnsltDate" class="form-control" />
            	<label for="cnsltTime">상담시간</label>
            	<input type="time" id="cnsltTime" class="form-control" step="1800" />
            </div>
            <div class="modal-footer">
            	<button class="btn btn-primary-soft text-primary" id="submitBtn" type="button">등록</button>
            	<button class="btn btn-danger-soft text-danger closeBtn" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div> 
    </div>
</div>
<script type="text/javascript">
$(function(){
	const preFrcTable = document.getElementById('preFrcTable');
	if (preFrcTable) {
		new simpleDatatables.DataTable(preFrcTable, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "아직 창업 신청이 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
});

let rfNo;
let rfNm;
let ftNm;

//면접일지정 버튼 클릭 시 지원번호 세팅, 지원자명, 프랜차이즈유형 모달에 세팅
$(document).on("click", ".ymdSelBtn", function(){
	rfNo = $(this).data("rfno");
	rfNm = $(this).data("rfnm");
	ftNm = $(this).data("ftnm");
	$("#rfNm").text(rfNm);
	$("#ftNm").text(ftNm);
});

//모달 닫을 때 값 초기화
$('#exampleModal').on('hidden.bs.modal', function () {
    $(this).find('input').val('');
});

//등록버튼
$("#submitBtn").on("click",function(){
	let cnsltDate = $("#cnsltDate").val();
	let cnsltTime = $("#cnsltTime").val();
	
	//유효성체크
	if(!cnsltDate){
		Swal.fire({
			title: "날짜는 반드시 선택해야 합니다.",
			icon: "warning",
			didClose: () => {
				$("#cnsltDate").focus();
			}
		});
		return;
	}
	
	if(!cnsltTime){
		Swal.fire({
			title: "시간은 반드시 선택해야 합니다.",
			icon: "warning",
			didClose: () => {
				$("#cnsltTime").focus();
			}
		});
		return;
	}
	
	let dateTime = cnsltDate + " " + cnsltTime;
	console.log("dateTime : "+dateTime);
	
	let ibiYmd = new Date(dateTime);
	let curYmd = new Date();
	console.log("ibiYmd : "+ibiYmd);
	if(ibiYmd<curYmd){
		Swal.fire({
			title: "현재 이후의 날짜와 시간을 선택해야 합니다.",
			icon: "warning"
		});
		return;
	}
	
	let dateObject = {
		"rfNo":rfNo,
		"ibiYmd":ibiYmd
	};
	console.log("dateObject : ",dateObject);
	
	$.ajax({
		url:"/preFrc/insert",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(dateObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			if(resp=="success"){
				Swal.fire({
					title: "정상적으로 면접일이 지정되었습니다.",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						$("#exampleModal").modal('hide');
						location.href="/preFrc/list";
					}
				});
			}else{
				Swal.fire({
					title: "저장 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});
</script>