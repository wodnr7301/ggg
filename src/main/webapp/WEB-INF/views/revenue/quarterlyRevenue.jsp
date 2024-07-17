<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #000;
        padding: 8px;
        text-align: right;
    }
    th {
        background-color: #f2f2f2;
    }
    .item-column {
        width: 15%;
        text-align: left;
    }
</style>
<script>
$(function(){
	const salesData = [145000, 200000, 199000, null];
    const costData = [87000, 117000, 120400, null];
    const profitData = [32000, 47000, 41600, null];
    const labels = ['1분기', '2분기', '3분기', '4분기'];

    // Sales Chart
    new Chart(document.getElementById('salesChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: '매출',
                data: salesData,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '분기별 매출'
                }
            }
        }
    });

    // Profit Chart
    new Chart(document.getElementById('profitChart'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '순이익',
                data: profitData,
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '분기별 순이익'
                }
            }
        }
    });

    // Cost Chart
    new Chart(document.getElementById('costChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                {
                    label: '매출',
                    data: salesData,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                },
                {
                    label: '비용',
                    data: costData,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '분기별 매출과 비용 비교'
                }
            }
        }
    });

    // Function to create pie charts with labels
    function createPieChart(ctx, sales, cost, profit, quarter) {
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['매출', '비용', '순이익'],
                datasets: [{
                    data: [sales, cost, profit],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(153, 102, 255, 0.2)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                plugins: {
                    datalabels: {
                        formatter: (value, context) => {
                            const dataset = context.chart.data.datasets[0];
                            const total = dataset.data.reduce((prevValue, curValue) => prevValue + curValue);
                            const percentage = (value / total * 100).toFixed(2) + '%';
                            return percentage;
                        },
                        color: '#000',
                        font: {
                            weight: 'bold'
                        }
                    },
                    title: {
                        display: true,
                        text: `\${quarter}`
                    }
                }
            },
            plugins: [ChartDataLabels]
        });
    }

    // Create pie charts for each quarter
    createPieChart(document.getElementById('comparisonChart1'), 145000, 87000, 32000, '1분기');
    createPieChart(document.getElementById('comparisonChart2'), 200000, 117000, 47000, '2분기');
    createPieChart(document.getElementById('comparisonChart3'), 199000, 120400, 41600, '3분기');
});
</script>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
	                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
							  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783"/>
							</svg>
                        </div>
                        	매출 분석
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<nav class="nav nav-borders">
    <a class="nav-link ms-0" href="/revenue/monthly">월별 매출 분석</a>
    <a class="nav-link ms-0 active" href="/revenue/quarterly">분기별 매출 분석</a>
    <a class="nav-link ms-0" href="/revenue/annual">연도별 매출 분석</a>
</nav>
<hr class="mt-0 mb-4" />
	<div class="card mb-4">
	   <div class="card-header">
	       분기별 매출과 비용, 순이익 비교
	   </div>
       <div class="card-body row">
       		<div class="col-4">
	  			<canvas id="comparisonChart1" width="300" height="100"></canvas>
       		</div>
       		<div class="col-4">
	  			<canvas id="comparisonChart2" width="300" height="100"></canvas>
       		</div>
       		<div class="col-4">
	  			<canvas id="comparisonChart3" width="300" height="100"></canvas>
       		</div>
       </div>
    </div>
	<div class="row">
	    <div class="col-xl-6 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	                매출
	            </div>
	            <div class="card-body">
	            	<canvas id="salesChart"></canvas>
	            </div>
	        </div>
	    </div>
	    <div class="col-xl-6 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	                순이익
	            </div>
	            <div class="card-body">
	            	<canvas id="profitChart"></canvas>
	            </div>
	        </div>
	    </div>
	</div>
    <div class="card">
        <div class="card-body">
        	<h2>분기별 손익계산서 (단위: 백만 원)</h2>
			<table>
			    <thead>
			        <tr>
			            <th class="item-column">항목</th>
			            <th>1분기</th>
			            <th>2분기</th>
			            <th>3분기</th>
			            <th>4분기</th>
			            <th>총계</th>
			        </tr>
			    </thead>
			    <tbody>
			        <tr>
			            <td class="item-column">매출</td>
			            <td>145,000</td>
			            <td>200,000</td>
			            <td>199,000</td>
			            <td></td>
			            <td>544,000</td>
			        </tr>
			        <tr>
			            <td class="item-column">매출원가</td>
			            <td>87,000</td>
			            <td>117,000</td>
			            <td>120,400</td>
			            <td></td>
			            <td>324,400</td>
			        </tr>
			        <tr>
			            <td class="item-column">매출총이익</td>
			            <td>58,000</td>
			            <td>83,000</td>
			            <td>78,600</td>
			            <td></td>
			            <td>219,600</td>
			        </tr>
			        <tr>
			            <td class="item-column">판관비</td>
			            <td>27,000</td>
			            <td>39,000</td>
			            <td>39,800</td>
			            <td></td>
			            <td>105,800</td>
			        </tr>
			        <tr>
			            <td class="item-column">영업이익</td>
			            <td>31,000</td>
			            <td>44,000</td>
			            <td>38,800</td>
			            <td></td>
			            <td>113,800</td>
			        </tr>
			        <tr>
			            <td class="item-column">기타수익 및 비용</td>
			            <td>3,000</td>
			            <td>3,000</td>
			            <td>3,000</td>
			            <td></td>
			            <td>9,000</td>
			        </tr>
			        <tr>
			            <td class="item-column">순이익</td>
			            <td>32,000</td>
			            <td>47,000</td>
			            <td>41,600</td>
			            <td></td>
			            <td>120,600</td>
			        </tr>
			    </tbody>
			</table>
        </div>
    </div>
</div>