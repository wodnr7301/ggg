<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
#trnListTable td:nth-child(1), td:nth-child(3), td:nth-child(6){
	text-align: center;
 	width: 10%;
}
#trnListTable td:nth-child(4){
 	width: 10%;
}
#trnListTable td:nth-child(2){
 	width: 40%;
}
#trnListTable td:nth-child(5){
 	width: 20%;
}
</style>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
	<div class="container-xl px-4">
		<div class="page-header-content">
			<div class="row align-items-center justify-content-between pt-3">
				<div class="col-auto mb-3">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-book-fill" viewBox="0 0 16 16">
							  <path
									d="M8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783" />
							</svg>
						</div>
						교육 이수 현황
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<!-- 개점 관리 페이지 탭 -->
<div class="row">
	<div style="height: 50px; text-align: end;">
		<span class="badge text-black" style="background-color: #dddddd;">이수 전 : <span id="cntNSpan">${cntN}</span></span>
		<span class="badge bg-blue-soft text-blue">이수 완료 : <span id="cntYSpan">${cntY}</span></span>
		<span class="badge bg-red-soft text-red">이수 불가 : <span id="cntFSpan">${cntF}</span></span>
	</div>
</div>
<hr class="mt-0 mb-4" />
	<div class="card">
		<div class="card-body" id="tableStart">
			<table id="trnListTable">
				<thead>
					<tr>
						<th>구분</th>
						<th>프로그램명</th>
						<th>교육일</th>
						<th>소요시간</th>
						<th>교육장소</th>
						<th>이수여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ednCndtn" items="${ednCndtnList}" varStatus="stat">
						<tr>
							<td><span style="color:
<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'Y'}">red</c:if>
<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'N'}">blue</c:if>
	                        								;">
	                        	<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'Y'}">필수</c:if>
	                        	<c:if test="${ednCndtn.ednPrgrmVO.epEsntlYn eq 'N'}">선택</c:if>
	                        </span></td>
							<td>${ednCndtn.ednPrgrmVO.epNm}</td>
							<td id="ecYmdStr"><fmt:formatDate value="${ednCndtn.ecYmd}"
									pattern="yyyy-MM-dd" /></td>
							<td>${ednCndtn.ednPrgrmVO.epTm} 시간</td>
							<td>${ednCndtn.ednPrgrmVO.epPlcNm}</td>
							<td>
								<div class="badge 
				<c:if test="${ednCndtn.ecYn eq 'N'}">text-black" style="background-color: #dddddd;</c:if>
				<c:if test="${ednCndtn.ecYn eq 'Y'}">bg-blue-soft text-blue" style="</c:if>
				<c:if test="${ednCndtn.ecYn eq 'F'}">bg-red-soft text-red" style="</c:if>
                       																width: 60%;height: 20px;align-content: center;">
									<c:if test="${ednCndtn.ecYn eq 'N'}">이수 전</c:if>
									<c:if test="${ednCndtn.ecYn eq 'Y'}">이수 완료</c:if>
									<c:if test="${ednCndtn.ecYn eq 'F'}">이수 불가</c:if>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	const trnListTable = document.getElementById('trnListTable');
	if (trnListTable) {
		new simpleDatatables.DataTable(trnListTable, {
			perPage : 10,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "이수 할 교육이 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
});
</script>