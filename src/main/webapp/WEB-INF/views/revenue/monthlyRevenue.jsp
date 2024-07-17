<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        text-align: center;
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$(function(){
	const labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];

    const salesData = {
        labels: labels,
        datasets: [{
            label: '매출(백 만원)',
            data: [40000, 45000, 60000, 65000, 70000, 65000, 67000, null, null, null, null, null],
            borderColor: 'rgba(75, 192, 192, 1)',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            fill: false,
            tension: 0.1
        }]
    };

    const costData = {
        labels: labels,
        datasets: [{
            label: '매출원가(백 만원)',
            data: [24000, 27000, 36000, 39000, 42000, 39000, 40200, null, null, null, null, null],
            borderColor: 'rgba(255, 99, 132, 1)',
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            fill: false,
            tension: 0.1
        }]
    };

    const profitData = {
        labels: labels,
        datasets: [{
            label: '순이익(백 만원)',
            data: [9000, 10000, 13000, 14000, 15000, 14000, 14400, null, null, null, null, null],
            borderColor: 'rgba(54, 162, 235, 1)',
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            fill: false,
            tension: 0.1
        }]
    };

    const configSales = {
   	    type: 'bar',  // 막대 그래프로 변경
   	    data: salesData,
   	    options: {
   	        responsive: true,
   	        plugins: {
   	            legend: {
   	                position: 'top',
   	            },
   	            title: {
   	                display: true,
   	                text: '월별 매출'
   	            }
   	        },
   	        scales: {
   	            y: {
   	                beginAtZero: true,
   	                ticks: {
   	                    callback: function(value) {return value.toLocaleString();}  // 콤마 찍기
   	                }
   	            }
   	        }
   	    }
   	};

    const configCost = {
   	    type: 'bar',  // 막대 그래프로 변경
   	    data: costData,
   	    options: {
   	        responsive: true,
   	        plugins: {
   	            legend: {
   	                position: 'top',
   	            },
   	            title: {
   	                display: true,
   	                text: '월별 매출원가'
   	            }
   	        },
   	        scales: {
   	            y: {
   	                beginAtZero: true,
   	                ticks: {
   	                    callback: function(value) {return value.toLocaleString();}  
   	                }
   	            }
   	        }
   	    }
   	};

    const configProfit = {
        type: 'line',
        data: profitData,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '월별 순이익'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                    	callback: function(value) {return value.toLocaleString();}
                    }
                }
            }
        }
    };

    const salesChart = new Chart(
        document.getElementById('salesChart'),
        configSales
    );

    const costChart = new Chart(
        document.getElementById('costChart'),
        configCost
    );

    const profitChart = new Chart(
        document.getElementById('profitChart'),
        configProfit
    );
    
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
<!-- 개점 관리 페이지 탭 -->
<nav class="nav nav-borders">
    <a class="nav-link ms-0 active" href="/revenue/monthly">월별 매출 분석</a>
    <a class="nav-link ms-0" href="/revenue/quarterly">분기별 매출 분석</a>
    <a class="nav-link ms-0" href="/revenue/annual">연도별 매출 분석</a>
</nav>
<hr class="mt-0 mb-4" />
	<div class="card mb-4">
	   <div class="card-header">
	       순이익
	   </div>
       <div class="card-body">
  			<canvas id="profitChart" width="300" height="100"></canvas>
       </div>
    </div>
	<div class="row">
	    <div class="col-xl-6 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	                매출
	            </div>
	            <div class="card-body">
	            	<canvas id="salesChart" width="400" height="200"></canvas>
	            </div>
	        </div>
	    </div>
	    <div class="col-xl-6 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	                매출 원가
	            </div>
	            <div class="card-body">
	            	<canvas id="costChart" width="400" height="200"></canvas>
	            </div>
	        </div>
	    </div>
	</div>
    <div class="card">
        <div class="card-body">
        	<h1>월별 손익계산서 (1월 - 12월, 단위: 백만 원)</h1>
		    <table>
		        <thead>
		            <tr>
		                <th>항목</th>
		                <th>1월</th>
		                <th>2월</th>
		                <th>3월</th>
		                <th>4월</th>
		                <th>5월</th>
		                <th>6월</th>
		                <th>7월</th>
		                <th>8월</th>
		                <th>9월</th>
		                <th>10월</th>
		                <th>11월</th>
		                <th>12월</th>
		                <th>총 계</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr>
		                <td style="text-align:left">매출</td>
		                <td>40,000</td>
		                <td>45,000</td>
		                <td>60,000</td>
		                <td>65,000</td>
		                <td>70,000</td>
		                <td>65,000</td>
		                <td>67,000</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>412,000</td>
		            </tr>
		            <tr>
		                <td style="text-align:left">매출원가</td>
		                <td>24,000</td>
		                <td>27,000</td>
		                <td>36,000</td>
		                <td>39,000</td>
		                <td>42,000</td>
		                <td>39,000</td>
		                <td>40,200</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>247,200</td>
		            </tr>
		            <tr>
		                <td style="text-align:left">매출총이익</td>
		                <td>16,000</td>
		                <td>18,000</td>
		                <td>24,000</td>
		                <td>26,000</td>
		                <td>28,000</td>
		                <td>26,000</td>
		                <td>26,800</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>164,800</td>
		            </tr>
		            <tr>
		                <td style="text-align:left">판관비</td>
		                <td>8,000</td>
		                <td>9,000</td>
		                <td>12,000</td>
		                <td>13,000</td>
		                <td>14,000</td>
		                <td>13,000</td>
		                <td>13,400</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>82,400</td>
		            </tr>
		            <tr>
		                <td style="text-align:left">영업이익</td>
		                <td>8,000</td>
		                <td>9,000</td>
		                <td>12,000</td>
		                <td>13,000</td>
		                <td>14,000</td>
		                <td>13,000</td>
		                <td>13,400</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>82,400</td>
		            </tr>
		            <tr>
		                <td style="text-align:left">기타수익 및 비용</td>
		                <td>1,000</td>
		                <td>1,000</td>
		                <td>1,000</td>
		                <td>1,000</td>
		                <td>1,000</td>
		                <td>1,000</td>
		                <td>1,000</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>7,000</td>
		            </tr>
		            <tr>
		                <td style="text-align:left">순이익</td>
		                <td>9,000</td>
		                <td>10,000</td>
		                <td>13,000</td>
		                <td>14,000</td>
		                <td>15,000</td>
		                <td>14,000</td>
		                <td>14,400</td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td>89,400</td>
		            </tr>
		        </tbody>
		    </table>
        </div>
    </div>
</div>