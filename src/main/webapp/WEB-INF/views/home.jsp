<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0/dist/chartjs-plugin-datalabels.min.js" crossorigin="anonymous"></script>
<style>
#datatablesSimple-nctBbs td:nth-child(1),#datatablesSimple-nctBbs td:nth-child(3), #datatablesSimple-nctBbs td:nth-child(4){
	text-align: center;
}
</style>
<script type="text/javascript">
$(function() {
	// 월별 매출을 저장할 배열
	let monthlySales = [];
	let preMonthlySales = [];

	// 1부터 12까지 반복하여 각 월별 입력 필드의 값을 가져와서 배열에 저장
	for (let i = 1; i <= 12; i++) {
	    let monthlyValue = parseInt($("input[name=monthly" + i + "]").val()); // input의 값은 문자열이므로 정수로 변환
	    monthlySales.push(monthlyValue); 
	}
	// 1부터 12까지 반복하여 각 월별 입력 필드의 값을 가져와서 배열에 저장
	for (let i = 1; i <= 12; i++) {
	    let preMonthlyValue = parseInt($("input[name=preMonthly" + i + "]").val()); // input의 값은 문자열이므로 정수로 변환
	    preMonthlySales.push(preMonthlyValue);
	}
	
	// 월별매출 그래프
	var myChart = new Chart(
    document.getElementById('myBarChart'),
    {
        type: 'bar',
        data: {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            datasets: [{
                data: monthlySales,
                fill: false,
                backgroundColor: 'rgba(75, 192, 192, 0.5)',
                tension: 0.1
            }]
        },
        options: {
            plugins: {
                datalabels: {
                    display: false
                }
            },
            legend: {
                display: false
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem) {
                        return tooltipItem.yLabel / 1000000 + 'M'; // 백만 단위로 나누고 'M'을 추가하여 표시
                    }
                }
            },
            scales: {
                yAxes: [{
                    ticks: {
                        callback: function(value) {
                            return value / 1000000 + 'M'; // y축 눈금에도 백만 단위로 나누고 'M'을 추가하여 표시
                        }
                    }
                }]
            }
        }
    }
);

	// 전년대비
	
	var myChart = new Chart(
    document.getElementById('myAreaChart'),
    {
        type: 'line',
        data: {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            datasets: [
                {
                    label: '2023',
                    data: preMonthlySales,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: false
                },
                {
                    label: '2024',
                    data: monthlySales,
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 2,
                    fill: false
                }
            ]
        },
        options: {
            plugins: {
                datalabels: {
                    display: false,
                }
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return tooltipItem.yLabel.toLocaleString('ko-KR') + '원';
                    }
                }
            },
            scales: {
                yAxes: [{
                    ticks: {
                        callback: function(value, index, values) {
                            return value.toLocaleString('ko-KR');
                        }
                    }
                }]
            }
        }
    }
);

	
	// 발주현황 막대 차트
	let a = parseInt($("input[name=N]").val());
	let b = parseInt($("input[name=F]").val());
	let c = parseInt($("input[name=A]").val());
	let d = parseInt($("input[name=D]").val());
	let e = parseInt($("input[name=E]").val());
	
	const ctx1 = document.querySelector('#myBarChart1').getContext('2d');
	const myBarChart1 = new Chart(ctx1, {
	    type: 'bar',
	    data: {
	        labels: ['반려', '입고필요', '결재중', '배송중', '입고완료'],
	        datasets: [{
	            data: [a, b, c, d, e],
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
	
	// 재고현황 도넛 차트
	let allStockCnt = $("#allStockCnt").data("allstock");
	let insufStockCnt = $("#insufStockCnt").data("insufstock");
	console.log("allStockCnt : ", allStockCnt);
	console.log("insufStockCnt : ", insufStockCnt);
    var ctx = document.getElementById('myChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['적정재고', '미달재고'],
            datasets: [
                {
                    data: [allStockCnt, insufStockCnt],
                    backgroundColor: [
                        'rgb(134, 181, 255)',
                        'rgb(255, 52, 65)',
                    ],
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                datalabels: {
                    display: false // 데이터 라벨을 표시하지 않도록 설정
                }
            }
        },
        plugins: [ChartDataLabels] // ChartDataLabels 플러그인 사용
    });
    
    const datatablesSimpleNctBbs = document.getElementById('datatablesSimple-nctBbs');
    if (datatablesSimpleNctBbs) { 
        new simpleDatatables.DataTable(datatablesSimpleNctBbs,{
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
});
</script>
<main>
	<header
		class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
		<div class="container-xl px-4">
			<div class="page-header-content pt-4">
				<div class="row align-items-center justify-content-between">
					<div class="col-auto mt-4">
						<h1 class="page-header-title">
							<div class="page-header-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-building" viewBox="0 0 16 16" style="color: white;">
									<path d="M4 2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zM7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zM4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
									<path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1zm11 0H3v14h3v-2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5V15h3z" />
								</svg>
							</div>
							${frcsNm}
						</h1>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div class="container-xl px-4 mt-n10">
		<div class="row">
			<div class="mb-4">
				<div class="card card-header-actions h-100">
					<div class="card-header">
						<b>공지사항</b>
					</div>
					<div class="card-body">
						<table id="datatablesSimple-nctBbs">
			               <thead>
			                   <tr>
			                       <th style="width: 5%;">No</th>
			                       <th style="width: 30%;">제목</th>
			                       <th style="width: 15%;">작성일</th>
			                       <th style="width: 10%;">조회수</th>
			                   </tr>
			               </thead>
			               <tbody>
			          		<c:forEach var="ntcBbs" items="${ntcBbsList}" varStatus="stat">
			                   <tr>
			                       <td style="text-align: center;">${ntcBbs.displayNo}</td>
			                       <td>
						            <a href="frcowner/ntcBoardDetail?nbNo=${ntcBbs.nbNo}" style="color: #585858;">
						                <c:choose>
						                    <c:when test="${ntcBbs.nbImp == 3}">
						                        <span style="color: red;">[필독]&nbsp</span> ${ntcBbs.nbTtl}
						                    </c:when>
						                    <c:when test="${ntcBbs.nbImp == 2}">
						                        <span style="color: #848484;">[중요]&nbsp</span> ${ntcBbs.nbTtl}
						                    </c:when>
						                    <c:otherwise>
						                        ${ntcBbs.nbTtl}
						                    </c:otherwise>
						                </c:choose>
						            </a>
						        </td>
			                       <td>${ntcBbs.nbPstdt}</td>
			                       <td>${ntcBbs.nbCount}</td>
			                   </tr>
			          		</c:forEach>
			               </tbody>
			           </table>
					</div>
				</div>
			</div>
			<div class="col-xxl-7 col-xl-7 mb-4">
				<div class="card card-header-actions h-100">
					<div class="card-header">
						<b>발주현황</b>
						<div class="dropdown no-caret">
							<div class="dropdown-menu dropdown-menu-end animated--fade-in-up"
								aria-labelledby="dropdownMenuButton">
								<h6 class="dropdown-header">Filter Activity:</h6>
								<a class="dropdown-item" href="#!"><span
									class="badge bg-green-soft text-green my-1">Commerce</span></a> <a
									class="dropdown-item" href="#!"><span
									class="badge bg-blue-soft text-blue my-1">Reporting</span></a> <a
									class="dropdown-item" href="#!"><span
									class="badge bg-yellow-soft text-yellow my-1">Server</span></a> <a
									class="dropdown-item" href="#!"><span
									class="badge bg-purple-soft text-purple my-1">Users</span></a>
							</div>
						</div>
					</div>
					<div class="card-body" style="height: 320px">
						<div class="chart-bar">
							<div class="chartjs-size-monitor">
								<div class="chartjs-size-monitor-expand">
									<div class=""></div>
								</div>
								<div class="chartjs-size-monitor-shrink">
									<div class=""></div>
								</div>
							</div>
							<canvas id="myBarChart1" width="639" height="250"></canvas>
						</div>
					</div>
					<div class="card-footer position-relative">
						<div
							class="d-flex align-items-center justify-content-between small text-body">
							<a class="stretched-link text-body" href="/frcorder/list">발주조회 및 내역확인</a>
							<svg class="svg-inline--fa fa-angle-right" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-right"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 256 512" data-fa-i2svg="">
								<path fill="currentColor"
									d="M246.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L178.7 256 41.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z"></path></svg>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xxl-5 col-xl-5 mb-4">
				<div class="card card-header-actions h-100">
					<div class="card-header">
						<b>재고현황</b>
					</div>
					<div class="card-body">
						<div class="chart-container">
							<div class="chart-bar" style="float: left; width: 50%;">
								<div class="chartjs-size-monitor">
									<div class="chartjs-size-monitor-expand">
										<div class=""></div>
									</div>
									<div class="chartjs-size-monitor-shrink">
										<div class=""></div>
									</div>
								</div>
								<canvas id="myChart" width="319" height="240"
									class="chartjs-render-monitor"
									style="display: block; width: 319px; height: 240px;"></canvas>
							</div>
							<div class="additional-content" style="float: left; width: 50%;">
								<div class="card-body bg-gray-100 p-3 border border-lg rounded mb-4 mt-3">
									<div style="text-align: center; font-size: 15px;"><b>적정재고</b></div>
									<div id="allStockCnt" style="text-align: center; font-size: 20px; font-weight: bold;" data-allstock="${100-((insufStockCnt/allStockCnt)*100)}"><fmt:formatNumber type="number" maxFractionDigits="1" value="${(100 - (insufStockCnt / allStockCnt) * 100)}" />%</div>
								</div>
								<div class="card-body bg-gray-100 p-3 border border-lg rounded">
									<div style="text-align: center; font-size: 15px;"><b>미달재고</b></div>
									<div id="insufStockCnt" style="text-align: center; font-size: 20px; font-weight: bold;" data-insufstock="${(insufStockCnt/allStockCnt)*100}"><fmt:formatNumber type="number" maxFractionDigits="1" value="${(insufStockCnt/allStockCnt)*100}" />%</div>
								</div>
							</div>
							<div style="clear: both;"></div>
						</div>
					</div>
					<div class="card-footer position-relative">
						<div
							class="d-flex align-items-center justify-content-between small text-body">
							<a class="stretched-link text-body" href="/frcorder/stockMng">재고관리 페이지 이동</a>
							<svg class="svg-inline--fa fa-angle-right" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-right"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 256 512" data-fa-i2svg="">
								<path fill="currentColor"
									d="M246.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L178.7 256 41.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z"></path></svg>
							<!-- <i class="fas fa-angle-right"></i> Font Awesome fontawesome.com -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Example Colored Cards for Dashboard Demo-->
		<div class="row">
			<div class="col-lg-6 col-xl-3 mb-4">
				<div class="card border-start-lg border-start-primary h-100">
					<div class="card-body">
						<div class="d-flex justify-content-between align-items-center">
							<div class="me-3">
								<div class="small">이번달 매출</div>
								<div class="text-lg fw-bold"><b><fmt:formatNumber value="${monthAmt}" pattern="#,###" />원</b></div>
								<div
									class="text-xs fw-bold text-success d-inline-flex align-items-center">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round"
										class="feather feather-trending-up me-1">
										<polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline>
										<polyline points="17 6 23 6 23 12"></polyline></svg>
									${pms}%
								</div>
							</div>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-calendar feather-xl text-white-50">
								<rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
								<line x1="16" y1="2" x2="16" y2="6"></line>
								<line x1="8" y1="2" x2="8" y2="6"></line>
								<line x1="3" y1="10" x2="21" y2="10"></line></svg>
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="stretched-link" href="/frcowner/revenueMonth">월별매출 확인하기</a>
						<div class="text-white">
							<svg class="svg-inline--fa fa-angle-right" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-right"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 256 512" data-fa-i2svg="">
								<path fill="currentColor"
									d="M246.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L178.7 256 41.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z"></path></svg>
							<!-- <i class="fas fa-angle-right"></i> Font Awesome fontawesome.com -->
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-xl-3 mb-4">
				<div class="card border-start-lg border-start-primary h-100">
					<div class="card-body">
						<div class="d-flex justify-content-between align-items-center">
							<div class="me-3">
								<div class="small">이번분기 매출</div>
								<div class="text-lg fw-bold"><b><fmt:formatNumber value="${qtAmt}" pattern="#,###" />원</b></div>
								<div
									class="text-xs fw-bold text-success d-inline-flex align-items-center">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round"
										class="feather feather-trending-up me-1">
										<polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline>
										<polyline points="17 6 23 6 23 12"></polyline></svg>
									12%
								</div>
							</div>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-dollar-sign feather-xl text-white-50">
								<line x1="12" y1="1" x2="12" y2="23"></line>
								<path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="stretched-link" href="/frcowner/revenueQuater">분기별 매출 확인하기</a>
						<div class="text-white">
							<svg class="svg-inline--fa fa-angle-right" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-right"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 256 512" data-fa-i2svg="">
								<path fill="currentColor"
									d="M246.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L178.7 256 41.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z"></path></svg>
							<!-- <i class="fas fa-angle-right"></i> Font Awesome fontawesome.com -->
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-xl-3 mb-4">
				<div class="card border-start-lg border-start-primary h-100">
					<div class="card-body">
						<div class="d-flex justify-content-between align-items-center">
							<div class="me-3">
								<div class="small">이번년도 매출</div>
								<div class="text-lg fw-bold"><b><fmt:formatNumber value="${yearAmt}" pattern="#,###" />원</b></div>
								<div
									class="text-xs fw-bold text-success d-inline-flex align-items-center">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round"
										class="feather feather-trending-up me-1">
										<polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline>
										<polyline points="17 6 23 6 23 12"></polyline></svg>
									${yms}%
								</div>
							</div>
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-check-square feather-xl text-white-50">
								<polyline points="9 11 12 14 22 4"></polyline>
								<path
									d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="stretched-link" href="/frcowner/revenueYear">연간매출 확인하기</a>
						<div class="text-white">
							<svg class="svg-inline--fa fa-angle-right" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-right"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 256 512" data-fa-i2svg="">
								<path fill="currentColor"
									d="M246.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-160 160c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L178.7 256 41.4 118.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l160 160z"></path></svg>
							<!-- <i class="fas fa-angle-right"></i> Font Awesome fontawesome.com -->
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-6 col-xl-3 mb-4">
				<div class="card border-start-lg border-start-primary h-100">
					<div class="card-body">
						<div>
							<div class="me-3" style="text-align: center;">
								<div class="small"><p>매출총이익률(%)</p></div>
								<p><b style="font-size: 2.0em; font-weight: bold; color: blue;">${gpm}%</b></p>
								<p style="font-size: 12px;">매출총이익률 = (매출총이익 / 매출액) * 100</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Example Charts for Dashboard Demo-->
		<div class="row">
			<div class="col-xl-6 mb-4">
				<div class="card card-header-actions h-100">
					<div class="card-header">
						<b>전년 대비 매출</b>
					</div>
					<div class="card-body">
						<div class="chart-area">
							<canvas id="myAreaChart" width="639" height="240"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-6 mb-4">
				<div class="card card-header-actions h-100">
					<div class="card-header">
						<b>월별 매출(2024)</b>
					</div>
					<div class="card-body">
						<div class="chart-bar">
							<canvas id="myBarChart" width="639" height="240"
								class="chartjs-render-monitor"
								style="display: block; width: 639px; height: 240px;"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:forEach var="revenueVO" items="${revenueList}" varStatus="stat">
		<input type="hidden" name="monthly${stat.count}" value="${revenueVO.fsAmt}">
		<input type="hidden" name="fsAmt" value="${revenueVO.fsMonthly}">
	</c:forEach>

	<c:forEach var="revenueVO2" items="${revenueList2}" varStatus="stat">
		<input type="hidden" name="preMonthly${stat.count}" value="${revenueVO2.fsAmt}">
		<input type="hidden" name="preFsAmt" value="${revenueVO2.fsMonthly}">
	</c:forEach>

	<input name="N" type="hidden" value="${countN}">
	<input name="A" type="hidden" value="${countA}">
	<input name="D" type="hidden" value="${countD}">
	<input name="F" type="hidden" value="${countF}">
	<input name="E" type="hidden" value="${countE}">
</main>