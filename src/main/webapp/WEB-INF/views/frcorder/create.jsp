<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 포트원 결제 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 포트원 결제 -->

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
#insufStock td:nth-child(6){
	color: red;
}
#datatablesSimple6 td:nth-child(4), #insufStock td:nth-child(4), #insufStock td:nth-child(5), #insufStock td:nth-child(6){
	text-align: right;
}
#datatablesSimple4 td:nth-child(4), #datatablesSimple3 td:nth-child(5){
	text-align: right;
}
#datatablesSimple4 td:nth-child(2){
	text-align: center;
}
#datatablesSimple3 td:nth-child(2),#datatablesSimple3 td:nth-child(3){
	text-align: center;
}
</style> 
<script type="text/javascript">
$(function(){
	
	let frcsNo = $("input[name='frcsNo']").val();
	console.log("frcsNo : ", frcsNo);
	let foDeliveryDt;
	let foRequest;
	
	// 납기요청일 가져오기
	$('#deliDt').on('change', function() {
	    foDeliveryDt = $(this).val();
    });
	
	$('#request').on('input', function() {
		foRequest = $(this).val();
        console.log("foRequest : ", foRequest);
    });
	
 	// 전체 or 구분 별 상품 목록 함수
	selGdsGu();
	
	// 가맹점 별 거래내역 함수
	getFrcGdsDtl();
	
	// 가맹점 별 거래내역 구하기
	function getFrcGdsDtl(){
	    let data = {
	    	"frcsNo":frcsNo,
	    	"foPrcsYn":"E"
	    };
	    
    	$.ajax({
			url:"/frcorder/getFrcGdsDtl",
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
				str += `<div> 전체<input type="checkbox" id="allDtChecked"></div>`;
				str += "<table  id='datatablesSimple3'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th></th><th>발주상세번호</th><th>발주일</th><th>상품명</th><th>수량</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				$.each(result, function(idx, frcorderVO) {
					$.each(frcorderVO.frcOrderDtlVOList, function(idx, frcorderDtlVO) {
						str += "<tr>";
						str += "<td><input class='form-check-input allDtChecked' type='checkbox' name='allDtChecked' value='" 
						+ frcorderDtlVO.gdsNo
						+ "' data-name='" +  frcorderDtlVO.fodGdsNm 
						+ "' data-qnt='" +  frcorderDtlVO.fodQnt 
						+ "' data-price='" +  frcorderDtlVO.fodPrc
						+ "'></td>";
						str += "<td>" + frcorderDtlVO.fodNo + "</td>";
						
						var date = new Date(frcorderVO.foOdt); 
						var formattedDate = date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
						str += "<td>" + formattedDate + "</td>";
						str += "<td>" + frcorderDtlVO.fodGdsNm + "</td>";
						str += "<td>" + frcorderDtlVO.fodQnt + "</td>";
						str += "</tr>";
					});
				});
				str += "</tbody>";
				str += "</table>";
				$("#modal-body-frcorderDt").html(str); 
				
				const datatablesSimple = document.getElementById('datatablesSimple3');
			    if (datatablesSimple) {
			        new simpleDatatables.DataTable(datatablesSimple,{
			        	  searchable: false,
			        	  perPageSelect:false,
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
			        $('.allDtChecked').prop('checked', checked);
				});
				
				$('.form-check-input').on('change', function() {
		            updateSelectedGds();
		        });
			}
		});
	}
	
	// 전체 or 구분 별 상품 목록
	function selGdsGu() {
		$(".selGu").on("change", function() {
			
			let comcdGroupcd = $(this).val();
			
			console.log(comcdGroupcd);
			
			let data = {
					"comcdGroupcd":comcdGroupcd
				}

			console.log("data : ", data);
			
			ajax(data);
			
		});
	}
	
	 // 구분 별 상품 목록 ajax
	function ajax(data){
		$.ajax({
			url:"/frcorder/getAllGds",
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
				str += "<tr>";
				str += "<th></th><th>상품번호</th><th>상품명</th><th>단가</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				$.each(result, function(idx, gdsVO) {
					str += "<tr>";
					str += "<td><input class='form-check-input allGdsChecked' type='checkbox' name='allGdsChecked' value='" + gdsVO.gdsNo + "' data-name='" + gdsVO.gdsNm + "' data-price='" + gdsVO.gdsNtslAmt + "'></td>";
					str += "<td style='text-align:center;'>" + gdsVO.gdsNo + "</td>";
					str += "<td>" + gdsVO.gdsNm + "</td>";
					str += "<td>" + gdsVO.gdsNtslAmt + "원</td>";
					str += "</tr>";
				});
					
					$("#datatablesSimple4 tbody").html(str); 
					
					const datatablesSimple = document.getElementById('datatablesSimple6');
				    if (datatablesSimple) {
				        new simpleDatatables.DataTable(datatablesSimple,{
				        	perPage:5, 
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
				    
				    $('#allGdsChecked').on("click", function() {
				        var checked = $('#allGdsChecked').is(':checked');
				        
				        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
				        $('.allGdsChecked').prop('checked', checked);
				    });
				    
				}
		});
	}
	 
	$('.form-check-input').on('change', function() {
        updateSelectedGds();
    });
	
	let leng = 0;
	let selectCart = [];
	$('.addSelectedGds').on('click', function() {
		let selectedGds = updateSelectedGds();
		console.log("selectedGds : ", selectedGds);
		$('#datatablesSimple1 tbody tr').each(function() {
			let gdsNo = $(this).find('td').first().text();
		});
		let tbody = $('#datatablesSimple1 tbody');
	    
		let total = parseInt($('input[name="foTotalAmt"]').val()) || 0; // 기존의 총 금액을 가져옴
		console.log("total22 : ", total);
		let totalVat = parseInt($('input[name="totalVat"]').val()) || 0; // 총 부가세를 저장할 변수 추가
		let totalPrInput = "<input type='hidden' name='foTotalAmt'>";
	    let totalVatInput = "<input type='hidden' name='totalVat'>";
	    let totalPriceInput = "<input type='hidden' name='foTotal'>";
		if ($("input[name='foTotalAmt']").length === 0 && selectedGds.length != 0) {
		    $("#totalPr").after(totalPrInput);
		    $("#vat").after(totalVatInput);
		    $("#totalPrice").after(totalPriceInput);
		}
		console.log("frcsNo : ", frcsNo);
		console.log("foDeliveryDt : ", foDeliveryDt);
		console.log("foRequest : ", foRequest);
		// 이미 숨겨진 입력 필드가 있는지 확인
	    if ($("input[name='foDeliveryDt']").length === 0 && selectedGds.length != 0) {
	        let str = "";
	        str += "<input type='hidden' name='frcsNo' value='" + frcsNo + "' />";
	        str += "<input type='date' name='foDeliveryDt' value='" + foDeliveryDt + "' style='display:none;'/>";
	        str += "<input type='hidden' name='foRequest' value='" + foRequest + "' />";
	        tbody.prepend(str);
	    }
		$.each(selectedGds, function(idx, gdsVO) {
	        let quantity = gdsVO.qnt !== undefined ? gdsVO.qnt : 1;
	        let vat = parseInt(gdsVO.price * quantity) / 10;
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
			row += "<input type='hidden' class='cnt' name='frcOrderDtlVOList["+ leng +"].gdsNo' value='"+gdsVO.gdsNo+"' />";
			 
	        row += "<td>" + gdsVO.gdsNm + "</td>";
	        row += "<input type='hidden' name='frcOrderDtlVOList["+ leng +"].fodGdsNm' value='"+gdsVO.gdsNm+"' />";
	        
	        row += "<td class='right'>" + format3 + "원</td>";
	        row += "<input type='hidden' value='"+parseInt(gdsVO.price)+"' name='frcOrderDtlVOList["+ leng +"].fodPrc' />";
	        
	        row += "<td><input type='number' value='" + quantity + "' name='frcOrderDtlVOList["+ leng +"].fodQnt' min='1' class='form-control quantity'></td>";
	        
	        row += "<td class='total-price right'>" + format1 + "원</td>";
	        row += "<input class='total-price1' type='hidden' value='"+parseInt(gdsVO.price * quantity)+"' name='frcOrderDtlVOList["+ leng +"].fodAmt'/>";
	        
	        row += "<td class='vat right'>"+ format2 +"원</td>";
	        
	        row += "<td></td>";
	        
			row += "</tr>";
			tbody.prepend(row);
			$('input[name="foTotalAmt"]').val(parseInt(total)); // 품목 추가 될때마다 초기값의 합
			$('input[name="totalVat"]').val(parseInt(totalVat)); // 품목 추가 될때마다 초기값의 합
	        leng++;
		});
		
		console.log("total : ", total);
		console.log("totalVat2 : ", totalVat); // 총 부가세 출력
		
	    let row = $(this).closest('tr');
		let price = parseFloat(row.find('td').eq(4).text().replace('원', ''));
		let quantity = $(this).val();
		let total1 = price * quantity;
		let vat = total/10;
		console.log("vat : ", vat);
		
		const format1 = (parseInt(total)).toLocaleString('ko-KR');
		const format2 = (parseInt(totalVat)).toLocaleString('ko-KR');
		const format3 = (parseInt(total + totalVat)).toLocaleString('ko-KR');
		const format4 = (parseInt(total1)).toLocaleString('ko-KR');
		const format5 = (parseInt(vat)).toLocaleString('ko-KR');
		
		$("#totalPr").text(format1 + '원');
	    $("#vat").text(parseInt(totalVat)+'원');
	    $("#totalPrice").text(format3 +'원');
	    
		row.find('.total-price').text(format4 + '원');
		row.find('.total-price1').val(parseInt(total1));
		row.find('.vat').text(format5 + '원'); // 수량이 변경 될때마다 값이 변함
		updateTotalPrice();
		selectCart = [];
		
	    $('#exampleModalScrollable1').modal('hide');
	    $('#exampleModalScrollable2').modal('hide');
	    $('#exampleModalScrollable3').modal('hide');
	});
	
	$(document).on('input', '.quantity', function() {
		let row = $(this).closest('tr');
		let priceStr = row.find('td').eq(3).text().replace('원', '').trim();
		let price = parseInt(priceStr.replace(',', ''), 10);
		let quantity = $(this).val();
		let total = price * quantity;
		let vat = total/10;
		console.log("vat : ", vat);
		const format1 = (parseInt(total)).toLocaleString('ko-KR');
		const format2 = (parseInt(vat)).toLocaleString('ko-KR');
		row.find('.total-price').text(format1 + '원');
		row.find('.total-price1').val(parseInt(total));
		row.find('.vat').text(format2 + '원'); // 수량이 변경 될때마다 값이 변함
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
	    console.log("totalPr : ", totalPr);
	    $('input[name="foTotalAmt"]').val(parseInt(totalPr)); 
	    $('input[name="foTotal"]').val(parseInt(totalPr + totalVat)); 
	    $('input[name="totalVat"]').val(parseInt(totalVat)); 
	    const format2 = (parseInt(totalPr + totalVat)).toLocaleString('ko-KR');
	    const format3 = (parseInt(totalPr)).toLocaleString('ko-KR');
	    const format4 = (parseInt(totalPr/10)).toLocaleString('ko-KR');
	    $('#vat').text(format4 + '원'); // 총 부가세 업데이트
	    $('#totalPrice').text(format2 + '원'); 
	    $("#totalPr").text(format3+'원');
	}
	
	$(document).ready(function() {
		
		$('.form-check-input.allChecked:not(.checkAllInRow)').hide();
		
	    // 각 행의 첫 번째 체크박스를 클릭했을 때
	    $(document).on('click', '.checkAllInRow', function() {
	        // 해당 행에서 모든 체크박스를 가져옵니다.
	        let checkboxes = $(this).closest('tr').find('.form-check-input.allChecked');

	        // 첫 번째 체크박스의 상태에 따라 나머지 체크박스들의 상태를 설정합니다.
	        checkboxes.prop('checked', $(this).prop('checked'));
	    });
	});
	
	// allGdsChecked용
	$('#allGdsChecked').on("click", function() {
	        var checked = $('#allGdsChecked').is(':checked');
	        
	        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
	        $('.allGdsChecked').prop('checked', checked);
	});
	
	// allDtChecked용
	$('#allDtChecked').on("click", function() {
	        var checked = $('#allDtChecked').is(':checked');
	        
	        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
	        $('.allDtChecked').prop('checked', checked);
	});
	
	$(document).on("click",'#allChecked', function() {
        var checked = $('#allChecked').is(':checked');
        
        // 체크박스의 상태에 따라 모든 체크박스의 상태를 설정
        $('.allChecked').prop('checked', checked);
    });
	
	// 모달1 : 닫힐 때 실행되는 이벤트 핸들러
    $('#exampleModalScrollable1').on('hidden.bs.modal', function () {
    	$('input:checkbox').prop('checked', false);
    	$('.selGu').val('');
        // 모달이 닫힐 때 선택된 select 요소를 전체로 변경
    	let comcdGroupcd = $('.selGu').val();
    	let data =  {
				"comcdGroupcd":comcdGroupcd
			};
    	console.log("data : ", data);
    	ajax(data);
    });
	
	// 모달2 : 닫힐 때 실행되는 이벤트 핸들러
    $('#exampleModalScrollable2').on('hidden.bs.modal', function () {
    	$('input:checkbox').prop('checked', false);
    });
    
	// 모달3
    $('#exampleModalScrollable3').on('shown.bs.modal', function() {
        $('.hiddenChek').prop('checked', true);
	});
    $('#exampleModalScrollable3').on('hidden.bs.modal', function () { 
		$('input:checkbox').prop('checked', false);
	});
	
	// 커밋버튼
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
					let totalPrice = $("input[name='foTotal']").val();
					const format = parseInt(totalPrice).toLocaleString('ko-KR');
		            let gdsNm1 = $("input[name='frcorderDtlVOList[0].gdsNm']").val();
		            console.log("totalPrice : ", totalPrice);
		            console.log("gdsNm1 : ", gdsNm1);
		            console.log("format : ", format);
		            if (totalPrice === undefined) {
		                $(".ttp").text("총 결제금액 : 0원");
		            }else{
			            $(".ttp").text("총 결제금액 : " + format + "원");
		            }

		            $('#exampleModalCenter').modal('show'); // 모달 창 보이기
		            //구매자 정보
		            const user_email = "a";
		            const username = "b";
		            const gdsNm = gdsNm1;
		            const price = totalPrice;

		            // 여기에 JavaScript 코드 작성
		            const buyButton = document.getElementById('kakaoPay');
		            const buyButton2 = document.getElementById('toss');
		            const buyButton3 = document.getElementById('payco');
		            const buyButton4 = document.getElementById('uplus');

		            buyButton.addEventListener('click', () => kakaoPay(user_email, username));
		            buyButton2.addEventListener('click', () => toss(user_email, username));
		            buyButton3.addEventListener('click', () => payco(user_email, username));
		            buyButton4.addEventListener('click', () => uplus(user_email, username));

		            var IMP = window.IMP;

		            var timestamp = new Date().getTime();
		            var makeMerchantUid = `IMP\${timestamp}`;
		            console.log("timestamp : ", timestamp);
		            console.log("makeMerchantUid : ", makeMerchantUid);
		            
		            // 카카오페이
		            function kakaoPay(useremail, username) {
		                IMP.init("imp03332385"); // 가맹점 식별코드
		                IMP.request_pay({
		                    pg: 'kakaopay', // PG사 코드표에서 선택
		                    pay_method: 'card', // 결제 방식
		                    merchant_uid: makeMerchantUid, // 결제 고유 번호
		                    name: gdsNm1 + ' 외', // 제품명
		                    amount: price, // 가격
		                    //구매자 정보 ↓
		                    buyer_email: `${useremail}`,
		                    buyer_name: `${username}`
		                    // buyer_tel : '010-1234-5678',
		                    // buyer_addr : '서울특별시 강남구 삼성동',
		                    // buyer_postcode : '123-456'
		                }, function (rsp) { // callback
		                    if (rsp.success) { //결제 성공시
		                        console.log(rsp);
		                        Swal.fire('발주처리가 완료되었습니다.', '', 'success');
		                        setTimeout(function () {
		                            $("#frm").submit();
		                        }, 1500);
		                    } else { // 결제 실패시
		                        alert(rsp.error_msg);
		                    }
		                });
		            }
		            
		            // 토스
		            function toss(useremail, username) {
		                IMP.init("imp03332385"); // 가맹점 식별코드
		                IMP.request_pay({
		                    pg: 'tosspay', // PG사 코드표에서 선택
		                    pay_method: 'card', // 결제 방식
		                    merchant_uid: makeMerchantUid, // 결제 고유 번호
		                    name: gdsNm1 + ' 외', // 제품명
		                    amount: price, // 가격
		                    //구매자 정보 ↓
		                    buyer_email: `${useremail}`,
		                    buyer_name: `${username}`
		                    // buyer_tel : '010-1234-5678',
		                    // buyer_addr : '서울특별시 강남구 삼성동',
		                    // buyer_postcode : '123-456'
		                }, function (rsp) { // callback
		                    if (rsp.success) { //결제 성공시
		                        console.log(rsp);
		                        Swal.fire('발주처리가 완료되었습니다.', '', 'success');
		                        setTimeout(function () {
		                            $("#frm").submit();
		                        }, 1500);
		                    } else { // 결제 실패시
		                        alert(rsp.error_msg);
		                    }
		                });
		            }
		            
		            // 페이코
		            function payco(useremail, username) {
		                IMP.init("imp03332385"); // 가맹점 식별코드
		                IMP.request_pay({
		                    pg: 'payco', // PG사 코드표에서 선택
		                    pay_method: 'card', // 결제 방식
		                    merchant_uid: makeMerchantUid, // 결제 고유 번호
		                    name: gdsNm1 + ' 외', // 제품명
		                    amount: price, // 가격
		                    //구매자 정보 ↓
		                    buyer_email: `${useremail}`,
		                    buyer_name: `${username}`
		                    // buyer_tel : '010-1234-5678',
		                    // buyer_addr : '서울특별시 강남구 삼성동',
		                    // buyer_postcode : '123-456'
		                }, function (rsp) { // callback
		                    if (rsp.success) { //결제 성공시
		                        console.log(rsp);
		                        Swal.fire('발주처리가 완료되었습니다.', '', 'success');
		                        setTimeout(function () {
		                            $("#frm").submit();
		                        }, 1500);
		                    } else { // 결제 실패시
		                        alert(rsp.error_msg);
		                    }
		                });
		            }
		            
		            // 카드결제
		            function uplus(useremail, username) {
		                IMP.init("imp03332385"); // 가맹점 식별코드
		                IMP.request_pay({
		                    pg: 'uplus', // PG사 코드표에서 선택
		                    pay_method: 'card', // 결제 방식
		                    merchant_uid: makeMerchantUid, // 결제 고유 번호
		                    name: gdsNm1 + ' 외', // 제품명
		                    amount: price, // 가격
		                    //구매자 정보 ↓
		                    buyer_email: `${useremail}`,
		                    buyer_name: `${username}`
		                    // buyer_tel : '010-1234-5678',
		                    // buyer_addr : '서울특별시 강남구 삼성동',
		                    // buyer_postcode : '123-456'
		                }, function (rsp) { // callback
		                    if (rsp.success) { //결제 성공시
		                        console.log(rsp);
		                        Swal.fire('발주처리가 완료되었습니다.', '', 'success');
		                        setTimeout(function () {
		                            $("#frm").submit();
		                        }, 1500);
		                    } else { // 결제 실패시
		                        alert(rsp.error_msg);
		                    }
		                });
		            }
			    }
			});
	});
	
	// "제거" 버튼 클릭 시 선택된 행을 제거하는 기능 추가
	$("#removeBtn").on("click", function() {
	    // 선택된 체크박스를 찾아서 그에 해당하는 행을 제거
	    $(".allChecked:checked").each(function() {
	        $(this).closest("tr").remove(); // 선택된 체크박스의 부모인 tr을 찾아서 제거
	    });
	    $('#allChecked').prop('checked', false);
	    updateTotalPrice();
	});
	
	$(document).on("click", ".cartCheck", function() {
	    if ($(this).is(":checked")) {
	        let cartNo = $(this).val();
	        console.log("cartNo : ", cartNo);
	        let data = {
	        	"cartNo":cartNo
	        }
	        $.ajax({
				url:"/frcorder/getCartDtl",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
				    console.log("result : ", result);
				    $.each(result, function(idx, cartDtVO){
				    	let gds = {
								gdsNo : cartDtVO.gdsNo,
								gdsNm : cartDtVO.cdtlGdsNm,
								price: cartDtVO.cdtlNtslAmt,
								qnt : cartDtVO.cdtlQnt
							};
				    	console.log("gds : ", gds);
				    	selectCart.push(gds);
						console.log("selectCart : ", selectCart);
				    });
				}
	        });
	    }
	});
	
	function updateSelectedGds(){
		console.log("selectCart : ", selectCart);
		if (selectCart.length === 0) {
			let selectGds = [];
			$('.form-check-input:checked').each(function(){
				let gds = {
					gdsNo : $(this).val(),
					gdsNm : this.dataset.name,
					price: this.dataset.price
				};
				if (this.dataset.qnt !== undefined) {
				    gds.qnt = this.dataset.qnt;
				}
				console.log("gds : ", gds);
				selectGds.push(gds);
				console.log("selectGds : ", selectGds);
			});
			return selectGds;
		}
		return selectCart;
	};
	const datatablesSimple = document.getElementById('datatablesSimple4');
    if (datatablesSimple) { 
        new simpleDatatables.DataTable(datatablesSimple,{
        	  sortable:false,
        	  perPage:5, 
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
    
	const datatablesSimple5 = document.getElementById('datatablesSimple5');
    if (datatablesSimple5) { 
        new simpleDatatables.DataTable(datatablesSimple5,{
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
    
    const datatablesSimple6 = document.getElementById('insufStock');
    if (datatablesSimple6) { 
        new simpleDatatables.DataTable(datatablesSimple6,{
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
				<div class="row gx-3 mb-3 d-flex justify-content-center">
						<div class="col-md-4">
							<label class="small mb-1">지역</label> 
							<input class="form-control form-control-solid" type="text" value="${getFranchiseVO.comcdCdnm}" readonly>
						</div>
						<div class="col-md-4">
							<label class="small mb-1">가맹점명</label> 
							<input class="form-control form-control-solid" type="text" value="${getFranchiseVO.frcsNm}" readonly>
						</div>
					</div>
					<div class="row gx-3 mb-3 d-flex justify-content-center">
						<div class="col-md-4">
							<label class="small mb-1" for="">배송지</label> <input readonly
								class="form-control form-control-solid" id="deliveryAddress" type="text"
								value="${getFranchiseVO.frcsAddr}">
						</div>
						<div class="col-md-4">
							<label class="small mb-1" for="">납기요청일</label> <input
								class="form-control" id="deliDt" type="date" name="">
						</div>
					</div>
					<div class="row gx-3 mb-4 d-flex justify-content-center">
						<div class="col-md-8 mb-3">
							<label class="small mb-1" for="">전달사항</label> <input
								class="form-control" id="request" type="text" value="">
						</div>
						<input type="hidden" name="frcsNo" value="${getFranchiseVO.frcsNo}">
					</div>
					<hr>
					<form action="/frcorder/createPost?${_csrf.parameterName}=${_csrf.token}" method="post" id="frm"
						name="frm">
						<div
							class="datatable-wrapper datatable-loading no-footer sortable fixed-columns">
							<div class="datatable-container">
<!-- 								<div> -->
<!-- 									전체<input type="checkbox" id="allChecked"> -->
<!-- 								</div> -->
							<div class="mb-4">
								<!-- 품목 모달 버튼 -->
								<button class="btn btn-outline-blue" type="button" data-bs-toggle="modal"
									data-bs-target="#exampleModalScrollable1">품목</button>
								
								<!-- 거래내역 모달 버튼 -->
								<button class="btn btn-outline-blue" type="button" data-bs-toggle="modal"
									data-bs-target="#exampleModalScrollable2">거래내역</button>	
									
								<!-- 미달품목 모달 버튼 -->
								<button class="btn btn-outline-blue" type="button" data-bs-toggle="modal"
									data-bs-target="#exampleModalScrollable3">미달품목</button>	
							</div>
								<table id="datatablesSimple1" class="datatable-table">
									<thead>
										<tr>
											<th data-sortable="true" style="width: 5.35933147632312%;"><a
												href="#" class="datatable-sorter"></a></th>
											<th data-sortable="true" style="width: 15.35933147632312%;"><a
												href="#" class="datatable-sorter">품목코드</a></th>
											<th data-sortable="true" style="width: 15.573816155988858%;"><a
												href="#" class="datatable-sorter">품목명</a></th>
											<th data-sortable="true" style="width: 7.788300835654596%;"><a
												href="#" class="datatable-sorter">단가</a></th>
											<th data-sortable="true" style="width: 8.788300835654596%;"><a
												href="#" class="datatable-sorter">수량</a></th>
											<th data-sortable="true" style="width: 10.35933147632312%;"><a
												href="#" class="datatable-sorter">공급가액</a></th>
											<th data-sortable="true" style="width: 10.35933147632312%;"><a
												href="#" class="datatable-sorter">부가세</a></th>
											<th data-sortable="true" style="width: 5.35933147632312%;"><a
												href="#" class="datatable-sorter">합계</a></th>
										</tr>
									</thead>
									<tbody>
										<tr data-index="0">
											<td></td>
											<td></td>
											<td></td>
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
				<h5 class="modal-title" id="exampleModalScrollableTitle1">품목</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<!-- 품목 테이블 생성 -->
			<div class="modal-body" id="modal-body-gds">
				<select class="form-control selGu" style="width: 100px;">
					<option class="all" value="" selected>전체</option>
					<c:forEach var="gdsGu" items="${gdsGuList}" varStatus="stat">
						<option value="${gdsGu.comcdGroupcd}">${gdsGu.comcdCdnm}</option>
					</c:forEach>
				</select>
				<div class="modal-body-body">
					<table id="datatablesSimple4">
						<thead>
							<tr>
								<th data-sortable="true" style="width: 5.35933147632312%;"><a
									href="#" class="datatable-sorter"></a></th>
								<th data-sortable="true" style="width: 15.35933147632312%;"><a
									href="#" class="datatable-sorter">품목코드</a></th>
								<th data-sortable="true" style="width: 15.573816155988858%;"><a
									href="#" class="datatable-sorter">품목명</a></th>
								<th data-sortable="true" style="width: 7.788300835654596%;"><a
									href="#" class="datatable-sorter">단가</a></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="gdsVO" items="${gdsVOList}" varStatus="stat">
								<tr data-index="0">
									<td><input class='form-check-input allGdsChecked'
										type='checkbox' value="${gdsVO.gdsNo}"
										data-name="${gdsVO.gdsNm}" data-price="${gdsVO.gdsNtslAmt}"></td>
									<td>${gdsVO.gdsNo}</td>
									<td>${gdsVO.gdsNm}</td>
									<td>${gdsVO.gdsNtslAmt}원</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="modal-footer">
				<button class="btn btn-primary addSelectedGds" type="button">추가</button>
				<button class="btn btn-secondary" type="button"
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
				<h5 class="modal-title" id="exampleModalScrollableTitle2">가맹점 별
					거래내역</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<!-- 거래내역 테이블 생성 -->
			<div class="modal-body" id="modal-body-frcorderDt"></div>

			<div class="modal-footer">
				<button class="btn btn-primary addSelectedGds" type="button">추가</button>
				<button class="btn btn-secondary modal-close" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 미달품목 모달 -->
<div class="modal fade" id="exampleModalScrollable3" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalScrollableTitle3"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-lg"
		role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalScrollableTitle3">미달품목</h5>
				<button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="modal-body-insufStock">
			<table id="insufStock">
					<thead>
						<tr>
							<th>품목코드</th>
							<th>품목명</th>
							<th>품목그룹</th>
							<th>재고수량</th>
							<th>최소재고수량</th>
							<th>미달수량</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="frcsStockVO" items="${insufStockList}" varStatus="stat">
							<tr>
								<td>${frcsStockVO.gdsNo}</td>
								<td>${frcsStockVO.gdsNm}</td>
								<td>${frcsStockVO.comcdCdnm}</td>
								<td>${frcsStockVO.frcssCnt}</td>
								<td>${frcsStockVO.minGdsStock}</td>
								<td>${frcsStockVO.frcssCnt - frcsStockVO.minGdsStock}</td>
							</tr>
							<input class="form-check-input hiddenChek" type="checkbox" value="${frcsStockVO.gdsNo}" data-name="${frcsStockVO.gdsNm}" data-price="${frcsStockVO.gdsNtslAmt}" data-qnt="${frcsStockVO.minGdsStock - frcsStockVO.frcssCnt}">
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="modal-footer">
				<button class="btn btn-primary addSelectedGds" type="button">추가</button>
				<button class="btn btn-secondary modal-close" type="button"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">결제 수단 선택</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            	<div class="row">
					<div id="kakaoPay" class="form-control" style="width: 150px; height: 60px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; margin-right: 10px; margin-left: 10px; margin-bottom: 10px;">
						<img src="/resources/img/kakao.png" style="width: 100%;height: auto;"> <!-- 결제하기 버튼 생성 -->
					</div> 
					<div id="toss" class="form-control" style="width: 150px; height: 60px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; margin-right: 10px; margin-bottom: 10px;">
						<img src="/resources/img/logo-toss-pay.svg" style="width: 100%;height: auto;"> <!-- 결제하기 버튼 생성 -->
					</div>	
					<div class="form-control" style="width: 150px; height: 60px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; margin-bottom: 10px;">
						<img src="/resources/img/logo_navergr_large.svg" style="width: 100%;height: auto;"> <!-- 결제하기 버튼 생성 -->
					</div>	
				</div>
				<div class="row">
					<div id="payco" class="form-control" style="width: 150px; height: 60px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; overflow: hidden; margin-left: 10px; margin-right: 10px;">
					    <img src="/resources/img/payco2.svg" style="width: 100%; height: 100%;">
					</div>
					<div class="form-control" style="width: 150px; height: 60px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
					    <img src="/resources/img/icons8-구글-페이-192.svg" style="width: 40%; height: auto;">
					    <span style="margin-left: 5px;"></span>
					</div>
					<div id="uplus" class="form-control" style="width: 150px; height: 60px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center;">
					    <img src="/resources/img/card.svg" style="width: 40%; height: auto;">
					    <span style="margin-left: 5px;">신용카드</span>
					</div>
				</div>
            </div>
			<div class="modal-footer">
				<div class="ttp"></div>
			</div>
		</div>
    </div>
</div>
