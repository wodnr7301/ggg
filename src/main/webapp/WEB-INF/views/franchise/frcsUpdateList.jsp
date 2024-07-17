<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    const datatablesSimple = document.getElementById('datatablesSimple1');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
            paging: false,
            searchable: false,
            perPageSelect: false,
            sortable: false,
            labels: {
                placeholder: "Search...",
                searchTitle: "Search within table",
                pageTitle: "Page {page}",
                perPage: "",
                noRows: "No entries found",
                info: " ",
                noResults: "No results match your search query",
            }
        });
    }
});

$(function() {
	$("#btnSave1").on("click", function() {
		
		var frcsNo = $('input[name=frcsNo]').val();
		var frcsNm = $('input[name=frcsNm]').val();
		var frcsZip = $('input[name=frcsZip]').val();
		var frcsAddr = $('input[name=frcsAddr]').val();
		var frcsDaddr = $('input[name=frcsDaddr]').val();
		var frcsTelno = $('input[name=frcsTelno]').val();
	
		let data = {
				"frcsNo" : frcsNo,
				"frcsNm" : frcsNm,
				"frcsZip" : frcsZip,
				"frcsAddr" : frcsAddr,
				"frcsDaddr" : frcsDaddr,
				"frcsTelno" : frcsTelno,
		};
		
		console.log("data : ", data);
		
		$.ajax({
			url : "/frcs/updateFrcsAjax",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data), 
            type : 'POST',
            beforeSend:function(xhr){
		          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		       }, 
          success : function(result) {
              console.log(result);
              swal("수정이 완료되었습니다.","","success");
          	},
          	 error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		            swal("수정이 실패하였습니다.","","error");
          	 }
		});
	});
	
	$("#btnSave2").on("click", function() {
		
		var empNo = $('input[name=empNo]').val();
		var empTelno = $('input[name=empTelno]').val();
		var empZip = $('input[name=empZip]').val();
		var empAddr = $('input[name=empAddr]').val();
		var empDaddr = $('input[name=empDaddr]').val();
		var empJncmpYmd = $('input[name=empJncmpYmd]').val();
		var empActno = $('input[name=empActno]').val();
		
		let data = {
				"empNo" : empNo,
				"empTelno" : empTelno,
				"empZip" : empZip,
				"empAddr" : empAddr,
				"empDaddr" : empDaddr,
				"empJncmpYmd" : empJncmpYmd,
				"empActno" : empActno,
		};
		
		console.log("data : ", data);
		
		$.ajax({
			url : "/frcs/updateFrcsEmpAjax",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data), 
            type : 'POST',
            beforeSend:function(xhr){
		          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		       },
		       success : function(result) {
		              console.log(result);
		              swal("수정이 완료되었습니다.","","success");
		          	},
	          	 error: function(xhr, status, error) {
			            console.error(xhr.responseText);
			            swal("수정이 실패하였습니다.","","error");
	          	 }
		});
	});
	
});

$(function() {
    $("#btnPost").on("click", function() {
        new daum.Postcode({
            oncomplete: function(data) {
                $("#frcsZip").val(data.zonecode);
                $("#frcsAddr").val(data.address);
                $("#frcsDaddr").val(data.buildingName);
            }
        }).open();
    });
});

$(function() {
    $("#btnPost2").on("click", function() {
        new daum.Postcode({
            oncomplete: function(data) {
                $("#empZip").val(data.zonecode);
                $("#empAddr").val(data.address);
                $("#empDaddr").val(data.buildingName);
            }
        }).open();
    });
});

$(function () {
	$(document).on('click', '.list', function() {
		
		location.href = "/frcs/list"
	});
});

