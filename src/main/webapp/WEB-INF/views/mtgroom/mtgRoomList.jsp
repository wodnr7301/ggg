<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<header
	class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
	<div class="container-xl px-4">
		<div class="page-header-content pt-4">
			<div class="row align-items-center justify-content-between">
				<div class="col-auto mt-4">
					<h3 class="page-header-title">
						<div class="page-header-icon">
							<i data-feather="bar-chart"></i>
						</div>
						회의실
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal.username" var="empId" />
							${user.username}
						</sec:authorize>
					</h3>
					<div class="page-header-subtitle">OHO KOREA FRANCHISE
						MANAGEMENT</div>
				</div>
			</div>
		</div>
	</div>
</header>

<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8' />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>
#CalendarCard {
	display: flex;
	flex-wrap: wrap;
	position: relative;
	top: -130px;
	margin-left: 20px;
	margin-right: 20px;
	height: 32vh;
}

.card {
	display: flex;
	flex: 10 auto;
	margin: 10px;
}

.mb-4 {
   margin-bottom: -3.0rem !important; /* 원하는 마진 값으로 조정 */
}

.card-body {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	flex: 10 auto;
}

.button1 {
	align-self: flex-end;
}

.card-scrollable {
	position: relative;
	top: -50px; /* 원하는 값으로 조정하세요 */
}

.rentClickArea:hover {
	background-color: #f2f2f2;
	cursor: pointer;
}

#listContainer {
	height: 35vh;
}

#dateContainer {
	text-align: center;
}

#prevDate, #nextDate {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 20px;
}

#currentDate {
	font-size: 25px;
	color: black;
}

#tableCard {
	top: -60px;
}

