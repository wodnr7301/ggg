<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                     	일정관리 
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
    <!-- 라이센스 필요한 애 우앙 $480 음.. 맹글어볼깡? 
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.8/index.global.min.js'></script>
    -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <script type="text/javascript" src="/resources/js/jquery.min.js"></script>
    
    <style>

        #calendar {
            width: 70vw;
            height: 70vh;
            float: right;
        }

        #yrModal {
            position: fixed;
            top: 5%;
            width: 100%;
            height: 100%;
            background-color: rgb(223, 231, 253, 0.3);
            display: none;
            z-index: 1000;
        }
        
        #yrModal2 {
            position: fixed;
            top: 5%;
            width: 100%;
            height: 100%;
            background-color: rgb(223, 231, 253, 0.3);
            display: none;
            z-index: 1000;
        }
        
        #CalendarCard {
        	position: relative;
        	top: -130px;
        	margin-left: 40px;
            margin-right: 40px;
            height: 90vh; 
        }
        
        #SideBar {
        	float: left;
        	text-align: center;
        	font-size: 18px;
        	position:relative;
        	top:3px
        	
        }
        
        input[readonly] {
            background-color: #f0f0f0; /* 옅은 회색 배경색 */
            color: #6c757d; /* 회색 텍스트 색상 */
        }
        
        /* 일요일 날짜 빨간색 */
		.fc-day-sun a {
		  color: red;
		  text-decoration: none;
		}

		/* 토요일 날짜 파란색 */
		.fc-day-sat a {
		  color: blue;
		  text-decoration: none;
		}
		
		#personal {
  			accent-color: #EA6676;
		}
		
		#department {
  			accent-color: #66648B;
		}

    </style>
</head>

<body>
	  <div class="modal fade show" id="yrModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-modal="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                   <div class="modal-header">
						<input class="form-control" type="text" id="tdlTtl" name="tdlTtl" value="제목">
                   </div>
                   <div class="modal-body">
		                            시작일 <input class="form-control" type="date" id="tdlStrDt" name="tdlStrDt" value=""><br>
		                            종료일 <input class="form-control" type="date" id="tdlEndDt" name="tdlEndDt" value=""><br>
		                            사원이름 <input class="form-control" type="text" id="empNo" name="empNo" value="" readonly><br>
		                            부서이름 <input class="form-control" type="text" id="deptNo" name="deptNo" value="" readonly><br>
 					<label for="tdlCmptnYn">카테고리</label>
		            <select class="form-control" id="tdlCmptnYn" name="tdlCmptnYn">
		                <option value="" selected>--</option>
		                <option value="#EA6676">개인</option>
		                <option value="#66648B">부서</option>
		            </select><br>