</script>
<main>
    <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
        <div class="container-xl px-4">
            <div class="page-header-content pt-4">
                <div class="row align-items-center justify-content-between">
                    <div class="col-auto mt-4">
                        <h1 class="page-header-title">
                            <div class="page-header-icon">
                                <i data-feather="layout"></i>
                            </div>
                            가맹점 정보 수정
                        </h1>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="container-xl px-4 mt-n10">
        <div class="card mb-4">
            <div class="card-header border-bottom">
                <ul class="nav nav-tabs card-header-tabs" id="dashboardNav" role="tablist">
                    <li class="nav-item me-1">
                        <a class="nav-link active" id="overview-pill" href="#overview" data-bs-toggle="tab" role="tab" aria-controls="overview" aria-selected="true">가맹점 정보 수정</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="activities-pill" href="#activities" data-bs-toggle="tab" role="tab" aria-controls="activities" aria-selected="false">가맹점주 정보 수정</a>
                    </li>
                </ul>
            </div>
            <form action="/frcs/updatePost" method="post" id="frcsUpdate">
                <div class="card-body">
                    <div class="tab-content" id="dashboardNavContent">
                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-pill">
                            <div class="mb-3">
                                <input type="hidden" id="frcsNo" name="frcsNo" value="${frcsVO.frcsNo}">
                                <table id="datatablesSimple1">
                                    <thead>
                                        <tr>
                                            <th>항목</th>
                                            <th>정보</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>가맹번호</td>
                                            <td>${frcsVO.frcsNo}</td>
                                        </tr>
                                        <tr>
                                            <td>가맹점명</td>
                                            <td><input class="form-control" type="text" name="frcsNm" id="frcsNm" value="${frcsVO.frcsNm}" /></td>
                                        </tr>
                                        <tr>
                                            <td><button class="btn btn-primary" type="button" id="btnPost">우편번호</button></td>
                                            <td><input class="form-control" type="text" name="frcsZip" id="frcsZip" value="${frcsVO.frcsZip}" readonly /></td>
                                        </tr>
                                        <tr>
                                            <td>주소</td>
                                            <td><input class="form-control" type="text" name="frcsAddr" id="frcsAddr" value="${frcsVO.frcsAddr}" readonly /></td>
                                        </tr>
                                        <tr>
                                            <td>상세주소</td>
                                            <td><input class="form-control" type="text" name="frcsDaddr" id="frcsDaddr" value="${frcsVO.frcsDaddr}" /></td>
                                        </tr>
                                        <tr>
                                            <td>전화번호</td>
                                            <td><input class="form-control" type="text" name="frcsTelno" id="frcsTelno" value="${frcsVO.frcsTelno}" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
	                            <div class="text-end">
					            	<button class="btn btn-primary btn-sm" type="button" id="btnSave1" name="btnSave1">수정</button>
					            	<button class="btn btn-primary btn-sm list" type="button">목록</button>
				            	</div>
                        	</div>
                        <div class="tab-pane fade" id="activities" role="tabpanel" aria-labelledby="activities-pill">
                            <div class="mb-3">
                                <input type="hidden" id="empNo" name="empNo" value="${empVO.empNo}">
                                <table id="datatablesSimple2" class="datatable-table">
                                    <thead>
                                        <tr>
                                            <th>항목</th>
                                            <th>정보</th>
                                        </tr>
                                    </thead>
                                     <tr>
                                           <td>가맹점주 회원번호</td>
                                           <td>${empVO.empNo}</td>
                                    </tr>
                                    <tbody>
                                    	<tr>
                                    		<td>전화번호</td>
                                    		<td><input class="form-control" name="empTelno" id="empTelno" type="text" value="${empVO.empTelno}" /></td>
                                    	</tr>
                                    	<tr>
                                    		<td><button class="btn btn-primary" type="button" id="btnPost2">우편번호</button></td>
                                    		<td><input class="form-control" type="text" name="empZip" id="empZip" value="${empVO.empZip}" readonly /></td>
                                    	</tr>
                                    	<tr>
                                    		<td>주소</td>
                                    		<td><input class="form-control" type="text" name="empAddr" id="empAddr" value="${empVO.empAddr}" readonly /></td>
                                    	</tr>
                                    	<tr>
                                    		<td>상세주소</td>
                                    		<td><input class="form-control" type="text" name="empDaddr" id="empDaddr" value="${empVO.empDaddr}" /></td>
                                    	</tr>
                                    	<tr>
                                    		<td>주거래 은행</td>
                                    		<td><input class="form-control" type="text" name="empJncmpYmd" id="empJncmpYmd" value="${empVO.empJncmpYmd}" /></td>
                                    	</tr>
                                    	<tr>
                                    		<td>계좌번호</td>
                                    		<td><input class="form-control" type="text" name="empActno" id="empActno" value="${empVO.empActno}" /></td>
                                    	</tr>
                                    </tbody>
                                </table>
                            </div>
                             	<div class="text-end">
					            	<button class="btn btn-primary btn-sm" type="button" id="btnSave2" name="btnSave2">수정</button>
					            	<button class="btn btn-primary btn-sm list" type="button">목록</button>
			            		</div>
                        	</div>
                    	</div>
                	</div>
               	 <sec:csrfInput />
            </form>
        </div>
    </div>
</main>
