<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	.svg-icon-right-top {
	    position: absolute;
	    top: 10px;  /* 원하는 위치로 조정 */
	    right: 10px; /* 원하는 위치로 조정 */
	    
	    .d-flex > i,
		.d-flex > div {
		  margin-top: 5px; /* 원하는 위치로 조정 */
		}
	}
	
	#noticeTable td:nth-child(1), td:nth-child(3){
	   text-align: center;
	}
</style>
<main>
	<header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
		<div class="container-xl px-4">
			<div class="page-header-content pt-1">
				<div class="row align-items-center justify-content-between">
					<div class="col-auto mt-4">
						<h1 class="page-header-title">
							<div class="page-header-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-building" viewBox="0 0 16 16" style="color: white;">
									<path d="M4 2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zM7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zM4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
									<path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1zm11 0H3v14h3v-2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5V15h3z" />
								</svg>
							</div>
							OHOKOREA
<%-- 							${totalWork}${outWork}${lateWork} --%>
						</h1>
					</div>
				</div>
			</div>
		</div>
	</header>
	<!-- chart.js 설치 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<!-- Main page content-->
	<div class="container-xl px-4 mt-n10">
		<div class="row">
			<div class="col-xxl-4 col-xl-12 mb-4">
				<div class="card h-100">
					<div class="card-body h-100 p-5">
						<div class="row align-items-center">
							<div class="col-xl-8 col-xxl-12">
								<div class="text-center text-xl-start text-xxl-center mb-4 mb-xl-0 mb-xxl-4">
									<h1 class="text-primary">${employeeVO2.empNm}님 환영합니다!</h1>
									<div class="card-body text-center">
										<!-- Profile picture image-->
										<img class="img-account-profile mb-2"
											src="/download/${login.getEmployeeVO().empNo}/1"
											style="max-width: 26rem" />
									</div>
									<div class="list-group list-group-flush">
										<div
											class="list-group-item d-flex align-items-center justify-content-between small px-0 py-2">
											<div class="me-3">
												<i class="fas fa-circle fa-sm me-1 text-blue"></i> 
												부서명 : <span>${employeeVO2.deptNm} (${employeeVO2.comcdCdnm})</span>
											</div>
<!-- 											<div class="fw-500 text-dark">55%</div> -->
										</div>
										<div
											class="list-group-item d-flex align-items-center justify-content-between small px-0 py-2">
											<div class="me-3">
												<i class="fas fa-circle fa-sm me-1 text-purple"></i> 연락처 : ${employeeVO2.empTelno}
											</div>
										</div>
										<div
											class="list-group-item d-flex align-items-center justify-content-between small px-0 py-2">
											<div class="me-3">
												<i class="fas fa-circle fa-sm me-1 text-green"></i> 이메일 : ${employeeVO2.empEmlAddr}
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-xl-4 col-xxl-12 text-center">
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 공지사항 시작 -->
			<div class="col-xxl-8 col-xl-12 mb-4">
				<div class="card h-100">
					<div class="card-header">공지사항</div>
					<div class="card-body">
						<table id="noticeTable" class="display" style="width: 100%">
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="ntcBbs" items="${ntcBbsList}" varStatus="stat">
									<tr>
										<td>${ntcBbs.displayNo}</td>
										<td><a href="/employee/ntcEmpBoardDetail?nbNo=${ntcBbs.nbNo}" style="color: #585858;"> 
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
										</a></td>
										<td>${ntcBbs.nbPstdt}</td>
										<td>${ntcBbs.nbCount}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 공지사항 끝 -->
		<!-- Example Colored Cards for Dashboard Demo-->
		<div class="row">
			<div class="col-12 col-md-6 col-xl mb-4">
				<div class="card border-start-lg border-start-primary text-dark h-100">
					<div class="card-body position: relative">
<!-- 						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-star-fill svg-icon-right-top" viewBox="0 0 16 16" style="color: gold;"> -->
<!-- 					    	<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/> -->
<!-- 					    </svg> -->
						<div class="title-font" style="text-align-last: center;font-size: 25px; margin-top: 10px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-calendar4" viewBox="0 0 16 16" style="margin-right: 10px;">
							  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M2 2a1 1 0 0 0-1 1v1h14V3a1 1 0 0 0-1-1zm13 3H1v9a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
							</svg>오늘일정(<c:out value="${getCountWork}"/>건)
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="text-dark stretched-link" href="/todoList/list">바로가기</a>
						<div class="text-dark">
							<i class="fas fa-angle-right"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 col-xl mb-4">
				<div class="card border-start-lg border-start-primary text-dark h-100">
					<div class="card-body position: relative">
