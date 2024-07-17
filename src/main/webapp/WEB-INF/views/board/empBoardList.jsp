<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<header class="page-header page-header-dark bg-gradient-primary-to-secondary mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content pt-4">
            <div class="row align-items-center justify-content-between">
                <div class="col-auto mt-4">
                    <h1 class="page-header-title">
                        <div class="page-header-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg></div>
                        	오호코리아 질의응답
                    </h1>
                    <div class="page-header-subtitle">OHO KOREA FREE BOARD</div>
                </div>
            </div>
        </div>
    </div>
</header>
<style>
.datatable-pagination ul {
    margin: 50;
    padding-left: 50;
    display: flex;
    justify-content: center;
    list-style: none;
}

.datatable-pagination li {
    list-style: none;
    margin: 50 30px;
}
.datatable-bottom > nav:last-child, .datatable-bottom > div:last-child {
    float: none;
}

#datatablesSimple-freeBbs td:nth-child(1), td:nth-child(3) {
    text-align: center;
}
</style>
<!-- Main page content href="boardCreate"-->
<div class="container-fluid px-4">
    <div class="card">
        <div class="card-body">
            <table id="datatablesSimple-freeBbs">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>제목 </th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
           		<c:forEach var="freeBbs" items="${freeBbsList}" varStatus="stat">
                    <tr>
                        <td>${freeBbs.displayNo}</td>
                        <td><a href="empBoardDetail?fbNo=${freeBbs.fbNo}" style="color: #585858;">${freeBbs.fbTtl}</a></td>
                        <td>${freeBbs.fbPstdt}</td>
                        <td>${freeBbs.fbCount}</td>
                    </tr>
           		</c:forEach>
                </tbody>
            </table>
        	<c:if test="${empClsf eq 'A301'}">
        		<a class="btn btn-primary" href="empBoardCreate" style="float: right; position: relative; top: -36px;">작성하기</a>
        	</c:if>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="/resources/js/datatables/datatables-simple-demo.js"></script>
<script>
const dayTable = document.getElementById('datatablesSimple-freeBbs');
if (dayTable) {
    new simpleDatatables.DataTable(dayTable,{
          perPage: 10,
          perPageSelect: false,
          labels: {
              placeholder: "search...",
              searchTitle: "Search within table",
              pageTitle: "Page {page}",
              perPage: "",
              noRows: "날짜를 선택해주세요",
              info: " ",
              noResults: "검색결과가 없습니다.",
          }      
       }
    );
}
</script>