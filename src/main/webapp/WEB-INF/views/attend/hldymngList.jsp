<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	#hldyTable1 td:nth-child(1), td:nth-child(4) {
	   text-align: center;
	   width: 10%;
	} 
	
	#hldyTable1 td:nth-child(2) {
		width: 50%;
	} 
	
	#hldyTable1 td:nth-child(3) {
		text-align: center;
		width: 10%;
	}
	
	#hldyTable2 td:nth-child(1), td:nth-child(4) {
	   text-align: center;
	   width: 10%;
	} 
	
	#hldyTable2 td:nth-child(2) {
		width: 50%;
	} 
	
	#hldyTable2 td:nth-child(3) {
		text-align: center;
		width: 10%;
	} 
	
 	.card-body { 
	  overflow-y: auto; /* 내용이 넘치면 수직 스크롤을 추가 */
 	} 
	
	.card-body2 {
		padding: 20px;
	}
	
	.card-body3 {
		padding: 20px;
	}
	
	/* Right column */
	.full-width {
		background-color:  #FFFFFF; /* Optional background color */
		padding: 10px; /* Optional padding */
	}
</style>

<header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
      <div class="container-xl px-4">
         <div class="page-header-content pt-4">
            <div class="row align-items-center justify-content-between">
               <div class="col-auto mt-4">
                  <h3 class="page-header-title">
                     <div class="page-header-icon">
                        <i data-feather="bar-chart"></i>
                     </div>휴가 / 출장 현황 
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.username" var="empId" />
					</sec:authorize>
                  </h3>
                  <div class="page-header-subtitle">OHO KOREA FRANCHISE MANAGEMENT</div>
               </div>
            </div>
         </div>
      </div>
</header>
	
<!-- 실제 화면을 담을 영역 -->
<div id ="table-container" class="full-width">
<%-- 	<button onclick="hldyChk()">날짜 확인용 </button> ${hldyMngLdgrVOList} --%>
	<div class="container-xl px-4 mt-n10">
		<div class="container-fluid px-4">
			<div class="card mb-4">
				<div class="card-header d-flex justify-content-between align-items-center">
					<strong>휴가 현황</strong>
					<div class="dropdown">
						<button class="btn btn-outline-blue dropdown-toggle" id="dropdownFadeIn" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">2024년</button>
						<div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownFadeIn">
							<a class="dropdown-item" href="#!">2023년</a> 
							<a class="dropdown-item" href="#!">2022년</a>
							<a class="dropdown-item" href="#!">2021년</a>
							<a class="dropdown-item" href="#!">2020년</a>
						</div>
					</div>
				</div>
				<div class="card-body2">
					<table id="hldyTable1">
					    <thead>
					        <tr>
					            <th>기안번호</th>
					            <th>제목</th>
					            <th>구분</th>
					            <th>승인내역</th>
					        </tr>
					    </thead>
						<tbody>
							<c:forEach var="HldyMng" items="${hldyMngLdgrVOList}" varStatus="stat">
								<tr>
									<td>${HldyMng.eatrztNo}</td>
									<td>${HldyMng.hmlRsn}</td>
									<td>${HldyMng.hldySeVO.hsNm}</td>
									<td><a href="/eatrzt/detail?atrzlnNo=${HldyMng.atrzlnNo}">상세내역확인</a></td>
								</tr>
							</c:forEach>
						</tbody>
		            </table>
		        </div>
		    </div>
		</div><!--cardbody2 -->
		
		<div class="container-fluid px-4" style="margin-top: 50px;">
			<div class="card">
				<div class="card-header d-flex justify-content-between align-items-center">
					<strong>출장 현황</strong>
					<div class="dropdown">
						<button class="btn btn-outline-blue dropdown-toggle" id="dropdownFadeIn" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">2024년</button>
						<div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownFadeIn">
							<a class="dropdown-item" href="#!">2023년</a> 
							<a class="dropdown-item" href="#!">2022년</a>
							<a class="dropdown-item" href="#!">2021년</a>
							<a class="dropdown-item" href="#!">2020년</a>
						</div>
					</div>
				</div>
				<div class="card-body2">
					<table id="hldyTable2">
					    <thead>
					        <tr>
					            <th>기안번호</th>
					            <th>제목</th>
					            <th>구분</th>
					            <th>승인내역</th>
					        </tr>
					    </thead>
						<tbody>
							<c:forEach var="HldyMng2" items="${hldyMngLdgrVOList2}" varStatus="stat">
								<tr>
									<td>${HldyMng2.eatrztNo}</td>
									<td>${HldyMng2.hmlRsn}</td>
									<td>${HldyMng2.hldySeVO.hsNm}</td>
									<td><a href="/eatrzt/detail?atrzlnNo=${HldyMng2.atrzlnNo}">상세내역확인</a></td>
								</tr>
							</c:forEach>
						</tbody>
		            </table>
		        </div>
		    </div>
		    </div>
		</div><!--cardbody2 -->
		</div><!-- right -->
   
	
<script>
	$(function(){
		const hldyTable1 = document.getElementById('hldyTable1');
		if (hldyTable1) {
			new simpleDatatables.DataTable(hldyTable1, {
				perPage : 5,
				labels : {
					placeholder : "Search...",
					searchTitle : "Search within table",
					pageTitle : "Page {page}",
					perPage : "",
					noRows : "작성된 문서가 없습니다.",
					info : "",
					noResults : "검색결과가 없습니다.",
				}
			});
		}
		
		const hldyTable2 = document.getElementById('hldyTable2');
		if (hldyTable2) {
			new simpleDatatables.DataTable(hldyTable2, {
				perPage : 5,
				labels : {
					placeholder : "Search...",
					searchTitle : "Search within table",
					pageTitle : "Page {page}",
					perPage : "",
					noRows : "작성된 문서가 없습니다.",
					info : "",
					noResults : "검색결과가 없습니다.",
				}
			});
		}
	});	
</script>
