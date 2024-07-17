<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    const datatablesSimple = document.getElementById('mngLedgerTable');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
        	paging: false,
        	perPageSelect: false,
            labels: {
                placeholder: "Search...",
                searchTitle: "Search within table",
                pageTitle: "Page {page}",
                perPage: "",
                noRows: "No entries found",
                info: " ",
                noResults: "No results match your search query",
            }
        });
    }
});
</script>
    <style>
        /* 테이블 셀의 텍스트를 가운데 정렬 */
       .mngLedgerTable td {
            text-align: center;
        }
    </style> 
<header
	class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
	<div class="container-xl px-4">
		<div class="page-header-content pt-4">
			<div class="row align-items-center justify-content-between">
				<div class="col-auto mt-4">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<i data-feather="layout"></i>
						</div>
						법인차량 관리대장
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone">법인차량 관리대장 목록</div>
		<div class="card-body main-card">
			<table id="mngLedgerTable" class="mngLedgerTable">
				<thead>
					<tr>
						<th>차량관리대장번호</th>
						<th>법인차량 번호</th>
						<th>대여자</th>
						<th>대여일자</th>
						<th>반납일자</th>
						<th>대여 목적</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="mngldgr" items="${ledger}" varStatus="stat">
						<tr>
							<td>${mngldgr.cvmlNo}</td>
							<td>${mngldgr.cvNo}</td>
							<td>${mngldgr.cvmlUser}</td>
							<td><fmt:formatDate value="${mngldgr.cvmlRentYmd}" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${mngldgr.cvmlRtnYmd}" pattern="yyyy-MM-dd" /></td>
							<td>${mngldgr.cvmlUsePrps}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
