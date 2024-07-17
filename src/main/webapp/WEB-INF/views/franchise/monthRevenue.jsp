<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>월별 매출 현황</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<style>
.bigTable {
  background-color: white; /* 배경색을 하얀색으로 설정 */
  width: 85%; /* 너비를 80%로 설정, 필요에 따라 조절 가능 */
  margin: 0 auto; /* 화면의 중심에 위치하도록 설정 */
  margin-top: -90px;
  padding: 20px; /* 테이블 주위에 패딩 추가 */
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 테이블에 그림자 효과 추가 */
  border-radius: 10px; /* 테이블 모서리를 둥글게 설정 */
}

.topTable {
  display: flex; /* Flexbox로 설정 */
  justify-content: space-between; /* 좌우로 정렬 */
  align-items: center; /* 중앙 정렬 */
}

.table {
  width: 100%; /* 테이블 너비를 부모 요소에 맞게 설정 */
  border-collapse: collapse; /* 테이블 경계선이 겹치지 않도록 설정 */
}

.table th, .table td {
  padding: 8px; /* 셀 내부 여백 설정 */
  text-align: left; /* 셀 내용 왼쪽 정렬 */
  border: 1px solid #ddd; /* 셀 경계선 설정 */
}

.table thead {
  background-color: #f9f9f9; /* 테이블 헤더 배경색 설정 */
}

.table-hover tbody tr:hover {
  background-color: #f1f1f1; /* 행에 마우스를 올렸을 때 배경색 변경 */
}

#header-table th:nth-child(-n+11) {
  text-align: center;
}

#middel-table td:nth-child(-n+9) {
  text-align: right;
}

#modal-table-regist-1 th:nth-child(-n+2){
  text-align: center;
}

#modal-table-regist-2 th:nth-child(-n+2){
  text-align: center;
}

#modal-table-regist-3 th:nth-child(-n+2){
  text-align: center;
}

#modal-table-edit-1 th:nth-child(-n+2){
  text-align: center;
}

#modal-table-edit-2 th:nth-child(-n+2){
  text-align: center;
}

#modal-table-edit-3 th:nth-child(-n+2){
  text-align: center;
}

.revenue-td td:nth-child(2){
  text-align: right;
  display=
}

#middel-table td:nth-child(10),
#middel-table td:nth-child(11),
#middel-table td:nth-child(12) {
  text-align: center;
}

/* 모달 영역 Style (insert) */
.modal-header {
    background-color: #5882FA;
    color: white;
}
.modal-body {
    padding: 20px;
    height: 100%;
}
.card-header {
    background-color: #f8f9fa;
    font-weight: bold;
}
.table thead th {
    background-color: #e9ecef;
}
.table td input {
    width: 100%;
}
.table td {
    vertical-align: middle;
}
.split-col {
    display: flex;
    flex-direction: column;
    gap: 20px;
}
#give-body {  
 	height: 401px; 
}
#give-body-detail {  
 	height: 460px; 
}

/* 모달 영역 Style (update) */
.modal-header-2 {
    background-color: #33C2E1;
    border-top-left-radius: 5px; 
    border-top-right-radius: 5px; 
    padding: 15px;
    color: white;
}
.modal-body-2 {
	padding: 20px;
    height: 100%;
}
#give-body-2 {
	height: 284px;
}

.number-format {
    min-width: 120px;
    white-space: nowrap;
}

