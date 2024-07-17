<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
#kakaoPay:hover {
        cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}
#toss:hover {
        cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}
#payco:hover {
        cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}
#uplus:hover {
        cursor: pointer; /* 마우스 커서를 포인터로 변경 */
}
.hiddenChek {
    display: none;
}
.right{
	text-align: right;
}
.center{
	text-align: center;
}
#datatablesSimple2 td:nth-child(5), #insufStock td:nth-child(4), #insufStock td:nth-child(5), #insufStock td:nth-child(6){
	text-align: right;
}
#datatablesSimple3 td:nth-child(4){
	text-align: right;
}
#insufStock td:nth-child(6){
	color: red;
}
</style>
<script type="text/javascript">
$(function(){
	
	let wrhsNo;
	$("#wrhsInfo").on("change", function() {
		wrhsNo = $(this).val();
		console.log("wrhsNo : ",wrhsNo);
	});
	
	let hoDeliveryDt;
	$("#hoDeliveryDt").on("change", function() {
	    hoDeliveryDt = $(this).val();
	});
	let cnptNo;
	$("#cnptInfo").on("change", function() {
		let cnptInfo = $(this).val();
		let cnpt = cnptInfo.split(",");
		let cnptNm = cnpt[0];
		cnptNo = cnpt[1];
		let empNm = cnpt[2];
		let empNo = cnpt[3];
		console.log('cnptNm : ',cnptNm);
		console.log('cnptNo : ',cnptNo);
		console.log('empNm : ',empNm);
		console.log('empNo : ',empNo);
		
		$("#eNm").val(empNm);
		
		let data = {
			'cnptNm':cnptNm,
			'cnptNo':cnptNo,
			'empNo':empNo
		};
		console.log("data : ", data);
		
		
		// 거래처 별 거래내역 출력 시작
		$.ajax({
			url:"/hdorder/getOrderDt",
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
				str += "<table  id='datatablesSimple2'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th></th><th>발주상세번호</th><th>발주일</th><th>상품명</th><th>수량</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				
				// result : List<hdorderVO>
				$.each(result, function(idx, hdorderVO) {
					$.each(hdorderVO.hdorderDtlVOList, function(idx, hdorderDtlVO) {
						str += "<tr>";
						str += "<td><input class='form-check-input' type='checkbox' name='allDtChecked' value='" 
						+ hdorderDtlVO.gdsNo
						+ "' data-name='" +  hdorderDtlVO.gdsNm 
						+ "' data-qnt='" +  hdorderDtlVO.hodQnt 
						+ "' data-price='" +  hdorderDtlVO.hodPrc
						+ "' data-wrhs='" +  hdorderDtlVO.wrhsNo
						+ "'></td>";
						str += "<td>" + hdorderDtlVO.hodNo + "</td>";
						
						var date = new Date(hdorderVO.hoDt); 
						var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
						str += "<td>" + formattedDate + "</td>";
						str += "<td>" + hdorderDtlVO.gdsNm + "</td>";
						str += "<td>" + hdorderDtlVO.hodQnt + "</td>";
						str += "</tr>";
					});
				});
					str += "</tbody>";
					str += "</table>";
					$("#modal-body-orderDt").html(str); 
					
					const datatablesSimple = document.getElementById('datatablesSimple2');
				    if (datatablesSimple) {
				        new simpleDatatables.DataTable(datatablesSimple,{
				              labels: {
				            	  placeholder: "검색",
				                  searchTitle: "검색",
				                  pageTitle: "Page {page}",
				                  perPage: "",
				                  noRows: "거래내역이 존재하지 않습니다.",
				                  info: "",
				                  noResults: "검색결과가 없습니다",
				              }      
				           }
				        );
				    }
					
				    
				    $('#allDtChecked').on("click", function() {
				        var checked = $('#allDtChecked').is(':checked');
				        
				        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
				        $('input[name=allDtChecked]').prop('checked', checked);
				    });
				    
				    $('.form-check-input').on('change', function() {
			            updateSelectedGds();
			        });
			}
		});
		// 거래처 별 거래내역 출력 끝
		
		// 거래처 별 품목 출력 시작
		$.ajax({
			url:"/hdorder/getCnptGds",
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
				str += "<table  id='datatablesSimple3'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th></th><th>상품번호</th><th>상품명</th><th>단가</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				
				// result : List<GdsVO>
				$.each(result, function(idx, gdsVO) {
					let format = (gdsVO.gdsPrchsAmt).toLocaleString('ko-KR');
					str += "<tr>";
					str += "<td><input class='form-check-input' type='checkbox' name='allGdsChecked' value='" + gdsVO.gdsNo + "' data-name='" + gdsVO.gdsNm + "' data-price='" + gdsVO.gdsPrchsAmt + "'></td>";
					str += "<td>" + gdsVO.gdsNo + "</td>";
					str += "<td>" + gdsVO.gdsNm + "</td>";
					str += "<td>" + format + "원</td>";
					str += "</tr>";
				});
					str += "</tbody>";
					str += "</table>";
					
					$("#modal-body-gds").html(str); 
					
					const datatablesSimple = document.getElementById('datatablesSimple3');
				    if (datatablesSimple) {
				        new simpleDatatables.DataTable(datatablesSimple,{
				        	  perPageSelect:false,
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
				    
				    $('.form-check-input').on('change', function() {
			            updateSelectedGds();
			        });
				    
				    $('#allGdsChecked').on("click", function() {
				        var checked = $('#allGdsChecked').is(':checked');
				        
				        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
				        $('input[name=allGdsChecked]').prop('checked', checked);
				    });
			}
		});
		// 거래처 별 품목 출력 끝
		// 모달 창 '추가'버튼 클릭 시 발생 이벤트 시작
		let leng = 0;
		function updateSelectedGds(){
			let selectGds = [];
			$('.form-check-input:checked').each(function(){
				let gds = {
					gdsNo : $(this).val(),
					gdsNm : this.dataset.name,
					price : this.dataset.price,
				};
				if (this.dataset.wrhs !== undefined) {
					gds.wrhs = this.dataset.wrhs;
				}
				if (this.dataset.qnt !== undefined) {
				    gds.qnt = this.dataset.qnt;
				}
				console.log("gds : ", gds);
				selectGds.push(gds);
				console.log("selectGds : ", selectGds);
			});
			return selectGds;
		};
		
		$('#exampleModalScrollable1').on('hidden.bs.modal', function () { 
			$('input:checkbox').prop('checked', false);
		});
		$('#exampleModalScrollable2').on('hidden.bs.modal', function () { 
			$('input:checkbox').prop('checked', false);
		});
		$('#exampleModalScrollable3').on('hidden.bs.modal', function () { 
			$('input:checkbox').prop('checked', false);
		});
		
		 $('#exampleModalScrollable3').on('shown.bs.modal', function() {
		        $('.hiddenChek').prop('checked', true);
	    });
		
		$('.addSelectedGds').on('click', function() {
			let selectedGds = updateSelectedGds();
			
			console.log("selectedGds : ", selectedGds);
			$('#datatablesSimple1 tbody tr').each(function() {
				let gdsNo = $(this).find('td').first().text();
			});
			
			let tbody = $('#datatablesSimple1 tbody');
			  // 이미 숨겨진 입력 필드가 있는지 확인
		    if ($("input[name='empNo']").length === 0 && selectedGds.length != 0) {
		        let str = "";
		        str += "<input type='hidden' name='empNo' value='" + empNo + "' />";
		        
		        str += "<input type='date' name='hoDeliveryDt' value='" + hoDeliveryDt + "' style='display:none;'/>";
		        tbody.prepend(str);
		    }
		    let total = parseInt($('input[name="hoAmt"]').val()) || 0; // 기존의 총 금액을 가져옴
		    let totalVat = parseInt($('input[name="totalVat"]').val()) || 0; // 총 부가세를 저장할 변수 추가
		    console.log("total : ", total);
		    console.log("totalVat : ", totalVat);
		    let totalPrInput = "<input type='hidden' name='hoAmt'>";
		    let totalVatInput = "<input type='hidden' name='totalVat'>";
		    let hoTotalAmtInput = "<input type='hidden' name='hoTotalAmt'>";
		    if ($("input[name='hoAmt']").length === 0 && selectedGds.length != 0) {
			    $("#totalPr").after(totalPrInput);
			    $("#vat").after(totalVatInput);
			    $("#totalPrice").after(hoTotalAmtInput); 
		    }
		    $.each(selectedGds, function(idx, gdsVO) {
		        console.log("idx : ", idx);
		        console.log("leng : ", leng);
		        let quantity = gdsVO.qnt !== undefined ? gdsVO.qnt : 1;
		        let vat = (gdsVO.price * quantity) / 10;
		        totalVat += vat; // 총 부가세 누적
			    console.log("totalVat1 : ", totalVat); // 총 부가세 출력
		        let totalPrice = gdsVO.price * quantity;
		        total += totalPrice;
			    const format1 = (parseInt(totalPrice)).toLocaleString('ko-KR');
				const format2 = (parseInt(vat)).toLocaleString('ko-KR');
				const format3 = (parseInt(gdsVO.price)).toLocaleString('ko-KR');
		        
		        let row = "<tr>";
		        row += "<td><input class='form-check-input allChecked' type='checkbox'></td>";
		        row += "<td>" + gdsVO.gdsNo + "</td>";
		        row += "<input type='hidden' class='cnt' name='hdorderDtlVOList["+ leng +"].gdsNo' value='"+gdsVO.gdsNo+"' />";
		        
		        row += "<input type='hidden' name='hdorderDtlVOList["+ leng +"].cnptNo' value='"+cnptNo+"' />";
		        
		        row += "<td>" + gdsVO.gdsNm + "</td>";
		        row += "<input type='hidden' name='hdorderDtlVOList["+ leng +"].gdsNm' value='"+gdsVO.gdsNm+"' />";
		        
		        if(gdsVO.wrhs === undefined || gdsVO.wrhs === null || gdsVO.wrhs === ''){
			        row += "<td class='center'>" +  wrhsNo + "</td>";
			        row += "<input type='hidden' name='hdorderDtlVOList["+ leng +"].wrhsNo' value='"+wrhsNo+"' />";
		        }
		        if(gdsVO.wrhs !== undefined && gdsVO.wrhs !== null && gdsVO.wrhs !== ''){
			        row += "<td>" +  gdsVO.wrhs + "</td>";
			        row += "<input type='hidden' name='hdorderDtlVOList["+ leng +"].wrhsNo' value='"+gdsVO.wrhs+"' />";
		        }
		        
		        row += "<td class='right'>" + format3 + "원</td>";
		        row += "<input type='hidden' value='"+gdsVO.price+"' name='hdorderDtlVOList["+ leng +"].hodPrc' />";
		        
		        row += "<td><input type='number' value='" + quantity + "' name='hdorderDtlVOList["+ leng +"].hodQnt' min='1' class='form-control quantity'></td>";
		        
		        
		        row += "<td class='total-price right'>" + format1  + "원</td>";
		        
		        row += "<td class='vat right'>"+ format2 +"원</td>";
		        
		        row += "<td></td>";
		        row += "<input class='total-price1' type='hidden' value='"+gdsVO.price * quantity+"' data-vat='"+ vat +"' name='hdorderDtlVOList["+ leng +"].gdsAmt'/>";
		        
		        row += "</tr>";
		        tbody.prepend(row);
		        $('input[name="hoAmt"]').val(parseInt(total)); 
		        $('input[name="totalVat"]').val(totalVat); 
		        leng++;
		    });
		    
		    let totalPr1 = $("#totalPr").text().replace("원", "");
		    let totalPr = parseInt(totalPr1.replace(',', ''), 10);
		    totalPr += total;
		   
			let row = $(this).closest('tr');
			let priceStr = row.find('td').eq(5).text().replace('원', '').trim();
			let price = parseInt(priceStr.replace(',', ''), 10);
			let quantity = $(this).val();
			let total1 = price * quantity;
			let vat = total/10;
			console.log("vat : ", vat);
			
			const format1 = (parseInt(totalPr)).toLocaleString('ko-KR');
			const format2 = (parseInt(totalVat)).toLocaleString('ko-KR');
			const format3 = (parseInt(total + totalVat)).toLocaleString('ko-KR');
			const format4 = (parseInt(total1)).toLocaleString('ko-KR');
			const format5 = (parseInt(vat)).toLocaleString('ko-KR');
			
			$("#totalPr").text(format1 + '원');
		    $("#vat").text(format2+'원');
		    $("#totalPrice").text(format3 +'원');
			
			row.find('.total-price').text(format4 + '원');
			row.find('.total-price1').val(parseInt(total1));
			row.find('.vat').text(format5 + '원');
			updateTotalPrice();

		    $('#exampleModalScrollable1').modal('hide');
		    
		$('#allChecked').on("click", function() {
		        var checked = $('#allChecked').is(':checked');
		        
		        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
		        $('.allChecked').prop('checked', checked);
		    });
		
		// "제거" 버튼 클릭 시 선택된 행을 제거하는 기능 추가
		$("#removeBtn").on("click", function() {
		    // 선택된 체크박스를 찾아서 그에 해당하는 행을 제거
		    $(".allChecked:checked").each(function() {
		        $(this).closest("tr").remove(); // 선택된 체크박스의 부모인 tr을 찾아서 제거
		    });
		    updateTotalPrice();
		});
		
		$('input:checkbox').prop('checked', false);
		
		$('.quantity').on('input', function() {
			let row = $(this).closest('tr');
			let priceStr = row.find('td').eq(4).text().replace('원', '').trim();
			let price = parseInt(priceStr.replace(',', ''), 10);
			let quantity = $(this).val();
			console.log("price : ", price);
			console.log("quantity : ", quantity);
			
			let total = price * quantity;
			console.log("total : ", total);
			let vat = total/10;
			console.log("vat : ", vat);
			
			const format1 = (parseInt(total)).toLocaleString('ko-KR');
			const format2 = (parseInt(vat)).toLocaleString('ko-KR');
			row.find('.total-price').text(format1 + '원');
			row.find('.total-price1').val(parseInt(total));
			row.find('.vat').text(format2 + '원');
			updateTotalPrice();
		});
			
		function updateTotalPrice() {
		    let totalPr = 0;
		    let totalVat = 0; // 부가세 합계를 저장할 변수 추가
		    $('.total-price1').each(function() {
		        totalPr += parseInt($(this).val());
		        // 각 행에서 계산된 부가세를 누적하여 총 부가세를 계산
		        totalVat += parseInt(($(this).closest('tr').find('.vat').text().replace('원', '').trim()).replace(',', ''), 10);
		    });

		    $('input[name="hoAmt"]').val(parseInt(totalPr)); 
		    $('input[name="totalVat"]').val(parseInt(totalVat)); 
		    $('input[name="hoTotalAmt"]').val(parseInt(totalPr + totalVat));
		    const format2 = (parseInt(totalPr + totalVat)).toLocaleString('ko-KR');
		    const format3 = (parseInt(totalPr)).toLocaleString('ko-KR');
		    const format4 = (parseInt(totalPr/10)).toLocaleString('ko-KR');
		    $('#vat').text(format4 + '원'); // 총 부가세 업데이트
		    $('#totalPrice').text(format2 + '원'); 
		    $("#totalPr").text(format3+'원');

		}
		
		$('#exampleModalScrollable1').modal('hide');
		$('#exampleModalScrollable2').modal('hide');
		$('#exampleModalScrollable3').modal('hide');
		});
		
	});
	// 모달 창 '추가'버튼 클릭 시 발생 이벤트 끝
	
	$("#btnSave").on("click", function() {
    let valueCnt = $(".cnt").val();
    console.log("valueCnt : ", valueCnt);
    Swal.fire({
        title: '발주처리 하시겠습니까?',
        text: '',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '확인', // confirm 버튼 텍스트 지정
        cancelButtonText: '취소', // cancel 버튼 텍스트 지정
        reverseButtons: false, // 버튼 순서 거꾸로
    }).then(result => {
        if (result.isConfirmed) {
        	 Swal.fire('발주처리가 완료되었습니다.', '', 'success');
             setTimeout(function () {
                 $("#frm").submit();
             }, 1500);
        }
    });
});

	
	const datatablesSimple = document.getElementById('datatablesSimple1');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple,{
        	  searchable: false,
        	  perPageSelect:false,
              labels: {
            	  placeholder: "검색",
                  searchTitle: "검색",
                  pageTitle: "Page {page}",
                  perPage: "",
                  noRows: "선택된 거래처가 없습니다.",
                  info: "",
                  noResults: "검색결과가 없습니다",
              }      
           }
        );
    }
    
    const datatablesSimple4 = document.getElementById('datatablesSimple4');
    if (datatablesSimple4) { 
        new simpleDatatables.DataTable(datatablesSimple4,{
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
    
    const datatablesSimple5 = document.getElementById('insufStock');
    if (datatablesSimple5) { 
        new simpleDatatables.DataTable(datatablesSimple5,{
        	  searchable: false,
      	  	  perPageSelect:false,
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
                        발주서입력
                    </h1>
                    <div class="page-header-subtitle"></div>
                </div>
            </div>
        </div>
    </div>
</header>
	<header class="page-header page-header-dark">
		<div class="container-xl px-4">
			<div class="page-header-content pt-4">
				<div class="row align-items-center justify-content-between"></div>
			</div>
		</div>
	</header>
	<!-- Main page content-->
	<div class="container-xl px-4 mt-n10">
			<div class="card mb-4">
				<div class="card-header">
					발주 입력
				</div>
				<div class="card-body">
				<div class="sbp-preview-content">
						<div class="row gx-3 mb-3 d-flex justify-content-center">
							<div class="col-md-4">
								<label class="small mb-1">발주일자</label> 
								<input class="form-control form-control-solid" type="date" name="hoDt" readonly/>
							</div>
							<div class="col-md-4">
								<label class="small mb-1">납기요청일</label> 
								<input class="form-control" type="date" id="hoDeliveryDt"/>
							</div>
						</div>
						<div class="row gx-3 mb-3 d-flex justify-content-center">
							<div class="col-md-4">
								<label class="small mb-1">거래처</label> 
								<select class="form-control" id="cnptInfo" name="cnptInfo">
									<option selected>선택</option>
									<c:forEach var="cnptVO" items="${cnptVOList}"
		 								varStatus="stat">
											<option value="${cnptVO.cnptNm},${cnptVO.cnptNo},${cnptVO.employeeVO.empNm},${cnptVO.empNo}">${cnptVO.cnptNm}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-4">
								<label class="small mb-1">입고창고</label> 
								<select class="form-control" id="wrhsInfo" name="wrhsInfo">
									<option selected>선택</option>
									<c:forEach var="comCdVO" items="${getAllWrhsList}"
		 								varStatus="stat">
											<option value="${comCdVO.comcdGroupcd}">${comCdVO.comcdCdnm}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="row gx-3 mb-5 d-flex justify-content-center">
							<div class="col-md-3">
								<label class="small mb-1">담당자</label> 
								<input class="form-control" type="text" id="eNm" value="담당자" readonly/>
							</div>
							<div class="col-md-5">
								<label class="small mb-1">참고</label> 
								<input class="form-control" type="text" name="hoDt" placeholder="참고"/>
							</div>
						</div>
					</div>
					<hr>
					<div class="mb-4">
						<!-- 품목 모달 버튼 -->
						<button class="btn btn-outline-blue" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable1">품목</button>
						<!-- 거래내역 모달 버튼 -->
						<button class="btn btn-outline-blue" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable2">거래내역</button>
						<!-- 미달품목 모달 버튼 -->
						<button class="btn btn-outline-blue" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable3">미달품목</button>
					</div>
					<form action="/hdorder/createPost?${_csrf.parameterName}=${_csrf.token}" method="post" id="frm" name="frm">
						<div
							class="datatable-wrapper datatable-loading no-footer sortable fixed-columns">
							<div class="datatable-top"></div>
							<div class="datatable-container">
<!-- 							<div>전체<input type="checkbox" id="allChecked"></div> -->
								<table id="datatablesSimple1" class="datatable-table">
									<thead>
										<tr>
											<th data-sortable="true" style="width: 5.35933147632312%;"><a
												href="#" class="datatable-sorter"></a></th>
											<th data-sortable="true" style="width: 15.35933147632312%;"><a
												href="#" class="datatable-sorter">품목코드</a></th>
											<th data-sortable="true" style="width: 10.573816155988858%;"><a
												href="#" class="datatable-sorter">품목명</a></th>
											<th data-sortable="true" style="width: 15.573816155988858%;"><a
												href="#" class="datatable-sorter">입고창고</a></th>
											<th data-sortable="true" style="width: 7.788300835654596%;"><a
												href="#" class="datatable-sorter">단가</a></th>
											<th data-sortable="true" style="width: 10.788300835654596%;"><a
												href="#" class="datatable-sorter">수량</a></th>
											<th data-sortable="true" style="width: 10.35933147632312%;"><a
												href="#" class="datatable-sorter">공급가액</a></th>
											<th data-sortable="true" style="width: 10.35933147632312%;"><a
												href="#" class="datatable-sorter">부가세</a></th>
											<th data-sortable="true" style="width: 10.35933147632312%;"><a
												href="#" class="datatable-sorter">합계</a></th>
										</tr>
									</thead>
									<tbody>
										<tr data-index="0">
											<td></td>
											<td></td>
											<td></td>
											<td class='center'></td>
											<td></td>
											<td></td>
											<td class='right' id="totalPr">0원</td>
											<td class='right' id="vat">0원</td>
											<td class='right' id="totalPrice">0원</td>
										</tr>
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
						<sec:csrfInput />
					</form>
					<div class="d-flex justify-content-end">
						<button class="btn btn-outline-blue me-1" type="button" id="btnSave">발주하기</button> 
						<button class="btn btn-outline-red" type="button" id="removeBtn">선택삭제</button>
					</div>
				</div>
		</div>
	</div>
</main>

<!-- 품목 모달 -->
<div class="modal fade" id="exampleModalScrollable1" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalScrollableTitle1"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalScrollableTitle1">거래처별
					품목</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<!-- 품목 테이블 생성 -->
			<div class="modal-body" id="modal-body-gds">
				<table id="datatablesSimple5" class="datatable-table">
					<thead>
						<tr>
							<th></th>
							<th>상품번호</th>
							<th>상품명</th>
							<th>단가</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="4" style="text-align: center">거래처를 선택해주세요</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="modal-footer">
				<button class="btn btn-primary addSelectedGds" type="button">추가</button>
				<button class="btn btn-secondary closeModal" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 거래내역 모달 -->
<div class="modal fade" id="exampleModalScrollable2" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalScrollableTitle2"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalScrollableTitle2">거래처별
					거래내역</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<!-- 거래내역 테이블 생성 -->
			<div class="modal-body" id="modal-body-orderDt">
				<table id="datatablesSimple6" class="datatable-table">
					<thead>
						<tr>
							<th data-sortable="true"><a href="#"
								class="datatable-sorter"></a></th>
							<th data-sortable="true"><a href="#"
								class="datatable-sorter">발주상세번호</a></th>
							<th data-sortable="true"><a href="#"
								class="datatable-sorter">발주일</a></th>
							<th data-sortable="true"><a href="#"
								class="datatable-sorter">상품명</a></th>
							<th data-sortable="true"><a href="#"
								class="datatable-sorter">수량</a></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="datatable-empty" colspan="5">거래내역이 존재하지 않습니다.</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="modal-footer">
				<button class="btn btn-primary addSelectedGds" type="button">추가</button>
				<button class="btn btn-secondary closeModal" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<!-- 미달품목 모달 -->
<div class="modal fade" id="exampleModalScrollable3" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalScrollableTitle3"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalScrollableTitle3">미달품목</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="modal-body-gds">
				<table id="insufStock">
					<thead>
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
							<th>품목그룹</th>
							<th>재고수량</th>
							<th>최소재고수량</th>
							<th>미달수량</th>
							<th>거래처</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="gdsVO" items="${insufStockList}" varStatus="stat">
							<tr>
								<td>${gdsVO.gdsNo}</td>
								<td>${gdsVO.gdsNm}</td>
								<td>${gdsVO.comcdCdnm}</td>
								<td style="text-align: right;">${gdsVO.gdsStock}</td>
								<td style="text-align: right;">${gdsVO.minGdsStock}</td>
								<td style="text-align: right;">${gdsVO.gdsStock - gdsVO.minGdsStock}</td>
								<td>${gdsVO.cnptNo}</td>
							</tr>
							<input class="form-check-input hiddenChek" type="checkbox" value="${gdsVO.gdsNo}" data-name="${gdsVO.gdsNm}" data-price="${gdsVO.gdsPrchsAmt}" data-qnt="${gdsVO.minGdsStock - gdsVO.gdsStock}" data-wrhs="${gdsVO.wrhsNo}">
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="modal-footer">
				<button class="btn btn-primary addSelectedGds" type="button">추가</button>
				<button class="btn btn-secondary closeModal" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function getToday() {
   let today = new Date();
   let year = today.getFullYear();
   let month = ('0' + (today.getMonth() + 1)).slice(-2);
   let day = ('0' + today.getDate()).slice(-2);
   
   let dateString = year + "-" + month + "-" + day;
   
   let obj = document.querySelector("input[name='hoDt']");
   obj.value = dateString;
}
</script>
<script type="text/javascript">
   getToday();
</script>
