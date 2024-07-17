<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

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
                     	근무현황 
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="empId" />
</sec:authorize>
                  </h3>
                  <div class="page-header-subtitle">OHO KOREA FRANCHISE MANAGEMENT</div>
               </div>
            </div>
         </div>
      </div>
</header>

<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <script type="text/javascript" src="/resources/js/jquery.min.js"></script>
    
    <style>
    #CalendarCard {
        	position: relative;
        	top: -130px;
        	margin-left: 20px;
            margin-right: 20px;
            height: 110vh; 
        }
    
	body {
		margin: 0;
		padding: 0;
	}
	
	/* Container for the columns */
	.card-body {
		display: grid;
		grid-template-columns: 1fr 2fr; /* 1/3 and 2/3 columns */
		gap: 10px; /* Optional gap between columns */
	}
	
	/* Left column */
	.left {
		background-color: #fbfbfb; /* Optional background color */
		padding: 10px; /* Optional padding */
	}
	
	/* Right column */
	.right {
		background-color: #ffffff; /* Optional background color */
		padding: 10px; /* Optional padding */
	}
	
	/* 출, 퇴근 버튼*/
 	.button-container { 
 	    display: flex; 
 	    flex-direction: row;
 	    justify-content: space-around;
 	     
 	}
 	
 	/* 일요일 날짜 빨간색 */
	.fc-day-sun a {
		color: red;
		text-decoration: none;
	}
 	
 	#gtWorkButton {
 		back-ground-color: #fff;
 	}
 	
 	#dnWorkButton {
 		back-ground-color: #fff;
 	}
 	
 	.color-container {
        display: flex; 
	  	flex-direction: row;
	  	justify-content: space-around;
	  	font-size: 20px;
    }
    
    .record-container {
		text-align: center;
	}
	
	.record-container .table tbody tr {
		font-size: 80px;
	}
 	
 	.btn-xl {
	    padding: 1.25rem 4.5rem;
	    font-size: 2.125rem;
	    border-radius: 0.5rem;
	}
 	
 	#dateDisplay {
	    font-size: 1.5rem;
	    margin-bottom: 20px;
	}
	
	#timeDisplay {
	    font-size: 4.5rem;
	    margin-bottom: 20px;
	    text-align: center;
	}
	
	</style>
	
</head>
<body>

    <!-- 실제 화면을 담을 영역 -->
	<div class="card mb-4" id="CalendarCard">
	    <div class="card-body">
	        <div id="SideBar" class="left">
	        	<div id="dateDisplay"></div>
	        	<div id="timeDisplay"></div><br>
	        	<div id="gtWork"><svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-watch" viewBox="0 0 16 16">
  <path d="M8.5 5a.5.5 0 0 0-1 0v2.5H6a.5.5 0 0 0 0 1h2a.5.5 0 0 0 .5-.5z"/>
  <path d="M5.667 16C4.747 16 4 15.254 4 14.333v-1.86A6 6 0 0 1 2 8c0-1.777.772-3.374 2-4.472V1.667C4 .747 4.746 0 5.667 0h4.666C11.253 0 12 .746 12 1.667v1.86a6 6 0 0 1 1.918 3.48.502.502 0 0 1 .582.493v1a.5.5 0 0 1-.582.493A6 6 0 0 1 12 12.473v1.86c0 .92-.746 1.667-1.667 1.667zM13 8A5 5 0 1 0 3 8a5 5 0 0 0 10 0"/>
</svg>출근시간 :  <span id="gtworkPoint"></span></div><br>
	        	<div id="dnWork"><svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-watch" viewBox="0 0 16 16">
  <path d="M8.5 5a.5.5 0 0 0-1 0v2.5H6a.5.5 0 0 0 0 1h2a.5.5 0 0 0 .5-.5z"/>
  <path d="M5.667 16C4.747 16 4 15.254 4 14.333v-1.86A6 6 0 0 1 2 8c0-1.777.772-3.374 2-4.472V1.667C4 .747 4.746 0 5.667 0h4.666C11.253 0 12 .746 12 1.667v1.86a6 6 0 0 1 1.918 3.48.502.502 0 0 1 .582.493v1a.5.5 0 0 1-.582.493A6 6 0 0 1 12 12.473v1.86c0 .92-.746 1.667-1.667 1.667zM13 8A5 5 0 1 0 3 8a5 5 0 0 0 10 0"/>
</svg>퇴근시간 :  <span id="dnworkPoint"></span></div><br><br>
	        	<div class="button-container">
					<button class="btn btn-primary btn-xl" id="gtWorkButton" onclick="f_gtWorkButton()">출근</button><br>
					<button class="btn btn-secondary btn-xl" id="dnWorkButton" onclick="f_dnWorkButton()">퇴근</button>
				</div>
				<br><br>
				
				<div class="color-container">
					<div class="color-round green"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#00FF00" class="bi bi-record-fill" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 13A5 5 0 1 0 8 3a5 5 0 0 0 0 10"/>
</svg>근무</div>
					<div class="color-round red"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#FFBF01" class="bi bi-record-fill" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 13A5 5 0 1 0 8 3a5 5 0 0 0 0 10"/>
</svg>지각</div>
					<div class="color-round yellow"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#FF0000" class="bi bi-record-fill" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 13A5 5 0 1 0 8 3a5 5 0 0 0 0 10"/>
