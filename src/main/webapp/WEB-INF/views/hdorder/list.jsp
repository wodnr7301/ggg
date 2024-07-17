<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<style>
#bill td:nth-child(8),#bill td:nth-child(4),#bill td:nth-child(5),#bill td:nth-child(6),#bill td:nth-child(7){
	text-align: right;
}
#datatablesSimple1 p:nth-child(1), #datatablesSimple1 td:nth-child(3), #datatablesSimple1 td:nth-child(4), #datatablesSimple1 td:nth-child(5),  #datatablesSimple1 td:nth-child(6), #datatablesSimple1 td:nth-child(7){
	text-align: right;
}
#stockDtlTable td:nth-child(1),#stockDtlTable td:nth-child(2),#stockDtlTable td:nth-child(3),#stockDtlTable td:nth-child(4), #stockDtlTable td:nth-child(5), #stockDtlTable td:nth-child(6){
	text-align: center;
}
#mainTable td:nth-child(1),#mainTable td:nth-child(2),#mainTable td:nth-child(3),#mainTable td:nth-child(4), #mainTable td:nth-child(5), #mainTable td:nth-child(6){
	text-align: center;
}
.checkBtn{
	display: none;
}
.invoice-box {
    width: 900px;
    margin: auto;
    padding: 20px;
    border: 1px solid #eee;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
    font-size: 14px;
    line-height: 24px;
    color: #555;
}

