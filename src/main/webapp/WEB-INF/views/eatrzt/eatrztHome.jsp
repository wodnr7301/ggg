<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<style>
	div#margin {
        margin-top: 3em;
    }
    
    .flex-grow-1 {
            flex-grow: 1;
    }
    
    #eatrztTable1 td:nth-child(1), td:nth-child(3), td:nth-child(5), td:nth-child(6), td:nth-child(8), td:nth-child(7){
	   text-align: center;
	   width: 12%;
	}

	#eatrztTable2 td:nth-child(1){
	   text-align: center;
	   width: 12%;
	}	
</style>

<header
	class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
	<div class="container-fluid px-4">
		<div class="page-header-content">
			<div class="row align-items-center justify-content-between pt-3">
				<div class="col-auto mb-3">
					<h1 class="page-header-title">
						<div class="page-header-icon"><i data-feather="list"></i>
						</div>
						전자결재 홈
					</h1>
				</div>
				<div class="col-12 col-xl-auto mb-3">
					<a class="btn btn-sm btn-light text-primary"
						href="/eatrzt/create"><i class="me-1" data-feather="plus"></i>새 결재 작성
					</a>
				</div>
			</div>
		</div>
	</div>
</header>

<!-- Main page content-->
<div class="container-fluid px-4">
	<!-- ///////////////결재 진행 상태 카드 시작/////////////// -->
<%-- 	${apvBoxList} --%>
<%-- ${nDocBoxList} --%>
	<div class="row">
		<div class="container">
			<div class="d-flex justify-content-center flex-wrap">
				<div class="col-lg-6 col-xl-3 mb-4 mx-2">
					<div class="card bg-primary text-white h-100">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<div class="me-3">
									<div class="text-white-75 fs-3">확인하지 않은 결재 요청</div>
								</div>
							</div>
							<div class="me-3" style="text-align: end;">
								<a href="/eatrzt/beforeApvBoxList" style="color: white;"><p style="font-size: 50px;">
<%-- 								<input type="text" id="beforeApvBoxListSize" value="${fn:length(beforeApvBoxList)}" /> --%>
								${fn:length(beforeApvBoxList)}건</p></a>
							</div>
<!-- 							<div class="text-white-75 fs-1">#건</div> -->
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-xl-3 mb-4 mx-2">
					<div class="card bg-success text-white h-100">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<div class="me-3">
									<div class="text-white-75 fs-3">결재내역 보기</div>
								</div>
							</div>
							<div class="me-3" style="text-align: end;">
								<a href="/eatrzt/apvBoxList" style="color: white;"><p style="font-size: 50px;">${fn:length(apvBoxList)}건</p></a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-xl-3 mb-4 mx-2">
					<div class="card bg-danger text-white h-100">
						<div class="card-body">
							<div class="d-flex justify-content-between align-items-center">
								<div class="me-3">
									<div class="text-white-75 fs-3">반려된 결재 내역</div>
								</div>
							</div>
							<div class="me-3" style="text-align: end;">
								<a href="#" onclick="nDoc();" style="color: white;">
									<p style="font-size: 50px;">${fn:length(nDocBoxList)}건</p>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ///////////////결재 진행 상태 카드 끝/////////////// -->
	
	<div class="card">
		<div class="card-header">
			<strong>결재대기문서함</strong>
		</div>
		<div class="card-body">
			<table id="eatrztTable1" class="display" style="width: 100%">
				<thead>
					<tr>
						<th>문서번호</th>
						<th>제목</th>
						<th>기안일</th>
						<th>결재양식</th>
						<th>기안자</th>
						<th>부서</th>
						<th>결재상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="eatrztVO" items="${beforeApvBoxList}" varStatus="stat">
						<tr>
							<td>${eatrztVO.eatrztNo}</td>
							<td><a href="/eatrzt/detail?atrzlnNo=${eatrztVO.atrzlnNo}">${eatrztVO.eatrztTtl}</a></td>
							<td><fmt:formatDate value="${eatrztVO.eatrztRepdt}" pattern="yyyy-MM-dd" /></td>
							<td>${eatrztVO.tmpltVO.tmpltTtl}</td>
							<td>${eatrztVO.employeeVO.empNm}</td>
							<td>${eatrztVO.deptVO.deptNm}</td>
							<td>
								<span class="badge
									<c:if test="${eatrztVO.eatrztPrcsYn eq 'I'}">bg-success</c:if>
								me-2">
									<c:if test="${eatrztVO.eatrztPrcsYn eq 'I'}">진행중</c:if>
								</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div id="margin" class="container-fluid px-4">
	<div class="card">
		<div class="card-header">
			<strong>기안문서함</strong>
		</div>
		<div class="card-body">
			<table id="eatrztTable2" class="display" style="width: 100%">
				<thead>
					<tr>
						<th>문서번호</th>
						<th>제목</th>
						<th>기안일</th>
						<th>결재양식</th>
						<th>기안자</th>
						<th>부서</th>
						<th>결재상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="eatrztVO" items="${docBoxList}" varStatus="stat">
						<tr>
							<td>${eatrztVO.eatrztNo}</td>
							<td><a href="/eatrzt/detail?atrzlnNo=${eatrztVO.atrzlnNo}">${eatrztVO.eatrztTtl}</a></td>
							<td><fmt:formatDate value="${eatrztVO.eatrztRepdt}" pattern="yyyy-MM-dd" /></td>
							<td>${eatrztVO.tmpltVO.tmpltTtl}</td>
							<td>${eatrztVO.employeeVO.empNm}</td>
							<td>${eatrztVO.deptVO.deptNm}</td>

							<td>
								<!-- 결재상태는 진행상황에 따라 다름 --> 
								<span class="badge 
							 		<c:if test="${eatrztVO.eatrztPrcsYn eq 'I'}">bg-success</c:if>
							 		<c:if test="${eatrztVO.eatrztPrcsYn eq 'Y'}">bg-secondary</c:if>
							 		<c:if test="${eatrztVO.eatrztPrcsYn eq 'N'}">bg-danger</c:if>
							 		<c:if test="${eatrztVO.eatrztPrcsYn eq 'C'}">bg-info</c:if>
							 	me-2">
									<c:if test="${eatrztVO.eatrztPrcsYn eq 'I'}">진행중</c:if> 
									<c:if test="${eatrztVO.eatrztPrcsYn eq 'Y'}">승인</c:if> 
									<c:if test="${eatrztVO.eatrztPrcsYn eq 'N'}">반려</c:if> 
									<c:if test="${eatrztVO.eatrztPrcsYn eq 'C'}">확인</c:if>
								</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
function nDoc() {
	location.href = "/eatrzt/docBoxList?gstatus=N";
}

$(function(){
	const eatrztTable1 = document.getElementById('eatrztTable1');
	if (eatrztTable1) {
		new simpleDatatables.DataTable(eatrztTable1, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "결재 대기 중인 문서가 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
	
	const eatrztTable2 = document.getElementById('eatrztTable2');
	if (eatrztTable2) {
		new simpleDatatables.DataTable(eatrztTable2, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "작성한 문서가 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
});
</script>