<!-- 						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-star-fill svg-icon-right-top" viewBox="0 0 16 16" style="color: gold;"> -->
<!-- 					    	<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/> -->
<!-- 					    </svg> -->
						<div class="title-font" style="text-align-last: center;font-size: 25px; margin-top: 10px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-clipboard-check-fill" viewBox="0 0 16 16" style="margin-right: 10px;">
							  <path d="M6.5 0A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0zm3 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5z"/>
							  <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1A2.5 2.5 0 0 1 9.5 5h-3A2.5 2.5 0 0 1 4 2.5zm6.854 7.354-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708.708"/>
							</svg>결재대기 (${fn:length (beforeApvBoxList)}건)
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="text-dark stretched-link" href="/eatrzt/eatrztHome">바로가기</a>
						<div class="text-dark">
							<i class="fas fa-angle-right"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 col-xl mb-4">
				<div class="card border-start-lg border-start-primary text-dark h-100">
					<div class="card-body position: relative">
<!-- 						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-star-fill svg-icon-right-top" viewBox="0 0 16 16" style="color: gold;"> -->
<!-- 					    	<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/> -->
<!-- 					    </svg> -->
						<div class="title-font" style="text-align-last: center;font-size: 25px; margin-top: 10px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-check-square-fill" viewBox="0 0 16 16" style="margin-right: 10px;">
							  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
							</svg>예약관리
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="text-dark stretched-link" href="/mtgRoom/list">바로가기</a>
						<div class="text-dark">
							<i class="fas fa-angle-right"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 col-xl mb-4">
				<div class="card border-start-lg border-start-primary text-dark h-100">
					<div class="card-body position: relative">
<!-- 						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-star-fill svg-icon-right-top" viewBox="0 0 16 16" style="color: gold;"> -->
<!-- 					    	<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/> -->
<!-- 					    </svg> -->
						<div class="title-font" style="text-align-last: center;font-size: 25px; margin-top: 10px;">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16" style="margin-right: 10px;">
							  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
							</svg>프로젝트관리
						</div>
					</div>
					<div
						class="card-footer d-flex align-items-center justify-content-between small">
						<a class="text-dark stretched-link" href="/biz/list">바로가기</a>
						<div class="text-dark">
							<i class="fas fa-angle-right"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 수주 발주 현황 / 그래프 시작-->
		<div class="row">
		<div class="col-xxl-4 col-xl-6 mb-4">
<!-- 		<div class="col-xl-6 mb-4"> -->
			<div class="card card-header-actions h-80">
				<!-- 발주관리 재고관리 -->
				<div class="card-header border-bottom">
					<!-- Dashboard card navigation-->
					<ul class="nav nav-tabs card-header-tabs" id="dashboardNav"
						role="tablist">
						<li class="nav-item me-1"><a class="nav-link active"
							id="overview-pill" href="#overview" data-bs-toggle="tab"
							role="tab" aria-controls="overview" aria-selected="true">발주현황</a></li>
						<li class="nav-item"><a class="nav-link" id="activities-pill"
							href="#activities" data-bs-toggle="tab" role="tab"
							aria-controls="activities" aria-selected="false">수주현황</a></li>
					</ul>
				</div>
				<div class="card-body">
					<div class="tab-content" id="dashboardNavContent">
						<!-- Dashboard Tab Pane 1-->
						<div class="tab-pane fade show active" id="overview"
							role="tabpanel" aria-labelledby="overview-pill">
							<div class="chart-area mb-4 mb-lg-0" style="align-content: center;height: 20rem">
								<!-- 												<div class="small mb-1">Page Headers</div> -->
								<ul class="list-group">
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="/hdorder/list">전체</a>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">입고필요</a>
										 <span class="badge bg-primary rounded-pill">${countY}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">반려</a><span class="badge bg-primary rounded-pill">${countN}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">진행중</a><span class="badge bg-primary rounded-pill">${countI}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">입고완료</a>
										 <span class="badge bg-primary rounded-pill">${countE}</span>
									</li>
								</ul>
							</div>
						</div>
						<!-- Dashboard Tab Pane 2-->
						<div class="tab-pane fade" id="activities" role="tabpanel"
							aria-labelledby="activities-pill">
							<div class="chart-area mb-4 mb-lg-0" style="align-content: center;height: 20rem">
								<!-- 												<div class="small mb-1">Page Headers</div> -->
								<ul class="list-group">
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="/hdorder/contract">전체</a>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">승인대기</a><span class="badge bg-primary rounded-pill">${conuntA}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">배송중</a> <span class="badge bg-primary rounded-pill">${conuntD}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">배송완료</a><span class="badge bg-primary rounded-pill">${conuntEF}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">반려</a><span class="badge bg-primary rounded-pill">${conuntN}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
				<div class="col-xxl-4 col-xl-6 mb-4">
<!-- 		<div class="col-xl-6 mb-4"> -->
			<div class="card card-header-actions h-100">
				<div class="card-header">
					재고관리
				</div>
				<div class="card-body" style="align-self: center;height: 100px;">
					<canvas id="myChart"></canvas>
				</div>
			</div>
		</div>
		<div class="col-xxl-4 col-xl-6 mb-4">
