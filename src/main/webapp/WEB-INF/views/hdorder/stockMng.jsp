<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0/dist/chartjs-plugin-datalabels.min.js"
	crossorigin="anonymous"></script>
<style>
#wrhsStock::before {
	content: none; /* 내용을 비워 가상 요소를 숨김 */
}

#stockTable td:nth-child(4), #stockTable td:nth-child(5), #stockTable td:nth-child(6),
	#stockTable td:nth-child(7), #mainTable2 td:nth-child(4),
	#mainTable2 td:nth-child(5), #mainTable2 td:nth-child(6),
	#mainTable2 td:nth-child(7), #mainTable td:nth-child(4), #mainTable td:nth-child(5), #mainTable td:nth-child(6),
	#mainTable td:nth-child(7), #table td:nth-child(4), #table td:nth-child(5), #table td:nth-child(6),
	#table td:nth-child(7) {
	text-align: right;
}

#stockTable td:nth-child(3), #mainTable2 td:nth-child(8), #mainTable td:nth-child(3){
	text-align: center;
}
</style>
<script type="text/javascript">
$(function(){
// 	let tbody = $("#stockTable tbody");
	
	selGdsGu();
	
	//전체 or 구분 별 상품 목록
	function selGdsGu() {
		$(".selGu").on("click", function() {
			
			let comcdGroupcd = $(this).val();
			
			console.log(comcdGroupcd);
			
			let data = {
					"comcdGroupcd":comcdGroupcd
				}
	
			console.log("data : ", data);
			
			ajax(data);
			
			$(".datatable-bottom").html('');
		});
	}
	
	// 구분 별 상품 목록 ajax
	function ajax(data){
		$.ajax({
			url:"/hdorder/getAllGdsGu",
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
			    str += "<table  id='mainTable'>";
				str += "<thead>";
				str += "<tr>";
				str += "<th>품목코드</th><th>품목명</th><th>품목그룹</th><th>재고수량(a)</th><th>최소재고수량(b)</th><th>발주필요수량(a-b)</th><th>안전재고수량(a-b)</th><th>거래처</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				$.each(result, function(idx, gdsVO) {
					str += "<tr>";
					str += "<td>" + gdsVO.gdsNo + "</td>";
					str += "<td>" + gdsVO.gdsNm + "</td>";
					str += "<td>" + gdsVO.comcdCdnm + "</td>";
					str += "<td>" + gdsVO.gdsStock + "</td>";
					str += "<td>" + gdsVO.minGdsStock + "</td>";
					if(gdsVO.gdsStock < gdsVO.minGdsStock){
						str += `<td><div style='color: red'>\${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
							<td></td>`
					}
					if(gdsVO.gdsStock > gdsVO.minGdsStock){
						str += `
						<td></td>
						<td><div style="color: blue">\${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
							`
					}
					if(gdsVO.gdsStock == gdsVO.minGdsStock){
						str += `
						<td>0</td>
						<td>0</td>
							`
					}
					str += "<td>" + gdsVO.cnptNm + "</td>";
					str += "</tr>";
				});
					str += "</tbody>";
					str += "</table>";
					$(".mainTable").html(str); 
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
		};
		
		$(".btnWrhs").on("click", function(){
			let wrhsNo = $(this).val();
			console.log("wrhsNo : ", wrhsNo);
			
			let data = {
				"wrhsNo":wrhsNo
			}
			$.ajax({
				url:"/hdorder/getWrhsGds",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
				    console.log("result : ", result);
				    let total = 0;
				    let totalMin = 0;
				    let needStock = 0;
				    let safeStock = 0;
				    let str = "";
				    str += `
						<table id="table">
						<thead>
							<tr>
								<th data-sortable="true"><a href="#">품목코드</a></th>
								<th data-sortable="true"><a href="#">품목명</a></th>
								<th data-sortable="true"><a href="#">품목그룹</a></th>
								<th data-sortable="true"><a href="#">재고수량(a)</a></th>
								<th data-sortable="true"><a href="#">최소재고수량(b)</a></th>
								<th data-sortable="true"><a href="#">발주필요수량(a-b)</a></th>
								<th data-sortable="true"><a href="#">안전재고수량(a-b)</a></th>
								<th data-sortable="true"><a href="#">창고번호</a></th>
							</tr>
						</thead>
						<tbody>
					`;
				    $.each(result, function(idx, gdsVO){
				    	total += gdsVO.gdsStock;
						totalMin += gdsVO.minGdsStock;
						if(gdsVO.gdsStock <= gdsVO.minGdsStock){
							needStock += (gdsVO.gdsStock - gdsVO.minGdsStock);
						}else if (gdsVO.gdsStock > gdsVO.minGdsStock) {
							safeStock += (gdsVO.gdsStock - gdsVO.minGdsStock);
				    	}
				    	str += "<tr>";
				    	str += "<td>" + gdsVO.gdsNo + "</td>";
				    	str += "<td>" + gdsVO.gdsNm + "</td>";
				    	str += "<td>" + gdsVO.comcdCdnm + "</td>";
				    	str += "<td>" + gdsVO.gdsStock + "</td>";
				    	str += "<td>" + gdsVO.minGdsStock + "</td>";

				    	if (gdsVO.gdsStock < gdsVO.minGdsStock) {
				    	    str += "<td><div style='color: red'>" + (gdsVO.gdsStock - gdsVO.minGdsStock) + "</div></td>";
				    	    str += "<td></td>";
				    	} else if (gdsVO.gdsStock > gdsVO.minGdsStock) {
				    	    str += "<td></td>";
				    	    str += "<td><div style='color: blue'>" + (gdsVO.gdsStock - gdsVO.minGdsStock) + "</div></td>";
				    	} else if (gdsVO.gdsStock == gdsVO.minGdsStock) {
				    	    str += "<td>0</td>";
				    	    str += "<td>0</td>";
				    	}

				    	str += "<td>" + gdsVO.wrhsNo + "</td>";
				    	str += "</tr>";
				    });
			    	str += `
					</tbody>
					</table>
			    	`;
				    $(".stockWrhs").html(str);
				    
				    const datatablesSimple3 = document.getElementById('table');
				    if (datatablesSimple3) { 
				        new simpleDatatables.DataTable(datatablesSimple3,{
				        	  perPate:5,
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
				    
				}
			});
			
		});
		
		$("#insufStock").on("click", function(){
			let data = {
				param:"param"
			}
			$.ajax({
				url:"/hdorder/insufStock",
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
					$.each(result, function(idx, gdsVO) {
						str += "<tr>";
						str += "<td>" + gdsVO.gdsNo + "</td>";
						str += "<td>" + gdsVO.gdsNm + "</td>";
						str += "<td>" + gdsVO.comcdCdnm + "</td>";
						str += "<td>" + gdsVO.gdsStock + "</td>";
						str += "<td>" + gdsVO.minGdsStock + "</td>";
						if(gdsVO.gdsStock < gdsVO.minGdsStock){
							str += `<td><div style='color: red'>\${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
							<td></td>`
						}
						str += "<td>" + gdsVO.cnptNm + "</td>";
						str += "</tr>";
					});
						$("#stockTable tbody").html(str);
						$("#mainTable tbody").html(str);
						row += "<button class='btn btn-outline-blue me-1' type='button' id='orderLink'>발주페이지 이동</button>"
						$('.datatable-bottom').addClass("d-flex justify-content-end");
						$('.datatable-bottom').html(row); 
				}
			});
		});
		
		$(document).on("click","#orderLink", function(){
			location.href = "/hdorder/create";
		});
		
		const mainTable2 = document.getElementById('mainTable2');
	    if (mainTable2) { 
	        new simpleDatatables.DataTable(mainTable2,{
	        	  perPage : 10,
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
		const datatablesSimple = document.getElementById('stockTable');
	    if (datatablesSimple) { 
	        new simpleDatatables.DataTable(datatablesSimple,{
	        	  perPage : 10,
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
	    
	    let countTotalA = $("input[name=countTotalA]").val();
	    let countTotalB = $("input[name=countTotalB]").val();
	    let countTotalC = $("input[name=countTotalC]").val();
	    let countTotalD = $("input[name=countTotalD]").val();
	    let countTotalE = $("input[name=countTotalE]").val();
	    const ctx1 = document.querySelector('#myBarChart1').getContext('2d');
		const myBarChart1 = new Chart(ctx1, {
		    type: 'bar',
		    data: {
		        labels: ['채소류', '과일류', '육류', '어패류', '기타식품'],
		        datasets: [{
		            data: [countTotalA,countTotalB,countTotalC,countTotalD,countTotalE],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.5)',
		                'rgba(54, 162, 235, 0.5)',
		                'rgba(255, 206, 86, 0.5)',
		                'rgba(75, 192, 192, 0.5)',
		                'rgba(153, 102, 255, 0.5)',
		            ]
		        }]
		    },
		    options: {
		    	responsive: true, // 반응형 설정
		        maintainAspectRatio: false, // 가로 세로 비율 유지 설정
		    	legend: {
		            display: false
		        },
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true,
		                    precision: 0 // 소수점 자리 수 설정
		                }
		            }]
		        },
		        barThickness: 'flex', // 혹은 원하는 두께 설정
		        minBarLength: 1 // 최소 높이 설정
		    }
		});
		
		let countTotalPriceA = $("input[name=countTotalPriceA]").val();
	    let countTotalPriceB = $("input[name=countTotalPriceB]").val();
	    let countTotalPriceC = $("input[name=countTotalPriceC]").val();
	    let countTotalPriceD = $("input[name=countTotalPriceD]").val();
	    let countTotalPriceE = $("input[name=countTotalPriceE]").val();
	    const ctx2 = document.querySelector('#myBarChart2').getContext('2d');
		const myBarChart2 = new Chart(ctx2, {
		    type: 'bar',
		    data: {
		        labels: ['채소류', '과일류', '육류', '어패류', '기타식품'],
		        datasets: [{
		            data: [countTotalPriceA, countTotalPriceB, countTotalPriceC, countTotalPriceD, countTotalPriceE],
		            backgroundColor: [
		            	'rgba(255, 99, 132, 0.5)',
		                'rgba(54, 162, 235, 0.5)',
		                'rgba(255, 206, 86, 0.5)',
		                'rgba(75, 192, 192, 0.5)',
		                'rgba(153, 102, 255, 0.5)'
		            ]
		        }]
		    },
		    options: {
		    	responsive: true, // 반응형 설정
		        maintainAspectRatio: false, // 가로 세로 비율 유지 설정
		    	legend: {
		            display: false
		        },
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true,
		                    callback: function(value) {
		                        return value.toLocaleString(); // 숫자를 천 단위로 포맷팅
		                    }
		                }
		            }]
		        },
		        barThickness: 'flex', // 혹은 원하는 두께 설정
		        minBarLength: 1 // 최소 높이 설정
		    }
		});
});
</script>
<header
	class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
	<div class="container-fluid px-4">
		<div class="page-header-content">
			<div class="row align-items-center justify-content-between pt-3">
				<div class="col-auto mb-3">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-list">
								<line x1="8" y1="6" x2="21" y2="6"></line>
								<line x1="8" y1="12" x2="21" y2="12"></line>
								<line x1="8" y1="18" x2="21" y2="18"></line>
								<line x1="3" y1="6" x2="3.01" y2="6"></line>
								<line x1="3" y1="12" x2="3.01" y2="12"></line>
								<line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
						</div>
						재고관리
					</h1>
				</div>
				<div class="col-12 col-xl-auto mb-3"></div>
			</div>
		</div>
	</div>
