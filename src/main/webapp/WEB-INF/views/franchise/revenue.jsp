<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>매출관리 메인페이지</title>
<style>
.card-header {
    display: flex; /* Flexbox로 설정 */
    justify-content: space-between; /* 좌우로 정렬 */
    align-items: center; /* 중앙 정렬 */
}

</style>    
</head>
<body class="nav-fixed">
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
                            	매출 관리
                    </h1>
                    <div class="page-header-subtitle">OHO KOREA FRANCHISE MANAGEMENT</div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="container-xl px-4 mt-n10">
    <!-- Area chart example-->
    <div class="card mb-4">
        <div class="card-header">${fsWrtYear}년 매출/지출 통계
            <a class="btn btn-primary" href="monthRevenue" style="float: right; position: relative;">매출등록</a>
        </div>
        <div class="card-body">
            <div id="chart-area" style="height: 100%; width: 100%;">
                <canvas id="myChart" width="100%" height="30"></canvas>
            </div>
        </div>
    </div>
    <div class="row">
        
        <div class="col-lg-6">
        <a class="card card-icon lift lift-sm mb-2" href="revenueMonth">
             <div class="row g-0">
                 <div class="col-auto card-icon-aside bg-primary"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#ffffff" class="bi bi-currency-dollar" viewBox="0 0 16 16">
  					<path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73z"/>
					</svg>
				</div>
                 <div class="col">
                     <div class="card-body py-5">
                         <h3 class="card-title text-primary mb-2">월별 매출 현황</h3>
                         <p class="card-text mb-1" style="color: #898484">월별 매출 현황 바로가기   >></p>
                         <div class="small text-muted"></div>
                     </div>
                 </div>
             </div>
         </a>
         <a class="card card-icon lift lift-sm mb-2" href="revenueYear">
             <div class="row g-0">
                 <div class="col-auto card-icon-aside bg-secondary"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#ffffff" class="bi bi-currency-dollar" viewBox="0 0 16 16">
  					<path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73z"/>
					</svg>
				</div>
                 <div class="col">
                     <div class="card-body py-5">
                         <h3 class="card-title text-secondary mb-2">연도별 매출 현황</h3>
                         <p class="card-text mb-1" style="color: #898484">연도별 매출 현황 바로가기   >></p>
                         <div class="small text-muted"></div>
                     </div>
                 </div>
             </div>
         </a>
         <a class="card card-icon lift lift-sm mb-2" href="revenueQuater">
             <div class="row g-0">
                 <div class="col-auto card-icon-aside bg-teal"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#ffffff" class="bi bi-currency-dollar" viewBox="0 0 16 16">
  					<path d="M4 10.781c.148 1.667 1.513 2.85 3.591 3.003V15h1.043v-1.216c2.27-.179 3.678-1.438 3.678-3.3 0-1.59-.947-2.51-2.956-3.028l-.722-.187V3.467c1.122.11 1.879.714 2.07 1.616h1.47c-.166-1.6-1.54-2.748-3.54-2.875V1H7.591v1.233c-1.939.23-3.27 1.472-3.27 3.156 0 1.454.966 2.483 2.661 2.917l.61.162v4.031c-1.149-.17-1.94-.8-2.131-1.718zm3.391-3.836c-1.043-.263-1.6-.825-1.6-1.616 0-.944.704-1.641 1.8-1.828v3.495l-.2-.05zm1.591 1.872c1.287.323 1.852.859 1.852 1.769 0 1.097-.826 1.828-2.2 1.939V8.73z"/>
					</svg>
				</div>
                 <div class="col">
                     <div class="card-body py-5">
                         <h3 class="card-title text-teal mb-2">분기별 매출 현황</h3>
                         <p class="card-text mb-1" style="color: #898484">분기별 매출 현황 바로가기   >></p>
                         <div class="small text-muted"></div>
                     </div>
                 </div>
             </div>
         </a>
        </div>
        <div class="col-lg-6">
		    <div class="card mb-4">
		        <div class="card-header"><a href="/frcowner/frcowner/revenueQuater">연간 지출 내역</a></div>
		        <div class="card-body">
		            <div class="chart-bar" style="float: left; width: 50%;">
		                <canvas id="myChart2" width="100%" height="40"></canvas>
		            </div>
					<hr />		            
					<div id="infoArea" style="float: right; width: 40%; font-size: 17px;"></div>
		            <div style="clear: both;"></div>
					<hr />	
		        </div>
		    </div>
		</div>
    </div>