<!-- 		<div class="col-xl-6 mb-4"> -->
			<div class="card card-header-actions h-80">
				<!-- 발주관리 재고관리 -->
				<div class="card-header border-bottom">
					<!-- Dashboard card navigation-->
					연도별 매출 현황
				</div>
				<div class="card-body">
					<div class="tab-content" id="dashboardNavContent">
						<!-- Dashboard Tab Pane 1-->
						<div class="tab-pane fade show active" id="overview"
							role="tabpanel" aria-labelledby="overview-pill">
							<div class="chart-area mb-4 mb-lg-0" style="align-content: center;height: 20rem">
								<!-- 												<div class="small mb-1">Page Headers</div> -->
								<!-- 매출 그래프 넣기 -->
								<canvas id="myLineChart"></canvas>
							</div>
						</div>
						<!-- Dashboard Tab Pane 2-->
						<div class="tab-pane fade" id="activities" role="tabpanel"
							aria-labelledby="activities-pill">
							<div class="chart-area mb-4 mb-lg-0" style="align-content: center;height: 20rem">
								<!-- 												<div class="small mb-1">Page Headers</div> -->
								<ul class="list-group">
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="/hdorder/contract">전체</a>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">승인대기</a><span class="badge bg-primary rounded-pill">${conuntA}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">배송중</a> <span class="badge bg-primary rounded-pill">${conuntD}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">배송완료</a><span class="badge bg-primary rounded-pill">${conuntEF}</span>
									</li>
									<li class="list-group-item d-flex justify-content-between align-items-center" style="height: 50px;">
										<a href="#">반려</a><span class="badge bg-primary rounded-pill">${conuntN}</span>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<script>
let needStock = "${needStock}"; //미달품목
let countAA = "${countAA}"; //채소류
let countBB = "${countBB}"; //과일류
let countCC = "${countCC}"; //육류
let countDD = "${countDD}"; //어패류
let countEE = "${countEE}"; //기타 식품
console.log("countAA 6나와야됨 : ", countAA);
const ctx = document.querySelector('#myChart').getContext('2d');

const myC = new Chart(ctx, {

	type : 'pie',
	data : {
		labels: ['미달품목', '채소류', '과일류', '육류', '어패류', '기타 식품'],
		datasets: [
			{
				data:[needStock, countAA, countBB, countCC, countDD, countEE],
				backgroundColor: [
					'rgb(255, 99, 132)',
					'rgb(255, 159, 64)',
					'rgb(255, 205, 86)',
					'rgb(75, 192, 192)',
					'rgb(54, 162, 235)',
					'rgb(153, 102, 255)',
				],
			}
		]
	},
	options : {
		responsive : true,
		plugins : {
		legend : {
			position : 'top',
		},
			title : {
				display : true,
				text : '품목별 재고현황'
			}
		}
	}
});

	$(function() {
		const noticeTable = document.getElementById('noticeTable');
		if (noticeTable) {
			new simpleDatatables.DataTable(noticeTable, {
				perPage : 8,
				perPageSelect : false,
				searchable : false,
				labels : {
					placeholder : "Search...",
					searchTitle : "Search within table",
					pageTitle : "Page {page}",
					perPage : "",
					noRows : "작성된 공지사항이 없습니다.",
					info : "",
					noResults : "검색결과가 없습니다.",
				}
			});
		}
		
		var ctx = document.getElementById("myLineChart").getContext('2d');
	    var myLineChart = new Chart(ctx, {
	        type: 'line',
	        data: {
	            labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	            datasets: [
	                {
	                    label: '2023',
	                    fill: false,
	                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
	                    borderColor: 'rgba(54, 162, 235, 1)',
	                    data: [50, 52, 55, 75, 85, 60, 55, 65, 50, 45, 55, 50], // 4월과 5월에 2024년보다 높은 값
	                },
	                {
	                    label: '2024',
	                    fill: false,
	                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
	                    borderColor: 'rgba(255, 99, 132, 1)',
	                    data: [40, 45, 60, 65, 70, 65, 66], // 4월과 5월에 2023년도보다 낮은 값
	                }
	            ]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            scales: {
	                x: {
	                    title: {
	                        display: true,
	                        text: ' '
	                    }
	                },
	                y: {
	                    title: {
	                        display: true,
	                        text: ' '
	                    },
	                    ticks: {
	                        callback: function(value) {
	                            return value.toLocaleString() + '억';
	                        },
	                        beginAtZero: true
	                    }
	                }
	            },
	            plugins: {
	                tooltip: {
	                    callbacks: {
	                        label: function(context) {
	                            let label = context.dataset.label || '';
	                            if (label) {
	                                label += ': ';
	                            }
	                            label += '₩' + context.raw.toLocaleString() + '억';
	                            return label;
	                        }
	                    }
	                }
	            }
	        }
	    });
		
	    
	    
	});
</script>