.small-text {
            font-size: 0.8em; /* 작은 글씨 크기 */
            font-family: Arial, sans-serif; /* 그럴싸한 글씨체 */
            line-height: 1.5em; /* 가독성을 위한 줄 간격 */
}
</style>
</head>
<body>
<main>
    <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
        <div class="container-xl px-4">
            <div class="page-header-content pt-4">
                <div class="row align-items-center justify-content-between">
                    <div class="col-auto mt-4">
                        <h1 class="page-header-title">
                            <div class="page-header-icon">
                                <i data-feather="bar-chart"></i>
                            </div>
                                                 매출 현황 등록 / ${revenueList[0].frcsNm}
                        </h1>
                        <div class="page-header-subtitle">OHO KOREA FRANCHISE MANAGEMENT</div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="bigTable">
        <div class="topTable">
            <a href="revenue" style="color: #2E9AFE; font-size: 14px;"> 매출관리 > </a><br /><br />
            <div class="dropdown">
                <button class="btn btn-gray btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">${fsWrtYear}년</button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">2024년</a></li>
                    <li><a class="dropdown-item" href="#">2023년</a></li>
                    <li><a class="dropdown-item" href="#">2022년</a></li>
                    <li><a class="dropdown-item" href="#">2021년</a></li>
                    <li><a class="dropdown-item" href="#">2020년</a></li>
                </ul>
            </div>
        </div>
        <hr />
        <table class="table table-striped table-hover table-bordered table-sm" id="revenueTable">
            <thead class="table-light" id="header-table">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">매출액</th>
                    <th scope="col">제품 원가   
                    	<svg data-bs-toggle="tooltip" data-bs-placement="right" style="color: gray" title="원자재비 발생 액수" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
						</svg>
					</th>
                    <th scope="col">매출 총 액
                    	<svg data-bs-toggle="tooltip" data-bs-placement="right" style="color: gray" title="매출액 - 제품원가 = 매출총액" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
						</svg>
                    </th>
                    <th scope="col">인건비</th>
                    <th scope="col">판매비</th>
                    <th scope="col">관리비</th>
                    <th scope="col">순이익
                    	<svg data-bs-toggle="tooltip" data-bs-placement="right" style="color: gray" title="매출총액 - (인건비 + 판매비 + 관리비) = 순이익" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
						</svg>
                    </th>
                    <th scope="col">지출 총 액
                    	<svg data-bs-toggle="tooltip" data-bs-placement="right" style="color: gray" title="모든 지출 액의 합계" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
						</svg>
                    </th>
                    <th scope="col">기준일</th>
                    <th scope="col">수정일</th>
                    <th scope="col">작성년도</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="revenue" items="${revenueList}" varStatus="stat">
                    <tr class="revenueArea" id="middel-table" data-bs-toggle="modal" data-bs-target="#exampleModalXl-2">
                        <td scope="row">${revenue.fsMonthly}월</td>
                        <td class="number-format"><em style="color: #584D4D;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsAmt}" />원</em></td>
                        <td class="number-format"><em style="color: #5882FA;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsCost}" />원</em></td>
                        <td class="number-format"><em style="color: #FF6666;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsEarn}" />원</em></td>
                        <td class="number-format"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsLbrco}" />원</td>
                        <td class="number-format"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsNtslAmt}" />원</td>
                        <td class="number-format"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsMngAmt}" />원</td>
                        <td class="number-format"><em style="color: #0C9C56;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsOp}" />원</em></td>
                        <td class="number-format"><em style="color: #5858FA;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsExpense}" />원</em></td>
                        <td>${revenue.fsWrtDt}</td>
                        <td>${revenue.fsMdfcnDt}</td>
                        <td>${revenue.fsWrtYear}년</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table><hr/>
            <div style="float: right;">
				<button class="btn btn-primary btn-sm" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalXl-1">매출 등록</button>
            </div>
        <div class="small-text">
	        <b style="color:#848484">● 가맹점주님의 순이익 계산 방식은 아래와 같습니다. 각 항목을 다음과 같은 알파벳으로 정의하여 계산합니다.</b>&nbsp;&nbsp;&nbsp;
	        <i style="color:#FA5858">A = 매출액   /   B = 제품 원가   /   C = 매출 총액   /   D = 인건비   /   E = 판매비   /   F = 관리비   /   G = 순이익</i><br/>
			<b style="color:#848484">● 매출 총액(C)은 매출액(A)에서 제품 원가(B)를 차감한 금액입니다.</b>&nbsp;&nbsp;&nbsp;
			<h style="color:#FA5858">𝐶 = 𝐴 − 𝐵</h><br/>
			<b style="color:#848484">● 순이익(G)은 매출 총액(C)에서 인건비(D), 판매비(E), 관리비(F)를 차감한 금액입니다.</b>&nbsp;&nbsp;&nbsp;
			<h style="color:#FA5858">𝐺 = 𝐶−(𝐷+𝐸+𝐹)</h><br/>
			<b style="color:#848484">● 이를 종합하면 다음과 같습니다.</b>&nbsp;&nbsp;&nbsp;
			<h style="color:#FA5858">𝐺 = (𝐴−𝐵)−(𝐷+𝐸+𝐹)</h>
		</div>
    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
    <div class="modal fade" id="exampleModalXl-1" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><font color="white">매출 등록</font></h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal"
					aria-label="Close"></button>
            </div>
            <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-6 split-col">
                            <div class="card" id="name-body">
                                <div class="card-header">매출</div>
                                <div class="card-body">
                                    <table class="table">
                                        <tbody>
                                        	<thead id="modal-table-regist-1">
                                            	<tr>
                                                	<th>항목</th>
                                                	<th>금액</th>
                                            	</tr>
                                        	</thead>
                                        <tbody>
                                        	<tr>
                                                <td>수익(매출액)</td>
                                                <td><input class="form-control" id="fsAmt" name="fsAmt" type="text" placeholder="숫자만 입력"></td>
                                            </tr>
                                       </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">지출</div>
                                <div class="card-body" id="give-body">
                                    <table class="table">
                                        <thead id="modal-table-regist-1">
                                            <tr>
                                                <th>항목</th>
                                                <th>금액</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>매출 원가</td>
                                                <td><input class="form-control" id="fsCost" name="fsCost" type="text" placeholder="미입력시 0원으로 처리"></td>
                                            </tr>
                                            <tr>
                                                <td>인건비</td>
                                                <td><input class="form-control" id="fsLbrco" name="fsLbrco" type="text" placeholder="미입력시 0원으로 처리"></td>
                                            </tr>
                                            <tr>
                                                <td>판매비</td>
                                                <td><input class="form-control" id="fsNtslAmt" name="fsNtslAmt" type="text" placeholder="미입력시 0원으로 처리"></td>
                                            </tr>
                                            <tr>
                                                <td>관리비</td>
                                                <td><input class="form-control" id="fsMngAmt" name="fsMngAmt" type="text" placeholder="미입력시 0원으로 처리"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <i style="color:red">● 매출  원가 : 원자재 값+ 부자재 값+ 가맹점 비용을 합친 내용입니다. </i>
                                    <i style="color:gray">● 매출 총 액 : 매출액 - 매출원가 </i><p/>
                                    <i style="color:gray">● 순이익 : 매출 총 액 - (인건비 + 판매비 + 관리비)</i> 
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 split-col">
                            <div class="card">
                                <div class="card-header">결산</div>
                                <div class="card-body">
                                    <table class="table">
                                        <thead id="modal-table-regist-2">
                                            <tr>
                                                <th>항목</th>
                                                <th>금액</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>매출 총 액</td>
                                                <td><input class="form-control form-control-solid" id="fsEarn" name="fsEarn" type="text" placeholder="매출 총 이익 액수" readonly></td>
                                            </tr>
                                            <tr>
                                                <td>순이익</td>
                                                <td><input class="form-control form-control-solid" id="fsOp" name="fsOp" type="text" placeholder="순이익 액수" readonly></td>
                                            </tr>
                                            <tr>
                                                <td>총 지출</td>
                                                <td><input class="form-control form-control-solid" id="fsExpense" name="fsExpense" type="text" placeholder="총 지출" readonly></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">일자</div>
                                <div class="card-body">
                                    <table class="table">
                                        <thead id="modal-table-regist-3">
                                            <tr>
                                                <th>항목</th>
                                                <th>연도월일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>기준일자</td>
                                                <td><input type="date" class="form-control" id="fsWrtDt" name="fsWrtDt"></td>
                                            </tr>
                                            <tr>
                                                <td>년도/분기</td>
                                                <td>
                                                    <input class="form-control form-control-solid mb-2" id="fsWrtYear" name="fsWrtYear" type="text" placeholder="연도 자동 생성" readonly>
                                                    <input class="form-control form-control-solid block" id="fsWrtQy" name="fsWrtQy" type="text" placeholder="분기 자동 생성" readonly>
                                                    <input class="form-control" id="fsMonthly" name="fsMonthly" type="hidden" placeholder="월 자동 생성" readonly>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="submitRevenue">등록</button>
                <button type="button" class="btn btn-light" id="btnCalculate">계산</button>
            </div>
        </div>
    </div>
