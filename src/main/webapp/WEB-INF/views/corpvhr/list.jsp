<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    const datatablesSimple = document.getElementById('datatablesSimple1');
    console.log("테이블 datatablesSimple", datatablesSimple);
    
    var selectedCvMdlNm = ""; // 차 이름 저장용 전역변수
    
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
	        	
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
    }//datatablesSimple1 테이블 생성 끝
    
    const reserveModal = document.getElementById('reserveModal');
    if (reserveModal) {
        new simpleDatatables.DataTable(reserveModal, {
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
    } //reserveModal 테이블 생성 끝
    
    $('.resv').on('click',function(){
    	let cvNo = this.dataset.cvNo;
    	console.log(cvNo);
    	
    	let cvMdlNm = this.dataset.cvMdlNm;
    	console.log(cvMdlNm);
    	
    	//전역 변수에 값 저장
    	selectedCvMdlNm = cvMdlNm;
    	console.log("selectedCvMdlNm:", selectedCvMdlNm);
    	
    	$('#cvNo').val(cvNo);
    	
    });//resv 버튼이벤트 끝
    
    $(".reserve").on('click', function() {
    	var cvNo = $('input[name=cvNo]').val();
    	var cvmlRentYmd = $('input[name=cvmlRentYmd]').val();
    	var cvmlRtnYmd = $('input[name=cvmlRtnYmd]').val();
    	var cvmlUsePrps = $('input[name=cvmlUsePrps]').val();
    	console.log("selectedCvMdlNm 쓸 수 있는지 확인:", selectedCvMdlNm);
    	
    	let data = {
    		"cvNo" : cvNo,
    		"cvMdlNm" : selectedCvMdlNm,
    		"cvmlRentYmd" : cvmlRentYmd,
    		"cvmlUsePrps" : cvmlUsePrps,
    		"cvmlRtnYmd" : cvmlRtnYmd
    	};
    	
    	console.log("data : ", data);
    	
    	$.ajax({
    		url:"/corpvhr/reserveAjax",
    		contentType:"application/json;charset=utf-8",
            data : JSON.stringify(data), 
            type : 'POST',
            beforeSend:function(xhr){
		          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	       },
	       	success : function(result) {
                console.log(result);
               
                swal("예약이 완료되었습니다.","","success").then(function() {
                	window.location.href="/corpvhr/list";
                });
	       	},
	      	 error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	            
	            swal("예약에 실패하였습니다.","해당 차량은 예약/사용중입니다. 다른 차량을 선택하세요.","error");
		        }
    	}); // ajax 끝
    }); // 예약 끝
    	
    	$(".impos").on("click", function() {
    		swal("예약할 수 없습니다.","해당 차량은 예약/사용중입니다. 다른 차량을 선택하세요.","error");
    	});
    	$(".as").on("click", function() {
    		swal("예약할 수 없습니다.","이미 다른 차량을 예약/사용중인 상태입니다.","error");
    	});
    
}); //펑션끝
</script>
<style>
.main-card {
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
						법인차량 목록
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
	<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone">법인차량 목록</div>
			<div class="card-body main-card">
				<table id="datatablesSimple1">
					<thead>
						<tr>
							<th>법인차량 번호</th>
							<th>차량 모델</th>
							<th>현재 사용 가능 여부</th>
							<th>차량 예약</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="corpvhrVO" items="${carList}" varStatus="stat">
									<tr>
										<td>${corpvhrVO.cvNo}</td>
										<td class="cvMdlNm">${corpvhrVO.cvMdlNm}</td>
										<td>
											<c:if test="${corpvhrVO.cvUseYn eq 'B101'}">O</c:if>
											<c:if test="${corpvhrVO.cvUseYn eq 'B102'}">X</c:if>
										</td>
										<td>
											<c:if test="${cnt eq 0}">
												<c:if test="${corpvhrVO.cvUseYn eq 'B101'}">
													<button class="btn btn-outline-cyan resv" data-bs-toggle="modal" data-bs-target="#exampleModalCenter2" data-cv-no="${corpvhrVO.cvNo}" data-cv-mdl-nm="${corpvhrVO.cvMdlNm}">예약</button>
												</c:if>
											</c:if>
											<c:if test="${cnt eq 1}">
												<c:if test="${corpvhrVO.cvUseYn eq 'B101'}">
													<button class="btn btn-outline-cyan as" >예약</button>
												</c:if>
											</c:if>
											<c:if test="${corpvhrVO.cvUseYn eq 'B102'}">
												<button class="btn btn-outline-cyan impos">예약</button>
											</c:if>
										</td>
									</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
	</div>
</div>
<div class="modal fade" id="exampleModalCenter2" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">예약</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form action="/corpvhr/reserve" method="post" id="corpVhrReserve">
				<div class="mb-3">
				
					<div class="modal-body-reserve">
						<table id="reserveModal">
							<thead>
								<tr>
									<th>항목</th><th>상세정보</th>
								</tr>
							</thead>
							<tbody>
									<tr>
										<td>차량번호</td><td><input class="form-control" type="text" id="cvNo" name="cvNo" readonly/></td>						
									</tr>
									<tr>
										<td>사원번호</td><td><input class="form-control" type="text" id="empNo" name="empNo" value="${empNo}" readonly /></td>						
									</tr>
									<tr>
										<td>차량대여일자</td><td><input class="form-control" type="date" id="cvmlRentYmd" name="cvmlRentYmd" /></td>						
									</tr>
									<tr>
										<td>차량반납일자</td><td><input class="form-control" type="date" id="cvmlRtnYmd" name="cvmlRtnYmd" /></td>						
									</tr>
									<tr>
										<td>대여목적</td><td><input class="form-control" type="text" id="cvmlUsePrps" name="cvmlUsePrps" placeholder="대여목적"  /></td>
									</tr>
							</tbody>
						</table>
					</div>
				</div>
			</form>
			<div class="modal-footer">
				<button class="btn btn-secondary reserve" data-bs-dismiss="modal"
					type="button">예약</button>
				<button class="btn btn-primary" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>