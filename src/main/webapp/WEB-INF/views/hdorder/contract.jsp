<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.checkBtn{
	display: none;
}
#datatablesSimple1 td:nth-child(3), #datatablesSimple1 td:nth-child(4), #datatablesSimple1 td:nth-child(5), #datatablesSimple1 td:nth-child(6){
	text-align: right;
}
#stockTable td:nth-child(2), #stockTable td:nth-child(3), #stockTable td:nth-child(5), #stockTable td:nth-child(6), #stockTable td:nth-child(7){
	text-align: center;
}
#stockTable td:nth-child(1),#stockTable td:nth-child(4), #mainTable td:nth-child(1), #mainTable td:nth-child(2), #mainTable td:nth-child(3),#mainTable td:nth-child(4), #mainTable td:nth-child(5), #mainTable td:nth-child(6), #mainTable td:nth-child(7){
	text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
	let frcsNo;
	let comcdGroupcd;
	let foPrcsYn;
	
	$(".selBtn").on("click", function() {
		foPrcsYn = $(this).val();
		
		let data = {
				"foPrcsYn":foPrcsYn	
			};
		
		if(frcsNo){
			data.frcsNo = frcsNo;
		}
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/hdorder/getSelFrcorder",
			contentType:"application/json;charset=utf-8",
			data: JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
				let str = "";
				if (result == '' || result == null) {
				    str += "<tr>";
				    str += "<td colspan='6' style='text-align: center'>발주내역이 존재하지 않습니다.</td>";
				    str += "</tr>";
				}
				str += "<table  id='mainTable'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>발주일시</th><th>발주번호</th><th>가맹점</th><th>납기요청일</th><th>진행상태</th><th>전표</th><th>선택</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				$.each(result, function(idx, frcorderVO) {
					
					str += "<tr>";
					var date = new Date(frcorderVO.foOdt); 
					var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					var date2 = new Date(frcorderVO.foDeliveryDt); 
					var formattedDate2 = date2.toLocaleDateString() + ' ' + date2.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					str += "<td>" + formattedDate + "</td>";
					str += "<td>" + frcorderVO.foNo + "</td>";
					str += "<td>" + frcorderVO.frcsNm + "</td>";
					str += "<td>" + formattedDate2 + "</td>";
					if (frcorderVO.foPrcsYn=='N'){
						str += "<td><div class='badge bg-danger text-white rounded-pill'>반려</div></td>"
					}
					if (frcorderVO.foPrcsYn=='A'){
						str += "<td><div class='badge bg-warning text-white rounded-pill'>승인대기</div></td>"
					}
					if (frcorderVO.foPrcsYn=='D'){
						str += "<td><div class='badge bg-success text-white rounded-pill'>배송중</div></td>"
					}
					if (frcorderVO.foPrcsYn=='F'){
						str += "<td><div class='badge bg-primary text-white rounded-pill'>배송완료</div></td>"
					}
					if (frcorderVO.foPrcsYn=='E'){
						str += "<td><div class='badge bg-primary text-white rounded-pill'>배송완료</div></td>"
					}
					
					str += "<td><label for='check"+idx+"'  style='color:blue;'>조회</label>"
					str += "<input class='btn btn-primary checkBtn' id='check"+idx+"' value='"+frcorderVO.foNo +"' data-yn='"+ frcorderVO.foPrcsYn  +"' type='button' data-bs-toggle='modal' data-bs-target='#exampleModalScrollable1'/></td>"
					if(frcorderVO.foPrcsYn == 'A'){
						str += "<td>";
						str += "<button class='btn btn-outline-blue approval' type='button' value='"+frcorderVO.foNo+"' data-yn='D'>승인</button> ";
						str += "<button class='btn btn-outline-red reject' type='button' value='"+frcorderVO.foNo+"' data-yn='N'>반려</button> ";
						str += "</td>";
					}else{
						str+="<td></td>"
					}
					str += "</tr>";
				});
					str += "</tbody>";
					str += "</table>";
				$(".tableDiv").html(str);
				
				const mainTable = document.getElementById('mainTable');
			    if (mainTable) { 
			        new simpleDatatables.DataTable(mainTable,{
			              labels: {
			                  placeholder: "검색",
			                  searchTitle: "검색",
			                  pageTitle: "Page {page}",
			                  perPage: "",
			                  noRows: "내역이 존재하지 않습니다.",
			                  info: "",
			                  noResults: "검색결과가 없습니다.",
			              }      
			           }
			        );
			    }
			}
		});
	});

	
	$(".frnSel").on("change", function() {
	    let selectedAddress = $(this).val();
	 	// 프랜차이즈 번호(frcsNo) 구하기
	    frcsNo = $(this).find(":selected").data("franchise-info");
		console.log("frcsNo : ", frcsNo);
		let data = {
				"frcsNo":frcsNo
			};
		console.log("data : ", data);
		selAjax(data);
	});
	
	// 클릭 이벤트 핸들러 함수 정의
	function handleSelBtnClick() {
	    let foPrcsYn = "";
	    let frcsNo = "";

	    let data = {
	        "frcsNo": frcsNo,
	        "foPrcsYn": foPrcsYn
	    };

	    console.log("data : ", data);

	    selAjax(data);
	}
	
	// .selLoc 변경 이벤트 핸들러
	$(".selLoc").on("change", function() {
	    comcdGroupcd = $(this).val();

	    let data = {
	        "comcdGroupcd": comcdGroupcd
	    };

	    // comcdGroupcd 값이 undefined나 ""이면 frcsNo도 undefined나 ""로 설정
	    if (!comcdGroupcd) {
	        frcsNo = undefined;
	        
	        // .selBtn 요소에 클릭 이벤트 핸들러 연결
	        $(".selBtn").on("click", handleSelBtnClick);

	        // .selBtn 요소를 트리거로 사용하여 클릭 이벤트 실행
	        $(".selBtn").trigger("click");
	    }

	    $.ajax({
	        url: "/hdorder/locFrn",
	        contentType: "application/json;charset=utf-8",
	        data: JSON.stringify(data),
	        type: "post",
	        dataType: "json",
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success: function(result) {
	            console.log("result : ", result);
	            let str = "";
	            str += "<option value='가맹점을 선택해주세요'>전체</option>";
	            $.each(result, function(idx, franchiseVO) {
	                str += "<option value='" + franchiseVO.frcsAddr + " " + franchiseVO.frcsDaddr + "' data-franchise-info='" + franchiseVO.frcsNo + "'>" + franchiseVO.frcsNm + "</option>";
	            });
	            $(".frnSel").html(str);
	        }
	    });

	    console.log("data : ", data);

	    // .selBtn 클릭 이벤트 핸들러 삭제
	    $(".selBtn").off("click", handleSelBtnClick);
	});

	// 조회버튼
    $(document).on("click", ".checkBtn", function() {
		let foNo = $(this).val();
		let foPrcsYn = this.dataset.yn;
		console.log("foPrcsYn : ", foPrcsYn);
		let data = {
				"foNo" : foNo
		};
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/hdorder/getfrcOrderDtl",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
				let str = "";
				let row = "";
				let yn = "";
				let foDeliveryDt = '';
				let totalPrModal = "";
				let reason = '';
				str += "<table  id='datatablesSimple1'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>발주상세번호</th><th>상품명</th><th>수량</th><th>단가</th><th>공급가액</th><th>부가세</th><th>가맹점</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				
	            
				let total = 0;
				let format4 = "";
				$.each(result, function(idx, frcorderDtlVO) {
					
					if(frcorderDtlVO.foPrcsYn == 'N'){
						yn = `
						<div class="step step-lg">
							<div class="step-item">
						        <a class="step-item-link" href="#!">승인대기</a>
						    </div>
						    <div class="step-item active">
						        <a class="step-item-link" href="#!">반려</a>
						    </div>
						    <div class="step-item">
						        <a class="step-item-link" href="#!">입고필요</a>
						    </div>
						    <div class="step-item">
						        <a class="step-item-link disabled" href="#!" tabindex="-1" aria-disabled="true">입고완료</a>
						    </div>
						</div>
						`;
						reason = `<span style="color: black;">반려사유 : <span style="color: red;">\${frcorderDtlVO.foRequest}</span></span>`;
					}
					if(frcorderDtlVO.foPrcsYn == 'A'){
						yn = `
						<div class="step step-lg">
							<div class="step-item active">
						        <a class="step-item-link" href="#!">승인대기</a>
						    </div>
						    <div class="step-item">
						        <a class="step-item-link" href="#!">배송중</a>
						    </div>
						    <div class="step-item">
					        	<a class="step-item-link" href="#!">입고필요</a>
					   		</div>
						    <div class="step-item">
						        <a class="step-item-link disabled" href="#!" tabindex="-1" aria-disabled="true">입고완료</a>
						    </div>
						</div>
						`;
					}
					if(frcorderDtlVO.foPrcsYn == 'D'){
						yn = `
							<div class="step step-lg">
								<div class="step-item">
							        <a class="step-item-link" href="#!">승인대기</a>
							    </div>
							    <div class="step-item active">
							        <a class="step-item-link" href="#!">배송중</a>
							    </div>
							    <div class="step-item">
						       		<a class="step-item-link" href="#!">입고필요</a>
						    	</div>
							    <div class="step-item">
							        <a class="step-item-link disabled" href="#!" tabindex="-1" aria-disabled="true">입고완료</a>
							    </div>
							</div>
							`;
					}
					
					if(frcorderDtlVO.foPrcsYn == 'F'){
						yn = `
							<div class="step step-lg">
								<div class="step-item">
							        <a class="step-item-link" href="#!">승인대기</a>
							    </div>
							    <div class="step-item">
							        <a class="step-item-link" href="#!">배송중</a>
							    </div>
							    <div class="step-item">
					       			<a class="step-item-link" href="#!">입고필요</a>
					    		</div>
							    <div class="step-item active">
							        <a class="step-item-link disabled" href="#!" tabindex="-1" aria-disabled="true">입고완료</a>
							    </div>
							</div>
							`;
					}
					
					if(frcorderDtlVO.foPrcsYn == 'E'){
						yn = `
							<div class="step step-lg">
								<div class="step-item">
							        <a class="step-item-link" href="#!">승인대기</a>
							    </div>
							    <div class="step-item">
							        <a class="step-item-link" href="#!">배송중</a>
							    </div>
							    <div class="step-item">
					       			<a class="step-item-link" href="#!">입고필요</a>
					    		</div>
							    <div class="step-item active">
							        <a class="step-item-link disabled" href="#!" tabindex="-1" aria-disabled="true">입고완료</a>
							    </div>
							</div>
							`;
					}
					
					if(frcorderDtlVO.foPrcsYn == 'E' || frcorderDtlVO.foPrcsYn == 'F'){
						let selectedDate = new Date(frcorderDtlVO.foDeliveryDt);
					    let year = selectedDate.getFullYear();
					    let month = ("0" + (selectedDate.getMonth() + 1)).slice(-2);
					    let day = ("0" + selectedDate.getDate()).slice(-2);
				    	foDeliveryDt = '배송완료일 : ' + year + "/" + month + "/" + day;
					}else{
						let selectedDate = new Date(frcorderDtlVO.foDeliveryDt);
					    let year = selectedDate.getFullYear();
					    let month = ("0" + (selectedDate.getMonth() + 1)).slice(-2);
					    let day = ("0" + selectedDate.getDate()).slice(-2);
				    	foDeliveryDt = '납기요청일 : ' + year + "/" + month + "/" + day;
					}
					
					const format1 = (frcorderDtlVO.fodPrc).toLocaleString('ko-KR');
		        	
					const format2 = (frcorderDtlVO.fodAmt).toLocaleString('ko-KR');
		        	
					const format3 = (parseInt(frcorderDtlVO.fodAmt/10)).toLocaleString('ko-KR');
		        	
					total += parseInt(frcorderDtlVO.fodAmt + frcorderDtlVO.fodAmt/10);
					format4 = total.toLocaleString('ko-KR');
		        	
					str += "<tr>";
					str += "<td>" + frcorderDtlVO.fodNo + "</td>";
					str += "<td>" + frcorderDtlVO.fodGdsNm + "</td>";
					str += "<td>" + frcorderDtlVO.fodQnt + "</td>";
					str += "<td>" + format1 + "원</td>";
					str += "<td>" + format2 + "원</td>";
					str += "<td>" + format3 + "원</td>";
					str += "<td>" + frcorderDtlVO.frcsNm + "원</td>";
					str += "</tr>";
				});
					str += "</tbody>";
					str += "</table>";
					totalPrModal += "<p style='text-align:right;'>결제금액 : "+format4+"원</p>";
					$("#modal-body-check").html(str); 
					$("#modal-body-text1").html(yn);
					$("#modal-body-text2").html(foDeliveryDt);
					$("#modal-body-text3").html(reason);
					$("#modal-body-text4").html(totalPrModal);
					$("#modal-body-text5").html("발주번호 : " + foNo);
					
					const datatablesSimple = document.getElementById('datatablesSimple1');
				    if (datatablesSimple) {
				        new simpleDatatables.DataTable(datatablesSimple,{
				        	  perPageSelect:false,
				        	  searchable:false,
				              labels: {
				                  placeholder: "검색",
				                  searchTitle: "검색",
				                  pageTitle: "Page {page}",
				                  perPage: "",
				                  noRows: "거래내역이 없습니다.",
				                  info: "",
				                  noResults: "검색결과가 없습니다.",
				              }      
				           }
				        );
				    }
			}
		});
	});
	
	$(document).on("click",".approval", function(){
		
		let foNo = $(this).val();
		let foPrcsYn = this.dataset.yn;
		console.log("foNo : ", foNo);
		console.log("foPrcsYn : ", foPrcsYn);
		let data = {
			"foNo":foNo,
			"foPrcsYn":foPrcsYn
		};
		Swal.fire({
			   title: '해당 발주('+ foNo + ')를 <br>승인 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				if (result.isConfirmed) {
					Swal.fire('승인이 완료되었습니다.', '', 'success');
					btnAjax(data);
			    }
			});
	});
	
	$(document).on("click", ".reject", function() {
	    let foNo = $(this).val();
	    let foPrcsYn = this.dataset.yn;
	    console.log("foNo : ", foNo);
	    console.log("foPrcsYn : ", foPrcsYn);

	    Swal.fire({
	        title: '해당 발주('+ foNo + ')를 <br>반려처리를 하시겠습니까?',
	        html: '<input id="rejectReason" class="swal2-input" style="width:350px" placeholder="반려 사유를 입력하세요">',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonText: '확인',
	        cancelButtonText: '취소',
	        reverseButtons: false,
	        preConfirm: () => {
	            return {
	                rejectReason: $('#rejectReason').val()
	            }
	        }
	    }).then(result => {
	        if (result.isConfirmed) {
	            let rejectReason = result.value.rejectReason;
	            let data = {
	                foNo: foNo,
	                foPrcsYn: foPrcsYn,
	                foRequest: rejectReason  // 반려 사유 추가
	            };

	            Swal.fire('반려처리가 완료되었습니다.', '', 'success');
	            btnAjax(data);
	        }
	    });
	});
	
	function btnAjax(data){
		$.ajax({
			url:"/hdorder/updateYn",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success: function(result) {
	            console.log("result:", result);
	            let data2 = {
	            	"frcsNo":frcsNo
	            };
	            selAjax(data2);
	        },
		});
	}
	
	function selAjax(data){
		$.ajax({
			url:"/hdorder/getSelFrcorder",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result2 : ", result);
				let str = "";
				if (result == '' || result == null) {
				    str += "<tr>";
				    str += "<td colspan='6' style='text-align: center'>발주내역이 존재하지 않습니다.</td>";
				    str += "</tr>";
				}
				let countN = 0;
				let countA = 0;
				let countD = 0;
				let countF = 0;
				let countE = 0;
				$.each(result, function(idx, frcorderVO) {
					
					str += "<tr>";
					var date = new Date(frcorderVO.foOdt); 
					var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					
					var date2 = new Date(frcorderVO.foDeliveryDt); 
					var formattedDate2 = date2.toLocaleDateString() + ' ' + date2.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					str += "<td>" + formattedDate + "</td>";
					str += "<td>" + frcorderVO.foNo + "</td>";
					str += "<td>" + frcorderVO.frcsNm + "</td>";
					str += "<td>" + formattedDate2 + "</td>";
					if (frcorderVO.foPrcsYn=='N'){
						str += "<td><div class='badge bg-danger text-white rounded-pill'>반려</div></td>"
						countN++;
					}
					if (frcorderVO.foPrcsYn=='A'){
						str += "<td><div class='badge bg-warning text-white rounded-pill'>승인대기</div></td>"
						countA++;
					}
					if (frcorderVO.foPrcsYn=='D'){
						str += "<td><div class='badge bg-success text-white rounded-pill'>배송중</div></td>"
						countD++;
					}
					if (frcorderVO.foPrcsYn=='F'){
						str += "<td><div class='badge bg-primary text-white rounded-pill'>배송완료</div></td>"
						countF++;
					}
					if (frcorderVO.foPrcsYn=='E'){
						str += "<td><div class='badge bg-primary text-white rounded-pill'>배송완료</div></td>"
						countE++;
					}
					
					str += "<td><label for='check"+idx+"'  style='color:blue;'>조회</label>"
					str += "<input class='btn btn-primary checkBtn' id='check"+idx+"' value='"+frcorderVO.foNo +"' data-yn='"+ frcorderVO.foPrcsYn  +"' type='button' data-bs-toggle='modal' data-bs-target='#exampleModalScrollable1'/></td>"
					if(frcorderVO.foPrcsYn == 'A'){
						str += "<td>";
						str += "<button class='btn btn-outline-blue approval' type='button' value='"+frcorderVO.foNo+"' data-yn='D'>승인</button> ";
						str += "<button class='btn btn-outline-red reject' type='button' value='"+frcorderVO.foNo+"' data-yn='N'>반려</button> ";
						str += "</td>";
					}else{
						str+="<td></td>"
					}
					str += "</tr>";
				});
				let countEF = parseInt(countE) + parseInt(countF);
				$(".btnA").text("승인대기("+countA+"건)");
				$(".btnN").text("반려("+countN+"건)");
				$(".btnEF").text("배송완료("+countEF+"건)");
				$(".btnD").text("배송중("+countD+"건)");
				
// 				$('#stockTable tbody').attr('id', 'tbody');
				$("#stockTable tbody").html(str);
			}
		});
	}
	
	
	const datatablesSimple = document.getElementById('stockTable');
    if (datatablesSimple) { 
        new simpleDatatables.DataTable(datatablesSimple,{
              labels: {
                  placeholder: "검색",
                  searchTitle: "검색",
                  pageTitle: "Page {page}",
                  perPage: "",
                  noRows: "내역이 존재하지 않습니다.",
                  info: "",
                  noResults: "검색결과가 없습니다.",
              }      
           }
        );
    }
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
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layout">
                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="3" y1="9" x2="21" y2="9"></line>
                                <line x1="9" y1="21" x2="9" y2="9"></line>
                            </svg>
                        </div>
                        수주관리
                    </h1>
                    <div class="page-header-subtitle"></div>
                </div>
            </div>
        </div>
    </div>