</div>
    <div class="modal fade" id="exampleModalXl-2" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header-2" style="display: flex; justify-content: space-between;">
			    <h5 class="modal-title"><font color="white">매출 상세</font></h5>
			    <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
            <div class="modal-body-2" id="myModel">
                    <div class="row">
                        <div class="col-lg-6 split-col">
                            <div class="card" id="name-body">
                                <div class="card-header">점포</div>
                                <div class="card-body">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>매장 정보</td>
                                                <td><div class="nameBody">${revenueList[0].frcsNm}</div></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">지출</div>
                                <div class="card-body" id="give-body-detail">
                                    <table class="table">
                                        <thead id="modal-table-edit-1">
                                            <tr>
                                                <th>항목</th>
                                                <th>금액</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           
                                            <tr class="revenue-td">
                                                <td>매출 원가</td>
                                                <td><span class="number-format" id="fsCost" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td">
                                                <td>인건비</td>
                                                <td><span class="number-format" id="fsLbrco" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td">
                                                <td>판매비</td>
                                                <td><span class="number-format" id="fsNtslAmt" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td">
                                                <td>관리비</td>
                                                <td><span class="number-format" id="fsMngAmt" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td" style="background-color: #F2F2F2;">
                                                <td>지출 총액</td>
                                                <td><span class="number-format" id="fsExpense" style="line-height: 2.6;"></span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                     <i style="color:red">● 매출  원가 : 원자재 값+ 부자재 값+ 가맹점 비용을 합친 내용입니다. </i>
                                    <i style="color:gray">● 매출 총 액 : 매출액 - 매출원가 </i><p/>
                                    <i style="color:gray">● 순이익 : 매출 총 액 - (인건비 + 판매비 + 관리비)</i> 
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 split-col">
                            <div class="card">
                                <div class="card-header">수익</div>
                                <div class="card-body">
                                    <table class="table">
                                        <thead id="modal-table-edit-2">
                                            <tr>
                                                <th>항목</th>
                                                <th>금액</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                         	<tr class="revenue-td">
                                                <td>수익(매출액)</td>
                                                <td><span class="number-format" id="fsAmt" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td">
                                                <td>매출 총 이익</td>
                                                <td><span class="number-format" id="fsEarn" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td" style="background-color: #F2F2F2;">
                                                <td>순이익</td>
                                                <td><span class="number-format" id="fsOp" style="line-height: 2.6;"></span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">일자</div>
                                <div class="card-body" id="give-body-2">
                                    <table class="table">
                                        <thead id="modal-table-edit-3">
                                            <tr>
                                                <th>항목</th>
                                                <th>연도월일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>기준일자</td>
                                                <td><span id="fsWrtDt" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr>
                                                <td>수정일자</td>
                                                <td>
												    <span class="number-format" id="fsWrtQy" style="line-height: 2.6;"></span>
												</td>
                                            </tr>
                                            <tr>
                                                <td>기준월자</td>
                                                <td>
                                                	<span id="fsMonthly" style="line-height: 2.6;"></span>
												    <span class="number-format" id="fsWrtYear"  style="display: none"></span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="updateRevenue" >수정</button>
                <button type="button" class="btn btn-light" id="deleteRevenue" >삭제</button>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</main>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
	
	var rowData = [];
    // 콤마 추가 함수
    function addCommas(nStr) {
        nStr += '';
        var x = nStr.split('.');
        var x1 = x[0];
        var x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
        }
        return x1 + x2;
    }
    
    // 콤마 제거 함수
    function removeCommas(nStr) {
        return nStr.replace(/,/g, '');
    }

    // 숫자 입력 필드에 콤마 추가
    $('input[type="text"]').on('input', function() {
        var value = removeCommas($(this).val());
        if (!isNaN(value)) {
            $(this).val(addCommas(value));
        }
    });

    // AJAX로 매출 총 이익 및 순이익 계산
    $('#btnCalculate').click(function() {
        var fsAmt = parseFloat(removeCommas($('#fsAmt').val())) || 0;
        var fsCost = parseFloat(removeCommas($('#fsCost').val())) || 0;
        var fsLbrco = parseFloat(removeCommas($('#fsLbrco').val())) || 0;
        var fsNtslAmt = parseFloat(removeCommas($('#fsNtslAmt').val())) || 0;
        var fsMngAmt = parseFloat(removeCommas($('#fsMngAmt').val())) || 0;

        var fsEarn = fsAmt - fsCost;
        var fsOp = fsEarn - (fsLbrco + fsNtslAmt + fsMngAmt);
        var fsExpense = (fsCost + fsLbrco + fsNtslAmt + fsMngAmt);

        $('#fsEarn').val(addCommas(Math.floor(fsEarn)));
        $('#fsOp').val(addCommas(Math.floor(fsOp)));
        $('#fsExpense').val(addCommas(Math.floor(fsExpense)));
    });

    // 작성일자 선택 시 작성년도 및 분기 자동 입력
    $('#fsWrtDt').on('change', function() {
        var date = new Date($(this).val());
        var year = date.getFullYear();
        var month = date.getMonth() + 1;

        $('#fsWrtYear').val(year);
        $('#fsMonthly').val(month);
        
        var quarter;
        if (month >= 1 && month <= 3) {
            quarter = 1;
        } else if (month >= 4 && month <= 6) {
            quarter = 2;
        } else if (month >= 7 && month <= 9) {
            quarter = 3;
        } else if (month >= 10 && month <= 12) {
            quarter = 4;
        }

        $('#fsWrtQy').val(quarter);
    });

    // 년도 선택시 데이터 갱신
    $('.dropdown').on('click', '.dropdown-item', function() {
        let fsWrtYear = $(this).text().trim().replace("년", "");
        let selectedText = $(this).text().trim();
        let $dropdown = $(this).closest('.dropdown');
        
        $.ajax({
            url: "/frcowner/monthRevenue",
            type: "get",
            data: { fsWrtYear: fsWrtYear },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                let newTableBody = $(result).find('#revenueTable tbody').html();
                $('#revenueTable tbody').html(newTableBody);
                $dropdown.find('.btn.dropdown-toggle').text(selectedText);
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
            }
        });
    });
    
    $(document).on('click', '.revenueArea', function() {
        var fsMonthly = $(this).find('td:eq(0)').text();
        var fsAmt = $(this).find('td:eq(1)').text();
        var fsCost = $(this).find('td:eq(2)').text();
        var fsEarn = $(this).find('td:eq(3)').text();
        var fsLbrco = $(this).find('td:eq(4)').text();
        var fsNtslAmt = $(this).find('td:eq(5)').text();
        var fsMngAmt = $(this).find('td:eq(6)').text();
        var fsOp = $(this).find('td:eq(7)').text();
        var fsWrtDt = $(this).find('td:eq(10)').text();
        var fsWrtYear = $(this).find('td:eq(11)').text();
        var fsWrtQy = $(this).find('td:eq(9)').text();
        var fsMdfcnDt = $(this).find('td:eq(12)').text();
        var fsExpense = $(this).find('td:eq(8)').text();

        // 모달에 데이터를 설정
        $('#exampleModalXl-2 #fsAmt').text(fsAmt);
        $('#exampleModalXl-2 #fsCost').text(fsCost);
        $('#exampleModalXl-2 #fsLbrco').text(fsLbrco);
        $('#exampleModalXl-2 #fsNtslAmt').text(fsNtslAmt);
        $('#exampleModalXl-2 #fsMngAmt').text(fsMngAmt);
        $('#exampleModalXl-2 #fsEarn').text(fsEarn);
        $('#exampleModalXl-2 #fsOp').text(fsOp);
        $('#exampleModalXl-2 #fsWrtDt').text(fsWrtDt);
        $('#exampleModalXl-2 #fsWrtYear').text(fsWrtYear);
        $('#exampleModalXl-2 #fsMonthly').text(fsMonthly);
        $('#exampleModalXl-2 #fsMdfcnDt').text(fsMdfcnDt);
        $('#exampleModalXl-2 #fsWrtQy').text(fsWrtQy);
        $('#exampleModalXl-2 #fsExpense').text(fsExpense);
    });


    // 폼 데이터를 서버로 전송하는 함수
    $('#submitRevenue').click(function() {
        var revenueData = {
            frcsNo: "FRC001", // 필요한 경우 동적으로 설정
            fsAmt: removeCommas($('#fsAmt').val()),
            fsCost: removeCommas($('#fsCost').val()),
            fsEarn: removeCommas($('#fsEarn').val()),
            fsOp: removeCommas($('#fsOp').val()),
            fsWrtDt: $('#fsWrtDt').val(),
            fsLbrco: removeCommas($('#fsLbrco').val()),
            fsNtslAmt: removeCommas($('#fsNtslAmt').val()),
            fsMngAmt: removeCommas($('#fsMngAmt').val()),
            fsWrtYear: $('#fsWrtYear').val(),
            fsMonthly: $('#fsMonthly').val(),
            fsWrtQy: $('#fsWrtQy').val(),
            fsExpense: removeCommas($('#fsExpense').val())
        };
        
        $.ajax({
            type: 'POST',
            url: '/frcowner/revenueCreate',
            contentType: 'application/json',
            data: JSON.stringify(revenueData),
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(response) {
                if(response.status === 'SUCCESS') {
                    // 성공 시 실행할 코드
                    console.log('등록 성공:', response);
                    Swal.fire({
                        title: "매출 등록이 완료되었습니다",
                        icon: 'success'
                    }).then((result) => {
                        if (result.isConfirmed) {
 		                    location.reload();
                        }
                    });
                    
                    $.ajax({
                        url: '/frcowner/monthRevenue',
                        type: 'get',
                        data: { fsWrtYear: $('#fsWrtYear').val() },
                        success: function(result) {
                            let newTableBody = $(result).find('#revenueTable tbody').html();
                            $('#revenueTable tbody').html(newTableBody);
                        },
                        error: function(xhr, status, error) {
                            console.error('데이터 새로 고침 실패:', error);
                        }
                    });
                    // 추가적인 처리나 메시지 표시 등을 할 수 있습니다.
                } else {
                    console.error('등록 실패:', response);
                    swal.fire("등록에 실패하였습니다.","","error");
                }
            },
            error: function(xhr, status, error) {
                // 오류 처리
                console.error('등록 실패:', error);
                swal.fire("등록에 실패하였습니다.","","error");
            }
        });   
    });
 	
	 // 수정 버튼을 눌렀을 때
    $('#updateRevenue').on('click', function() {
        // 모든 텍스트를 입력 필드로 변경
        $('.modal-body-2 span').each(function() {
            var text = $(this).text().replace(/,/g, '').replace('원', '').replace('월', '').replace('년', ''); // 콤마와 '원', '월' 제거
            var id = $(this).attr('id');
            if (id !== 'fsMdfcnDt' && id !== 'fsWrtDt' && id !== 'fsWrtQy') { // 작성일자, 수정일자는 수정 안함
                if (id === 'fsWrtYear') {
                    // 작성연도는 숫자가 아닌 문자열로 받기 위해 input 타입을 text로 변경
                    $(this).replaceWith('<input type="text" id="' + id + '" value="' + text + '">');
                } else {
                    $(this).replaceWith('<input type="text" id="' + id + '" value="' + text + '">');
                }
            }
        });

        // 숫자를 입력할 때마다 세 자리마다 콤마 추가
        $('input[type="text"]').on('input', function() {
            var number = $(this).val().replace(/,/g, '');
            $(this).val(addCommas(number));
        });

        // 버튼의 텍스트와 이벤트 핸들러를 변경
        $(this).text('수정 완료').off('click').on('click', function() {
            // 입력 필드를 텍스트로 변경하고 데이터 수집
            var data = {};
            $('.modal-body-2 input[type="text"]').each(function() {
                var id = $(this).attr('id');
                var value = $(this).val().replace(/,/g, '');
                if (id === 'fsWrtYear') {
                    // 작성연도는 숫자가 아닌 문자열 그대로 가져오기
                    value = $(this).val(); // 숫자 형식 변환 로직 제외
                }
                data[id] = value; // 데이터를 객체에 추가
                $(this).replaceWith('<span id="' + id + '">' + value + '</span>');
            });

            // AJAX 요청을 사용하여 서버에 데이터 전송
            $.ajax({
                type: 'POST',
                url: '/frcowner/revenueUpdate', 
                contentType: 'application/json',
                data: JSON.stringify(data), 
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(response) {
                    Swal.fire({
                        title: "매출 수정이 완료되었습니다",
                        icon: 'success'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $('#exampleModalXl-2').modal('hide'); // 모달 닫기
 		                    location.reload();
                        }
                    });
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        title: "매출 수정에 실패하였습니다",
                        text: error,
                        icon: 'error'
                    });
                }
            });
            $(this).text('수정').off('click').on('click', function() {
            });
        });
    });
	 
    $(document).ready(function() {
        // 삭제 버튼 클릭 이벤트 핸들러
        $('#deleteRevenue').click(function() {
            var result = confirm('정말 삭제하겠습니까?');
            if (result) {
                // 연도와 월의 텍스트를 가져와서 뒤에 붙은 글씨를 제거
                var fsWrtYear = $('#exampleModalXl-2 #fsWrtYear').text().trim().replace(/[^0-9]/g, '');
                var fsMonthly = $('#exampleModalXl-2 #fsMonthly').text().trim().replace(/[^0-9]/g, '');

                // 콘솔 로그로 값 확인
                console.log("fsWrtYear:", fsWrtYear);
                console.log("fsMonthly:", fsMonthly);

                // 입력된 값이 유효한지 확인
                if (fsWrtYear && fsMonthly && !isNaN(fsWrtYear) && !isNaN(fsMonthly) && fsMonthly >= 1 && fsMonthly <= 12) {
                    // 삭제 요청 보내기
                    $.ajax({
                        url: '/frcowner/revenueDelete',
                        type: 'POST',
                        data: JSON.stringify({ fsWrtYear: fsWrtYear, fsMonthly: Number(fsMonthly) }),
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        contentType: 'application/json; charset=utf-8',
                        success: function(response) {
                            Swal.fire({
                                title: "삭제가 완료되었습니다",
                                icon: 'success'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    $('#exampleModalXl-2').modal('hide'); // 모달 닫기
                                    location.reload(); // 페이지 새로 고침
                                }
                            });
                        },
                        error: function(error) {
                            Swal.fire({
                                title: "삭제를 실패하였습니다",
                                icon: 'error'
                            });
                        }
                    });
                } else {
                    alert("올바른 연도와 월을 입력해 주세요.");
                }
            }
        });
    });

});
</script>
</body>
</html>