</div>
</main>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0/dist/chartjs-plugin-datalabels.min.js" crossorigin="anonymous"></script>
<script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/js/all.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    var fsAmt = [];
    var fsExpense = [];
    var fsMonthly = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
    <c:forEach var="revenue" items="${revenueData}">
        fsAmt.push(${revenue.fsAmt});
        fsExpense.push(${revenue.fsExpense});
    </c:forEach>

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: fsMonthly,
            datasets: [
                {
                    label: '매출 총액',
                    data: fsAmt,
                    backgroundColor: 'rgba(0, 150, 250, 0.6)'
                },
                {
                    label: '지출 총액',
                    data: fsExpense,
                    backgroundColor: 'rgba(255, 174, 0, 0.6)'
                }
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        callback: function(value, index, values) {
                            return '₩' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        },
                        beginAtZero: true
                    }
                }]
            },
            plugins: {
                datalabels: {
                    formatter: function(value, context) {
                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원';
                    },
                    anchor: 'end',
                    align: 'top'
                }
            }
        },
        plugins: [ChartDataLabels]
    });
});

$(document).ready(function() {
    var totalLbrco = 0;
    var totalNtslAmt = 0;
    var totalMngAmt = 0;
    var totalCost = 0;
    var fsWrtYear = ${fsWrtYear};

    <c:forEach var="revenue" items="${revenueData}">
        if (${revenue.fsWrtYear} == fsWrtYear) {
            totalLbrco += ${revenue.fsLbrco};
            totalNtslAmt += ${revenue.fsNtslAmt};
            totalMngAmt += ${revenue.fsMngAmt};
            totalCost += ${revenue.fsCost};
        }
    </c:forEach>

    var totalAmount = totalLbrco + totalNtslAmt + totalMngAmt + totalCost;

    var lbrcoPercentage = (totalLbrco / totalAmount) * 100;
    var ntslAmtPercentage = (totalNtslAmt / totalAmount) * 100;
    var mngAmtPercentage = (totalMngAmt / totalAmount) * 100;
    var costPercentage = (totalCost / totalAmount) * 100;

    var ctx = document.getElementById('myChart2').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['인건비', '판매비', '관리비', '매출원가'],
            datasets: [
                {
                    data: [totalLbrco, totalNtslAmt, totalMngAmt, totalCost],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.6)',
                        'rgba(255, 159, 64, 0.6)',
                        'rgba(255, 99, 71, 0.6)',
                        'rgba(25, 199, 51, 0.6)'
                    ],
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                datalabels: {
                    display: false // 데이터 라벨을 표시하지 않도록 설정
                }
            }
        },
        plugins: [ChartDataLabels]
    });

    // 레이블과 색상, 퍼센테이지를 저장하는 배열을 생성합니다
    var labels = ['인건비 &nbsp &nbsp &nbsp &nbsp', '판매비 &nbsp &nbsp &nbsp &nbsp', '관리비 &nbsp &nbsp &nbsp &nbsp', '매출원가&nbsp &nbsp &nbsp'];
    var colors = ['rgba(75, 192, 192, 0.6)', 'rgba(255, 159, 64, 0.6)', 'rgba(255, 99, 71, 0.6)', 'rgba(25, 199, 51, 0.6)'];
    var percentages = [lbrcoPercentage, ntslAmtPercentage, mngAmtPercentage, costPercentage];

    // infoArea에 레이블을 추가합니다
    var infoArea = document.getElementById('infoArea');
    for (var i = 0; i < labels.length; i++) {
        var label = document.createElement('div');
        label.innerHTML = '<span style="color:' + colors[i] + '; font-size: 40px; vertical-align: middle;">●</span> ' + 
        '<i style="vertical-align: middle;">' + labels[i] + '</i>' +
        '<strong style="margin-left: 10px; color: #ec4545; padding-left: 20px; vertical-align: middle;">' + percentages[i].toFixed(2) + '%</strong>';
        label.addEventListener('click', function() {
            updateChart(i);
        });
        infoArea.appendChild(label);
    }
});
 

</script>
</body>
</html>
