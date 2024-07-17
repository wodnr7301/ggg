<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>월별 매출 현황</title>
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

.gTable {
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

#middel-table td:nth-child(1) {
  text-align: center;
} 

#middel-table td:nth-child(2), 
#middel-table td:nth-child(3),
#middel-table td:nth-child(4),
#middel-table td:nth-child(5),
#middel-table td:nth-child(6),
#middel-table td:nth-child(7),
#middel-table td:nth-child(8),
#middel-table td:nth-child(9) {
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


/* 모달 영역 Style */
.modal-header {
    background-color: #33C2E1;
    border-top-left-radius: 5px; 
    border-top-right-radius: 5px; 
    padding: 15px;
    color: white;
}

.modal-body {
    height: 100%;
}

#give-body {
	height: 284px;
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
                                   	월별 매출 현황 / ${revenueList[0].frcsNm}
                        </h1>
                        <div class="page-header-subtitle">OHO KOREA FRANCHISE MANAGEMENT</div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="gTable">
        <div class="topTable">
        	<div class="card-header"><a href="revenue" style="color: #2E9AFE; font-size: 14px;"> 매출 관리/등록 > </a></div>
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
        <div class="card-body">
            <div id="chart-area" style="height: 100%; width: 100%;">
                <canvas id="myChart" width="1380" height="360"></canvas>
            </div>
        </div><br />
        <div class="card-footer small text-muted">[월별] 매출 총액 기준 통계 그래프</div>
    	<div id="revenueData" data-revenue="${revenueData}" style="display:none;"></div>
    </div><br/><br/><br/><br/>
    <div class="bigTable">
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
                </tr>
            </thead>
            <tbody>
                <c:forEach var="revenue" items="${revenueList}" varStatus="stat">
                    <tr class="revenueArea" id="middel-table" data-bs-toggle="modal" data-bs-target="#exampleModalScrollable">
                        <td scope="row">${revenue.fsMonthly}월</td>
                        <td class="number-format"><em style="color: #584D4D;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsAmt}" />원</em></td>
                        <td class="number-format"><em style="color: #5882FA;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsCost}" />원</em></td>
                        <td class="number-format"><em style="color: #FF6666;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsEarn}" />원</em></td>
                        <td class="number-format"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsLbrco}" />원</td>
                        <td class="number-format"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsNtslAmt}" />원</td>
                        <td class="number-format"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsMngAmt}" />원</td>
                        <td class="number-format"><em style="color: #0C9C56;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsOp}" />원</em></td>
                        <td class="number-format"><em style="color: #5858FA;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${revenue.fsExpense}" />원</em></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table><hr/>
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
    <div class="modal fade" id="exampleModalScrollable" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollable" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable" role="document">
        <div class="modal-content" style="width: 700px;">
            <div class="modal-header" style="display: flex; justify-content: space-between;">
			    <h5 class="modal-title" id="exampleModalScrollableTitle"><font color="white">매출 상세</font></h5>
			    <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
            <div class="modal-body" id="myModel">
                    <div class="row">
                        <div class="col-lg-6 split-col" style="width: 100%;">
                            <div class="card" id="name-body">
                                <div class="card-header">점포</div>
                                <div class="card-body">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>매장 정보</td>
                                                <td><div class="nameBody" style="line-height: 2.6;">${revenueList[0].frcsNm}</div></td>
                                            </tr>
                                            <tr>
                                            	<td>기준 월자</td>
                                                <td><span id="fsMonthly" style="line-height: 2.6;"></span></td>
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
                                    <i style="color:#FA5858">● 매출  원가 : 원자재 값+ 부자재 값+ 가맹점 비용을 합친 금액입니다. </i><p/>
                                    <i style="color:#FA5858">● 지출 총액 : 매출원가 + 인건비 +  판매비 + 관리비의 비용을 합친 금액입니다.  </i>
                                </div>
                            </div>
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
                                                <td>매출 총액</td>
                                                <td><span class="number-format" id="fsEarn" style="line-height: 2.6;"></span></td>
                                            </tr>
                                            <tr class="revenue-td" style="background-color: #F2F2F2;">
                                                <td>순이익</td>
                                                <td><span class="number-format" id="fsOp" style="line-height: 2.6;"></span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <i style="color:#FA5858">● 매출 총 액 : 매출액 - 매출원가 </i><p/>
                                    <i style="color:#FA5858">● 순이익 : 매출 총 액 - (인건비 + 판매비 + 관리비)</i> 
                                </div>
                            </div>
                        </div>
                    </div>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
