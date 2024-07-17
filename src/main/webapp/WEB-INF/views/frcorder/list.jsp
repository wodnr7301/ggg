<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<style>
#bill td:nth-child(3),#bill td:nth-child(4),#bill td:nth-child(5),#bill td:nth-child(6),#bill td:nth-child(7){
	text-align: right;
}
.checkBtn{
	display: none;
}
#datatablesSimple1 td:nth-child(3), #datatablesSimple1 td:nth-child(4), #datatablesSimple1 td:nth-child(5), #datatablesSimple1 td:nth-child(6), #datatablesSimple1 td:nth-child(7){
	text-align: right;
}
#datatablesSimple1 td:nth-child(1), #mainTable td:nth-child(1), #mainTable td:nth-child(2),#mainTable td:nth-child(3), #mainTable td:nth-child(4), #mainTable td:nth-child(5){
	text-align: center;
}
#mainTable2 td:nth-child(1), #mainTable2 td:nth-child(2),#mainTable2 td:nth-child(3), #mainTable2 td:nth-child(4), #mainTable2 td:nth-child(5){
	text-align: center;
}
.invoice-box {
    width: 800px;
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
		let foPrcsYn = $(this).val();
		
		let data = {
				"foPrcsYn":foPrcsYn	
			};
		console.log("data : ", data);
		
		$.ajax({
			url:"/frcorder/getSelFrcorder",
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
				    str += "<td colspan='6' style='text-align: center'>발주내역이 존재하지 않습니다.</td>";
				    str += "</tr>";
				}
				str += "<table  id='mainTable2'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>발주일시</th><th>발주번호</th><th>납기요청일</th><th>진행상태</th><th>전표</th><th>선택</th>";
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
					str += "<td>" + formattedDate2 + "</td>";
					if (frcorderVO.foPrcsYn=='N'){
						str += "<td><div class='badge bg-danger text-white rounded-pill'>반려</div></td>"
					}
					if (frcorderVO.foPrcsYn=='A'){
						str += "<td><div class='badge bg-warning text-white rounded-pill'>결재중</div></td>"
					}
					if (frcorderVO.foPrcsYn=='D'){
						str += "<td><div class='badge bg-success text-white rounded-pill'>배송중</div></td>"
					}
					if (frcorderVO.foPrcsYn=='F'){
						str += "<td><div class='badge bg-secondary text-white rounded-pill'>입고필요</div></td>"
					}
					if (frcorderVO.foPrcsYn=='E'){
						str += "<td><div class='badge bg-primary text-white rounded-pill'>입고완료</div></td>"
					}
					
					str += "<td><label for='check"+idx+"'  style='color:blue;'>조회</label>"
					str += "<input class='btn btn-primary checkBtn' id='check"+idx+"' value='"+frcorderVO.foNo +"' data-yn='"+frcorderVO.foPrcsYn+"' data-frcsNo='"+frcorderVO.frcsNo+"' type='button' data-bs-toggle='modal' data-bs-target='#exampleModalScrollable1'/></td>"
					if(frcorderVO.foPrcsYn == 'A'){
						str += "<td><input class='form-check-input allChecked' type='checkbox' value='"+frcorderVO.foNo+"'></td>";
					}else{
						str+="<td></td>"
					}
					str += "</tr>";
				});
				str += "</tbody>";
				str += "</table>";
				$(".tableDiv").html(str);
				
				const mainTable = document.getElementById('mainTable2');
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
    $(document).on("click", ".checkBtn", function() {
		let foNo = $(this).val();
		let foPrcsYn = this.dataset.yn;
		let frcsNo = this.dataset.frcsno;
		console.log("foNo : ", foNo);
		console.log("frcsNo : ", frcsNo);
		let data = {
				"foNo" : foNo
		};
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/frcorder/getfrcOrderDtl",
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
				let row2 = "";
				let row3 = "";
				let foDeliveryDt = '';
				let totalPrModal = "";
				let yn = '';
				let reason = '';
				str += "<table  id='datatablesSimple1'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>발주상세번호</th><th>상품명</th><th>수량</th><th>단가</th><th>공급가액</th><th>부가세</th><th>합계</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				
	            
				let total = 0;
				let format4 = "";
				$.each(result, function(idx, frcorderDtlVO) {
					let gdsInfo={};
					gdsInfo.foNo = foNo;
					gdsInfo.frcsNo = frcsNo;
					gdsInfo.gdsNo = frcorderDtlVO.gdsNo;
					gdsInfo.fodQnt = frcorderDtlVO.fodQnt;
					
					array.push(gdsInfo);
					
					if(frcorderDtlVO.foPrcsYn == 'N'){
						yn = `
						<div class="step step-lg">
							<div class="step-item">
						        <a class="step-item-link" href="#!">결재중</a>
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
						        <a class="step-item-link" href="#!">결재중</a>
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
							        <a class="step-item-link" href="#!">결재중</a>
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
							        <a class="step-item-link" href="#!">결재중</a>
							    </div>
							    <div class="step-item">
							        <a class="step-item-link" href="#!">배송중</a>
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
					
					if(frcorderDtlVO.foPrcsYn == 'E'){
						yn = `
							<div class="step step-lg">
								<div class="step-item">
							        <a class="step-item-link" href="#!">결재중</a>
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
						let selectedDate = new Date(frcorderDtlVO.foDeliveryDt);
					    let year = selectedDate.getFullYear();
					    let month = ("0" + (selectedDate.getMonth() + 1)).slice(-2);
					    let day = ("0" + selectedDate.getDate()).slice(-2);
				    	foDeliveryDt = '배송완료일 : ' + year + "/" + month + "/" + day;
					}else{
						let selectedDate = new Date(frcorderDtlVO.foOdt);
					    let year = selectedDate.getFullYear();
					    let month = ("0" + (selectedDate.getMonth() + 1)).slice(-2);
					    let day = ("0" + selectedDate.getDate()).slice(-2);
				    	foDeliveryDt = '발주일 : ' + year + "/" + month + "/" + day;
					}
					
				    formattedDate = `${year}/${month}/${day} ${hours}:${minutes}`;
					
					const format1 = (frcorderDtlVO.fodPrc).toLocaleString('ko-KR');
		        	
					const format2 = (frcorderDtlVO.fodAmt).toLocaleString('ko-KR');
		        	
					const format3 = (parseInt(frcorderDtlVO.fodAmt/10)).toLocaleString('ko-KR');
					
					const format5 = (parseInt(frcorderDtlVO.fodAmt) + parseInt(frcorderDtlVO.fodAmt/10)).toLocaleString('ko-KR');
		        	
					total += parseInt(frcorderDtlVO.fodAmt + frcorderDtlVO.fodAmt/10);
					format4 = total.toLocaleString('ko-KR');
		        		
					str += "<tr>";
					str += "<td>" + frcorderDtlVO.fodNo + "</td>";
					str += "<td>" + frcorderDtlVO.fodGdsNm + "</td>";
					str += "<td>" + frcorderDtlVO.fodQnt + "</td>";
					str += "<td>" + format1 + "원</td>";
					str += "<td>" + format2 + "원</td>";
					str += "<td>" + format3 + "원</td>";
					str += "<td>" + format5 + "원</td>";
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
					
					console.log("array : ", array);
					
					if(foPrcsYn == "F"){
						row3 += `<button class="btn btn-secondary saveBtn" type="button" value=\${foNo} 
							data-bs-dismiss="modal">입고처리</button>`;
						row3 += `<button class="btn btn-secondary close" type="button"
							data-bs-dismiss="modal">닫기</button>`;
					}else if(foPrcsYn =="E"){
						row3 += `<button class="btn btn-secondary bill" type="button" value=\${foNo} 
							data-bs-toggle="modal" data-bs-target="#exampleModalXl">전표</button>`;
						row3 += `<button class="btn btn-secondary close" type="button"
							data-bs-dismiss="modal">닫기</button>`;
					}else{
						row3 += `<button class="btn btn-secondary close" type="button"
							data-bs-dismiss="modal">닫기</button>`;
					}
					$(".checkFooter").html(row3); 
					
					// 전표 출력용
					let str2 ="";
					str2 += "<table  id='bill' class='datatable-table'>";
					str2 += "<thead>";
					str2 += "<tr class='bg-gray-300'>";
					str2 += "<th>발주상세번호</th><th>상품명</th><th>수량</th><th>단가</th><th>공급가액</th><th>부가세</th><th>합계</th>";
					str2 += "</tr>";
					str2 += "</thead>";
					str2 += "<tbody>";
					
					$.each(result, function(idx, frcorderDtlVO) {
						
						const format1 = (frcorderDtlVO.fodPrc).toLocaleString('ko-KR');
			        	
						const format2 = (frcorderDtlVO.fodAmt).toLocaleString('ko-KR');
			        	
						const format3 = (parseInt(frcorderDtlVO.fodAmt/10)).toLocaleString('ko-KR');
						
						const format5 = (parseInt(frcorderDtlVO.fodAmt) + parseInt(frcorderDtlVO.fodAmt/10)).toLocaleString('ko-KR');
			        	
						format4 = total.toLocaleString('ko-KR');
			        		
						str2 += "<tr>";
						str2 += "<td>" + frcorderDtlVO.fodNo + "</td>";
						str2 += "<td>" + frcorderDtlVO.fodGdsNm + "</td>";
						str2 += "<td>" + frcorderDtlVO.fodQnt + "</td>";
						str2 += "<td>" + format1 + "원</td>";
						str2 += "<td>" + format2 + "원</td>";
						str2 += "<td>" + format3 + "원</td>";
						str2 += "<td>" + format5 + "원</td>";
						str2 += "</tr>";
					});
					str2 += "<tr>";
					str2 += "<td class='bg-gray-300' colspan='6' style='text-align:center;'>합 계</td>";
					str2 += "<td class='bg-gray-300' style='text-align:right;'>" + format4 + "원</td>";
					str2 += "</tr>";
					str2 += "</tbody>";
					str2 += "</table>";
					$(".here").html(str2);
					
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
	
	$(document).on("click",".saveBtn",function(){
		let foNo = $(this).val();
		let param = array;
		console.log("arrayaaaaa : ",array);
		
		Swal.fire({
			   title: '입고처리 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
				if (result.isConfirmed) {
					$.ajax({
						url:"/frcorder/updateSave",
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
							  setTimeout(function () {
								  location.reload();
		                        }, 1500);
						    
						}
			 		});
			    }
			});
	});
	
	$('#exampleModalScrollable1').on('hidden.bs.modal', function (e) {
 	    array = []; 
 	});
	
    /* 전체 선택 버튼 이벤트 */
    $('#allChecked').on("click", function() {
        var checked = $('#allChecked').is(':checked');
        
        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
        $('.allChecked').prop('checked', checked);
    });
	
 // "제거" 버튼 클릭 시 선택된 행을 제거하는 기능 + 토스트 기능
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
					 Swal.fire('발주취소가 완료되었습니다.', '', 'success');
					 $(".allChecked:checked").each(function() {
						 let foNo=$(this).val();
						 console.log("foNo : ", foNo);
						 
						 let data = {
							"foNo":foNo
						 }
						 $.ajax({
								url:"/frcorder/deleteFrcOrder",
								contentType:"application/json;charset=utf-8",
								data:JSON.stringify(data),
								type:"post",
								dataType:"text",
								beforeSend:function(xhr){
									xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
								},
								success: function(result) {
						                console.log("result : ", result);
						                $('#exampleModalCenter').modal('hide');
						                $('.toast').toast('show');
				
						                let data = {
						                		"result":result
						                }
					                	$.ajax({
					            			url:"/frcorder/listAjax",
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
					            				$.each(result, function(idx, frcorderVO) {
					            					row += "<tr>";
					            					var date = new Date(frcorderVO.foOdt); 
					            					var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
					            					row += "<td>" + formattedDate + "</td>";
					            				    row += "<td>" + frcorderVO.foNo + "</td>";
					            				    if (frcorderVO.foPrcsYn == 'N') {
					            				        row += "<td> <div class='badge bg-danger text-white rounded-pill'>반려</div></td>";
					            				    } else if (frcorderVO.foPrcsYn == 'A') {
					            				        row += "<td> <div class='badge bg-warning text-white rounded-pill'>결재중</div></td>";
					            				    } else if (frcorderVO.foPrcsYn == 'D') {
					            				        row += "<td> <div class='badge bg-success text-white rounded-pill'>배송중</div></td>";
					            				    } else if (frcorderVO.foPrcsYn == 'F') {
					            				        row += "<td> <div class='badge bg-secondary text-white rounded-pill'>입고필요</div></td>";
					            				    } else if (frcorderVO.foPrcsYn == 'E') {
					            				        row += "<td> <div class='badge bg-primary text-white rounded-pill'>입고완료</div></td>";
					            				    }
					            				    row += "<td><label for='check" + idx + "' style='color: blue;'>조회</label>";
					            				    row += "<input class='btn btn-primary checkBtn' id='check" + idx + "' value='" + frcorderVO.foNo + "' data-yn='"+frcorderVO.foPrcsYn+"' data-frcsNo='"+frcorderVO.frcsNo+"' type='button' data-bs-toggle='modal' data-bs-target='#exampleModalScrollable1'/></td>";
					            				    row += "<td>";
					            				    if (frcorderVO.foPrcsYn == 'A') {
					            				        row += "<input class='form-check-input allChecked' type='checkbox' value='" + frcorderVO.foNo + "'>";
					            				    }
					            				    row += "</td>";
					            				    row += "<input type='hidden' name='hoNo' value='" + frcorderVO.foNo + "' />";
					            				    row += "</tr>";
					            				});
					            				tbody.html(row);
					            				
					            				$("#sel").val("");
					            			}
					                	});
						            }
								});
					 });
			    }
			});
	});
 
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
 
	const datatablesSimple = document.getElementById('mainTable');
    if (datatablesSimple) { 
        new simpleDatatables.DataTable(datatablesSimple,{
              labels: {
                  placeholder: "검색",
                  searchTitle: "검색",
                  pageTitle: "Page {page}",
                  perPage: "",
                  noRows: "미달품목이 존재하지 않습니다.",
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
                        발주내역
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
					<button type="button" class="form-control btn btn-outline-blue sel" value = "N">반려(${conuntN}건)</button>　
					<button type="button" class="form-control btn btn-outline-blue sel" value = "F">입고필요(${conuntF}건)</button>　
					<button type="button" class="form-control btn btn-outline-blue sel" value = "E">입고완료(${conuntE}건)</button>　
					<button type="button" class="form-control btn btn-outline-blue sel" value = "A">결재중(${conuntA}건)</button>　
					<button type="button" class="form-control btn btn-outline-blue sel" value = "D">배송중(${conuntD}건)</button>
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
							<table id="mainTable">
								<thead>
									<tr>
										<th data-sortable="true" style="width: 16.550764951321277%;"><a
											href="#">발주일시</a></th>
										<th data-sortable="true" style="width: 10.33240611961057%;"><a
											href="#">발주번호</a></th>
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
								<tbody id="tbody">
									<c:forEach var="frcorderVO" items="${frcorderVOList}" varStatus="stat">
										<tr data-index="0">
												<td><fmt:formatDate value="${frcorderVO.foOdt}" pattern="yyyy. M. d. a hh:mm" /></td>
												<td>${frcorderVO.foNo}</td>
												<td><fmt:formatDate value="${frcorderVO.foDeliveryDt}" pattern="yyyy. M. d. a hh:mm" /></td>
												<c:if test="${frcorderVO.foPrcsYn == 'N'}">
													<td>
														<div class="badge bg-danger text-white rounded-pill">반려</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'A'}">
													<td>
														<div class="badge bg-warning text-white rounded-pill">결재중</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'D'}">
													<td>
														<div class="badge bg-success text-white rounded-pill">배송중</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'F'}">
													<td>
														<div class="badge bg-secondary text-white rounded-pill">입고필요</div>
													</td>
												</c:if>
												<c:if test="${frcorderVO.foPrcsYn == 'E'}">
													<td>
														<div class="badge bg-primary text-white rounded-pill">입고완료</div>
													</td>
												</c:if>
												<td>
													<label for='check${stat.index}' style="color:blue; text-align: center;">조회</label>
     												<input class="btn btn-primary checkBtn" id="check${stat.index}" value="${frcorderVO.foNo}" data-yn="${frcorderVO.foPrcsYn}" data-frcsNo='${frcorderVO.frcsNo}' type="button" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable1"/>
												</td>
												<input type="hidden" name="foNo" value="${frcorderVO.foNo}" />
     											<td>
												<c:if test="${frcorderVO.foPrcsYn == 'A'}">
     												<input class='form-check-input allChecked' type='checkbox' value="${frcorderVO.foNo}">
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
						
						<!-- 모달창 --> 
						<div class="modal fade" id="exampleModalScrollable1" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalScrollableTitle1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-scrollable modal-xl" role="document">
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