</style>
<script type="text/javascript">
$(function(){
	const { jsPDF } = window.jspdf;
	
	let array = [];
	$(".sel").on("click", function() {
		
		let hoPrcsYn = $(this).val();
		
		let data = {
				"hoPrcsYn":hoPrcsYn	
			};
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/hdorder/getAllHdorder",
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
				if (result == '' || result == null) {
				    str += "<tr>";
				    str += "<td colspan='7' style='text-align: center'>내역이 존재하지 않습니다.</td>";
				    str += "</tr>";
				}
				str += "<table  id='mainTable'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>발주일시</th><th>발주번호</th><th>담당자명</th><th>납기요청일</th><th>진행상태</th><th>전표</th><th>선택</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				$.each(result, function(idx, hdorderVO) {
					str += "<tr>";
					var date = new Date(hdorderVO.hoDt); 
					var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					var date2 = new Date(hdorderVO.hoDeliveryDt); 
					var formattedDate2 = date2.toLocaleDateString() + ' ' + date2.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					str += "<td>" + formattedDate + "</td>";
					str += "<td>" + hdorderVO.hoNo + "</td>";
					str += "<td>" + hdorderVO.employeeNm.empNm + "</td>";
					str += "<td>" + formattedDate2 + "</td>";
					if (hdorderVO.hoPrcsYn=='N'){
						str += "<td><div class='badge bg-danger text-white rounded-pill'>반려</div></td>"
					}
					if (hdorderVO.hoPrcsYn=='I'){
						str += "<td><div class='badge bg-warning text-white rounded-pill'>진행중</div></td>"
					}
					if (hdorderVO.hoPrcsYn=='Y'){
						str += "<td><div class='badge bg-primary text-white rounded-pill'>입고필요</div></td>"
					}
					if (hdorderVO.hoPrcsYn=='E'){
						str += "<td><div class='badge bg-success text-white rounded-pill'>입고완료</div></td>"
					}
					
					str += "<td><label for='check"+idx+"'  style='color:blue;'>조회</label>"
					str += "<input class='btn btn-primary checkBtn' id='check"+idx+"' value='"+hdorderVO.hoNo +"' data-yn='"+hdorderVO.hoPrcsYn+"' type='button' data-bs-toggle='modal' data-bs-target='#exampleModalScrollable1'/></td>"
					if(hdorderVO.hoPrcsYn == 'I'){
						str += "<td><input class='form-check-input allChecked' type='checkbox' value='"+hdorderVO.hoNo+"'></td>";
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
	
	// 조회버튼
	// 이벤트 위임을 사용하여 동적으로 생성된 버튼에 이벤트 핸들러 설정
    $(document).on("click", ".checkBtn", function() {
		let hoNo = $(this).val();
		let hoPrcsYn = this.dataset.yn;
		console.log("hoNo : ", hoNo);
		let data = {
				"hoNo" : hoNo
		};
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/hdorder/getOrderDt2",
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
				let yn = "";
				let totalPrModal = "";
				let row = "";
				let hoDeliveryDt = '';
				let reason = '';
				str += "<table  id='datatablesSimple1'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>발주상세번호</th><th>상품명</th><th>단가</th><th>수량</th><th>공급가액</th><th>부가세</th><th>합계</th><th>거래처</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				
				let total = 0;
				let format4 = "";
				$.each(result, function(idx, hdorderDtlVO) {
					let gdsInfo={};
					gdsInfo.hoNo = hoNo;
					gdsInfo.gdsNo = hdorderDtlVO.gdsNo;
					gdsInfo.hodQnt = hdorderDtlVO.hodQnt;
					
					array.push(gdsInfo);
					
					if(hdorderDtlVO.hoPrcsYn == 'N'){
						yn = `
						<div class="step step-lg">
							<div class="step-item">
						        <a class="step-item-link" href="#!">진행중</a>
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
						reason = `<span style="color: black;">반려사유 : <span style="color: red;">\${hdorderDtlVO.hoRequest}</span></span>`;
					}
					if(hdorderDtlVO.hoPrcsYn == 'I'){
						yn = `
						<div class="step step-lg">
							<div class="step-item active">
						        <a class="step-item-link" href="#!">진행중</a>
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
					if(hdorderDtlVO.hoPrcsYn == 'Y'){
						yn = `
							<div class="step step-lg">
								<div class="step-item">
							        <a class="step-item-link" href="#!">진행중</a>
							    </div>
							    <div class="step-item active">
						       		<a class="step-item-link" href="#!">입고필요</a>
						    	</div>
							    <div class="step-item">
							        <a class="step-item-link disabled" href="#!" tabindex="-1" aria-disabled="true">입고완료</a>
							    </div>
							</div>
							`;
					}
					
					if(hdorderDtlVO.hoPrcsYn == 'E'){
						yn = `
							<div class="step step-lg">
								<div class="step-item">
							        <a class="step-item-link" href="#!">진행중</a>
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
					
					if(hdorderDtlVO.hoPrcsYn == 'E'){
						let selectedDate = new Date(hdorderDtlVO.hoDeliveryDt);
					    let year = selectedDate.getFullYear();
					    let month = ("0" + (selectedDate.getMonth() + 1)).slice(-2);
					    let day = ("0" + selectedDate.getDate()).slice(-2);
				    	hoDeliveryDt = '배송완료일 : ' + year + "/" + month + "/" + day;
					}else{
						let selectedDate = new Date(hdorderDtlVO.hoDt);
					    let year = selectedDate.getFullYear();
					    let month = ("0" + (selectedDate.getMonth() + 1)).slice(-2);
					    let day = ("0" + selectedDate.getDate()).slice(-2);
				    	hoDeliveryDt = '발주일자 : ' + year + "/" + month + "/" + day;
					}
				
					const format1 = (hdorderDtlVO.hodPrc).toLocaleString('ko-KR');
					const format2 = (parseInt(hdorderDtlVO.gdsAmt)).toLocaleString('ko-KR');
					const format3 = (parseInt(hdorderDtlVO.gdsAmt/10)).toLocaleString('ko-KR');
					const format5 = (parseInt(hdorderDtlVO.gdsAmt/10) + parseInt(hdorderDtlVO.gdsAmt)).toLocaleString('ko-KR');
					total += parseInt(hdorderDtlVO.gdsAmt + hdorderDtlVO.gdsAmt/10);
					format4 = total.toLocaleString('ko-KR');
					str += "<input type='hidden' name='gdsNo' value='"+hdorderDtlVO.gdsNo+"'>";
					str += "<input type='hidden' name='hodQnt' value='"+hdorderDtlVO.hodQnt+"'>";
					str += "<tr>";
					str += "<td>" + hdorderDtlVO.hodNo + "</td>";
					str += "<td>" + hdorderDtlVO.gdsNm + "</td>";
					str += "<td>" + format1 + "원</td>";
					str += "<td>" + hdorderDtlVO.hodQnt + "</td>";
					str += "<td>" + format2 + "원</td>";
					str += "<td>" + format3 + "원</td>";
					str += "<td>" + format5 + "원</td>";
					str += "<td>" + hdorderDtlVO.cnptNm + "</td>";
					str += "</tr>";
				});
					str += "</tbody>";
					str += "</table>";
					totalPrModal += "<p style='text-align:right;'>결제금액 : "+format4+"원</p>";
					$("#modal-body-check").html(str); 
					$("#modal-body-text1").html(yn);
					$("#modal-body-text2").html(hoDeliveryDt);
					$("#modal-body-text3").html(reason);
					$("#modal-body-text4").html(totalPrModal);
					$("#modal-body-text5").html("발주번호 : " + hoNo);
					
					console.log("array : ", array);
					
					if(hoPrcsYn == "Y"){
						row += `<button class="btn btn-secondary saveBtn" type="button" value=\${hoNo} 
							data-bs-dismiss="modal">입고처리</button>`;
						row += `<button class="btn btn-secondary close" type="button"
							data-bs-dismiss="modal">닫기</button>`;
					}else if(hoPrcsYn =="E"){
						row += `<button class="btn btn-secondary bill" type="button" value=\${hoNo} 
							data-bs-toggle="modal" data-bs-target="#exampleModalXl">전표</button>`;
						row += `<button class="btn btn-secondary close" type="button"
							data-bs-dismiss="modal">닫기</button>`;
					}else{
						row += `<button class="btn btn-secondary close" type="button"
							data-bs-dismiss="modal">닫기</button>`;
					}
					
					$(".checkFooter").html(row); 
					
					// 전표 출력용
					let str2 ="";
					str2 += "<table  id='bill' class='datatable-table'>";
					str2 += "<thead>";
					str2 += "<tr class='bg-gray-300'>";
					str2 += "<th>발주상세번호</th><th>거래처</th><th>상품명</th><th>수량</th><th>단가</th><th>공급가액</th><th>부가세</th><th>합계</th>";
					str2 += "</tr>";
					str2 += "</thead>";
					str2 += "<tbody>";
					
					$.each(result, function(idx, hdorderDtlVO) {
						
						const format1 = (hdorderDtlVO.hodPrc).toLocaleString('ko-KR');
						const format2 = (parseInt(hdorderDtlVO.gdsAmt)).toLocaleString('ko-KR');
						const format3 = (hdorderDtlVO.hodPrc).toLocaleString('ko-KR');
						format4 = total.toLocaleString('ko-KR');
						const format5 = (parseInt(hdorderDtlVO.gdsAmt/10) + parseInt(hdorderDtlVO.gdsAmt)).toLocaleString('ko-KR');
						str2 += "<input type='hidden' name='gdsNo' value='"+hdorderDtlVO.gdsNo+"'>";
						str2 += "<input type='hidden' name='hodQnt' value='"+hdorderDtlVO.hodQnt+"'>";
						str2 += "<tr>";
						str2 += "<td>" + hdorderDtlVO.hodNo + "</td>";
						str2 += "<td>" + hdorderDtlVO.cnptNm + "</td>";
						str2 += "<td>" + hdorderDtlVO.gdsNm + "</td>";
						str2 += "<td>" + hdorderDtlVO.hodQnt + "</td>";
						str2 += "<td>" + format1 + "원</td>";
						str2 += "<td>" + format2 + "원</td>";
						str2 += "<td>" + parseInt(hdorderDtlVO.gdsAmt/10) + "원</td>";
						str2 += "<td>" + format5 + "원</td>";
						str2 += "</tr>";
					});
					str2 += "<tr>";
					str2 += "<td class='bg-gray-300' colspan='7' style='text-align:center;'>합 계</td>";
					str2 += "<td class='bg-gray-300' style='text-align:right;'>" + format4 + "원</td>";
					str2 += "</tr>";
					str2 += "</tbody>";
					str2 += "</table>";
					$(".here").html(str2);
					
					
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
				                  noRows: "선택된 거래처가 없습니다.",
				                  info: "",
				                  noResults: "검색결과가 없습니다.",
				              }      
				           }
				        );
				    }
					
				    const bill = document.getElementById('bill');
				    if (bill) {
				        new simpleDatatables.DataTable(bill,{
				        	  perPageSelect:false,
				        	  searchable:false,
				        	  sortable:false,
				              labels: {
				                  placeholder: "검색",
				                  searchTitle: "검색",
				                  pageTitle: "Page {page}",
				                  perPage: "",
				                  noRows: "선택된 거래처가 없습니다.",
				                  info: "",
				                  noResults: "검색결과가 없습니다.",
				              }      
				           }
				        );
				    }
				    
				    const billDetail = document.getElementById('billDetail');
				    if (billDetail) {
				        new simpleDatatables.DataTable(billDetail,{
				        	  perPageSelect:false,
				        	  searchable:false,
				        	  sortable:false,
				              labels: {
				                  placeholder: "검색",
				                  searchTitle: "검색",
				                  pageTitle: "Page {page}",
				                  perPage: "",
				                  noRows: "선택된 거래처가 없습니다.",
				                  info: "",
				                  noResults: "검색결과가 없습니다.",
				              }      
				           }
				        );
				    }
				    
			}
		});
	});
	
	/* 전체 선택 버튼 이벤트 */
    $('#allChecked').on("click", function() {
        var checked = $('#allChecked').is(':checked');
        
        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
        $('.allChecked').prop('checked', checked);
    });
    
 	// "제거" 버튼 클릭 시 선택된 행을 제거하는 기능 + toast 기능
	$("#removeBtn").on("click", function() {
		Swal.fire({
			   title: '발주취소 하시겠습니까?',
			   text: '',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				if (result.isConfirmed) {
					 $(".allChecked:checked").each(function() {
						 let hoNo=$(this).val();
						 console.log("hoNo : ", hoNo);
						 
						 let data = {
							"hoNo":hoNo
						 }
						 $.ajax({
								url:"/hdorder/deleteHdorder",
								contentType:"application/json;charset=utf-8",
								data:JSON.stringify(data),
								type:"post",
								dataType:"text",
								beforeSend:function(xhr){
									xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
								},
								success: function(result) {
									 Swal.fire('발주취소가 완료되었습니다.', '', 'success');
									 setTimeout(function() {
									        location.reload();
									    }, 1500);
						            }
								});
					 });
			    }
			});
	});
 	
 	$(document).on("click",".saveBtn", function(){
 		let hoNo = $(this).val();
 		let param = array;
 		Swal.fire({
			   title: '입고처리 하시겠습니까?',
			   text: '',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				if (result.isConfirmed) {
			 		$.ajax({
						url:"/hdorder/updateSave",
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(param),
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(result){
						    console.log("result : ", result);
							Swal.fire('입고처리가 완료되었습니다.', '', 'success');
						    location.reload();
						}
			 		});
			    }
			});
 	});
 	
 	$('#exampleModalScrollable1').on('hidden.bs.modal', function (e) {
 	    array = []; 
 	});
 	
 	function ajaxFn(data) {
 		$.ajax({
			url:"/hdorder/listAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("result2 : ", result);
				let row = "";
				$.each(result, function(idx, hdorderVO) {
					row += "<tr>";
					var date = new Date(hdorderVO.hoDt); 
					var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					row += "<td>" + formattedDate + "</td>";
				    row += "<td>" + hdorderVO.hoNo + "</td>";
				    row += "<input type='hidden' name='hoNo' value='" + hdorderVO.hoNo + "' />";
				    row += "<td>" + hdorderVO.employeeNm.empNm + "</td>";
				    if (hdorderVO.hoPrcsYn == 'N') {
				        row += "<td>반려</td>";
				    } else if (hdorderVO.hoPrcsYn == 'I') {
				        row += "<td>진행중</td>";
				    } else if (hdorderVO.hoPrcsYn == 'Y') {
				        row += "<td>입고필요</td>";
				    } else if (hdorderVO.hoPrcsYn == 'E') {
				        row += "<td>입고완료</td>";
				    }
				    row += "<td><label for='check" + idx + "' style='color: blue;'>조회</label>";
				    row += "<input class='btn btn-primary checkBtn' id='check" + idx + "' value='" + hdorderVO.hoNo + "' data-yn = '"+hdorderVO.hoPrcsYn+"' type='button' data-bs-toggle='modal' data-bs-target='#exampleModalScrollable1'/></td>";
				    row += "<td>";
				    if (hdorderVO.hoPrcsYn == 'I') {
				        row += "<input class='form-check-input allChecked' type='checkbox' value='" + hdorderVO.hoNo + "'>";
				    }
				    row += "</td>";
				    row += "</tr>";
				});
				tbody.html(row);
				
				$("#sel").val("");
			}
    	});
	}
 	
 	const datatablesSimple = document.getElementById('stockDtlTable');
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
 	
    $("#print").on('click', function() {
        // pdfArea 영역을 캡처
        html2canvas($('.invoice-box')[0], {
            allowTaint: true,  // 교차 출처 이미지를 캡처할 수 있도록 설정
            useCORS: true,     // CORS 사용한 서버로부터 이미지 로드할 것인지 여부
            scale: 2           // 기본 96dpi에서 해상도를 두 배로 증가
        }).then(function(canvas) {
            // 캔버스를 이미지로 변환
            const imgData = canvas.toDataURL('image/png');

            // 이미지와 페이지 크기 계산
            const imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
            const pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
            const imgHeight = canvas.height * imgWidth / canvas.width;
            let heightLeft = imgHeight;
            const margin = 10; // 출력 페이지 여백설정
            const doc = new jsPDF('p', 'mm');
            let position = 0;

            // 첫 페이지에 이미지 추가
            doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;

            // 여러 페이지가 필요한 경우 루프를 돌면서 이미지 추가
            while (heightLeft >= 20) {
                position = heightLeft - imgHeight;
                position -= 20; // 페이지 사이 간격 설정

                doc.addPage();
                doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }

            // PDF 파일 저장
            doc.save('filename.pdf');
        }).catch(function(error) {
            console.error('html2canvas error:', error);
        });
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
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layout">
                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="3" y1="9" x2="21" y2="9"></line>
                                <line x1="9" y1="21" x2="9" y2="9"></line>
                            </svg>
                        </div>
                        발주서내역
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
			<div class="card-header d-flex justify-content-start">
						<button type="button" class="form-control btn btn-outline-blue sel" value = "">전체</button>　
						<button type="button" class="form-control btn btn-outline-blue sel" value = "Y">입고필요(${conuntY}건)</button>　
						<button type="button" class="form-control btn btn-outline-blue sel" value = "E">입고완료(${conuntE}건)</button>　
						<button type="button" class="form-control btn btn-outline-blue sel" value = "N">반려(${conuntN}건)</button>　
						<button type="button" class="form-control btn btn-outline-blue sel" value = "I">진행중(${conuntI}건)</button>　
			</div>
			<div class="card-body">
				<div
					class="datatable-wrapper datatable-loading no-footer sortable fixed-columns">
					<div class="datatable-top">
						<div class="d-flex justify-content-end">
							<button class="btn btn-outline-dark" type="button" id="removeBtn">발주취소</button>
						</div>
					</div>
					<div class="datatable-container tableDiv">
						<table id="stockDtlTable">
							<thead>
								<tr>
									<th data-sortable="true" style="width: 16.550764951321277%;"><a
										href="#">발주일시</a></th>
									<th data-sortable="true" style="width: 10.33240611961057%;"><a
										href="#">발주번호</a></th>
									<th data-sortable="true" style="width: 7.76912378303199%;"><a
										href="#">담당자명</a></th>
									<th data-sortable="true" style="width: 7.76912378303199%;"><a
										href="#">납기요청일</a></th>
									<th data-sortable="true" style="width: 7.76912378303199%;"><a
										href="#">진행상태</a></th>
									<th data-sortable="true" style="width: 5.76912378303199%;"><a
										href="#">전표</a></th>
									<th data-sortable="true" style="width: 5.76912378303199%;"><a
										href="#">선택</a></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="hdorderVO" items="${hdordeVOList}" varStatus="stat">
									<tr data-index="0">
											<td><fmt:formatDate value="${hdorderVO.hoDt}" pattern="yyyy. M. d. a hh:mm" /></td>
											<td>${hdorderVO.hoNo}</td>
											<input type="hidden" name="hoNo" value="${hdorderVO.hoNo}" />
											<td>${hdorderVO.employeeNm.empNm}</td>
											<td><fmt:formatDate value="${hdorderVO.hoDeliveryDt}" pattern="yyyy. M. d. a hh:mm" /></td>
											<c:if test="${hdorderVO.hoPrcsYn == 'N'}">
												<td>
													<div class='badge bg-danger text-white rounded-pill'>반려</div>
												</td>
											</c:if>
											<c:if test="${hdorderVO.hoPrcsYn == 'I'}">
												<td>
													<div class='badge bg-warning text-white rounded-pill'>진행중</div>
												</td>
											</c:if>
											<c:if test="${hdorderVO.hoPrcsYn == 'Y'}">
												<td>
													<div class='badge bg-primary text-white rounded-pill'>입고필요</div>
												</td>
											</c:if>
											<c:if test="${hdorderVO.hoPrcsYn == 'E'}">
												<td>
													<div class='badge bg-success text-white rounded-pill'>입고완료</div>
												</td>
											</c:if>
											<td>
												<label for='check${stat.index}' style="color:blue;">조회</label>
    												<input class="btn btn-primary checkBtn" id="check${stat.index}" value="${hdorderVO.hoNo}" data-yn = "${hdorderVO.hoPrcsYn}"  type="button" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable1"/>
											</td>
    											<td>
											<c:if test="${hdorderVO.hoPrcsYn == 'I'}">
    												<input class='form-check-input allChecked' type='checkbox' value="${hdorderVO.hoNo}">
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
				</div>
			</div>
	</div>
</div>
	
<!-- 모달창 -->
<div class="modal fade" id="exampleModalScrollable1" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalScrollableTitle1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-xl"
		role="document">
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

			<div class="modal-footer checkFooter">
				<button class="btn btn-secondary close" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

	<!-- Extra large modal -->
<div class="modal fade" id="exampleModalXl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">거래명세서</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="invoice-box">
                	<div class="text-center">
                		<h1>거래명세서</h1>
                	</div>
                	<div class="row">
                		<div class="col">
                    		<img src="/resources/img/logo.png" alt="Company logo" style="width:100%; max-width:500px;">
                    	</div>
                    	<div class="col">
                    		<table id="billDetail">
                    			<thead>
                    				<tr>
                    					<th>항목</th>
                    					<th>내용</th>
                    				</tr>
                    			</thead>
                    			<tbody>
                    				<tr>
                    					<td><strong>발행번호:</strong></td>
                    					<td>2023-09-21-7</td>
                    				</tr>
                    				<tr>
                    					<td><strong>사업자등록번호:</strong></td>
                    					<td>203-81-65488</td>
                    				</tr>
                    				<tr>
                    					<td><strong>주소:</strong></td>
                    					<td>서울특별시 중구 충무로1가 113-8</td>
                    				</tr>
                    				<tr>
                    					<td><strong>전화번호:</strong></td>
                    					<td>02-1234-5678</td>
                    				</tr>
                    			</tbody>
                    		</table>
		                </div>
                	</div>
			        <div class="here">
			         왜 안나옴?
			        </div>
			    </div>
            </div>
            <div class="modal-footer"><button class="btn btn-secondary" id="print" type="button" >출력</button><button class="btn btn-primary" type="button" data-bs-dismiss="modal">닫기</button></div>
        </div>
    </div>
</div>
</main>
