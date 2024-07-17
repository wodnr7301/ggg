<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
#frcCnsltTable td:nth-child(3), td:nth-child(4), td:nth-child(5){
	text-align: center;
	width: 15%;
}
#frcCnsltTable td:nth-child(1){
	width: 15%;
}
</style>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-dots-fill" viewBox="0 0 16 16">
							  <path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 1 0-2 1 1 0 0 1 0 2"/>
							</svg>
                        </div>
                        	가맹 상담 관리
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<!-- 개발 관리 페이지 탭  -->
<nav class="nav nav-borders">
    <a class="nav-link ms-0" href="/preFrc/list">예비 창업자 관리&nbsp;
    <span class="badge bg-primary">신청 ${listCnt}</span></a>
    <a class="nav-link active" href="/frcCnslt/list">가맹 상담 관리&nbsp;
    <span class="badge" style="background-color: #12a512;">완료 ${cntY}</span>
    <span class="badge" style="background-color: #ffa700;">대기 ${cntN}</span></a>
</nav>
<hr class="mt-0 mb-4" />
<pre>본인 담당 창업 상담 예정자의 목록입니다.
담당 상담 배정을 취소할 수 있고, 상담 완료 후 상담내용을 기록할 수 있습니다.</pre>
    <div class="card">
        <div class="card-body">
            <table id="frcCnsltTable">
                <thead>
                    <tr>
                        <th>신청자명</th>
                        <th>프랜차이즈 유형</th>
                        <th>연락처</th>
                        <th>상담일시</th>
                        <th>진행상태</th>
                    </tr>
                </thead>
                <tbody>
           <c:forEach var="preFrc" items="${preFrcList}" varStatus="stat">
                    <tr>
                        <td><a href="/frcCnslt/detail?ibiNo=${preFrc.itvBscInfoVO.ibiNo}">${preFrc.rfNm}</a></td>
                        <td>${preFrc.frcsTypeVO.ftNm}</td>
                        <td>${preFrc.rfTelno}</td>
                        <td><fmt:formatDate value="${preFrc.itvBscInfoVO.ibiYmd}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <c:set var="passYn" value="${preFrc.itvBscInfoVO.ibiPassYn}" />
                        <td>
                        	<div class="badge" 
                        						<c:if test="${passYn eq 'N'}"> style="background-color: #ffa700;"</c:if>
                        						<c:if test="${passYn eq 'Y'}"> style="background-color: #12a512;"</c:if>
                        							>
                        		<c:if test="${passYn eq 'N'}">대기중</c:if>
                        		<c:if test="${passYn eq 'Y'}">상담 완료</c:if>
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
	const frcCnsltTable = document.getElementById('frcCnsltTable');
	if (frcCnsltTable) {
		new simpleDatatables.DataTable(frcCnsltTable, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "담당 가맹 상담이 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
});
</script>