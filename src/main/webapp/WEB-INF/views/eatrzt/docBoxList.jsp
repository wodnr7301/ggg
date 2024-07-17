<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
 #simple td:nth-child(1), td:nth-child(3), td:nth-child(5), td:nth-child(6), td:nth-child(8), td:nth-child(7){
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
						기안 문서함
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
	<!-- 전자결재 탭 -->
	<nav class="nav nav-borders">
		<a class="nav-link" href="/eatrzt/beforeApvBoxList">결재대기문서함</a> 
		<a class="nav-link active ms-0" href="/eatrzt/docBoxList">기안문서함</a> 
		<a class="nav-link" href="/eatrzt/apvBoxList">결재문서함</a>
	</nav> <hr class="mt-0 mb-4" />
	${nApvBoxList}
	<div class="card">
		<div class="card-body">
			<table id="simple">
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
	const simple = document.getElementById('simple');
	if (simple) {
		new simpleDatatables.DataTable(simple, {
			perPage : 10,
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