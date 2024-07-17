<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
.card-footer{
	color:black;
}
</style>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
							  <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"/>
							</svg>
                        </div>
                        	영업 지역 통계
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
	<div class="row">
		<!-- 지도 공간 -->
		<div class="col-lg-5">
			<div class="card mb-4">
	            <div class="card-header">영업점 분포</div>
	            <div class="card-body">
	                <!-- 지도 그리기 -->
					<div id="map" style="width:100%;height:600px;"></div>
	            </div>
	            <div class="card-footer small"></div>
	        </div>
		</div>
		<!-- 차트 공간 -->
		<div class="col-lg-7">
			<div class="card mb-4">
	            <div class="card-header"><span id="sysYear"></span> 지역별 영업점 현황</div>
	            <div class="card-body">
					<!-- 차트 크기는 부모 크기에 맞게 자동 -->
					<div>
						<!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
						<canvas id="myChart"></canvas>
					</div>
	            </div>
	            <div class="card-footer small"></div>
	        </div>
		</div>
	</div>
</div>
<!----------------지도 데이터------------------->
<c:forEach var="frcsVORegion" items="${frcsVORegionList}" varStatus="stat">
	<input type="hidden" class="addr${stat.index+1}" data-ad="${frcsVORegion.frcsAddr}" />
</c:forEach>
<!----------------지도 데이터------------------->
<!----------------차트 데이터------------------->
<c:forEach var="countRegion" items="${countRegionList}" varStatus="stat">
	<input type="hidden" class="rg${stat.index+1}" data-rgnm="${countRegion.comcdCdnm}" data-rgcnt="${countRegion.countRegion}" />
</c:forEach>
<c:forEach var="countRegionYear" items="${countRegionYearList}" varStatus="stat">
	<input type="hidden" class="rgy${stat.index+1}" data-rgcntyear="${countRegionYear.countRegion}" />
</c:forEach>
<!----------------차트 데이터------------------->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98c23c9ab59ad46aefaad5cb0b645a2b&libraries=clusterer,services"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	//카카오맵 api 시작
	var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	    center : new kakao.maps.LatLng(36.0000, 127.6358), // 지도의 중심좌표
	    level : 13 // 지도의 확대 레벨 1~14
	});
	
	// 마커 클러스터러를 생성
	var clusterer = new kakao.maps.MarkerClusterer({
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
	    minLevel: 10 // 클러스터 할 최소 지도 레벨
	});

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소 데이터 배열
	var places = [];	
	for (let j = 1; j <= `${fn:length(frcsVORegionList)}`; j++) {
		let idx3 = ".addr"+j;
		places.push($(idx3).data("ad"));
	}
	console.log("places : ",places);
	
	var markers = [];

    function addMarker(address) {
    	return new Promise((resolve) => {
	// 주소로 좌표 검색
	geocoder.addressSearch(address, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	    	 
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			console.log("result[0].y, result[0].x", result[0].y, result[0].x);
	        
	        // 결과값으로 받은 위치를 마커로 표시
	        var marker = new kakao.maps.Marker({
	            position: coords
	        });
	        
	        resolve({ status: 'fulfilled', marker: marker });
	    } else {
	    	console.log("Geocoding failed for address: ", address);
	    	resolve({ status: 'rejected', reason: "Geocoding failed" });
        }
	});
		});
	}
	
	// 배열의 모든 주소에 대해 마커 추가
    Promise.allSettled(places.map(address => addMarker(address)))
        .then(results => {
            const fulfilledMarkers = results
                .filter(result => result.status === 'fulfilled')
                .map(result => result.value.marker);
            clusterer.addMarkers(fulfilledMarkers);
        })
        .catch(error => {
            console.error("Failed to add marker: ", error);
        });
	//카카오맵 api 끝
	
	//chart.js 시작
	let nmArr = [];
	let cntArr = [];
	let cntYearArr = [];
	for (let i = 1; i <= 8; i++) {
		let idx = ".rg"+i;
		let idx2 = ".rgy"+i;
		nmArr.push($(idx).data("rgnm"));
		cntArr.push($(idx).data("rgcnt"));
		cntYearArr.push($(idx2).data("rgcntyear"));
	}
	console.log("nmArr : ", nmArr);
	console.log("cntArr : ", cntArr);
	console.log("cntYearArr : ", cntYearArr);
		
	const ctx = document.querySelector('#myChart');

	const mChart = new Chart(ctx, {
		type : 'bar',	// horizontalBar
		data : {
			labels : nmArr,
			datasets : [ {
				label : '올해 신규 가맹점',
				backgroundColor: "rgba(244, 161, 0, 1)",
				data : cntYearArr,
				borderWidth : 1,
			}, {
				label : '전체 가맹점 수',
				backgroundColor: "rgba(0, 97, 242, 1)",
				data : cntArr,
				borderWidth : 1
			} ]
		},
		options : {
			indexAxis : 'y',	//수평차트
			scales : {
				x : {
					beginAtZero : true
				}
			}
        }
	});
	//chart.js 끝
	
	//현재시간
	const today = new Date();
	
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);	
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
// 	var seconds = ('0' + today.getSeconds()).slice(-2); 

	var dateString = year + '-' + month  + '-' + day;
// 	var timeString = hours + ':' + minutes  + ':' + seconds;
	var timeString = hours + ':' + minutes;
	
	var now = dateString + " " + timeString + " 기준";
	console.log("현재시간 : ",now);
	
	$(".card-footer").text(now);
	$("#sysYear").text(year);
</script>