var fsAmt = [];
var fsOp = [];
var fsMonthly = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
var myChart;

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

    // 년도 선택시 데이터 갱신
    $('.dropdown').on('click', '.dropdown-item', function() {
        let fsWrtYear = $(this).text().trim().replace("년", "");
        let selectedText = $(this).text().trim();
        let $dropdown = $(this).closest('.dropdown');

        $.ajax({
            url: "/frcowner/revenueMonth",
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
        
        $.ajax({
            url: "/frcowner/revenueMonthChartAjax",
            type: "get",
            data: { fsWrtYear: fsWrtYear },
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("성공데이터가 잘 들어오는지 확인 -> ", result);

                // 데이터 추출
                let pgArr = result.revenueData;
                let pg2AmtArr = [];
                let pg2OpArr = [];
                for(let i=0; i<pgArr.length; i++){
                    pg2AmtArr.push(pgArr[i].fsAmt);
                    pg2OpArr.push(pgArr[i].fsOp);
                }

                console.log("체크 ->", pg2AmtArr, pg2OpArr);
                console.log("체크 ->", pg2OpArr, pg2OpArr);

                updateChart(pg2AmtArr, pg2OpArr);

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
        $('#exampleModalScrollable #fsAmt').text(fsAmt);
        $('#exampleModalScrollable #fsCost').text(fsCost);
        $('#exampleModalScrollable #fsLbrco').text(fsLbrco);
        $('#exampleModalScrollable #fsNtslAmt').text(fsNtslAmt);
        $('#exampleModalScrollable #fsMngAmt').text(fsMngAmt);
        $('#exampleModalScrollable #fsEarn').text(fsEarn);
        $('#exampleModalScrollable #fsOp').text(fsOp);
        $('#exampleModalScrollable #fsWrtDt').text(fsWrtDt);
        $('#exampleModalScrollable #fsWrtYear').text(fsWrtYear);
        $('#exampleModalScrollable #fsMonthly').text(fsMonthly);
        $('#exampleModalScrollable #fsMdfcnDt').text(fsMdfcnDt);
        $('#exampleModalScrollable #fsWrtQy').text(fsWrtQy);
        $('#exampleModalScrollable #fsExpense').text(fsExpense);
    });

    // 차트 초기화
    <c:forEach var="revenue" items="${revenueData}">
    	fsAmt.push(${revenue.fsAmt});
    	fsOp.push(${revenue.fsOp});
    </c:forEach>

    const ctx = document.getElementById('myChart').getContext('2d');

    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: fsMonthly,
            datasets: [{
                label: '매출액',
                data: fsAmt,
                borderWidth: 1,
                backgroundColor: '#FA5858',
                borderColor: '#FA5858'
            },
            {
                label: '순이익',
                data: fsOp,
                borderWidth: 1,
                backgroundColor: '#04B404',
                borderColor: '#04B404'
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
});

function updateChart(newAmtData, newOpData) {
    // fsAmt 및 fsOp 배열 초기화
    fsAmt = [];
    fsOp = [];

    // 새로운 데이터 추가
    newAmtData.forEach(function(data) {
    	fsAmt.push(data);
    });

    newOpData.forEach(function(data) {
    	fsOp.push(data);
    });

    // 차트 업데이트
    myChart.data.datasets[0].data = fsAmt;
    myChart.data.datasets[1].data = fsOp;
    myChart.update();
}
</script>


</body>
</html>