</header>
<div class="container-xl px-1">
	<div class="row">
		<div class="col-xxl-5 col-xl-5 mb-4">
			<div class="card card-header-actions h-100">
				<div class="card-header">
					<b>유형별 재고수량</b>
				</div>
				<div class="card-body" style="height: 320px">
					<div class="chart-bar">
						<canvas id="myBarChart1" width="639" height="280"></canvas>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xxl-4 col-xl-4 mb-4">
			<div class="card card-header-actions h-100">
				<div class="card-header">
					<b>유형별 재고금액</b>
				</div>
				<div class="card-body" style="height: 320px">
					<div class="chart-bar">
						<canvas id="myBarChart2" width="639" height="280"></canvas>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xxl-3 col-xl-3 mb-4">
			<div class="card border-start-lg border-start-primary card-header-actions h-50 mb-2">
				<div class="card-header">
					<div class="col-auto">
						<div class="small" style="font-size: 1.0em">
							<b>총 재고수량(EA)</b>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="me-3">
						<div class="col-auto d-flex justify-content-center align-items-center" style="margin-top: 20px">
							<fmt:formatNumber value="${countTotal}" pattern="#,###" var="formatNumber" />
							<b style="text-align: center; font-size: 1.5em">${formatNumber}EA</b>
						</div>
						<div style="font-size: 0.75em; text-align: center">
							(채소류 + 과일류 + 육류 + 어패류 + 기타식품)
						</div>
					</div>
				</div>
			</div>
			<div class="card border-start-lg border-start-primary card-header-actions h-50 mb-2">
				<div class="card-header">
					<div class="col-auto">
						<div class="small" style="font-size: 1.0em">
							<b>총 재고 금액(원)</b>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="me-3">
						<div class="col-auto d-flex justify-content-center align-items-center" style="margin-top: 20px;">
							<fmt:formatNumber value="${countTotalPrice}" pattern="#,###" var="formatNumber1" />
							<b style="text-align: center; font-size: 1.5em">${formatNumber1}원</b>
						</div>
						<div style="font-size: 0.75em; text-align: center">
							(재고수량 * 품목단가)의 총합
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="card mb-4" style="min-height:500px">
		 <div class="card-header border-bottom">
            <ul class="nav nav-tabs card-header-tabs" id="dashboardNav" role="tablist">
                <li class="nav-item me-1" role="presentation">
                    <a class="nav-link active" id="stock-tab" data-bs-toggle="tab" href="#stock" role="tab" aria-controls="stock" aria-selected="true">품목별 재고현황</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="wrhsStock-tab" data-bs-toggle="tab" href="#wrhsStock" role="tab" aria-controls="wrhsStock" aria-selected="false">창고별 재고현황</a>
                </li>
            </ul>
        </div>
		<div class="card-body">
			<div class="tab-content" id="dashboardNavContent">
				<!-- 품목별 재고현황 -->
				  <div class="tab-pane fade show active" id="stock" role="tabpanel" aria-labelledby="stock-tab">
					<div class="datatable-top"
						style="display: flex; align-items: center;">
						<c:forEach var="gdsGu" items="${gdsGuList}" varStatus="stat">
							<c:if test="${gdsGu.comcdCdnm == '채소류'}">
								　<button class="form-control  selGu" type="button"
									value="${gdsGu.comcdGroupcd}">${gdsGu.comcdCdnm}(${countA})</button>　
							</c:if>
							<c:if test="${gdsGu.comcdCdnm == '과일류'}">
								<button class="form-control selGu" type="button"
									value="${gdsGu.comcdGroupcd}">${gdsGu.comcdCdnm}(${countB})</button>　
							</c:if>
							<c:if test="${gdsGu.comcdCdnm == '육류'}">
								<button class="form-control selGu" type="button"
									value="${gdsGu.comcdGroupcd}">${gdsGu.comcdCdnm}(${countC})</button>　
							</c:if>
							<c:if test="${gdsGu.comcdCdnm == '어패류'}">
								<button class="form-control selGu" type="button"
									value="${gdsGu.comcdGroupcd}">${gdsGu.comcdCdnm}(${countD})</button>　
							</c:if>
							<c:if test="${gdsGu.comcdCdnm == '기타 식품'}">
								<button class="form-control selGu" type="button"
									value="${gdsGu.comcdGroupcd}">${gdsGu.comcdCdnm}(${countE})</button>　
							</c:if>
						</c:forEach>
						<c:if test="${needStock > 0}">
							<button class="btn btn-danger form-control" type="button"
								id="insufStock">미달품목(${needStock})</button>
						</c:if>
						<c:if test="${needStock == 0}">
							<button class="btn btn-danger form-control" type="button"
								id="zeroStock" data-bs-toggle="tooltip"
								data-bs-placement="right" title="미달된 품목이 없습니다.">미달품목(${needStock})</button>
						</c:if>
					</div>
					<!-- 품목별 재고현황 테이블 및 데이터 출력 -->
					<div class="mainTable">
						<table id="stockTable">
							<thead>
								<tr>
									<th data-sortable="true"><a href="#">품목코드</a></th>
									<th data-sortable="true"><a href="#">품목명</a></th>
									<th data-sortable="true"><a href="#">품목그룹</a></th>
									<th data-sortable="true"><a href="#">재고수량(a)</a></th>
									<th data-sortable="true"><a href="#">최소재고수량(b)</a></th>
									<th data-sortable="true"><a href="#">발주필요수량(a-b)</a></th>
									<th data-sortable="true"><a href="#">안전재고수량(a-b)</a></th>
									<th data-sortable="true"><a href="#">거래처</a></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="gdsVO" items="${gdsVOList}" varStatus="stat">
									<c:if test="${gdsVO.comcdCdnm == '채소류'}">
										<tr data-index="0">
											<td>${gdsVO.gdsNo}</td>
											<td>${gdsVO.gdsNm}</td>
											<td>${gdsVO.comcdCdnm}</td>
											<td>${gdsVO.gdsStock}</td>
											<td>${gdsVO.minGdsStock}</td>
											<c:if test="${gdsVO.gdsStock < gdsVO.minGdsStock}">
												<td><div style="color: red">${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
												<td></td>
											</c:if>
											<c:if test="${gdsVO.gdsStock > gdsVO.minGdsStock}">
												<td></td>
												<td><div style="color: blue">${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
											</c:if>
											<c:if test="${gdsVO.gdsStock == gdsVO.minGdsStock}">
												<td>0</td>
												<td>0</td>
											</c:if>
											<td>${gdsVO.cnptNm}</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			<!-- 창고별 재고현황 -->
			<div class="tab-pane fade" id="wrhsStock" role="tabpanel"
				aria-labelledby="activities-pill1">
				<div class="datatable-top" style="display: flex; align-items: center;">
						　<button type="button" class="form-control btnWrhs" value="">전체</button>　
						<c:forEach var="wrhsNo" items="${wrhsNoSet}" varStatus="stat">
							<button type="button" class="form-control btnWrhs"
								value="${wrhsNo}" data-cnt="${stat.count}">${stat.count}번
								창고</button>　
						</c:forEach>
				</div>
				<div class="datatable-container stockWrhs">
					<table id="mainTable2">
						<thead>
							<tr>
								<th data-sortable="true"><a href="#">품목코드</a></th>
								<th data-sortable="true"><a href="#">품목명</a></th>
								<th data-sortable="true"><a href="#">품목그룹</a></th>
								<th data-sortable="true"><a href="#">재고수량(a)</a></th>
								<th data-sortable="true"><a href="#">최소재고수량(b)</a></th>
								<th data-sortable="true"><a href="#">발주필요수량(a-b)</a></th>
								<th data-sortable="true"><a href="#">안전재고수량(a-b)</a></th>
								<th data-sortable="true"><a href="#">창고번호</a></th>
							</tr>
						</thead>
						<tbody>
							<c:set var="totalStock" value="0" />
							<c:set var="totalMinStock" value="0" />
							<c:set var="needStock" value="0" />
							<c:set var="safeStock" value="0" />
							<c:forEach var="gdsVO" items="${gdsVOList}" varStatus="stat">
								<c:set var="totalStock" value="${totalStock + gdsVO.gdsStock}" />
								<c:set var="totalMinStock"
									value="${totalMinStock + gdsVO.minGdsStock}" />
								<c:if test="${gdsVO.gdsStock <= gdsVO.minGdsStock}">
									<c:set var="needStock"
										value="${needStock + (gdsVO.gdsStock - gdsVO.minGdsStock)}" />
								</c:if>
								<c:if test="${gdsVO.gdsStock > gdsVO.minGdsStock}">
									<c:set var="safeStock"
										value="${safeStock + (gdsVO.gdsStock - gdsVO.minGdsStock)}" />
								</c:if>
								<tr data-index="${stat.index}">
									<td>${gdsVO.gdsNo}</td>
									<td>${gdsVO.gdsNm}</td>
									<td>${gdsVO.comcdCdnm}</td>
									<td>${gdsVO.gdsStock}</td>
									<td>${gdsVO.minGdsStock}</td>
									<c:if test="${gdsVO.gdsStock < gdsVO.minGdsStock}">
										<td><div style="color: red;">${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
										<td></td>
									</c:if>
									<c:if test="${gdsVO.gdsStock > gdsVO.minGdsStock}">
										<td></td>
										<td><div style="color: blue">${gdsVO.gdsStock - gdsVO.minGdsStock}</div></td>
									</c:if>
									<c:if test="${gdsVO.gdsStock == gdsVO.minGdsStock}">
										<td>0</td>
										<td>0</td>
									</c:if>
									<td>${gdsVO.wrhsNo}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<!-- 각 음식구분의 재고 합 -->
<input name="countTotalA" type="hidden" value="${countTotalA}">
<input name="countTotalB" type="hidden" value="${countTotalB}">
<input name="countTotalC" type="hidden" value="${countTotalC}">
<input name="countTotalD" type="hidden" value="${countTotalD}">
<input name="countTotalE" type="hidden" value="${countTotalE}">

<!-- 각 음식구분의 합 -->
<input name="countTotalPriceA" type="hidden" value="${countTotalPriceA}">
<input name="countTotalPriceB" type="hidden" value="${countTotalPriceB}">
<input name="countTotalPriceC" type="hidden" value="${countTotalPriceC}">
<input name="countTotalPriceD" type="hidden" value="${countTotalPriceD}">
<input name="countTotalPriceE" type="hidden" value="${countTotalPriceE}">
