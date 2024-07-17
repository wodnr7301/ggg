<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .chart-title {
        writing-mode: vertical-lr; /* 세로 방향으로 텍스트를 회전 */
        text-orientation: upright; /* 텍스트의 방향을 세로로 유지 */
        transform: rotate(180deg); /* 180도 회전하여 세로로 표시 */
        position: absolute; /* 절대 위치로 설정 */
        left: -20px; /* 적절한 위치에 조정 */
        top: 50%; /* 세로 중앙 정렬 */
        transform-origin: bottom left; /* 회전 중심을 왼쪽 아래로 설정 */
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
$(function(){
	var ctx = document.getElementById("myLineChart").getContext('2d');
    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            datasets: [
                {
                    label: '2023년',
                    fill: false,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    data: [50, 52, 55, 75, 85, 60, 55, 65, 50, 45, 55, 50], // 2023년 데이터
                },
                {
                    label: '2024년',
                    fill: false,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    data: [40, 45, 60, 65, 70, 65, 66], // 2024년 데이터
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    title: {
                        display: true,
                        text: '월'
                    }
                },
                y: {
                    title: {
                        display: true,
                        text: '수익 (억 원)'
                    },
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '억';
                        },
                        beginAtZero: true
                    }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += '₩' + context.raw.toLocaleString() + '억';
                            return label;
                        }
                    }
                }
            }
        }
    });

    // 비율을 보여주는 막대 그래프 추가
    var ctx2 = document.getElementById("franchiseDistributionChart").getContext('2d');
    var franchiseDistributionChart = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: ["2023년", "2024년"], // 연도
            datasets: [
                {
                    label: '오호 분식',
                    backgroundColor: 'rgba(255, 99, 132, 0.5)',
                    data: [30, 25], // 가맹점 1의 2023년과 2024년 비율 예시
                },
                {
                    label: '오호이 피자',
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    data: [20, 30], // 가맹점 2의 2023년과 2024년 비율 예시
                },
                {
                    label: '까페 오호',
                    backgroundColor: 'rgba(75, 192, 192, 0.5)',
                    data: [50, 45], // 가맹점 3의 2023년과 2024년 비율 예시
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    stacked: true,
                    title: {
                        display: true,
                        text: '연도'
                    }
                },
                y: {
                    stacked: true,
                    title: {
                        display: true,
                        text: '매출 (억 원)'
                    },
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '억';
                        },
                        beginAtZero: true
                    }
                }
            },
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        font: {
                            size: 8,
                            weight: 'bold'
                        }
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += '₩' + context.raw.toLocaleString() + '억';
                            return label;
                        }
                    }
                }
            }
        }
    });
 // 2023년도 막대 그래프
    var ctx2023 = document.getElementById("regionSalesChart2023").getContext('2d');
	var regionSalesChart2023 = new Chart(ctx2023, {
	    type: 'bar',
	    data: {
	        labels: ["서울", "경기,인천", "부산,울산,경남", "대전,충청", "강원", "대구,경북", "광주,전라", "제주"], // 지역
	        datasets: [
	            {
	                label: '2023년',
	                backgroundColor: 'rgba(54, 162, 235, 0.5)',
	                data: [80, 70, 60, 50, 40, 65, 55, 30], // 2023년 각 지역의 매출
	            }
	        ]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        scales: {
	            x: {
	                stacked: true,
	                title: {
	                    display: true,
	                    text: '지역'
	                },
	                ticks: {
	                    beginAtZero: true
	                }
	            },
	            y: {
	                title: {
	                    display: true,
	                    text: '수익'
	                }
	            }
	        },
	        plugins: {
	            legend: {
	                position: 'top',
	                labels: {
	                    font: {
	                        size: 14,
	                        weight: 'bold'
	                    }
	                }
	            },
	            tooltip: {
	                callbacks: {
	                    label: function(context) {
	                        let label = context.dataset.label || '';
	                        if (label) {
	                            label += ': ';
	                        }
	                        label += '₩' + context.raw.toLocaleString() + '억';
	                        return label;
	                    }
	                }
	            }
	        }
	    }
	});

    // 2024년도 막대 그래프
	var ctx2024 = document.getElementById("regionSalesChart2024").getContext('2d');
	var regionSalesChart2024 = new Chart(ctx2024, {
	    type: 'bar',
	    data: {
	        labels: ["서울", "경기,인천", "부산,울산,경남", "대전,충청", "강원", "대구,경북", "광주,전라", "제주"], // 지역
	        datasets: [
	            {
	                label: '2024년',
	                backgroundColor: 'rgba(255, 99, 132, 0.5)',
	                data: [85, 75, 65, 55, 45, 70, 60, 35], // 2024년 각 지역의 매출
	            }
	        ]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        scales: {
	            x: {
	                stacked: true,
	                title: {
	                    display: true,
	                    text: '지역'
	                },
	                ticks: {
	                    beginAtZero: true
	                }
	            },
	            y: {
	                title: {
	                    display: true,
	                    text: '수익 (억 원)'
	                }
	            }
	        },
	        plugins: {
	            legend: {
	                position: 'top',
	                labels: {
	                    font: {
	                        size: 14,
	                        weight: 'bold'
	                    }
	                }
	            },
	            tooltip: {
	                callbacks: {
	                    label: function(context) {
	                        let label = context.dataset.label || '';
	                        if (label) {
	                            label += ': ';
	                        }
	                        label += '₩' + context.raw.toLocaleString() + '억';
	                        return label;
	                    }
	                }
	            }
	        }
	    }
	});
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
    <a class="nav-link ms-0" href="/revenue/monthly">월별 매출 분석</a>
    <a class="nav-link ms-0" href="/revenue/quarterly">분기별 매출 분석</a>
    <a class="nav-link ms-0 active" href="/revenue/annual">연도별 매출 분석</a>
</nav>
<hr class="mt-0 mb-4" />
    <div class="card mb-4">
        <div class="card-body">
        	<canvas id="myLineChart" width="400" height="400"></canvas>
        </div>
    </div>
    <div class="row">
	    <div class="col-xl-4 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	               프랜차이즈 별 매출
	            </div>
	            <div class="card-body">
	            	<canvas id="franchiseDistributionChart" width="400" height="250"></canvas>
	            </div>
	        </div>
	    </div>
	    <div class="col-xl-4 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	                지역 별 매출(전년도 2023)
	            </div>
	            <div class="card-body">
	            	<canvas id="regionSalesChart2023" width="400" height="250"></canvas>
	            </div>
	        </div>
	    </div>
	    <div class="col-xl-4 mb-4">
	        <div class="card card-header-actions h-100">
	            <div class="card-header">
	                지역 별 매출(올해 2024)
	            </div>
	            <div class="card-body">
	            	<canvas id="regionSalesChart2024" width="400" height="250"></canvas>
	            </div>
	        </div>
	    </div>
	</div>
</div>