<!-- 		            <input type="color" id="backColor" name="backColor" value="#EA6676" ><br>           -->
		                            내용 <input class="form-control" type="text" id="tdlCn" name="tdlCn" value=""><br>
                   </div>
                   <div class="modal-footer">
                       <button class="btn btn-primary" type="button" onclick="fCalAdd()">등록</button>
                       <button class="btn btn-secondary" type="button" onclick="fMClose()" data-bs-dismiss="modal">닫기</button>
                   </div>
                 </div>
            </div>
      </div>
      
      <div class="modal fade show" id="yrModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-modal="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
              	  <input  class="form-control" type="hidden" id="tdlNo2" name="tdlNo2" value="">
                  <input  class="form-control" type="text" id="tdlTtl2" name="tdlTtl2" value="제목">
              </div>
              <div class="modal-body">
		                  시작일 <input class="form-control" type="date" id="tdlStrDt2" name="tdlStrDt2" value=""><br>
		                  종료일 <input class="form-control" type="date" id="tdlEndDt2" name="tdlEndDt2" value=""><br>
		                  사원이름 <input class="form-control" type="text" id="empNo2" name="empNo2" value="" readonly><br>
		                  부서이름 <input class="form-control" type="text" id="deptNo2" name="deptNo2" value="" readonly><br>
				<label for="tdlCmptnYn2">카테고리</label>
		            <select class="form-control" id="tdlCmptnYn2" name="tdlCmptnYn2">
		                <option value="" selected>--</option>
		                <option value="#EA6676">개인</option>
		                <option value="#66648B">부서</option>
		            </select><br>
		                  내용 <input class="form-control" type="text" id="tdlCn2" name="tdlCn2" value=""><br>
              </div>
              <div class="modal-footer">
                  <button class="btn btn-primary" type="button" onclick="fMUpdate()" data-bs-dismiss="modal">수정</button>
                  <button class="btn btn-danger" type="button" onclick="fCalDelete()" data-bs-dismiss="modal">삭제</button>
                  <button class="btn btn-secondary" type="button" onclick="fMClose()" data-bs-dismiss="modal">닫기</button>
              </div>
          </div>
        </div>
      </div>

    <!-- 실제 화면을 담을 영역 -->
	<div class="card mb-4" id="CalendarCard">
	    <div class="card-body">
	    	<div id="Wrapper">           
    			<div id='calendar'></div>
			</div>
			<div id="SideBar">
                <input type="checkbox" class="calendarCheckBox" id="all" name="schedule" value="all" onchange="f_allist()" checked>
                <label for="all">전체일정</label><br><br>
				<input type="checkbox" class="calendarCheckBox" id="personal" name="schedule" value="personal" onchange="f_pelist()">
                <label for="personal">개인일정</label><br><br>
                <input type="checkbox" class="calendarCheckBox" id="department" name="schedule" value="department" onchange="f_delist()">
                <label for="department">부서일정</label>
			</div>                       
	    </div>
	</div>
	
    <script>
    	//날짜형 문자를 날짜형으로 변환
    	//0123456789
    	//2024-06-11 -> 날짜형
    	//123456789...
	    function parse(str) {    
    		let strArr = str.split("-");
	    	var y = strArr[0];   //2024 
	    	var m = strArr[1];   //06
	    	var d = strArr[2];   //11
	    	
	    	return new Date(y,m-1,d);
	    }
    
    	//pDate : 날짜타입(new Date())
    	//그 날을 문자로 리턴
	    function toJWformat(pDate) {
	        let year = pDate.getFullYear();
	        let month = pDate.getMonth() + 1;
	        if (month < 10) {
	          month = "0" + month;
	        }
	        let date = pDate.getDate();
	        if (date < 10) {
	          date = "0" + date;
	        }
	
	        return `\${year}-\${month}-\${date}`; // 만약 jsp 안 이라면 \$year식으로
	    }
    
	    //그 날의 전 날을 문자로 리턴
	    function toJWBformat(pDate) {
	    	console.log("pDate : " + pDate);
	    	//전 날
	    	//pDate = pDate.setDate(pDate.getDate() - 1);
	        let year = pDate.getFullYear();
	        let month = pDate.getMonth() + 1;
	        if (month < 10) {
	          month = "0" + month;
	        }
	        let date = pDate.getDate() - 1;
	        if (date < 10) {
	          date = "0" + date;
	        }
	
	        return `\${year}-\${month}-\${date}`; // 만약 jsp 안 이라면 \$year식으로
	    }
	    
	    //그 날의 다음 날을 문자로 리턴
	    function toJWAformat(pDate) {
	    	//다음 날
	    	pDate = pDate.setDate(pDate.getDate() + 1);
	        let year = pDate.getFullYear();
	        let month = pDate.getMonth() + 1;
	        if (month < 10) {
	          month = "0" + month;
	        }
	        let date = pDate.getDate() - 1;
	        if (date < 10) {
	          date = "0" + date;
	        }
	
	        return `\${year}-\${month}-\${date}`; // 만약 jsp 안 이라면 \$year식으로
	    }
    
    	//체크박스가 하나 선택되면 다른 체크박스는 선택 해제
	    function uncheckOthers(changedCheckbox) {	//changedCheckbox, onchange가 시행되었을 때 생긴 인자에 대해 내가 임의로 이름을 정한 것
      		const checkboxes = document.querySelectorAll('.calendarCheckBox');	//클래스 calendarCheckBox 모두 가져와서
      		let isAnyCheckboxChecked = false;
      		
	      	checkboxes.forEach(checkbox => {	//반복문 돌릴건데
		        if (checkbox !== changedCheckbox) {	//체크박스가 changedCheckbox와 다를 때
		          checkbox.checked = false;		//false로 만들어버려
		        } else {
		            isAnyCheckboxChecked = checkbox.checked;
		        }
	      	});
      		
	     	// 적어도 하나는 체크되어 있어야 함
	      	if (!isAnyCheckboxChecked) {
	            swal("적어도 하나의 체크박스는 선택되어 있어야 합니다.","","info");
	            changedCheckbox.checked = true; // 마지막 체크박스를 다시 체크
	        }
    	}
    	
    	//여기서부터는 모달
    	
    	//전역변수 check
        let globalEvents=[];
    	console.log("전역변수 globalEvents 체크:", globalEvents);
    	let tdlNo;
    	let globalEmp = null;
    	let globalEmpNm =null;
    	let globalDept = null;
    	let globalDeptNm = null;
    	
        const calendarEl = document.querySelector('#calendar');
        
        const YrModal = document.querySelector("#yrModal");
        const myTdlNo = document.querySelector("#tdlNo");
        const mySchTitle = document.querySelector("#tdlTtl");
        const mySchStart = document.querySelector("#tdlStrDt");
        const mySchEnd = document.querySelector("#tdlEndDt");
        const myEmpNo = document.querySelector("#empNo");
        const myDeptNo = document.querySelector("#deptNo");
        const mySchCn = document.querySelector("#tdlCn");
        const myTdlCmptnYn = document.querySelector("#tdlCmptnYn");
        
        const myTdlNo2 = document.querySelector("#tdlNo2");
        const YrModal2 = document.querySelector("#yrModal2");
        const mySchTitle2 = document.querySelector("#tdlTtl2");
        const mySchStart2 = document.querySelector("#tdlStrDt2");
        const mySchEnd2 = document.querySelector("#tdlEndDt2");
        const myEmpNo2 = document.querySelector("#empNo2");
        const myDeptNo2 = document.querySelector("#deptNo2");
        const mySchCn2 = document.querySelector("#tdlCn2");
        const myTdlCmptnYn2 = document.querySelector("#tdlCmptnYn2");

        //캘린더 헤더 옵션
        const headerToolbar = {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth'
        }
		
        // 캘린더 생성 옵션(참공)
        const calendarOption = {
       		dayHeaderContent: function(args) {
       		    var date = args.date;
       		    var dayNumber = date.getDay();
       		    if (dayNumber === 0) {
       		        return { html: '<span style="color:#FF6961;">' + args.text + '</span>' };
       		    } else if (dayNumber === 6) {
       		        return { html: '<span style="color:#5A9BD5;">' + args.text + '</span>' };
       		    }
       		    return args.text;
       		},
       		eventBorderColor: 'transparent',//테두리 제거
            height: '750px', // calendar 높이 설정
            expandRows: true, // 화면에 맞게 높이 재설정
            slotMinTime: '09:00', // Day 캘린더 시작 시간
            slotMaxTime: '18:00', // Day 캘린더 종료 시간
            // 맨 위 헤더 지정
            headerToolbar: headerToolbar,
            initialView: 'dayGridMonth',  // default: dayGridMonth 'dayGridWeek', 'timeGridDay', 'listWeek'
            locale: 'kr',        // 언어 설정
            selectable: true,    // 영역 선택
            selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
         	navLinks: true,      // 날짜,WeekNumber 클릭 여부, default false
            weekNumbers: false,   // WeekNumber 출력여부, default false
            editable: true,      // event(일정)
            /* 시작일 및 기간 수정가능여부
            eventStartEditable: true,
            eventDurationEditable: true,
            */
            dayMaxEventRows: true,  // Row 높이보다 많으면 +숫자 more 링크 보임!
            nowIndicator: true,
//             events:[],
            dateClick: function(info){
				console.log("Clicked event occurs : date = ", info.dateStr);//2024-06-08
				console.log("info.dateStr : " + info.dateStr);
				
				$("#tdlEndDt").val(info.dateStr);
            },
            eventSources: [	
            	
            	{
                    events: function(info, successCallback, failureCallback) { // ajax 처리로 데이터를 로딩 시킨다.
                    
	             	$.ajax({
	             		url: "/todoList/getEmp",
	                     type: "get",
	                     dataType: "json",
	                     success: function(emp) {
	                     	 console.log("Logged in user: ", emp);
	                     	 
	                     	 globalEmp = emp.empNo; //전역변수에 담기(위로 뺄거임)
	                     	 console.log("globalEmp 값 확인", globalEmp);

	                     	 globalEmpNm = emp.empNm; //전역변수에 담기(위로 뺄거임)
	                     	 console.log("globalEmpNm", globalEmpNm);
	                     	 
	                     	 $('#empNo').val(globalEmpNm); //insert 모달에 empNm 넣기
	                     	 
	                     	 $.ajax({
	    	             		url: "/todoList/getDept",
	    	                     type: "get",
	    	                     dataType: "json",
	    	                     success: function(dept) {
	    	                     	 console.log("Logged in user: ", dept);
	    	                     	 
	    	                     	 let deptNo = dept.deptVO.deptNo;
	    	                     	 let deptNm = dept.deptVO.deptNm;
	    	                     	 
	    	                     	 $('#deptNo').val(deptNm); //insert 모달에 deptNm 넣기
	    	                     	 
	    	                     	 globalDept = deptNo; //전역변수에 담기(위로 뺄거임)
	    	                     	 globalDeptNm = deptNm; //전역변수에 담기(위로 뺄거임)
	    	                     	 
	    	                     	 console.log("globalDept 값 확인", globalDept);
	    	                     	 
	    	                     	 
	    	                     	 console.log("globalEmp globalEmp 값 확인 값 확인 :", globalEmp);
	    	                     	 console.log("globalDept globalDept 값 확인 값 확인 :", globalDept);
	    	                     	
	    	                     	 let listdata = {
	    	                     			"empNo":globalEmp,
	    	                     			"deptNo":globalDept
	    	                     	 }
	    	                     	 
	    	                     	 //eventSource listAjax 데이터 체크
	    	                     	 console.log("eventSource listAjax 데이터 체크:", listdata);
	    	                     	 
	    	                     	 $.ajax({  
	    	                            url: "/todoList/listAjax",
	    	                            type: "post",
	    	                            contentType:"application/json;charset=utf-8",
	    	                            data: JSON.stringify(listdata),
	    	                            dataType:"json",
	    	                            beforeSend:function(xhr){
	    		            	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    		            	    	},
	    	                            success: function(data) {
	    	                              console.log("eventSource[] data : ", data);
	    	                              	
	    	                           	  // 체크박스 상태 확인
	    	                              let isallChecked = $('#all').is(':checked');
	    	                           	  let isPersonalChecked = $('#personal').is(':checked');
	    	                              let isDepartmentChecked = $('#department').is(':checked');
	    	                              
	    	                              
	    	                              if(isallChecked){
	    	                            	  
	    	                            	  console.log("전체체크박스 :", data);
	    	                            	  
	    	                            	  calendar.removeAllEvents(globalEvents);
				                 			  //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
	    	                            	  
	    	                            	  //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
		    	                              globalEvents = data.map(function(event){
		    	                            	  
		    	                            	  return  { //event 발생용
		    	                                      tdlNo: event.tdlNo,
		    	                                      title: event.tdlTtl,
		    	                                      start: event.tdlStrDt,
		    	                                      end: event.tdlEndDt,
		    	                                      empNo: event.empNo,
		    	                                      deptNo: event.deptNo,
		    	                                      backgroundColor: event.tdlCmptnYn,
		    	                                      tdlCn: event.tdlCn,
		    	                                   };
		    	                                   
		    	                              });
		    	                              console.log("eventSource 전체 체크박스 gb:", globalEvents);
		    	                              successCallback(globalEvents);
		    	                              
	    	                              }else if(isPersonalChecked){
	    	                            	  
	    	                            	  console.log("개인체크박스 ");
	    	                            	  
	    	                            	  $.ajax({
	    	                              		url: "/todoList/getEmp",
	    	                                      type: "get",
	    	                                      dataType: "json",
	    	                                      success: function(emp) {
	    	                                      	 console.log("Logged in user: ", emp);
	    	                                      	 
	    	                                      	 let empNoImpl = emp.empNo;
	    	                                      	 let empNmImpl = emp.empNm;
	    	                                      	 console.log("empNoImpl:", empNoImpl);
	    	                                      	 console.log("empNmImpl:", empNmImpl);
	    	                                      	 
	    	                                      	 $('#empNo').val(empNmImpl); //insert 모달에 empNm 넣기
	    	                                      	 $('#deptNo').val(globalDeptNm); //insert 모달에 deptNm 넣기
	    	                                      	 
	    	                                           if(empNoImpl != null){
	    	                                           	console.log("개인체크박스에 왔나?");
	    	                                           	
	    	                                           	let data = {
	    	                                      			"empNo":empNoImpl,
	    	                                      			"tdlCmptnYn":"#EA6676"
	    	                                      	 	}
	    	                                               
	    	                                           	globalEmp = empNoImpl; //전역변수에 담기(위로 뺄거임)
	    	                                           	console.log("개인 체크박스 전역변수로 뺀 globalEmp:", globalEmp);
	    	                                           	
	    	                                           	console.log("개인 체크박스 아작스 매개변수 data :", data);

	    	                                               $.ajax({

	    	                                               url:"/todoList/peCheckBoxListAjax",
	    	                                               contentType:"application/json;charset=utf-8",
	    	                                               data:JSON.stringify(data),
	    	                                               type :"post",
	    	                                               beforeSend:function(xhr){
	    	                                               	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	                                               },
	    	                                               success:function(result){

	    	                                               console.log("개인 체크박스 아작스 결과값 result : ", result);
	    	                                               	
	    	                                               calendar.removeAllEvents(globalEvents); 
	    	                                               //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
	    	                                               	
	    	                                               //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
	    	                                               globalEvents = result.map(function(event){
	    	                                                  
	    	                                                  return  { //event 발생용
	    	                                                       tdlNo: event.tdlNo,
	    	                                                       title: event.tdlTtl,
	    	                                                       start: event.tdlStrDt,
	    	                                                       end: event.tdlEndDt,
	    	                                                       empNo: event.empNo,
	    	                                                       deptNo: event.deptNo,
	    	                                                       backgroundColor: event.tdlCmptnYn,
	    	                                                       tdlCn: event.tdlCn,
	    	                                                    };
	    	                                                    
	    	                                               });

	    	                                               console.log("eventSource 개인 체크박스 gb:", globalEvents);
	    	                                               successCallback(globalEvents);	
	    	                               	    		} //개인 체크박스 ajax success 끝
	    	                               	    	 
	    	                               	        	});//개인 체크박스 ajax 끝
	    	                               	        	
	    	                               	        	
	    	                                            }//if(empNoImpl != null)문 끝
	    	                                      
	    	                                      } //getEmpAjax success 끝
	    	                              	
	    	                              	  }); //getEmpAjax 끝
	    	                            	  
	    	                              }else if(isDepartmentChecked){
	    	                            	  
	    	                            	  console.log("부서체크박스 ");
	    	                            	  
	    	                            	  $.ajax({
	    	                              		url: "/todoList/getDept",
	    	                                      type: "get",
	    	                                      dataType: "json",
	    	                                      success: function(dept) {
	    	                                      	 console.log("Logged in Dept: ", dept);
	    	                      				
	    	                                      	 let deptNoImpl = dept.deptNo;
	    	                                      	 console.log("deptNoImpl:", deptNoImpl);
	    	                                      	 
	    	                                      	 if(deptNoImpl != null){
	    	                                               console.log("부서체크박스에 왔나?")
	    	                                               
	    	                                               globalDept = deptNoImpl; //전역변수에 담기(위로 뺄거임)
	    	                                           	   console.log("부서 체크박스 전역변수로 뺀 globalDept", globalDept);
	    	                                           
	    	                                           let data = {
	    	                                              	 
	    	                                              "deptNo":deptNoImpl,
	    	                                              "tdlCmptnYn":"#66648B"
	    	                                           };
	    	                                              
	    	                                           console.log("부서 체크박스 아작스 매개변수 data :", data);
	    	                                      	
	    	                                          $.ajax({

	    	                                          url:"/todoList/deCheckBoxListAjax",
	    	                                          contentType:"application/json;charset=utf-8",
	    	                                          data:JSON.stringify(data),
	    	                                          type :"post",
	    	                                          beforeSend:function(xhr){
	    	                                              xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	                                          },
	    	                                          success:function(result){

	    	                                          console.log("부서 체크박스 아작스 결과값 result : ", result);
	    	                                              
	    	                                          calendar.removeAllEvents(globalEvents);
	    	                                          //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
	    	                                              
	    	                                          globalEvents = result.map(function(event){
                                                          
                                                          return  { //event 발생용
                                                               tdlNo: event.tdlNo,
                                                               title: event.tdlTtl,
                                                               start: event.tdlStrDt,
                                                               end: event.tdlEndDt,
                                                               empNo: event.empNo,
                                                               deptNo: event.deptNo,
                                                               backgroundColor: event.tdlCmptnYn,
                                                               tdlCn: event.tdlCn,
                                                            };
                                                            
                                                       });

                                                       console.log("eventSource 부서 체크박스 gb:", globalEvents);
                                                       successCallback(globalEvents);  
	    	                                              
	    	                                          } //부서 체크박스 success 끝
	    	                                      
	    	                                          });//부서 체크박스 ajax 끝
	    	                                          
	    	                                      }//if(deptNoImpl != null)문 끝
	    	                                      
	    	                                      }//get deptNo suceess 끝
	    	                                  })//get deptNo ajax 끝
	    	                            	  
	    	                            	  
	    	                              };//if(isallChecked) 끝
	    	                            	  
	    	                              
					    	              
// 	    	                              calendar.removeAllEvents(globalEvents);
			                 			  //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
			                 			  
			                 			  
			                 			  
	    	                              //전역변수로 위로 올려버림, 아작스 결과값을 어디에서든 꺼내 쓸 수 있게(by 양자바쌤)
// 	    	                              globalEvents = data.map(function(event){
	    	                            	  
// 	    	                            	  return  { //event 발생용
// 	    	                                      tdlNo: event.tdlNo,
// 	    	                                      title: event.tdlTtl,
// 	    	                                      start: event.tdlStrDt,
// 	    	                                      end: event.tdlEndDt,
// 	    	                                      empNo: event.empNo,
// 	    	                                      deptNo: event.deptNo,
// 	    	                                      backgroundColor: event.tdlCmptnYn,
// 	    	                                      tdlCn: event.tdlCn,
// 	    	                                   };
	    	                                   

// 	    	                              });
	    	                              
// 	    	                              console.log("전역변수로 위로 올려버린 globalEvents :", globalEvents);
	    	                              
// 	    	                              successCallback(globalEvents); 

	    	                            },	//listAjax success 끝
	    	                            
	    	                            error: function() {
	    	                              failureCallback();
	    	                            }
	    	                          
	    	                          }); //listAjax 끝
	    	                     	 
		    	                          let getCount = {
		    	                        		  
		    	                        	"empNo":globalEmp
		    	                          }
		    	                          
		    	                          console.log("한번 보자 잘 뜨나:", getCount);
		    	                          
		    	                          $.ajax({
		    	                        	type:"post",
		    	                        	url:"/todoList/getCountAjax",
		    	                        	contentType:"application/json;charset=utf-8",
		    	                        	data:JSON.stringify(getCount),
		    	                        	dataType:"text",
		    	                        	beforeSend:function(xhr){
		    		    	         	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    		    	         	    },
		    		    	         	   	success: function(getCountData) {
		  	    	                    	 console.log("성공 후 받은 getCountData : ", getCountData);
		    		    	         	   	} //ajax getCountAjax suceess 끝
		    	                          }); //ajax getCountAjax 끝
	    	                          
	    	                     	}	//getDept success 끝
	    	             		 });	//getDept 끝
	                     	 		
	                     	 
	                     	}	//getEmp success 끝
	             		 });	//getEmp ajax 끝
	             		 
                    	
                    } //events function 끝
                  
            	} //eventSource 중괄호
            	
            ] //eventSource 대괄호
        } //캘린더 생성 옵션 끝

        // 캘린더 생성
        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
        // 캘린더 그리깅
        calendar.render();

        // 캘린더 이벤트 등록
        calendar.on("eventAdd", info => console.log("Add:", info));
        calendar.on("eventChange", info => console.log("Change:", info));
        calendar.on("eventRemove", info => console.log("Remove:", info));
        calendar.on("eventDrop", function(info) {
        	  // 여기서 info는 이벤트를 드롭한 후의 정보를 담고 있음
        	  console.log("이벤트가 드롭되었습니다:", info.event);
        	  console.log("날짜 외 이런 정보들이 있습니다:", info.event.extendedProps);
        	  console.log("테스트입니다:", info.event._def.title);
        	  console.log("날짜 정보(시작):", info.event.start);
        	  console.log("날짜 정보(끝):", info.event.end); //하루 짜리 event에는 null
        	  
        	  let updateTdlNo = info.event.extendedProps.tdlNo;
        	  let updateTitle = info.event._def.title;
        	  let updateTdlCn = info.event.extendedProps.tdlCn;
        	  let updateStrdt = info.event.start
        	  let updateEnddt = info.event.end
        	  let updateEmpNo = info.event.extendedProps.empNo;
        	  let updateDeptNo = info.event.extendedProps.deptNo;
        	  let updateColor = info.event.backgroundColor;
        	  
        	  //if test문 안되면 nvl
        	  let updateForData = {
        		"tdlNo":updateTdlNo,
        		"tdlTtl":updateTitle,
        		"tdlCn":updateTdlCn,
        		"tdlStrDt":updateStrdt,
        		"tdlEndDt":updateEnddt,
        		"tdlCmptnYn":updateColor,
        		"empNo":updateEmpNo,
        		"deptNo":updateDeptNo
        	  }
        	  console.log("드롭 업데이트를 위한 전송용 데이터:", updateForData);
        	  
        	  $.ajax({
      			url:"/todoList/updateAjax",
      			contentType:"application/json;charset=utf-8",
      			data:JSON.stringify(updateForData),
      			type:"post",
      			dataType:"json",
      			beforeSend:function(xhr){
      	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      	    	},
      			success:function(result){
      				console.log("result :", result);
      					
      				$("input[name='tdlTtl2']").val(result.tdlTtl);
      	    		$("input[name='tdlNo2']").val(result.tdlNo);
      	    		$("input[name='tdlStrDt2']").val(result.tdlStrDt);
      	    		$("input[name='tdlEndDt2']").val(result.tdlEndDt);
      	    		$("input[name='tdlCn2']").val(result.tdlCn);
      	    		$("input[name='tdlCmptnYn2']").val(result.tdlCmptnYn);
      	    		
      	    		console.log("수정 끝:", result);
      				
      	    		//재호출 후 닫기
      				swal("수정이 완료되었습니다.","","success").then(function() {
      	    			window.location.href = "/todoList/list";
      	    		});
      				fMClose();	
      				
      			}	//updateAjax success 끝
              });	//updateAjax 끝
        	  
        }); //eventDrop 끝
        calendar.on("eventClick", info => {
			
            console.log('Event: ', info.event.extendedProps);//이벤트에 추가된 값들 들어있는거 확인
            
            // 이벤트 클릭 할 때 모달이 뜸
            YrModal2.style.display = "block"
           	YrModal.style.display = "none"
            
			tdlNo = info.event.extendedProps.tdlNo	//이벤트 tdlNo꺼내서 전역변수로 보냄
			console.log('tdlNo>>>>>>>', tdlNo);
           	
        	let data = {
            // 일정 번호를 메인으로, detail을 하나만 가져오기 위해	
                 "tdlNo": tdlNo
            }
            console.log("detailAjax용 data :", data);
        	
         	$.ajax({
	    	url:"/todoList/detailAjax",
	    	contentType:"application/json;charset=utf-8",
	    	data:JSON.stringify(data),
	    	type :"post",
	    	beforeSend:function(xhr){
	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	},
	    	success:function(result){

	    		console.log("detailAjax 결과 값 확인 result : ", result);
				
	    		$("input[name='tdlNo2']").val(result.tdlNo);
	    		$("input[name='tdlTtl2']").val(result.tdlTtl);
	    		$("input[name='tdlStrDt2']").val(result.tdlStrDt);
	    		$("input[name='tdlEndDt2']").val(result.tdlEndDt);
	    		$("input[name='empNo2']").val(result.empNm);
	    		$("input[name='deptNo2']").val(result.deptNm);
	    		$("input[name='tdlCn2']").val(result.tdlCn);
	    		$("select[name='tdlCmptnYn2']").val(result.tdlCmptnYn);
	
	    	}	//detailAjax success 끝
	    	 
	        });	//detailAjax 끝
            
        }); //calendar.on("eventClick" 끝
        calendar.on("dateClick", info => console.log("dateClick:", info));
        calendar.on("select", info => {
            console.log("select 체킁 :", info);

            mySchStart.value = info.startStr;	//빈 날짜를 select 했을 때 첫번째 모달의 mySchStart에 시작시간 넣기
            mySchEnd.value = info.endStr;	//빈 날짜를 select 했을 때 첫번째 모달의 mySchEnd에 종료시간 넣기

            YrModal.style.display = "block";
            YrModal2.style.display = "none";
            
        });	//calendar.on("select" 끝
        
        
     	// checkBox 개인
        function f_pelist(){
        	console.log("CKBOX 개인 globalEvents 확인:", globalEvents);
        	console.log("CKBOX 개인 globalEmp 확인:", globalEmp);
        	console.log("CKBOX 개인 globalDept 확인:", globalDept);
        	console.log("CKBOX 개인 globalEmpNm 확인:", globalEmpNm);
        	console.log("CKBOX 개인 globalDeptNm 확인:", globalDeptNm);
        	
        	uncheckOthers(document.getElementById('personal')); //체크박스가 하나 선택되면 다른 체크박스는 선택 해제, 적어도 하나의 체크박스는 선택되어 있어야 함
        	
        	console.log("아작스 시작 전");
        	
        	// EmployeeVO 정보 가져오기
        	$.ajax({
        		url: "/todoList/getEmp",
                type: "get",
                dataType: "json",
                success: function(emp) {
                	 console.log("Logged in user: ", emp);
                	 
                	 let empNoImpl = emp.empNo;
                	 let empNmImpl = emp.empNm;
                	 console.log("empNoImpl:", empNoImpl);
                	 console.log("empNmImpl:", empNmImpl);
                	 
                	 $('#empNo').val(empNmImpl); //insert 모달에 empNm 넣기
                	 $('#deptNo').val(globalDeptNm); //insert 모달에 deptNm 넣기
                	 
                     if(empNoImpl != null){
                     	console.log("개인체크박스에 왔나?");
                     	
                     	let data = {
                			"empNo":empNoImpl,
                			"tdlCmptnYn":"#EA6676"
                	 	}
                         
                     	globalEmp = empNoImpl; //전역변수에 담기(위로 뺄거임)
                     	console.log("개인 체크박스 전역변수로 뺀 globalEmp:", globalEmp);
                     	
                     	console.log("개인 체크박스 아작스 매개변수 data :", data);

                         $.ajax({

                         url:"/todoList/peCheckBoxListAjax",
                         contentType:"application/json;charset=utf-8",
                         data:JSON.stringify(data),
                         type :"post",
                         beforeSend:function(xhr){
                         	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                         },
                         success:function(result){

                         console.log("개인 체크박스 아작스 결과값 result : ", result);
                         	
                         calendar.removeAllEvents(globalEvents); 
                         //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
                         	
                         //result로 여러개인 결과값을 모두 event발생용으로 addevent시켜버려야됨
                         result.forEach(function(item) {
         				    
                        	 let event = {
                         			
                                    tdlNo: item.tdlNo,
                                    title: item.tdlTtl,
        			        		start: item.tdlStrDt,
                                    end: item.tdlEndDt,
                                    empNo: item.empNo,
                                    deptNo: item.deptNo,
                                    tdlCn: item.tdlCn,
                                    backgroundColor: item.tdlCmptnYn
                                     
                 		 		};
         				 calendar.addEvent(event);
         				        
         				       
             			 });//forEach 끝
                         	
         	    		} //개인 체크박스 ajax success 끝
         	    	 
         	        	});//개인 체크박스 ajax 끝
         	        	
         	        	
                     }//if(empNoImpl != null)문 끝
                
                } //getEmpAjax success 끝
        	
        	}); //getEmpAjax 끝
        	
        };//f_pelist 끝
        	
        
     	// checkBox 부서
        function f_delist(){
        	console.log("CKBOX 부서 globalEvents 확인:", globalEvents);
        	console.log("CKBOX 부서 globalEmp 확인:", globalEmp);
        	console.log("CKBOX 부서 globalDept 확인:", globalDept);
        	console.log("CKBOX 부서 globalEmpNm 확인:", globalEmpNm);
        	console.log("CKBOX 부서 globalDeptNm 확인:", globalDeptNm);
        	
        	$('#empNo').val(globalEmpNm); //insert 모달에 empNm 넣기
       	    $('#deptNo').val(globalDeptNm); //insert 모달에 deptNm 넣기
        	
        	uncheckOthers(document.getElementById('department'));
        	console.log("부서 체크박스 아작스 시작 전");
        	
            $.ajax({
        		url: "/todoList/getDept",
                type: "get",
                dataType: "json",
                success: function(dept) {
                	 console.log("Logged in Dept: ", dept);
				
                	 let deptNoImpl = dept.deptNo;
                	 console.log("deptNoImpl:", deptNoImpl);
                	 
                	 if(deptNoImpl != null){
                         console.log("부서체크박스에 왔나?")
                         
                         globalDept = deptNoImpl; //전역변수에 담기(위로 뺄거임)
                     	 console.log("부서 체크박스 전역변수로 뺀 globalDept", globalDept);
                     
                     let data = {
                        	 
                        "deptNo":deptNoImpl,
                        "tdlCmptnYn":"#66648B"
                     };
                        
                     console.log("부서 체크박스 아작스 매개변수 data :", data);
                	
                    $.ajax({

                    url:"/todoList/deCheckBoxListAjax",
                    contentType:"application/json;charset=utf-8",
                    data:JSON.stringify(data),
                    type :"post",
                    beforeSend:function(xhr){
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success:function(result){

                    console.log("부서 체크박스 아작스 결과값 result : ", result);
                        
                    calendar.removeAllEvents(globalEvents);
                    //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
                        
                    //result로 여러개인 결과값을 모두 event발생용으로 addevent시켜버려야됨
                    result.forEach(function(item) {
                        let event = {
                            
                            tdlNo: item.tdlNo,
                            title: item.tdlTtl,
                            start: item.tdlStrDt,
                            end: item.tdlEndDt,
                            empNo: item.empNo,
                            deptNo: item.deptNo,
                            tdlCn: item.tdlCn,
                            backgroundColor: item.tdlCmptnYn
                            
                        };
                        calendar.addEvent(event);
                        
                    });//forEach 끝
                        
                    } //부서 체크박스 success 끝
                
                    });//부서 체크박스 ajax 끝
                    
                }//if(deptNoImpl != null)문 끝
                
                }//get deptNo suceess 끝
            })//get deptNo ajax 끝

        	
        }//f_delist 끝
        
     	// checkBox 전체
        function f_allist(){
        	console.log("CKBOX 전체 globalEvents 확인:", globalEvents);
        	console.log("CKBOX 전체 globalEmp 확인:", globalEmp);
        	console.log("CKBOX 전체 globalDept 확인:", globalDept);
        	console.log("CKBOX 전체 globalEmpNm 확인:", globalEmpNm);
        	console.log("CKBOX 전체 globalDeptNm 확인:", globalDeptNm);
        	
        	$('#empNo').val(globalEmpNm); //insert 모달에 empNm 넣기
       	    $('#deptNo').val(globalDeptNm); //insert 모달에 deptNm 넣기

        	uncheckOthers(document.getElementById('all'));
        	console.log("전체 체크박스에 왔나?");

        	$.ajax({
         		url: "/todoList/getEmp",
                type: "get",
                dataType: "json",
                success: function(emp) {
                 console.log("Logged in user: ", emp);
                 	 
                 	 globalEmp = emp.empNo; //전역변수에 담기(위로 뺄거임)
                 	 console.log("전체 체크박스에서 전역변수로 뺀 globalEmp 값 확인", globalEmp);
                 	 
                 	 $.ajax({
 	             		url: "/todoList/getDept",
 	                     type: "get",
 	                     dataType: "json",
 	                     success: function(dept) {
 	                     	 console.log("Logged in user: ", dept);
 	                     	 
 	                     	 let deptNo = dept.deptVO.deptNo;

 	                     	 globalDept = deptNo; //전역변수에 담기(위로 뺄거임)

 	                     	 console.log("전체 체크박스에서 전역변수로 뺀 globalDept 값 확인", globalDept);
 	                     	 
 	                     	 console.log("전체 체크박스 globalEmp 값 확인  :", globalEmp);
 	                     	 console.log("전체 체크박스 globalDept 값 확인 :", globalDept);
 	                     	 
 	                     	 let listCKdata = {
 	                     			"empNo":globalEmp,
 	                     			"deptNo":globalDept
 	                     	 };
 	                     	 
                             console.log("전체 체크박스 listAjax 전송용 데이터 체크:", listCKdata);

			                 $.ajax({
			                 url:"/todoList/alCheckBoxListAjax",
			                 type :"post",
			                 contentType:"application/json;charset=utf-8",
			                 data: JSON.stringify(listCKdata),
			                 dataType:"json",
			                 beforeSend:function(xhr){
                                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                              },
			                 success:function(result){
			
			                 console.log("전체 체크박사 아작스 결과값 result : ", result);
			                	
			                 calendar.removeAllEvents(globalEvents);
			                 //이벤트 클릭때마다 2개씩 쌓이는거 방지용, 이거 후에 다시 결과값을 globalEvents로 빼주는 작업 필요
			                	
			                 //result로 여러개인 결과값을 모두 event발생용으로 addevent시켜버려야됨
			                 result.forEach(function(item) {
			                	 
							        let event = {
			                			
			                            tdlNo: item.tdlNo,
			                            title: item.tdlTtl,
						        		start: item.tdlStrDt,
			                            end: item.tdlEndDt,
			                            empNo: item.empNo,
			                            deptNo: item.deptNo,
			                            tdlCn: item.tdlCn,
			                            backgroundColor: item.tdlCmptnYn
			        				};
							        calendar.addEvent(event);
							        
			    			 }); //forEach 끝
			                	
				    		 } //alCheckBoxListAjax success 끝
				    	 
				        }); //alCheckBoxListAjax 끝
						        	
						        	
					    }//getDept success 끝
 	     			
                 	    }); //getDept Ajax 끝
 	        
                } //getEmp success 끝	
 	        
        		});	//getEmp Ajax 끝
        		
        	removeAllEvents(globalEvents);
    	}//f_allist 끝
        
        function fCalAdd() {
            if (mySchTitle.value=="제목") {
            	swal("제목을 입력해주세요.","","error");
                mySchTitle.focus();
                return;
            };
           
            if (myTdlCmptnYn.value==""){
            	swal("카테고리를 선택해주세요.","","error");
            	myTdlCmptnYn.focus();
            	return;
            };
            
            //일정(이벤트) 추가하기 - 첫번째 모달
            console.log("fCalAdd globalEvents 확인:", globalEvents);
           	console.log("fCalAdd globalEmp 확인:", globalEmp);
            console.log("fCalAdd globalDept 확인:", globalDept);
            console.log("fCalAdd globalEmpNm 확인:", globalEmpNm);
            console.log("fCalAdd globalDeptNm 확인:", globalDeptNm);
            
            let event = {	//ajax 전송용
            		
                tdlTtl: mySchTitle.value,
            	tdlStrDt: mySchStart.value,
            	tdlEndDt: mySchEnd.value,
                empNo: globalEmp,
                deptNo: globalDept,
                tdlCn: mySchCn.value,
                tdlCmptnYn: myTdlCmptnYn.value

            };
            
            let event1 = { //event 발생용
            		
                title: mySchTitle.value,
            	start: mySchStart.value,
            	end: mySchEnd.value,
                empNo: globalEmp,
                deptNo: globalDept,
                tdlCn: mySchCn.value,
                backgroundColor: myTdlCmptnYn.value

            };
            
            console.log("fCalAdd ajax 전송용 :",event);
            console.log("fCalAdd event 발생용 :",event1);
            
        	$.ajax({	//아작스 전송
        		type:"post",
        		url:"/todoList/createAjax",
        		contentType:"application/json;charset=UTF-8",
        		data:JSON.stringify(event),
        		dataType:"text",
        		beforeSend:function(xhr){
    	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    	    	},
        		success:function(result){
        				console.log("돌아온 값 :", result);
        				
        		}, //createAjax success 끝
        		error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		            
		            swal("등록에 실패하였습니다.","","error");
		        }
        		
        	}); //createAjax 끝
        	calendar.addEvent(event1);	//이벤트 발생       	
        	
        	swal("등록이 완료되었습니다.","","success").then(function() {
	    		window.location.href = "/todoList/list";
	    	});
        	
            fMClose();	//모달창 닫기
        }

    	
        // 모달 수정하기
        function fMUpdate(){
        	console.log("fMUpdate globalEvents 확인:", globalEvents);
           	console.log("fMUpdate globalEmp 확인:", globalEmp);
            console.log("fMUpdate globalDept 확인:", globalDept);
            console.log("fMUpdate globalEmpNm 확인:", globalEmpNm);
            console.log("fMUpdate globalDeptNm 확인:", globalDeptNm);
            
            let insertedEmpNO = $('input[name=empNo2]').val();
            if(globalEmpNm != insertedEmpNO){
            	swal("다른 사람의 일정을 수정할 수 없습니다","","error");
            	
            	return false;
            };
           
            let data = {	//ajax 전송용
            		
                    tdlNo: myTdlNo2.value,
                    tdlTtl: mySchTitle2.value,
                	tdlStrDt: mySchStart2.value,
                	tdlEndDt: mySchEnd2.value,
                    tdlCn: mySchCn2.value,
                    tdlCmptnYn: myTdlCmptnYn2.value

            };
            
            console.log("수정 data 확인:", data)
            
            let event = {	//event 전송용
            		
                    tdlNo: myTdlNo2.value,
                    title: mySchTitle2.value,
            		start: mySchStart2.value,
                	end: mySchEnd2.value,
                    empNo: myEmpNo2.value,
                    deptNo: myDeptNo2.value,
                    tdlCn: mySchCn2.value,
                    backgroundColor: myTdlCmptnYn2.value
            }

            console.log("수정ajax전송용 data:", data);
            
            $.ajax({
			url:"/todoList/updateAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    	},
			success:function(result){
				console.log("result :", result);
					
				$("input[name='tdlTtl2']").val(result.tdlTtl);
	    		$("input[name='tdlNo2']").val(result.tdlNo);
	    		$("input[name='tdlStrDt2']").val(result.tdlStrDt);
	    		$("input[name='tdlEndDt2']").val(result.tdlEndDt);
	    		$("input[name='tdlCn2']").val(result.tdlCn);
	    		$("input[name='tdlCmptnYn2']").val(result.tdlCmptnYn);
	    		
	    		console.log("수정 끝:", result);
				
	    		//재호출 후 닫기
				swal("수정이 완료되었습니다.","","success").then(function() {
	    			window.location.href = "/todoList/list";
	    		});
				fMClose();	
				
			}	//updateAjax success 끝
            });	//updateAjax 끝
            
            
        }	//fmUpdate 끝
     	
        // 삭제
        function fCalDelete(){
        	console.log("fCalDelete globalEvents 확인:", globalEvents);
           	console.log("fCalDelete globalEmp 확인:", globalEmp);
            console.log("fCalDelete globalDept 확인:", globalDept);
            console.log("fCalDelete globalEmpNm 확인:", globalEmpNm);
            console.log("fCalDelete globalDeptNm 확인:", globalDeptNm);
        	
            let insertedEmpNO = $('input[name=empNo2]').val();
            if(globalEmpNm != insertedEmpNO){
            	swal("다른 사람의 일정을 삭제할 수 없습니다.","","error");
            	
            	return false;
            }
            
            let data = {	//ajax 전송용
            		
                    tdlNo: myTdlNo2.value,
                    tdlTtl: mySchTitle2.value,
                	tdlStrDt: mySchStart2.value,
                	tdlEndDt: mySchEnd2.value,
                    empNo: myEmpNo2.value,
                    deptNo: myDeptNo2.value,
                    tdlCn: mySchCn2.value,
                    tdlCmptnYn: myTdlCmptnYn2.value

                };
            
 			let event = {	//event 전송용
            		
                    tdlNo: myTdlNo2.value,
                    title: mySchTitle2.value,
            		start: mySchStart2.value,
                	end: mySchEnd2.value,
                    empNo: myEmpNo2.value,
                    deptNo: myDeptNo2.value,
                    tdlCn: mySchCn2.value,
                    backgroundColor: myTdlCmptnYn2.value
            		
            }

            console.log("dlelteAjax 전송용 data:", data);
            console.log("dlelteAjax event용:", event);
            
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
            				url:"/todoList/deleteAjax",
            				contentType:"application/json;charset=utf-8",
            				data:JSON.stringify(data),
            				type:"post",
            				dataType:"json",
            				beforeSend:function(xhr){
            		    		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            		    	},
            				success:function(result){
            					console.log("result :", result);
            					
            	              	//재호출 후 닫기
            				 	swal("삭제가 완료되었습니다.","","success").then(function() {
            		    			window.location.href = "/todoList/list";
            		    	  	});
            				  	fMClose();	
            	                
            				}, //deleteAjax success 끝
            				error: function(xhr, status, error) {
            		            console.error(xhr.responseText);
            		            
            		            swal("삭제에 실패하였습니다.","","error");
            		        }
            				
            	       }); //deleteAjax 끝
            	       
            	   } //if (result.isConfirmed)
            	}); //then(result

        } //fCalDelete 끝
        
     	// 모달 닫기
        function fMClose() {
            YrModal.style.display = "none";
            YrModal2.style.display = "none";
            
            document.getElementById("tdlTtl").value = "제목";
            document.getElementById("tdlStrDt").value = "";
        	document.getElementById("tdlEndDt").value = "";
        	document.getElementById("tdlCn").value = "";
        }
        
        // event 추가하기
        function addEventToCalendar(event)
        {
        	calendar.addEvent(event);
        }
        
        // event 제거하기
        function removeEventFromCalendar(id)
        {
        	var calendarEvent = calendar.getEventById(id);
        	calendarEvent.remove();
        }
        
        //사용자가 모달의 외부를 클릭했을 때 모달을 닫고 안쪽내용 값을 비우기
    	window.onclick = function() {
        if (event.target == yrModal||event.target == yrModal2) {
        	yrModal.style.display = "none";
        	yrModal2.style.display = "none";
            // 모달이 닫힐 때 입력 필드의 값을 비움
        	document.getElementById("tdlTtl").value = "";
        	document.getElementById("tdlStrDt").value = "";
        	document.getElementById("tdlEndDt").value = "";
//         	document.getElementById("empNo").value = "";
//         	document.getElementById("deptNo").value = "";
//         	document.getElementById("tdlNo").value = "";
        	document.getElementById("tdlCn").value = "";
        	document.getElementById("backColor").value = "#EA6676";
        	
        	document.getElementById("tdlTtl2").value = "";
        	document.getElementById("tdlStrDt2").value = "";
        	document.getElementById("tdlEndDt2").value = "";
        	document.getElementById("empNo2").value = "";
        	document.getElementById("deptNo2").value = "";
//         	document.getElementById("tdlNo2").value = ""; 주석처리했지만 detail에서 tdlNo2에 대해 생각해봐야함
        	document.getElementById("tdlCn2").value = "";
        	document.getElementById("backColor2").value = "";
        }
        
        
    };
        
       
    </script>
</body>

</html>