</svg>조퇴</div>
				</div>
				<br><br><br>
				<div class="record-container"><br><br><br>
					<h1>근태 현황</h1>
					<table class="table">
					  <thead>
					    <tr>
					      <th scope="col">근무</th>
					      <th scope="col">지각</th>
					      <th scope="col">조퇴</th>
					    </tr>
					  </thead>
					  <tbody id="trShow">
						<tr>
						  <td><c:out value="${totalWork}"/></td>
						  <td><c:out value="${lateWork}"/></td>
						  <td><c:out value="${outWork}"/></td>
						</tr>
					  </tbody>
					</table>
				</div>
	        </div>
	        <div id="Wrapper" class="right">
	            <div id='calendar'></div>
	        </div>                       
	    </div>
	</div>
	
	<script>
		
		const dateDisplay = document.getElementById('dateDisplay');
		const timeDisplay = document.getElementById('timeDisplay');
		
	    const calendarEl = document.querySelector('#calendar');
	    
	    let globalEvents=[];
	    let globalEmp=null;
	    let eaOutTimeResult=null;
	    
	    let waNo;		//근태번호
		let waDt;		//출근시간
		let eaOutTime;	//퇴근시간
		let waYmd;		//일자
		let waRsn;		//사유
		let waStatus;	//상태 : 1.출근 2.지각 3.조퇴
		let empNo; 		//사원번호
		let backColor;  //배경색
		
		console.log("전역변수 근태번호 waNo:", waNo);
		console.log("전역변수 출근시간 waDt:", waDt);
		console.log("전역변수 퇴근시간 eaOutTime:", eaOutTime);
		console.log("전역변수 사원번호 empNo:", empNo);
		console.log("전역변수 globalEvents", globalEvents);
	    
	    //시간
	    let today = new Date();
	    
	    let year = today.getFullYear();
		let month = ('0' + (today.getMonth()+1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		
		let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
		let date = daysOfWeek[today.getDay()];
		
		let dayString = `\${year}-\${month}-\${day}`;
		let dateString = `\${year}.\${month}.\${day}(\${date})`;
		console.log("dateString :" + dateString);
		dateDisplay.textContent = dateString;
		
		//현재시간 처리
		function fnCt(){
			console.log("현재시간");
			
			let now = new Date();
			let hours = ('0' + now.getHours()).slice(-2);
			let minutes = ('0' + now.getMinutes()).slice(-2);
			let seconds = ('0' + now.getSeconds()).slice(-2);
			
			let am_pm = hours >= 12 ? 'PM' : 'AM';
			
			hours = hours % 12;
			hours = hours ? hours : 12;
			minutes = ('0' + minutes).slice(-2);
			seconds = ('0' + seconds).slice(-2);
			
			let timeString = `\${hours}:\${minutes}:\${seconds}\${am_pm}`;
			timeDisplay.textContent = timeString;
		}
		
		//현재시간을 즉시 표시하고, 1초마다 갱신
		fnCt();
	    setInterval(fnCt, 1000);
	  	
	  	//버튼 비활성화
    	function btnDisabled1()  {
    		let target = document.getElementById('gtWorkButton');
    		target.disabled = true;
    	}
	  	
    	function btnDisabled2()  {
    		let target = document.getElementById('dnWorkButton');
    		target.disabled = true;
    	}
    	
	  	//캘린더 헤더 옵션
        const headerToolbar = {
            left: 'prev,next,today',
            center: 'title',
            right: 'dayGridMonth'
        }
     	
	  	// 캘린더 생성 옵션(참공)
        const calendarOption = {
            height: '700px', // calendar 높이 설정
            expandRows: true, // 화면에 맞게 높이 재설정
            slotMinTime: '09:00', // Day 캘린더 시작 시간
            slotMaxTime: '18:00', // Day 캘린더 종료 시간
            // 맨 위 헤더 지정
            headerToolbar: headerToolbar,
            initialView: 'dayGridMonth',  // default: dayGridMonth 'dayGridWeek', 'timeGridDay', 'listWeek'
            locale: 'kr',        // 언어 설정
            selectable: false,    // 영역 선택
            selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
            navLinks: false,      // 날짜,WeekNumber 클릭 여부, default false
            weekNumbers: false,   // WeekNumber 출력여부, default false
            editable: false,      // event(일정) 
            dayMaxEventRows: true,  // Row 높이보다 많으면 +숫자 more 링크 보임!
            nowIndicator: true,
            //events:[],
            eventSources: [
            	{
                    events: function(info, successCallback, failureCallback) { // ajax 처리로 데이터를 로딩 시킨다.
                    
                   	$.ajax({
   	             		url: "/attend/getEmp",
   	                     type: "get",
   	                     dataType: "text",
   	                     success: function(emp) {
   	                     	 
   	                    	 console.log("Logged in user: ", emp);
   	                     	 
   	                     	 globalEmp = emp;//전역변수에 담기(위로 뺄거임)
   	                     	 console.log("globalEmp", globalEmp);
   	                     	 
   	                     	 let data = {
   	                     		"empNo":globalEmp	 
   	                     	 }
   	                     	 console.log("eventSource listAjax 전송용 data", data);
                    	
		                      $.ajax({  
		                        url: "/attend/listAjax",
		                        contentType:"application/json;charset=utf-8",
		                        data:JSON.stringify(data),
		                        type: "post",
		                        beforeSend:function(xhr){
		            	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		            	    	},
		                        success: function(data) {
		                          console.log("eventSource listAjax 결과값 data : ", data);
		                          
		                          //gtworkPoint.textContent, dnworkPoint.textContent에 시간 넣기 시작(급 수습)
		                          console.log("Logged in user2: ", emp);
		                          data.sort((a, b) => a.waNo.localeCompare(b.waNo)); //정렬
		                          
		                          let lastEntry = data[data.length - 1];
		                          console.log("lastEntry:", lastEntry);
		                          
		                          //empNo 추출
		                          let lastEmpNo = lastEntry.empNo;
		                          console.log("lastEmpNo", lastEmpNo);
		                          
		                          //waNo 추출
		                          let lastWaNo = lastEntry.waNo; 
		                          console.log("lastWaNo", lastWaNo);
		                          
		                          	let requestData = {
		                          		"waNo":lastWaNo,	
		                          		"empNo":lastEmpNo
		                          	}
		                          	
		                          	$.ajax({
		                          		url:"/attend/getWaYmd",
		                          		type:"post",
		                          		contentType:"application/json;charset=utf-8",
		                          		data:JSON.stringify(requestData),
		                          		dataType:"json",
		                          		beforeSend:function(xhr){
		                    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		                    	    	},
		                    	    	success:function(result){
		                    	    		console.log("getWaYmd result:",result);
		                    	    		
		                    	    		let waYmdResult=result.waYmd;
		                    	    		
		                    	    		console.log("waYmdResult", waYmdResult);
		                    	    		
		                    	    		// waDt를 HH:mm:ss 형식으로 변환
		                                    let timeOnly = new Date(waYmdResult); // "2024-07-02 17:30:40.0"에서 "17:30:40" 추출
		                                    
		                                    let year = timeOnly.getFullYear();
		                                    let month = ('0' + (timeOnly.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
		                                    let day = ('0' + timeOnly.getDate()).slice(-2);
		                                    let hours = ('0' + timeOnly.getHours()).slice(-2);
		                                    let minutes = ('0' + timeOnly.getMinutes()).slice(-2);
		                                    let seconds = ('0' + timeOnly.getSeconds()).slice(-2);
		                                    
		                                    let waDtTimeonly = `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
		                                    let waDtTimeonly2 = `\${hours}:\${minutes}:\${seconds}`;
		                                    let waDtDateonly = `\${year}-\${month}-\${day}`
											console.log("waDtDateonly", waDtDateonly);
											console.log("waDtTimeonly", waDtTimeonly);
											console.log("waDtTimeonly2", waDtTimeonly2);
											console.log("dayString", dayString);
		                    	    		
											if(waDtDateonly == dayString){
												
											gtworkPoint.textContent = waDtTimeonly2;
											btnDisabled1();//비활성화
											}

		                    	    	} //waYmd ajax success 끝
		                          	}); //waYmd ajax 끝
		                    	    	
		                          	let requestData2 = {
			                          		"waNo":lastWaNo,	
			                          		"empNo":lastEmpNo
				                        }
		                          	
		                          	console.log("requestData2", requestData2);
		                    	    	
	                    	    	$.ajax({
	                    	    		url:"/attend/geteaOutTime",
		                          		type:"post",
		                          		contentType:"application/json;charset=utf-8",
		                          		data:JSON.stringify(requestData2),
		                          		dataType:"json",
		                          		beforeSend:function(xhr){
		                    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		                    	    	},
		                    	    	success:function(result){
		                    	    		console.log("geteaOutTime result:",result);
		                    	    		
		                    	    		eaOutTimeResult=result.eaOutTime;
		                    	    		
		                    	    		console.log("eaOutTimeResult", eaOutTimeResult); //"2024-06-29 16:33:33.0"
		                    	    		let eaDayTimePart = eaOutTimeResult.substring(0, 10);
		                    	    		let eaOutTimePart = eaOutTimeResult.substring(11, 19);
		                    	    		
		                    	    		console.log("eaDayTimePart:", eaDayTimePart); // "2024-06-29"
		                    	    		console.log("eaOutTimePart:", eaOutTimePart); // "16:33:33"
		                    	    		
		                    	    		if(eaDayTimePart == dayString){
		                    	    			
		                    	    			dnworkPoint.textContent = eaOutTimePart;
		                    	    			btnDisabled2();//비활성화
		                    	    		}
		                    	    		

		                    	    	} //eaOutTime success 끝
	                    	    	}); //eaOutTime ajax 끝
		                          		
 								  //gtworkPoint.textContent, dnworkPoint.textContent에 시간 넣기 끝(급 수습)
		                          
		                          calendar.removeAllEvents(globalEvents);
		                          //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
		                          globalEvents = data.map(function(event){
		                        	  
		                        	  return  { //event 발생용
		                        		  	waNo: event.waNo,
			                              	title: event.waStatus,
			                        		start: event.waDt,
			                         		end: event.eaOutTime,
			                              	empNo: event.empNo,
			                           		backgroundColor: event.backColor	
		                               };
		                               
		
		                          }); //globalEvents 끝
		                          
		                          console.log("eventSource[] listAjax globalEvents:", globalEvents);
		                          successCallback(globalEvents);
		                          
		                        },	// listAjax success 끝
		                        error: function() {
		                          failureCallback();
		                        }
		                        
		                      });// listAjax 끝
		                      
		                      let data2 = {
		  							"empId":"${empId}"	
		  						};
		  						
		  						console.log("data2 : ", data2);
		  						
		  						$.ajax({
		  							url:"/attend/listAjax2",
		  							contentType:"application/json;charset=utf-8",
		  							data:JSON.stringify(data2),
		  							type:"post",
		  							dataType:"json",
		  							beforeSend:function(xhr){
		  								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  							},
		  							success:function(result){
		  								/*result
		  								{"empId": "b001","empNo": "A102","waStatus": "지각"
		  									,"totalWork": 16,"outWork": 4,"lateWork": 6}
		  								*/
		  								console.log("result : ", result);
		  								
		  								$("#trShow").children("tr").children("td").eq(0).html(result.totalWork);
		  								$("#trShow").children("tr").children("td").eq(1).html(result.lateWork);
		  								$("#trShow").children("tr").children("td").eq(2).html(result.outWork);
		  							}
		  						});
                      
   	              	 }	// getEmp success 끝
	             });// getEmp Ajax 끝
                    
	             
                 }//end function(info, successCallback, failureCallback)
              }

            ],//end eventSource
            
        }//const calendarOption 캘린더 생성 옵션 끝
	  	
     	// 캘린더 생성
        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
        // 캘린더 그리깅
        calendar.render();
		
    	// 캘린더 이벤트 등록
        calendar.on("eventAdd", info => console.log("Add:", info));
        calendar.on("eventChange", info => console.log("Change:", info));
        calendar.on("eventRemove", info => console.log("Remove:", info));
        calendar.on("eventClick", info => {
            console.log("eClick:", info);
            console.log('Event: ', info.event.extendedProps);
            console.log('Coordinates: ', info.jsEvent);
            console.log('View: ', info.view);
        });
        calendar.on("dateClick", info => console.log("dateClick:", info));
        calendar.on("select", info => {
            console.log("체킁:", info);

            mySchStart.value = info.startStr;
            mySchEnd.value = info.endStr;

        });
     	
        //f_gtWorkButton() => 출근버튼
	    function f_gtWorkButton(){
	    	
	    	//출근 시간 처리
	    	console.log("출근시간");
	    	
	    	let gtWokrHour = new Date();
	    	let gtWokrHours = ('0' + gtWokrHour.getHours()).slice(-2);
	    	let gtWokrMinutes = ('0' + gtWokrHour.getMinutes()).slice(-2);
	    	let gtWokrSeconds = ('0' + gtWokrHour.getSeconds()).slice(-2);
	    	
	    	let dayString = `\${year}-\${month}-\${day}`;
	    	let gtWorkString = `\${gtWokrHours}:\${gtWokrMinutes}:\${gtWokrSeconds}`;
            let fulWorkString = `\${dayString} \${gtWorkString}`;
            console.log("fulWorkString :", fulWorkString)
	    	gtworkPoint.textContent = gtWorkString;
            
            let data = {
            		
            	"gtWorkString":gtWorkString	
            }
            
            $.ajax({
            	url: "/hldy/listAjax3",
            	contentType:"application/json;charset=utf-8",
            	data: JSON.stringify(data),
            	type: "post",
            	dataType: "text",
            	beforeSend:function(xhr){
    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    	    	},
            	success: function(response){
            		console.log("response:", response);
            	}
            	
            });	// hldy/listAjax3 끝 : 세션에 출근시간 저장용            
            
            //지각 처리
            let lateWorkHour = new Date();
            lateWorkHour.setHours(9);
            lateWorkHour.setMinutes(0);
            lateWorkHour.setSeconds(0);
            
            let lateWorkHours = ('0' + lateWorkHour.getHours()).slice(-2);
            let lateWorkMinutes = ('0' + lateWorkHour.getMinutes()).slice(-2);
            let lateWorkSeconds = ('0' + lateWorkHour.getSeconds()).slice(-2);
            
            dayString = `\${year}-\${month}-\${day}`;
            let ltWorkString = `\${lateWorkHours}:\${lateWorkMinutes}:\${lateWorkSeconds}`;
            let lateWorkString = `\${dayString} \${ltWorkString}`;
            console.log("lateWorkString:", lateWorkString);

	            if(fulWorkString > lateWorkString){
	            	console.log("fulWorkString > lateWorkString 지각");
	            	
	            	//db로 insert!! 
	    	    	$.ajax({
	            		url: "/attend/getEmp",
	                    type: "get",
	                    dataType: "text",
	                    success: function(emp) {
	                    	 console.log("Logged in user: ", emp);
	                    	 console.log("event 콜백해놓은 전역변수 :", globalEvents);
	                    	 
	                    	 if(emp == "error"){
	                    		 alert("로그인 해주세요!!");
	                    		 location.href ="/login";
	                    	 }
	                    	 
	                    	 empNO = emp;
	    					 
	                    	 /* 오늘 날짜 넣기
	                    	 waDt: gtWorkString,
	                  		 eaOutTime: gtWorkString,
	                  		 fulWorkString : lateWorkString보다 큰 fulWorkString(지각)
	                    	 */
	                    	 let data = {
	                  			waDt: fulWorkString,
	                  			eaOutTime: fulWorkString,
	                       	 	waStatus: '지각',
	                       	 	empNo: empNO,
	                    		backColor: '#FFBF01',
	                    		gubun:"출근" 
	                    	 };
	                    	 
// 	                    	 gtworkPoint.textContent = fulWorkString;//여기
	                    	
	                    	 let event = {
                       			start: fulWorkString,
                       			end: fulWorkString,
                            	title: '지각',
                            	empNo: empNO,
                         		backgroundColor: '#FFBF01'                         		
	                         };
	                    	 
	                    	 console.log("ajax전송 데이터:", data);
	                    	 console.log("event전송 데이터:", event);
	                    	 
	                    	 $.ajax({
	                    		 type:"post",
	    	               		 url:"/attend/createAjax",
	    	                     contentType:"application/json;charset=utf-8",
	    	                     data:JSON.stringify(data),
	    	                     dataType:"json",
	    	                     beforeSend:function(xhr){
	    	         	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	         	    	 },
	    	                     success: function(data) {
	    	                    	 console.log("createAjax(지각부분) 성공 후 받은 data : ", data);
	    	                          
	    	                    	 //calendar.removeAllEvents(globalEvents);

	    	                    	 //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
	    	                    	 globalEvents = data.map(function(event){
	    	                    	  
	    	                    	  return  { //event 발생용
	    	                    		  	waNo: event.waNo,
	    	                    			title: event.waStatus,
	    	                    			start: event.waDt,
	    	                    			end: event.EaOutTime,
	    	                    			empNo: event.empNo,
	    	                    			backgroundColor: event.backColor	
	    	                    	   };
	    	                    	   
	    	                    	 });
	    	                    	 console.log("지각 출근시간 insert 후 globalEvents:", globalEvents);
	    							
	    	                    	 // 캘린더 생성
	    	                         const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
	    	                    	
	    	                    	 // 캘린더 그리깅
	    	                         calendar.render();
	    	                         calendar.addEvent(globalEvents);
	    	                         
	    	                     }//ajax createAjax suceess끝
	    	                     
	                    	 })	//ajax createAjax 끝
	                    	 
	                    }	//ajax getEmp Success 끝
	                    	
	    	    	});	//ajax getEmp 끝
	    	    	
	    	    	console.log("waNo받아오기 아작스용 globalEmp:", globalEmp);
	    	    	
	    	    	let data = {
	    	    			
	    	    		"empNo":globalEmp
	    	    	}
	    	    	
	    	    	$.ajax({
	            		url: "/attend/getWaNo",
	                    type: "post",
	                    contentType:"application/json;charset=utf-8",
	                    data:JSON.stringify(data),
	                    dataType: "text",
	                    beforeSend:function(xhr){
	        	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        	    	},
	                    success: function(result) {
	                    	 console.log("getWaNo 아작스 result: ", result);
	                    	 
	                    	 
	                    }
	    	    	});	
	    	    	
	    	    	btnDisabled1();	//비활성화
	    	    	
	            }//지각 if문 끝!
	            
	            else
		    	//db로 insert!! 
		    	$.ajax({
	        		url: "/attend/getEmp",
	                type: "get",
	                dataType: "text",
	                success: function(emp) {
	                	 console.log("Logged in user: ", emp);
	                	 console.log("event 콜백해놓은 전역변수 :", globalEvents);
	                	 
	                	 if(emp == "error"){
	                		 alert("로그인 해주세요!!");
	                		 location.href ="/login";
	                	 }
	                	 
	                	 empNO = emp;
						 
	                	 /* 오늘 날짜 넣기
	                	 waDt: gtWorkString,
	              		 eaOutTime: gtWorkString,
	                	 */
	                	 let data = {
	              			waDt: fulWorkString,
	              			eaOutTime: fulWorkString,
	                   	 	waStatus: '출근',
	                   	 	empNo: empNO,
	                		backColor: '#0000FF'	 
	                	 };
	                	
	                	 let event = {
	                   			start: fulWorkString,
	                   			end: fulWorkString,
	                        	title: '출근',
	                        	empNo: empNO,
	                     		backgroundColor: '#0000FF'	 
	                     };
	                	 
	                	 console.log("ajax전송 데이터:", data);
	                	 console.log("event전송 데이터:", event);
	                	 
	                	 $.ajax({
	                		 type:"post",
		               		 url:"/attend/createAjax",
		                     contentType:"application/json;charset=utf-8",
		                     data:JSON.stringify(data),
		                     dataType:"json",
		                     beforeSend:function(xhr){
		         	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		         	    	 },
		                     success: function(data) {
		                    	 console.log("createAja(정상 출근 부분) 결과 값 data : ", data);
		                          
		                    	//전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
		                    	globalEvents = data.map(function(event){
		                    	  console.log("정상 출근 부분 결과값을 globalEvents로 리턴?");
		                    	  return  { //event 발생용
		                    		  	waNo: event.waNo,
		                    			start: event.waDt,
		                    			end: event.EaOutTime,
		                    			title: event.waStatus,
		                    			empNo: event.empNo,
		                    			backgroundColor: event.backColor	
		                    	   };
		                    	   
		                    	});
		                    	console.log("globalEvents 되나 :", globalEvents);
								
		                    	// 캘린더 생성
		                        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
		                    	
		                    	// 캘린더 그리깅
		                        calendar.render();
		                        calendar.addEvent(globalEvents);
		                        
		                     	}//ajax createAjax success끝
	                	 })	//ajax createAjax 끝
	                	 
	                } //ajax getEmp Success 끝
	                	
		    	});	//ajax getEmp 끝
		    	
		    	btnDisabled1();	//비활성화
		    	
	    }; //f_gtWorkButton() => 출근 버튼 끝
        
	    
        //f_dnWorkButton() => 퇴근버튼
        function f_dnWorkButton(){
        	//지각 시간 처리
            let lateWorkHour = new Date();
            lateWorkHour.setHours(9);
            lateWorkHour.setMinutes(0);
            lateWorkHour.setSeconds(0);
            
            let lateWorkHours = ('0' + lateWorkHour.getHours()).slice(-2);
            let lateWorkMinutes = ('0' + lateWorkHour.getMinutes()).slice(-2);
            let lateWorkSeconds = ('0' + lateWorkHour.getSeconds()).slice(-2);
            
            dayString = `\${year}-\${month}-\${day}`;
            let ltWorkString = `\${lateWorkHours}:\${lateWorkMinutes}:\${lateWorkSeconds}`;
            let lateWorkString = `\${dayString} \${ltWorkString}`;
            console.log("lateWorkString:", lateWorkString);
        	
        	//퇴근 시간 처리
	    	console.log("퇴근시간");
        	
	    	let dnWokrHour = new Date();
	    	let dnWokrHours = ('0' + dnWokrHour.getHours()).slice(-2);
	    	let dnWokrMinutes = ('0' + dnWokrHour.getMinutes()).slice(-2);
	    	let dnWokrSeconds = ('0' + dnWokrHour.getSeconds()).slice(-2);
	    	
	    	dayString = `\${year}-\${month}-\${day}`;
	    	let dnWorkString = `\${dnWokrHours}:\${dnWokrMinutes}:\${dnWokrSeconds}`;
	    	let fullWorkString = `\${dayString} \${dnWorkString}`;
	    	console.log("fullWorkString :", fullWorkString);
	    	dnworkPoint.textContent = dnWorkString;
	    		
	    		//listAjax4
	    		let data = {
            		
            	"dnWorkString":dnWorkString
            	}
            
            $.ajax({
            	url: "/hldy/listAjax4",
            	contentType:"application/json;charset=utf-8",
            	data: JSON.stringify(data),
            	type: "post",
            	dataType: "text",
            	beforeSend:function(xhr){
    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    	    	},
            	success: function(response){
            		console.log("response:", response);
            	}
            	
            });
	    		
	    	//조퇴 시간 처리
	    	console.log("조퇴시간");
	    	
	    	let outWorkHour = new Date();
	    	outWorkHour.setHours(18);
	    	outWorkHour.setMinutes(0);
	    	outWorkHour.setSeconds(0);
            
            let outWorkHours = ('0' + outWorkHour.getHours()).slice(-2);
            let outWorkMinutes = ('0' + outWorkHour.getMinutes()).slice(-2);
            let outWorkSeconds = ('0' + outWorkHour.getSeconds()).slice(-2);
            
            dayString = `\${year}-\${month}-\${day}`;
            let outWorkString = `\${outWorkHours}:\${outWorkMinutes}:\${outWorkSeconds}`;
            let outedWorkString = `\${dayString} \${outWorkString}`;
            console.log("outedWorkString:", outedWorkString);
	    	
	    	$.ajax({
	                url: "/attend/getEmp",
	                type: "get",
	                dataType: "text",
	                success: function(emp) {
	                	 console.log("Logged in user: ", emp);
	                	 console.log("event 콜백해놓은 전역변수 :", globalEvents);

	                     if(emp == "error"){
	                		 alert("로그인 해주세요!!");
	                		 location.href ="/login";
	                	 }
	                     
	                     globalEvents.forEach(function (event) {
	                         console.log("waDt:", event.start); // 
	                     });	//waDt 확인 됨
	                     
	                  	 // waNo를 기준으로 정렬
		                 globalEvents.sort((a, b) => {
		                     let waNoA = parseInt(a.waNo.replace('WA', ''));
		                     let waNoB = parseInt(b.waNo.replace('WA', ''));
		                     return waNoA - waNoB;
		                 });
	                     
	                     // 가장 최근의 객체 가져오기 여기만
		                 let latestEvent2 = globalEvents[globalEvents.length - 1];

		                 // 시작 시간 가져오기
		                 let waDT = latestEvent2.start.slice(0, -2);
		                    
// 	                     let waDT = globalEvents[globalEvents.length - 1].start.slice(0, -2);
	                     console.log("뽑아낸 waDT:", waDT);
	                     
	                     globalEvents.forEach(function (event) {
	                         console.log("eaOutTime:", event.end); // 
	                     });	//eaOutTime 확인 됨
	                     
	                  	 // eaOutTime을 기준으로 정렬
	                     globalEvents.sort((a, b) => {
						    let eaOutTimeA = new Date(a.eaOutTime).getTime();
						    let eaOutTimeB = new Date(b.eaOutTime).getTime();
						    return eaOutTimeA - eaOutTimeB;
						});
	                     
	                  	// 가장 최근의 객체 가져오기
	                    let latestEvent3 = globalEvents[globalEvents.length - 1];
	                  	
	                  	console.log("지각에서 쓸 latestEvent3", latestEvent3);
	                  	
	                 	// 종료 시간 가져오기, 이게 없다는 건
// 	                    let eaOutTime2 = latestEvent3.end.slice(0, -2);
	                    //console.log("지각한 날 퇴근 때 쓰려고 뽑아낸 eaOutTime:", eaOutTime2);
	                    
	                    //출근일시 > 아침9시 그리고 퇴근시간 > 아침9시
	                    //&& eaOutTime2 > lateWorkString
                        if(waDT > lateWorkString){
                        	console.log("지각한 날 퇴근");
                        	
	                       	let waNO = globalEvents[globalEvents.length - 1].waNo;
	 		                console.log("기본키waNO 확인 :", waNO);
	                       	
	                       	let empNO = emp;
	 	                    console.log("로그인 한 회사원 번호 확인:", emp);
	                       	
	 	                    fullWorkString;
	                        console.log("퇴근시간 확인:", fullWorkString);
	 	                      	
	                       	let data = {	//ajax 전송용
	 		                 	waNo: waNO,
	 		                    waDt: fullWorkString,
	 		                    eaOutTime: fullWorkString,
	 		                    waStatus: '지각',
	 		                    empNo: emp,
	 		                    backColor: '#FFBF01',
	 		                    gubun:'퇴근'
	                      	};
	                       	
// 	                       	dnworkPoint.textContent = fullWorkString; //여기
	                       	console.log("지각한 날 data:", data);
	                       	
	                       	eaOutTime = data.eaOutTime;
	                       	
	                        $.ajax({
		                         url: "/attend/updateAjax",
		                         contentType: "application/json;charset=utf-8",
		                         data: JSON.stringify(data),
		                         type: "post",
		                         dataType: "json",
		                         beforeSend: function (xhr) {
		                             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		                         },
		                         success: function (data) {
		                             console.log("지각한 날 퇴근 data :", data);
		                             
		                           	 //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
		 	                    	 globalEvents = data.map(function(event){
		 	                    	 console.log("지각 후 수정수정?");
		 	                    	  return  { //event 발생용
		 	                    		  	waNo: event.waNo,
		 	                    			end: event.eaOutTime,
		 	                    			start: event.waDt,
		 	                    			title: event.waStatus,
		 	                    			empNo: event.empNo,
		 	                    			backgroundColor: event.backColor	
		 	                    	   };
		 	                    	   
		 	                    	});
		 	                    	console.log("이 전역변수가 되는지 확인 eaOutTimeResult:", eaOutTimeResult);
		 	                    	console.log("지각 후 수정 globalEvents 되나 :", globalEvents);
		 							
		 	                    	globalEvents.forEach(function (event) {
		 		                         console.log("eaOutTime:", event.end); // 
		 		                    });	//eaOutTime 확인 됨
		 		                     
		 		                  	 // waNo를 기준으로 정렬
		 			                 globalEvents.sort((a, b) => {
		 			                     let waNoA = parseInt(a.waNo.replace('WA', ''));
		 			                     let waNoB = parseInt(b.waNo.replace('WA', ''));
		 			                     return waNoA - waNoB;
		 			                 });
		 		                     
		 		                     // 가장 최근의 객체 가져오기 여기만2
		 			                 let latestEvent3 = globalEvents[globalEvents.length - 1];
		 		                     console.log("latestEvent3", latestEvent3);

		 			                 // 끝 시간 가져오기
		 			                 let eaOutTime = latestEvent3.start.slice(0, -2);
		 		                     console.log("뽑아낸 eaOutTime:", eaOutTime);
		 		                     
		 		                     // 급하게 조퇴 넣기
		 		                     if(eaOutTimeResult < eaOutTime){
		 		                    	console.log("여기 오는지 확인여기 오는지 확인여기 오는지 확인여기 오는지 확인");
		 		                    	latestEvent3.title ="조퇴";
		 		                    	console.log("좀 되라 좀 되랒 ㅈ뫼 되라:", latestEvent3.title);
		 		                     };
		 		                     
		 		                    console.log("globalEvents 변경 후:", globalEvents); // globalEvents 확인
		 	                    	
		 	                    	// 캘린더 생성
		 	                        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
		 	                    	
		 	                    	// 캘린더 그리깅
		 	                        calendar.render();
		 	                        calendar.addEvent(globalEvents);

		                         }// upadteAjax success 끝
		                     });// upadteAjax 끝
                        	
                        	
                        	
                        }//if(waDT > lateWorkString) 끝
	                         	
	                    else{
	                     //요기    
			             empNO;
			             console.log("로그인 한 회사원 번호 확인:", empNO);
			             
			             fullWorkString;
			             console.log("퇴근시간 확인:", fullWorkString);
			             
			             let waNO = globalEvents[globalEvents.length-1].waNo;
				         console.log("기본키waNO 확인 :", waNO);
				         
				         let data = {	//ajax 전송용
				         	 waNo: waNO,
			                 waDt: fullWorkString,
			                 eaOutTime: fullWorkString,
			                 waStatus: '퇴근',
			                 empNo: empNO,
			                 backColor: '#00FF00'
				         };
			                     
	                     $.ajax({
	                         url: "/attend/updateAjax",
	                         contentType: "application/json;charset=utf-8",
	                         data: JSON.stringify(data),
	                         type: "post",
	                         dataType: "json",
	                         beforeSend: function (xhr) {
	                             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                         },
	                         success: function (data) {
	                             console.log("data :", data);
	                             
	                           	 //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
	 	                    	 globalEvents = data.map(function(event){
	 	                    	 console.log("수정수정?");
	 	                    	  return  { //event 발생용
	 	                    		  	waNo: event.waNo,
	 	                    			end: event.eaOutTime,
	 	                    			start: event.waDt,
	 	                    			title: event.waStatus,
	 	                    			empNo: event.empNo,
	 	                    			backgroundColor: event.backColor	
	 	                    	   };
	 	                    	   
	 	                    	});
	 	                    	console.log("수정 globalEvents 되나 :", globalEvents);
	 							
	 	                    	// 캘린더 생성
	 	                        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
	 	                    	
	 	                    	// 캘린더 그리깅
	 	                        calendar.render();
	 	                        calendar.addEvent(globalEvents);

	                         }// upadteAjax success 끝
	                     });// upadteAjax 끝

	                    }//else if(waDT < lateWorkString)문 끝
						
	                 	// waNo를 기준으로 정렬
	                    globalEvents.sort((a, b) => {
	                        let waNoA = parseInt(a.waNo.replace('WA', ''));
	                        let waNoB = parseInt(b.waNo.replace('WA', ''));
	                        return waNoA - waNoB;
	                    });

	                    // 가장 최근의 객체 가져오기
	                    let latestEvent = globalEvents[globalEvents.length - 1];

	                    // 시작 시간 가져오기
	                    let waDT2 = latestEvent.start.slice(0, -2);
	                    
//                      let eaOutTime = globalEvents[globalEvents.length - 1].start.slice(0, -2);
	                    console.log("뽑아낸 waDT2는?:", waDT);
	                    
	                    // eaOutTime을 기준으로 정렬
	                    globalEvents.forEach(function (event) {
                            console.log("eaOutTime:", event.end); // 
                        });   //eaOutTime 확인 됨
                        
	                    // eaOutTime을 기준으로 정렬
	                    globalEvents.sort((a, b) => {
	                      let eaOutTimeA = new Date(a.eaOutTime).getTime();
	                      let eaOutTimeB = new Date(b.eaOutTime).getTime();
	                      return eaOutTimeA - eaOutTimeB;
	                  	});
                        
	                 	// 가장 최근의 객체 가져오기
	                    let latestEvent4 = globalEvents[globalEvents.length - 1];
					
                    	// 종료 시간 가져오기(1005)
                        let eaOutTime3 = eaOutTime.slice(0, -2);
                        console.log("뽑아낸 eaOutTime3:", eaOutTime3);
						
                        //종료시간 < 저녁6시 그리고 출근시간 < 저녁6시
	                    if(eaOutTime3 < outedWorkString && waDT2 < outedWorkString){
							console.log("조퇴");
	                    	
		                       let waNO = globalEvents[globalEvents.length - 1].waNo;
		 		               console.log("기본키waNO 확인 :", waNO);
		                       
// 		                       empNO;
		 	                   console.log("로그인 한 회사원 번호 확인:", emp);
		                       
		 	                   fullWorkString;
		                       console.log("퇴근시간 확인:", fullWorkString);
		 	                     	
		                       let data1 = {	//ajax 전송용
		 		                   waNo: waNO,
		 		                   waDt: fullWorkString,
		 		                   eaOutTime: fullWorkString,
		 		                   waStatus: '조퇴',
		 		                   empNo: emp,
		 		                   backColor: '#FF0000'
		                       };
		                       
		                       console.log("조퇴한 날 data1:", data1);
		                       
		                       $.ajax({
			                        url: "/attend/updateAjax",
			                        contentType: "application/json;charset=utf-8",
			                        data: JSON.stringify(data1),
			                        type: "post",
			                        dataType: "json",
			                        beforeSend: function (xhr) {
			                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			                        },
			                        success: function (data) {
			                            console.log("조퇴 data ajax 결과값:", data);
			                            
			                          	 //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
			 	                   	 globalEvents = data.map(function(event){
			 	                   	 console.log("조퇴 후 수정수정?");
			 	                   	  return  { //event 발생용
			 	                   		  	waNo: event.waNo,
			 	                   			end: event.eaOutTime,
			 	                   			start: event.waDt,
			 	                   			title: event.waStatus,
			 	                   			empNo: event.empNo,
			 	                   			backgroundColor: event.backColor	
			 	                   	   };
			 	                   	   
			 	                   	});
			 	                   	console.log("조퇴 후 수정 globalEvents 되나 :", globalEvents);
			 				 		
			 	                   	// 캘린더 생성
			 	                    const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
			 	                   	
			 	                   	// 캘린더 그리깅
			 	                    calendar.render();
			 	                    calendar.addEvent(globalEvents);
                               
			                        }// upadteAjax success 끝
			                    });// upadteAjax 끝
	                    	
						}// if(eaOutTime < outedWorkString) 끝
						
						//비동기 처리
						console.log("비동기 처리");						
						
						let data = {
							"empId":"${empId}"	
						};
						
						console.log("data : ", data);
						
						$.ajax({
							url:"/attend/listAjax2",
							contentType:"application/json;charset=utf-8",
							data:JSON.stringify(data),
							type:"post",
							dataType:"json",
							beforeSend:function(xhr){
								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
							},
							success:function(result){
								/*result
								{"empId": "b001","empNo": "A102","waStatus": "지각"
									,"totalWork": 16,"outWork": 4,"lateWork": 6}
								*/
								console.log("result : ", result);
								
								$("#trShow").children("tr").children("td").eq(0).html(result.totalWork);
								$("#trShow").children("tr").children("td").eq(1).html(result.lateWork);
								$("#trShow").children("tr").children("td").eq(2).html(result.outWork);
							}
						});
	                    
	               	}//ajax getEmp success 끝	 
	            });//ajax getEmp 끝
	    	
	          	btnDisabled2();//비활성화
        
        }//f_dnWorkButton() => 퇴근버튼 끝!!

        // 모달 닫기
        function fMClose() {
            YrModal.style.display = "none";
        }
	       
	</script>
</body>
</html>