</header>
	<!-- Main page content-->
	<div class="container-xl px-4 mt-n10">
			<div class="card mb-4">
				<div class="card-header">
					<div class="row gx-3 mb-3">
						<div class="col-md-3">
							<label class="small mb-1">지역</label> <select class="form-control selLoc">
								<option value="" selected>전체</option>
								<c:forEach var="location" items="${locationVOList}"
									varStatus="stat">
									<option value="${location.comcdGroupcd}">${location.comcdCdnm}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-3">
							<label class="small mb-1">가맹점명</label> <select
								class="form-control frnSel">
								<option value="">전체</option>
							</select>
						</div>
					</div>
					<div class="d-flex justify-content-start">
						<button type="button" class="form-control btn btn-outline-blue selBtn" value = "">전체</button>　
						<button type="button" class="form-control btn btn-outline-blue selBtn btnA" value = "A">승인대기(${conuntA}건)</button>　
						<button type="button" class="form-control btn btn-outline-blue selBtn btnD" value = "D">배송중(${conuntD}건)</button>　
						<button type="button" class="form-control btn btn-outline-blue selBtn btnEF" value = "E">배송완료(${countEF}건)</button>　
						<button type="button" class="form-control btn btn-outline-blue selBtn btnN" value = "N">반려(${conuntN}건)</button>
					</div>
				</div>
				<div class="card-body">
					<div
						class="datatable-wrapper datatable-loading no-footer sortable fixed-columns">
						<div class="datatable-top"></div>
						<div class="datatable-container tableDiv">
							<table id="stockTable">
								<thead>
									<tr>
										<th style="width: 16.550764951321277%;"><a
											href="#">발주일시</a></th>
										<th style="width: 10.33240611961057%;"><a
											href="#">발주번호</a></th>
										<th style="width: 10.33240611961057%;"><a
											href="#">가맹점</a></th>
										<th style="width: 10.33240611961057%;"><a
											href="#">납기요청일</a></th>
										<th style="width: 7.76912378303199%;"><a
											href="#">진행상태</a></th>
										<th style="width: 5.76912378303199%;"><a
											href="#">전표</a></th>
										<th style="width: 3.76912378303199%;"><a
											href="#">선택</a></th>
									</tr>
								</thead>
								<tbody id="tbody">
									<c:forEach var="frcorderVO" items="${frcorderVOList}" varStatus="stat">
										<tr data-index="0">
												<td><fmt:formatDate value="${frcorderVO.foOdt}" pattern="yyyy. M. d. a hh:mm" /></td>
												<td>${frcorderVO.foNo}</td>
												<td>${frcorderVO.frcsNm}</td>
												<td><fmt:formatDate value="${frcorderVO.foDeliveryDt}" pattern="yyyy. M. d. a hh:mm" /></td>
												<input type="hidden" name="foNo" value="${frcorderVO.foNo}"/>
												<c:if test="${frcorderVO.foPrcsYn == 'N'}">
													<td>
														<div class='badge bg-danger text-white rounded-pill'>반려</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'A'}">
													<td>
														<div class='badge bg-warning text-white rounded-pill'>승인대기</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'D'}">
													<td>
														<div class='badge bg-success text-white rounded-pill'>배송중</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'F'}">
													<td>
														<div class='badge bg-primary text-white rounded-pill'>배송완료</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'E'}">
													<td>
														<div class='badge bg-primary text-white rounded-pill'>배송완료</div>
													</td>
												</c:if>
												<td>
													<label for='check${stat.index}' style="color:blue;">조회</label>
     												<input class="btn btn-primary checkBtn" id="check${stat.index}" value="${frcorderVO.foNo}" data-yn="${frcorderVO.foPrcsYn}" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable1"/>
												</td>
     											<td>
												<c:if test="${frcorderVO.foPrcsYn == 'A'}">
													<button class="btn btn-outline-blue approval" type="button" value="${frcorderVO.foNo}" data-yn="D">승인</button>
													<button class="btn btn-outline-red reject" type="button" value="${frcorderVO.foNo}" data-yn="N">반려</button>
												</c:if>
     											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="datatable-bottom">
							<div class="datatable-info"></div>
							<nav class="datatable-pagination">
								<ul class="datatable-pagination-list"></ul>
							</nav>
						</div>
						
						<!-- 전표 모달창 --> 
						<div class="modal fade" id="exampleModalScrollable1" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalScrollableTitle1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalScrollableTitle1">전표</h5>
									<button class="btn-close" type="button" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<!-- 전표 테이블 생성 -->
								<div class="modal-body">
										<div id="modal-body-text1" style="color: black;"></div>
										<br>
										<div id="modal-body-text5" style="color: black;">발주번호</div>
										<div class="row">
											<div class="col-md-6" id="modal-body-text2" style="color: black;">발주일자</div>
										</div>
										<div class="row">
											<div class="col-md-6 d-flex" id="modal-body-text4" style="color: black;">총 합계</div>
											<div class="col-md-6 d-flex justify-content-end" id="modal-body-text3">반려사유</div>
										</div>
										<div id="modal-body-check"></div>
								</div>
	
								<div class="modal-footer footerCheck">
									<button class="btn btn-secondary" type="button"
										data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
						</div>
					</div>
				</div>
		</div>
	</div>
</main>
<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">수정 확인</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">정말 삭제 하시겠습니까?</div>
            <div class="modal-footer">
	            <button class="btn btn-primary" id="removeBtn" type="button">삭제</button>
	            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
