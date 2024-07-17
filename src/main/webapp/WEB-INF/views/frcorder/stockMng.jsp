<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0/dist/chartjs-plugin-datalabels.min.js" crossorigin="anonymous"></script>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
#stockTable td:nth-child(3),#mainTable td:nth-child(3){
	text-align: center;
}	
#stockTable td:nth-child(4),#stockTable td:nth-child(5),#stockTable td:nth-child(6),#stockTable td:nth-child(7){
	text-align: right;
}
#mainTable td:nth-child(4),#mainTable td:nth-child(5),#mainTable td:nth-child(6),#mainTable td:nth-child(7){
	text-align: right;
}
</style>
<script type="text/javascript">
$(function(){
	let tbody = $("#stockTable tbody");
	let frcsNo = $("input[name=hiddenFrcsNo]").val();
	console.log("frcsNo : ", frcsNo);
	selGdsGu();
	
	//전체 or 구분 별 상품 목록
	function selGdsGu() {
		$(".selGu").on("click", function() {
			
			let comcdGroupcd = $(this).val();
			
			console.log(comcdGroupcd);
			
			let data = {
					"comcdGroupcd":comcdGroupcd,
					"frcsNo" : frcsNo
				}
	
			console.log("data : ", data);
			
			ajax(data);
			
			$(".datatable-bottom").html(''); 
			
		});
	}
	
	// 구분 별 상품 목록 ajax
	function ajax(data){
		$.ajax({
			url:"/frcorder/getAllGdsGu",
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
				str += "<th>품목코드</th><th>품목명</th><th>품목그룹</th><th>재고수량(a)</th><th>최소재고수량(b)</th><th>발주필요수량(a-b)</th><th>안전재고수량(a-b)</th>";
				str += "</tr>";
				str += "</thead>";
				str += "<tbody>";
				$.each(result, function(idx, frcsStockVO) {
					str += "<tr>";
					str += "<td>" + frcsStockVO.gdsNo + "</td>";
					str += "<td>" + frcsStockVO.gdsNm + "</td>";
					str += "<td>" + frcsStockVO.comcdCdnm + "</td>";
					str += "<td>" + frcsStockVO.frcssCnt + "</td>";
					str += "<td>" + frcsStockVO.minGdsStock + "</td>";
					if(frcsStockVO.frcssCnt < frcsStockVO.minGdsStock){
						str += `<td><div style='color: red'>\${frcsStockVO.frcssCnt - frcsStockVO.minGdsStock}</div></td>
							<td></td>`
					}
					if(frcsStockVO.frcssCnt > frcsStockVO.minGdsStock){
						str += `
						<td></td>
						<td><div style="color: blue">\${frcsStockVO.frcssCnt - frcsStockVO.minGdsStock}</div></td>
							`
					}
					if(frcsStockVO.frcssCnt == frcsStockVO.minGdsStock){
						str += `
						<td>0</td>
						<td>0</td>
							`
					}
					str += "</tr>";
				});
					str += "</tbody>";
					str += "</table>";
					$(".mainTable").html(str); 
					
					const mainTable = document.getElementById('mainTable');
				    if (mainTable) { 
				        new simpleDatatables.DataTable(mainTable,{
				        	perPage : 5,
				              labels: {
				                  placeholder: "검색",
				                  searchTitle: "검색",
				                  pageTitle: "Page {page}",
				                  perPage: "",
				                  noRows: "품목이 존재하지 않습니다.",
				                  info: "",
				                  noResults: "검색결과가 없습니다.",
				              }      
				           }
				        );
				    }
				}
			});
		};
		
		
		$("#insufStock").on("click", function(){
			let data = {
				param:"param"
			}
			$.ajax({
				url:"/frcorder/insufStock",
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
					$.each(result, function(idx, frcsStockVO) {
						str += "<tr>";
						str += "<td>" + frcsStockVO.gdsNo + "</td>";
						str += "<td>" + frcsStockVO.gdsNm + "</td>";
						str += "<td>" + frcsStockVO.comcdCdnm + "</td>";
						str += "<td>" + frcsStockVO.frcssCnt + "</td>";
						str += "<td>" + frcsStockVO.minGdsStock + "</td>";
						if(frcsStockVO.frcssCnt < frcsStockVO.minGdsStock){
							str += `<td><div style='color: red'>\${frcsStockVO.frcssCnt - frcsStockVO.minGdsStock}</div></td>
							<td></td>`
						}
						str += "</tr>";
					});
					row += "<button class='btn btn-outline-blue me-1' type='button' id='orderLink'>발주페이지 이동</button>"
					$("#stockTable tbody").html(str); 
					$("#mainTable tbody").html(str); 
					$(".datatable-bottom").addClass("d-flex justify-content-end");
					$(".datatable-bottom").html(row); 
				}
			});
		});
		
		$(document).on("click","#orderLink", function(){
			location.href = "/frcorder/create";
		});
		
		const datatablesSimple = document.getElementById('stockTable');
	    if (datatablesSimple) { 
	        new simpleDatatables.DataTable(datatablesSimple,{
	        	perPage : 5,
	              labels: {
	                  placeholder: "검색",
	                  searchTitle: "검색",
	                  pageTitle: "Page {page}",
	                  perPage: "",
	                  noRows: "품목이 존재하지 않습니다.",
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
		                'rgba(255, 159, 64, 0.5)'
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
		
		
		let countTotalPriceA = parseInt($("input[name=countTotalPriceA]").val());
	    let countTotalPriceB = parseInt($("input[name=countTotalPriceB]").val());
	    let countTotalPriceC = parseInt($("input[name=countTotalPriceC]").val());
	    let countTotalPriceD = parseInt($("input[name=countTotalPriceD]").val());
	    let countTotalPriceE = parseInt($("input[name=countTotalPriceE]").val());
		const ctx = document.querySelector('#myBarChart').getContext('2d');
		const myBarChart = new Chart(ctx, {
		    type: 'horizontalBar',
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
		        responsive: true,
		        maintainAspectRatio: false,
		        legend: {
		            display: false
		        },
		        tooltips: {
	                callbacks: {
	                    label: function(tooltipItem, data) {
	                        return tooltipItem.xLabel.toLocaleString('ko-KR') + '원';
	                    }
	                }
	            },
		        scales: {
		            xAxes: [{
		                ticks: {
		                    beginAtZero: true,
		                    callback: function(value, index, values) {
		                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		                    }
		                }
		            }]
		        },
		        barThickness: 'flex',
		        minBarLength: 1
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
<div class="container-xl px-4 mt-n10 pt-10">
		<div class="row">
			<div class="col-xl-9 mb-4">
				<div class="card card-header-actions h-100" style="min-height:860px">
					<div class="card-header">
						<b>재고현황</b>
					</div>
					<div class="card-body">
						<div class="chart-area mb-5">
							<canvas id="myBarChart1" width="639" height="250"></canvas>
						</div>
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
						<input name="hiddenFrcsNo" type="hidden" value="${frcsNo}">
					</div>
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
								</tr>
							</thead>
							<tbody>
								<c:forEach var="frcsStockVO" items="${frcsStockVOList}"
									varStatus="stat">
									<c:if test="${frcsStockVO.comcdCdnm == '채소류'}">
										<tr data-index="0">
											<td>${frcsStockVO.gdsNo}</td>
											<td>${frcsStockVO.gdsNm}</td>
											<td>${frcsStockVO.comcdCdnm}</td>
											<td>${frcsStockVO.frcssCnt}</td>
											<td>${frcsStockVO.minGdsStock}</td>
											<c:if
												test="${frcsStockVO.frcssCnt < frcsStockVO.minGdsStock}">
												<td><div style="color: red">${frcsStockVO.frcssCnt - frcsStockVO.minGdsStock}</div></td>
												<td></td>
											</c:if>
											<c:if
												test="${frcsStockVO.frcssCnt > frcsStockVO.minGdsStock}">
												<td></td>
												<td><div style="color: blue">${frcsStockVO.frcssCnt - frcsStockVO.minGdsStock}</div></td>
											</c:if>
											<c:if
												test="${frcsStockVO.frcssCnt == frcsStockVO.minGdsStock}">
												<td>0</td>
												<td>0</td>
											</c:if>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				</div>
			</div>
			<div class="col-lg-3 col-xl-3 mb-4">
			<div
				class="card border-start-lg border-start-primary h-25 mb-2">
				<div class="card-header">
					<div class="col-auto">
						<div class="small" style="font-size: 1.0em">
							<b>총 재고수량(EA)</b>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="me-3">
						<div class="col-auto d-flex justify-content-center align-items-center" style="margin-top: 30px">
							<fmt:formatNumber value="${countTotal}" pattern="#,###" var="formatNumber" />
							<b style="text-align: center; font-size: 1.5em">${formatNumber}EA</b>
						</div>
						<div style="font-size: 0.75em; text-align: center">
							(채소류 + 과일류 + 육류 + 어패류 + 기타식품)
						</div>
					</div>
				</div>
			</div>
			<div
				class="card border-start-lg border-start-primary h-25 mb-2">
				<div class="card-header">
					<div class="col-auto">
						<div class="small" style="font-size: 1.0em">
							<b>총 재고 금액(원)</b>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="me-3">
						<div class="col-auto d-flex justify-content-center align-items-center" style="margin-top: 30px">
							<fmt:formatNumber value="${countTotalPrice}" pattern="#,###" var="formatNumber1" />
							<b style="text-align: center; font-size: 1.5em">${formatNumber1}원</b>
						</div>
						<div style="font-size: 0.75em; text-align: center">
							(재고수량 * 품목단가)의 총합
						</div>
					</div>
				</div>
			</div>
				<div class="card border-start-lg border-start-primary h-50">
					<div class="card-header">
						<div class="small" style="font-size: 1.0em">
							<b>유형별 재고 금액</b>
						</div>
					</div>
					<div class="card-body">
						<canvas id="myBarChart" width="639" height="250"></canvas>
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