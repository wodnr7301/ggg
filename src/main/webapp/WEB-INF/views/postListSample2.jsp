<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-fluid px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon"><i data-feather="list"></i></div>
                        	예비 창업자 관리
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-fluid px-4">
    <div class="card">
        <div class="card-body">
            <table id="datatablesSimple">
                <thead>
                    <tr>
                        <th>프랜차이즈 유형</th>
                        <th>신청자명</th>
                        <th>연락처</th>
                        <th>신청일</th>
                        <th>상담일 지정</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>프랜차이즈 유형</th>
                        <th>신청자명</th>
                        <th>연락처</th>
                        <th>신청일</th>
                        <th>상담일 지정</th>
                    </tr>
                </tfoot>
                <tbody>
<%--            <c:forEach var="" items="" varStatus="stat"> --%>
                    <tr>
                        <td>빽다방</td>
                        <td>이창섭</td>
                        <td>010-1111-1111</td>
                        <td>2024-05-30</td>
                        <td>
                            <button class="btn btn-outline-primary btn-sm" type="button">일시 선택</button>
                        </td>
                    </tr>
<%--            </c:forEach> --%>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="/resources/js/datatables/datatables-simple-demo.js"></script>