input[readonly] {
	background-color: #f0f0f0; /* 옅은 회색 배경색 */
	color: #6c757d; /* 회색 텍스트 색상 */
}
</style>
</head>
<body>
	<%-- 	<sec:authentication property="principal.emp.deptNo"/> --%>
	<div class="container">
	<div class="card mb-4" id="CalendarCard">
		<div class="card">
			<img class="card-img-top" src="/resources/upload/2024/06/24/회의실1.jpg"
				alt="mtgRoom1">
			<div class="card-body">
				<h3 class="card-title">101호</h3>
				<div class="button1">
					<a class="btn btn-secondary btn-sm" data-html="true" href="#!"
						tabindex="0" data-bs-container="body" data-bs-toggle="popover"
						data-bs-placement="left" title="101호"
						data-bs-content="적정인원: 4인　 　 　 　 　 　 　 　 　 위치: 오호관 101호　　　　　　　 　운영시간: 09:00 - 20:00 　　　　　">상세
					</a>
				</div>
			</div>
		</div>
		<div class="card">
			<img class="card-img-top" src="/resources/upload/2024/06/24/회의실4.jpg"
				alt="mtgRoom4">
			<div class="card-body">
				<h3 class="card-title">102호</h3>
				<div class="button1">
					<a class="btn btn-secondary btn-sm" data-html="true" href="#!"
						tabindex="0" data-bs-container="body" data-bs-toggle="popover"
						data-bs-placement="left" title="102호"
						data-bs-content="적정인원: 6인　 　 　 　 　 　 　 　 　 위치: 오호관 102호　　　　　　　 　운영시간: 09:00 - 20:00 　　　　　">상세
					</a>
				</div>
			</div>
		</div>
		<div class="card">
			<img class="card-img-top" src="/resources/upload/2024/06/24/회의실3.jpg"
				alt="mtgRoom3">
			<div class="card-body">
				<h3 class="card-title">201호</h3>
				<div class="button1">
					<a class="btn btn-secondary btn-sm" data-html="true" href="#!"
						tabindex="0" data-bs-container="body" data-bs-toggle="popover"
						data-bs-placement="left" title="201호"
						data-bs-content="적정인원: 10인　 　 　 　 　 　 　 　 　 위치: 오호관 201호　　　　　　　 　운영시간: 09:00 - 20:00">상세
					</a>
				</div>
			</div>
		</div>
		<div class="card">
			<img class="card-img-top" src="/resources/upload/2024/06/24/회의실2.jpg"
				alt="mtgRoom2">
			<div class="card-body">
				<h3 class="card-title">202호</h3>
				<div class="button1">
					<a class="btn btn-secondary btn-sm" data-html="true" href="#!"
						tabindex="0" data-bs-container="body" data-bs-toggle="popover"
						data-bs-placement="left" title="202호"
						data-bs-content="적정인원: 12인　 　 　 　 　 　 　 　 　 위치: 오호관 202호　　　　　　　 　운영시간: 09:00 - 20:00">상세
					</a>
				</div>
			</div>
		</div>
	</div>

	<!-- ////////리스트 시작//////// -->
	<div class="card" id="tableCard">
		<div class="card-header">
			<div id="dateContainer">
				<button id="prevDate" onclick=f_minusDate()>&lt;</button>
				<span id="currentDate"></span>
				<button id="nextDate" onclick=f_plusDate()>&gt;</button>
			</div>
		</div>
		<div id=listContainer>
			<div id="tableContainer">
				<table class="table" id="selectTimeTbl">
					<thead>
						<tr>
							<th>회의실명</th>
							<%
								for (int hour = 9; hour <= 18; hour++) {
							%>
							<th><%=hour%>:00 - <%=(hour + 1)%>:00</th>
							<%
								}
							%>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="roomNm">101호</td>

							<%
								for (int hour = 9; hour <= 18; hour++) {
							%>
							<td class="rentClickArea" id="time1-<%=hour%>_00"
								onclick="selectRoom(this)">-</td>
							<%
								}
							%>
						</tr>
						<tr>
							<td id="roomNm2">102호</td>

							<%
								for (int hour = 9; hour <= 18; hour++) {
							%>
							<td class="rentClickArea" id="time2-<%=hour%>_00"
								onclick="selectRoom(this)">-</td>
							<%
								}
							%>
						</tr>
						<tr>
							<td id="roomNm3">201호</td>

							<%
								for (int hour = 9; hour <= 18; hour++) {
							%>
							<td class="rentClickArea" id="time3-<%=hour%>_00"
								onclick="selectRoom(this)">-</td>
							<%
								}
							%>
						</tr>
						<tr>
							<td id="roomNm4">202호</td>

							<%
								for (int hour = 9; hour <= 18; hour++) {
							%>
							<td class="rentClickArea" id="time4-<%=hour%>_00"
								onclick="selectRoom(this)">-</td>
							<%
								}
							%>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>
	<!-- ////////리스트 끝//////// -->

	<!-- ////////모달 시작//////// -->
	<div class="modal fade show" id="modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-modal="true"
		data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">회의실 예약</h4>
				</div>
				<div class="modal-body">
					<p>
						<input type="hidden" name="mmlNo" placeholder="관리대장번호" value="" />
					</p>
					<p>
						<input type="hidden" name="empNo" placeholder="사원번호" value="" />
					</p>
					<p>
						<input type="hidden" name="mtgrRsvtYN" placeholder="회의실 예약 여부"
							value="Y" />
					</p>
					<p>
						회의실 번호 :
						<!--                 	<input type="text" name="mtgrNo" class="form-control" /></p> -->
						<select name="mtgrNo" class="form-control">
							<option value="default" selected>---</option>
							<option value="MTR001">101호</option>
							<option value="MTR002">102호</option>
							<option value="MTR003">201호</option>
							<option value="MTR004">202호</option>
						</select>
					</p>
					<!--            <p>사용목적 : <input type="text"   name="mmlUsePrps" class="form-control" /></p> -->
					<p>
						사용목적 : <select name="mmlUsePrps" class="form-control">
							<option value="default" selected>---</option>
							<option value="1">회의</option>
							<option value="2">면접</option>
						</select>
					</p>
					<!-- 				예약일자 : SYSDATE -->
					<p>
						예약 시작 시간 : <input type="text" name="mmlRsvtStrdt"
							class="form-control" readonly />
					</p>
					<p>
						예약 종료 시간 : <input type="text" name="mmlRsvtEnddt"
							class="form-control" readonly />
					</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" onclick="fCalAdd()">예약</button>
					<button class="btn btn-secondary" type="button"
						onclick="closeModal()">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ////////모달 끝//////// -->

	<!-- ////////모달2 시작//////// -->
	<div class="modal fade show" id="modal-lg2" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-modal="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">회의실 예약</h4>
				</div>
				<div class="modal-body">
					<p>
						<input type="hidden" name="mmlNo2" placeholder="관리대장번호" value="" />
					</p>
					<p>
						예약자 :<input type="text" class="form-control" name="empNo2"
							placeholder="" value="" readonly />
					</p>
					<p>
						<input type="hidden" class="form-control"
							name="mtgrRsvtYN2" placeholder="" value="Y" readonly />
					</p>
					<p>
						회의실 번호 :
						<!--                 	<input type="text" name="mtgrNo" class="form-control" /></p> -->
						<select name="mtgrNo2" class="form-control" disabled>
							<option value="default" selected>---</option>
							<option value="MTR001">101호</option>
							<option value="MTR002">102호</option>
							<option value="MTR003">201호</option>
							<option value="MTR004">202호</option>
						</select>
					</p>
					<!--            <p>사용목적 : <input type="text"   name="mmlUsePrps" class="form-control" /></p> -->
					<p>
						사용목적 : <select name="mmlUsePrps2" class="form-control" disabled>
							<option value="default" selected>---</option>
							<option value="1">회의</option>
							<option value="2">면접</option>
						</select>
					</p>
					<!-- 				예약일자 : SYSDATE -->
					<p>
						예약 시작 시간 : <input type="text" name="mmlRsvtStrdt2"
							class="form-control" readonly />
					</p>
					<p>
						예약 종료 시간 : <input type="text" name="mmlRsvtEnddt2"
							class="form-control" readonly />
					</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" type="button" onclick="fCalDelete()"
						data-bs-dismiss="modal">예약 취소</button>
					<button class="btn btn-secondary" type="button"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ////////모달2 끝//////// -->

	<script>
// const myModal = document.querySelector("#modal-lg");
// const myEmpNo = document.querySelector("#empNo");
// const myMtgrNo = document.querySelector("#mtgrNo");
// const myMmlUsePrps = document.querySelector("#mmlUsePrps");
// const myMmlRsvtStrdt = document.querySelector("#mmlRsvtStrdt");
// const myMmlRsvtEnddt = document.querySelector("#mmlRsvtEnddt");

let myMmlNo = document.querySelector("#mmlNo");
let mmlNo = null;
let today = new Date();
var roomNameAll = null;

$(function(){
	// 여기에 문서가 준비된 후에 실행할 코드를 넣으세요.
	
	// 모든 시간 슬롯을 '예약 가능'으로 초기 설정
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time1' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time2' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time3' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time4' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
   
	//오늘 날짜 얻기
	today = new Date();
	    
	let year = today.getFullYear();
	let month = ('0' + (today.getMonth()+1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	
	let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
	let date = daysOfWeek[today.getDay()];
	
	today = new Date();
    
	let dayString = `\${year}-\${month}-\${day}`;
	let dateString = `\${year}.\${month}.\${day}(\${date})`;
	console.log("dayString :" + dayString);
	console.log("dateString :" + dateString);
	currentDate.textContent = dateString;
	let mmlEmpNo=null;
	console.log("mmlEmpNo", mmlEmpNo);
	
// 	$.ajax({
// 		type:"get",
// 		url:"/mtgRoom/mtgRoomAjax",
// 		dataType:"json",
// 		success:function(data){
// 			console.log("mtgRoomAjax 결과 값 data", data);
// 		} //mtgRoomAjax success 끝
// 	}); //mtgRoomAjax 끝
	
// 	$.ajax({
// 		url: "/mtgRoom/getEmp",
//           type: "get",
//           dataType: "text",
//           success: function(emp) {
          
//           console.log("Logged in user: ", emp);   //A102
	
//           } //getEmp success 끝
//  	}); //getEmp Ajax 끝
	
	$.ajax({
		type:"get",
		url:"/mtgRoom/listAjax",
		dataType:"json",
		success:function(data){
			console.log("listAjax 결과 값 data", data);
			
			let mmlNo;
			let mmlRsvtYNValue;  //예약여부 B101 
			let mtgrNoValue;	 //회의실 번호
			let mmlRsvtStrdtValue; //예약시작시간 "2024.07.01(월) 14:00"
			let mmlRsvtEnddtValue; //예약종료시간 "2024.07.01(월) 15:00"
			let mmlRsvtDateValue; //예약 날짜
			let mmlEmpNo; //회원번호
			
			for (let i = 0; i < data.length; i++) {
					mmlNo = data[i].mmlNo;
				    mmlRsvtYNValue = data[i].mmlRsvtYN;
				    mtgrNoValue = data[i].mtgrNo;
				    mmlRsvtStrdtValue = data[i].mmlRsvtStrdt.split(' ')[1].split(':')[0];
				    mmlRsvtEnddtValue = data[i].mmlRsvtEnddt.split(' ')[1].split(':')[0];
				    mmlRsvtDateValue = data[i].mmlRsvtStrdt.split(' ')[0]; // 예약 날짜 2024.07.01(월)
				    mmlEmpNo = data[i].empNo;
				    
				    console.log("listAjax mmlNo", mmlNo);
				    console.log("listAjax mmlRsvtYNValue", mmlRsvtYNValue);
					console.log("listAjax mtgrNoValue", mtgrNoValue);
					console.log("listAjax mmlRsvtStrdtValue", mmlRsvtStrdtValue);
					console.log("listAjax mmlRsvtEnddtValue", mmlRsvtEnddtValue);
					console.log("listAjax mmlRsvtDateValue", mmlRsvtDateValue);
					console.log("listAjax mmlEmpNo", mmlEmpNo);
					
					let today2 = document.getElementById('currentDate').textContent;
					console.log("listAjax today2", today2);  //현재 날짜
					
					// mtgrNo 값에 따라 다른 ID 접두사 선택
				    if (mtgrNoValue == "MTR001") {
				        let idPrefix = 'time1';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR001 time1 timeSlot", timeSlot);
					        console.log("MTR001 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR001 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR001 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					            //이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
 					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time1 for문 끝
				    } else if (mtgrNoValue == "MTR002") {
				        let idPrefix = 'time2';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR002 time2 timeSlot", timeSlot);
					        console.log("MTR002 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR002 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR002 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time2 for문 끝
				    } else if (mtgrNoValue == "MTR003") {
				        idPrefix = 'time3';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR003 time3 timeSlot", timeSlot);
					        console.log("MTR003 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR003 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR003 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
							    
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time3 for문 끝
				    } else if (mtgrNoValue == "MTR004") {
				        idPrefix = 'time4';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR004 time4 timeSlot", timeSlot);
					        console.log("MTR004 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR004 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR004 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time4 for문 끝
				    } //time4 else if문 끝
				    
			}//for문 끝
			
		} //listAjax success 끝
	}); //listAjax 끝

        
	
}); //$(function() 끝



function f_minusDate(){
	
	// 모든 시간 슬롯을 '예약 가능'으로 초기 설정
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time1' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time2' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time3' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time4' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
	
	//어제 날짜 얻기
	today.setDate(today.getDate()-1);

	let year = today.getFullYear();
	let month = ('0' + (today.getMonth()+1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	
	let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
	let date = daysOfWeek[today.getDay()];
	
	let dayString = `\${year}-\${month}-\${day}`;
	let dateString2 = `\${year}.\${month}.\${day}(\${date})`;
	console.log("dayString :" + dayString);
	console.log("dateString2 :" + dateString2);
	currentDate.textContent = dateString2;
	
// 	$.ajax({
//         url: "/mtgRoom/getEmp",
//           type: "get",
//           dataType: "text",
//           success: function(emp) {
          
//           console.log("Logged in user: ", emp);   //A102
          
//           } //getEmp success 끝
//     }); //getEmp Ajax 끝
   
   
    $.ajax({
		type:"get",
		url:"/mtgRoom/listAjax",
		dataType:"json",
		success:function(data){
			console.log("listAjax 결과 값 data", data);
			
			let mmlNo;
			let mmlRsvtYNValue;  //예약여부 B101 
			let mtgrNoValue;	 //회의실 번호
			let mmlRsvtStrdtValue; //예약시작시간 "2024.07.01(월) 14:00"
			let mmlRsvtEnddtValue; //예약종료시간 "2024.07.01(월) 15:00"
			let mmlRsvtDateValue; //예약 날짜
			let mmlEmpNo; //회원번호
			
			for (let i = 0; i < data.length; i++) {
					mmlNo = data[i].mmlNo;
				    mmlRsvtYNValue = data[i].mmlRsvtYN;
				    mtgrNoValue = data[i].mtgrNo;
				    mmlRsvtStrdtValue = data[i].mmlRsvtStrdt.split(' ')[1].split(':')[0];
				    mmlRsvtEnddtValue = data[i].mmlRsvtEnddt.split(' ')[1].split(':')[0];
				    mmlRsvtDateValue = data[i].mmlRsvtStrdt.split(' ')[0]; // 예약 날짜 2024.07.01(월)
				    mmlEmpNo = data[i].empNo;
				    
				    console.log("listAjax mmlNo", mmlNo);
				    console.log("listAjax mmlRsvtYNValue", mmlRsvtYNValue);
					console.log("listAjax mtgrNoValue", mtgrNoValue);
					console.log("listAjax mmlRsvtStrdtValue", mmlRsvtStrdtValue);
					console.log("listAjax mmlRsvtEnddtValue", mmlRsvtEnddtValue);
					console.log("listAjax mmlRsvtDateValue", mmlRsvtDateValue);
					console.log("listAjax mmlEmpNo", mmlEmpNo);
					
					let today2 = document.getElementById('currentDate').textContent;
					console.log("listAjax today2", today2);  //현재 날짜
					
					// mtgrNo 값에 따라 다른 ID 접두사 선택
				    if (mtgrNoValue == "MTR001") {
				        let idPrefix = 'time1';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR001 time1 timeSlot", timeSlot);
					        console.log("MTR001 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR001 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR001 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time1 for문 끝
				    } else if (mtgrNoValue == "MTR002") {
				        let idPrefix = 'time2';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR002 time2 timeSlot", timeSlot);
					        console.log("MTR002 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR002 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR002 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time2 for문 끝
				    } else if (mtgrNoValue == "MTR003") {
				        idPrefix = 'time3';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR003 time3 timeSlot", timeSlot);
					        console.log("MTR003 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR003 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR003 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time3 for문 끝
				    } else if (mtgrNoValue == "MTR004") {
				        idPrefix = 'time4';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR004 time4 timeSlot", timeSlot);
					        console.log("MTR004 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR004 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR004 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time4 for문 끝
				    } //time4 else if문 끝
				    
			}//for문 끝
			
		} //listAjax success 끝
	}); //listAjax 끝

         
	 
// 	 console.log("dayString minus date:", dayString);
// 	 document.getElementsByName('mmlRsvtStrdt')[0].value = startTimeVal;
// 	 document.getElementsByName('mmlRsvtEnddt')[0].value = endTimeVal;
	 
		   
}; //f_minusDate 끝

function f_plusDate(){
	
	// 모든 시간 슬롯을 '예약 가능'으로 초기 설정
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time1' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time2' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time3' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
    for (let hour = 9; hour <= 18; hour++) {
        let timeSlot = document.getElementById('time4' + '-' + hour + '_00');
        timeSlot.style.backgroundColor = ''; // 배경색 초기화
        timeSlot.textContent = '예약 가능';
        
        if (timeSlot.textContent == '예약 가능') {
            timeSlot.style.color = 'blue';
        }
    }
	
	//다음 날짜 얻기
	today.setDate(today.getDate()+1);
	
	let year = today.getFullYear();
	let month = ('0' + (today.getMonth()+1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	
	let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
	let date = daysOfWeek[today.getDay()];
	
	let dayString = `\${year}-\${month}-\${day}`;
	let dateString3 = `\${year}.\${month}.\${day}(\${date})`;
	console.log("dateString3 :" + dateString3);
	currentDate.textContent = dateString3;
	
// 	$.ajax({
//         url: "/mtgRoom/getEmp",
//           type: "get",
//           dataType: "text",
//           success: function(emp) {
          
//           console.log("Logged in user: ", emp);   //A102
//           } //getEmp success 끝
//     }); //getEmp Ajax 끝
   
    $.ajax({
		type:"get",
		url:"/mtgRoom/listAjax",
		dataType:"json",
		success:function(data){
			console.log("listAjax 결과 값 data", data);
			
			let mmlNo;
			let mmlRsvtYNValue;  //예약여부 B101 
			let mtgrNoValue;	 //회의실 번호
			let mmlRsvtStrdtValue; //예약시작시간 "2024.07.01(월) 14:00"
			let mmlRsvtEnddtValue; //예약종료시간 "2024.07.01(월) 15:00"
			let mmlRsvtDateValue; //예약 날짜
			let mmlEmpNo; //회원번호
			
			for (let i = 0; i < data.length; i++) {
					mmlNo = data[i].mmlNo;
				    mmlRsvtYNValue = data[i].mmlRsvtYN;
				    mtgrNoValue = data[i].mtgrNo;
				    mmlRsvtStrdtValue = data[i].mmlRsvtStrdt.split(' ')[1].split(':')[0];
				    mmlRsvtEnddtValue = data[i].mmlRsvtEnddt.split(' ')[1].split(':')[0];
				    mmlRsvtDateValue = data[i].mmlRsvtStrdt.split(' ')[0]; // 예약 날짜 2024.07.01(월)
				    mmlEmpNo = data[i].empNo;
				    
				    console.log("listAjax mmlNo", mmlNo);
				    console.log("listAjax mmlRsvtYNValue", mmlRsvtYNValue);
					console.log("listAjax mtgrNoValue", mtgrNoValue);
					console.log("listAjax mmlRsvtStrdtValue", mmlRsvtStrdtValue);
					console.log("listAjax mmlRsvtEnddtValue", mmlRsvtEnddtValue);
					console.log("listAjax mmlRsvtDateValue", mmlRsvtDateValue);
					console.log("listAjax mmlEmpNo", mmlEmpNo);
					
					let today2 = document.getElementById('currentDate').textContent;
					console.log("listAjax today2", today2);  //현재 날짜
					
					// mtgrNo 값에 따라 다른 ID 접두사 선택
				    if (mtgrNoValue == "MTR001") {
				        let idPrefix = 'time1';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR001 time1 timeSlot", timeSlot);
					        console.log("MTR001 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR001 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR001 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          //이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time1 for문 끝
				    } else if (mtgrNoValue == "MTR002") {
				        let idPrefix = 'time2';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR002 time2 timeSlot", timeSlot);
					        console.log("MTR002 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR002 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR002 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time2 for문 끝
				    } else if (mtgrNoValue == "MTR003") {
				        idPrefix = 'time3';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR003 time3 timeSlot", timeSlot);
					        console.log("MTR003 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR003 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR003 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          	//이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time3 for문 끝
				    } else if (mtgrNoValue == "MTR004") {
				        idPrefix = 'time4';
				        
				        for (let hour = 9; hour <= 18; hour++) {
					        let timeSlot = document.getElementById(idPrefix + '-' + hour + '_00');
					        console.log("MTR004 time4 timeSlot", timeSlot);
					        console.log("MTR004 idPrefix hour", hour);
					        //이 부분이 아마 달라질거임
					        console.log("MTR004 mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
					        console.log("MTR004 mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
					        
					        // 예약 시작 시간과 종료 시간 사이인지 확인  예약 시작 시간과 종료 시간 사이인지 확인 
					        if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue) {
					        	
					            timeSlot.textContent = '예약 불가';
					          //이 부분 조심
					            timeSlot.setAttribute('data-mml-no', mmlNo); //기본키를 data 속성에 저장
					            
					         	$.ajax({
					          		url: "/mtgRoom/getEmp",
					            	type: "get",
					            	dataType: "text",
					            	success: function(empResult) {
					           
					            	console.log("Logged in user listGetEmp: ", empResult);//EMP157   
					           			
					            		//여기를 바꾸면 됨(if (today2 == mmlRsvtDateValue && hour >= mmlRsvtStrdtValue && hour < mmlRsvtEnddtValue)를 같은 방식으로 한번 더 하면...)
					            		let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
							            let datagetEmp = {
							            	"mmlNo":mmlNoFromTimeSlot	
							            }
					            			console.log("datagetEmp", datagetEmp);
					            
								            $.ajax({
								          	  url:"/mtgRoom/getEmp2",
								          	  type:"post",
								          	  contentType:"application/json;charset=utf-8",
								          	  data: JSON.stringify(datagetEmp),
								          	  dataType:"text",
								          	  beforeSend:function(xhr){
								  		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								  		      },
								          	  success: function(emp3){
								          	  	console.log("보라색으로 색 바꿀 사람: ", emp3); //EMP157
								          	 	console.log("로그인 한 사람 확인 empResult", empResult); //EMP157
								          	  	
								          	 	if(timeSlot.textContent == '예약 불가' && empResult == emp3){
								          	 		timeSlot.textContent = '나의 예약';
								          	 		timeSlot.style.backgroundColor = 'rgb(253,205,205,0.3)';
								          	 	 	//timeSlot.setAttribute('data-mml-No', mmlNo);
								          	  	}
								          	  	
								          	  } //getEmp2 success 끝
								            }); //getEmp2 ajax 끝
					            
					              } //getEmp success 끝
							    }); //getEmp Ajax 끝
					            
					            if (timeSlot.textContent == '예약 불가') {
					                timeSlot.style.color = 'red';
					                timeSlot.setAttribute('data-mml-No', mmlNo);
					            }
					            
					        } else if (timeSlot.textContent != '예약 불가') {
					        	
				                timeSlot.textContent = '예약 가능';
				                
				            } 
					        
					    } //time4 for문 끝
				    } //time4 else if문 끝
				    
			}//for문 끝
			
		} //listAjax success 끝
	}); //listAjax 끝

          
	
} //f_plusDate함수 끝

//여기
function selectRoom(e){
	console.log("e", e);
	mmlNo = e.dataset.mmlNo;
	console.log("-------------------------------------------")
	console.log("mmlNo",mmlNo);
	
	//101호, 102호, 201호, 202호
	let roomName = e.parentNode.querySelector('td').textContent.trim();
	console.log("roomName", roomName);
	roomNameAll = roomName;
	console.log("roomNameAll:", roomNameAll);
	
	//select 선택(클릭한 td에 맞게)
	let selectElement = document.querySelector('select[name="mtgrNo"]');
	console.log("selectElement", selectElement);
	
	for (var i = 0; i < selectElement.options.length; i++) {
         if (selectElement.options[i].text == roomName) {
             selectElement.selectedIndex = i;
             break;
         }
    };
	
	//날짜 얻기
	let today2 = document.getElementById('currentDate').textContent;
    
	console.log("today2:", today2); //2024.07.01(월)
	
	// 클릭된 요소의 id에서 시간 추출
    let id = e.id;	
	console.log("id : " + id);//time2-14_00
	let time = id.split('-')[0];//time2
    let startTime = id.split('-')[1].replace('_', ':');
    let hour = parseInt(id.split('-')[1].split('_')[0]); // '9'를 추출
    console.log("hour : " + hour);
	let timeSlot = document.getElementById(time + '-' + hour + '_00');
    
    let startTimeVal = `\${today2} \${startTime}`;
    
    console.log("selectRoom e timeSlot:", timeSlot);
    console.log("selectRoom e startTimeVal:", startTimeVal);
    
    console.log("timeSlot.textContent : " + timeSlot.textContent);
	
	if(timeSlot.textContent == '예약 가능'){
			
		$('#modal-lg').modal('show');
		
		
	}else if(timeSlot.textContent == '예약 불가'){
		
		$('#modal-lg2').modal('show');
		
		let data = {
				
			"mmlNo":mmlNo	
		}
		
		console.log("selectRoom(e) detailAjax 데이터:", data);
		
		$.ajax({
			url:"/mtgRoom/detailAjax",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			beforeSend:function(xhr){
	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	},
	    	success:function(result){
	    		console.log("detailAjax 결과값 result:", result);
	    		
	    		$("input[name='empNo2']").val(result.empNm);
	    		$("input[name='mtgrRsvtYN2']").val(result.mmlRsvtYN);
	    		$("select[name='mtgrNo2']").val(result.mtgrNo);
	    		$("select[name='mmlUsePrps2']").val(result.mmlUsePrps);
	    		$("input[name='mmlRsvtStrdt2']").val(result.mmlRsvtStrdt);
	    		$("input[name='mmlRsvtEnddt2']").val(result.mmlRsvtEnddt);
	    	}//detailAjax success 끝
			
		}); //detailAjax 끝
		//else if(timeSlot.textContent == '예약 불가')  if문 끝
	} else if(timeSlot.textContent == '나의 예약'){
		
		$('#modal-lg2').modal('show');
		
		//여기
		//let mmlNoFromTimeSlot = timeSlot.getAttribute('data-mml-no');
		let myDetailData = {
			"mmlNo":mmlNo
		}
		
		console.log("selectRoom(e)222 detailAjax 데이터:", myDetailData);
		
		$.ajax({
        	  url:"/mtgRoom/getEmp2",
        	  type:"post",
        	  contentType:"application/json;charset=utf-8",
        	  data: JSON.stringify(myDetailData),
        	  dataType:"text",
        	  beforeSend:function(xhr){
		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		      },
        	  success: function(empDataResult){
        	  	console.log("삭제 대상의 소유자: ", empDataResult);
        	  	
        	  	let myDetailData2 = {
        	  			"mmlNo":mmlNo,
        	  			"empNo":empDataResult
        	  	}
        	  	
        		$.ajax({
        			url:"/mtgRoom/detailAjax",
        			type:"post",
        			contentType:"application/json;charset=utf-8",
        			data:JSON.stringify(myDetailData2),
        			dataType:"json",
        			beforeSend:function(xhr){
        	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        	    	},
        	    	success:function(myResult){
        	    		console.log("detailAjax 결과값 myResult:", myResult);
        	  	
        	  	$("input[name='empNo2']").val(myResult.empNm);
	    		$("input[name='mtgrRsvtYN2']").val(myResult.mmlRsvtYN);
	    		$("select[name='mtgrNo2']").val(myResult.mtgrNo);
	    		$("select[name='mmlUsePrps2']").val(myResult.mmlUsePrps);
	    		$("input[name='mmlRsvtStrdt2']").val(myResult.mmlRsvtStrdt);
	    		$("input[name='mmlRsvtEnddt2']").val(myResult.mmlRsvtEnddt);
        	  	
        	  } //getdetail success 끝
		});	//getDetailAjax 끝	
        	  } //getEmp2 success 끝
		}); //getEmp2
		
		
		
		
		
		
		
		console.log("myDetailData", myDetailData);
	}
	
	
    // endTime용 1시간 더하기
    let selectEndTime = parseInt(startTime.split(':')[0]);
    let endHour = selectEndTime + 1;
    let endTime = endHour + ':00';

    console.log("startTimeVal:", startTime); //9:00 뜸
    console.log("endTimeVal", endTime);  // 10:00 뜸
    
    let endTimeVal = `\${today2} \${endTime}`;
    
 	// 모달의 입력 필드에 시간 설정
    document.getElementsByName('mmlRsvtStrdt')[0].value = startTimeVal;
    document.getElementsByName('mmlRsvtEnddt')[0].value = endTimeVal;
	
}

function fCalAdd(){
	
	let mmlNoValue = $("input[name='mmlNo']").val();
	let empNoValue = $("input[name='empNo']").val();
	let mtgrNoValue = $("select[name='mtgrNo']").val();
    let mtgrRsvtYN = $("input[name='mtgrRsvtYN']").val();
	let mmlUsePrpsValue = $("select[name='mmlUsePrps']").val();
	let mmlRsvtStrdtValue = $("input[name='mmlRsvtStrdt']").val();
    let mmlRsvtEnddtValue = $("input[name='mmlRsvtEnddt']").val();
    
    console.log("fCalAdd mmlNoValue:", mmlNoValue);
    console.log("fCalAdd empNoValue:", empNoValue);
    console.log("fCalAdd mtgrNoValue:", mtgrNoValue);
	console.log("fCalAdd mtgrRsvtYN:", mtgrRsvtYN);
	console.log("fCalAdd mmlUsePrpsValue:", mmlUsePrpsValue);
    console.log("fCalAdd mmlRsvtStrdtValue:", mmlRsvtStrdtValue);
	console.log("fCalAdd mmlRsvtEnddtValue:", mmlRsvtEnddtValue);
	
	$.ajax({
    		url: "/mtgRoom/getEmp",
            type: "get",
            dataType: "text",
            success: function(emp) {
            
            console.log("Logged in user: ", emp);	//A102
            
            $.ajax({
         		url: "/mtgRoom/getDept",
                type: "get",
                dataType: "json",
                success: function(dept) {
                	
                console.log("Logged in user: ", dept);
                let deptNo = dept.deptNo;
                console.log("Logged in user22: ", deptNo);
                console.log("fCalAdd() roomNameAll:", roomNameAll);
                
            	let data = {
	            	"mtgrNo" : mtgrNoValue,
	            	"mtgrNm" : roomNameAll,
	            	"mmlUsePrps" : mmlUsePrpsValue,
	            	"mmlRsvtYN" : mtgrRsvtYN,
	            	"mmlRsvtStrdt" : mmlRsvtStrdtValue,
	            	"mmlRsvtEnddt" : mmlRsvtEnddtValue,
            		"empNo"	: emp,
            		"deptNo": deptNo
            	}
            
            	console.log("createAjax data:", data);
            
				$.ajax({
					type:"post",
					url: "/mtgRoom/createAjax",
					contentType:"application/json;charset=UTF-8",
					data:JSON.stringify(data),
					dataType:"text",
					beforeSend:function(xhr){
	    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	    	},
	    	    	success:function(rslt){
	    	    		console.log("돌아온 값 :", rslt);
	    	    		
        			},//createAjax success 끝
        			error: function(xhr, status, error) {
    		            console.error(xhr.responseText);
    		            
    		            swal("등록에 실패하였습니다.","","error");
    		        }

				});//createAjax 끝
				
				let data2 = {
					"mtgrNo":mtgrNoValue
				}
				
				console.log("update용 mtgrNo:", data2);
				
				$.ajax({
					type:"post",
					url:"/mtgRoom/updateAjax",
					contentType:"application/json;charset=UTF-8",
					data:JSON.stringify(data2),
					dataType:"text",
					beforeSend:function(xhr){
	    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	    	},
	    	    	success:function(rslt){
	    	    		console.log("돌아온 값 :", rslt);
	    	    		
        			}//updateAjax success 끝
        			
				});//updateAjax 끝
				
				swal("등록이 완료되었습니다.","","success").then(function() {
		    		window.location.href = "/mtgRoom/list";
		    	});
				
               } //getDept success 끝
            }); //getDept ajax 끝
				
            }//getEmp Ajax success끝
            ,error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	            
	            swal("로그인해주세요.","","error");
	            
	        }
	}); //getEmp Ajax 끝

} //fCalAdd 끝


function fCalDelete(){
	
	console.log("전역변수로 뺀 mmlNo확인:", mmlNo);
	
	$.ajax({
        url: "/mtgRoom/getEmp",
          type: "get",
          dataType: "text",
          success: function(emp) {
          
          console.log("fCalDelete Logged in user: ", emp);   //A102
          
          let data = {
        		  
        	"mmlNo":mmlNo	  
          }
          console.log("getEmp2() 아작스 전송용 data", data)
          
          $.ajax({
        	  url:"/mtgRoom/getEmp2",
        	  type:"post",
        	  contentType:"application/json;charset=utf-8",
        	  data: JSON.stringify(data),
        	  dataType:"text",
        	  beforeSend:function(xhr){
		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		      },
        	  success: function(emp2){
        	  	console.log("삭제 대상의 소유자: ", emp2);
        	  	
        	  	if(emp != emp2){
        	  		swal("본인이 아니면 삭제할 수 없습니다.","","error");
        	  		return;
        	  	}
          
				let data = {
					"mmlNo":mmlNo,
					"empNo":emp
				}
	
	console.log("fDelete() 아작스 전송용 data", data);
	
	Swal.fire({
	    title: '삭제하시겠습니까?',
	    icon: 'warning',
	    
	    showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
	    confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
	    cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
	    confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
	    cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	    
	    reverseButtons: false, // 버튼 순서 거꾸로
	    
	 }).then(result => {
	    
	     if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
	    
	        $.ajax({
	            url:"/mtgRoom/deleteAjax",
	            type:"post",
	            contentType:"application/json;charset=utf-8",
	            data:JSON.stringify(data),
	            dataType:"json",
	            beforeSend:function(xhr){
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
	            success:function(result){
	                console.log("result :", result);
	                
	              	//재호출 후 닫기
				 	swal("삭제되었습니다.","","success").then(function() {
		    			window.location.href = "/mtgRoom/list";
		    	  	});
	             
	            }, //deleteAjax success 끝
	            error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		            
		            swal("삭제에 실패하였습니다.","","error");
		        }
	        }); //deleteAjax 끝
	        
	    } //if (result.isConfirmed)
	 }); //then(result
		
       	
       		} //getEmp2 success 끝
        }); //getEmp2 끝	 
			
        } //getEmp success 끝
        ,error: function(xhr, status, error) {
            console.error(xhr.responseText);
            
            swal("로그인 해주세요.","","error");
            
        }
        
    
        
	}); //getEmp 끝
	
} //fCalDelete() 끝

function closeModal(e){
    
	let modal = $('#modal-lg').modal('hide');
	document.querySelector('select[name="mmlUsePrps"]').selectedIndex = 0;
	
} //closeModal() 끝



</script>
</body>