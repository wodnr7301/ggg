<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_blue.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
.custom-date {
    background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
    color: #000; /* 텍스트 색상 */
}
</style>
<script>
$(function(){
	const specialDates = [
    ];
	
	const table = document.getElementById('mngTable');
	const rows = table.getElementsByTagName('tr'); 

	for (let i = 1; i < rows.length; i++) { 
	    const dateCell = rows[i].getElementsByTagName('td')[3]; 
	    const originalDate = dateCell.textContent.trim(); 

	    console.log(originalDate); 
	    
	    if (!specialDates.includes(originalDate)) {
	        specialDates.push(originalDate);
	    }
	}
	
	console.log(specialDates);
	
	let alrGlocd="";
	
	function getMax(){
		$.ajax({
			url:"/mng/getMax",
			contentType:"application/json;charset=utf-8",
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log("최대값:"+result);
				alrGlocd=result;	
			}
		});
	}
	
	
	function getCount(){
		$.ajax({
			url:"/mng/getCount",
			contentType:"application/json;charset=utf-8",
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				$('.total').html(result.success+" 완료 /"+result.total+" 전체");
				$('.success').html(result.success+" 건");
				$('.ing').html(result.ing+" 건");
			}
		});
	}
	
	$("#picker").flatpickr({
	    inline: true,
	    onDayCreate: function(dObj, dStr, fp, dayElem) {
	    	const year = dayElem.dateObj.getFullYear();
	    	const month = dayElem.dateObj.getMonth() + 1; // 월은 0부터 시작하므로 +1을 해줍니다.
	    	const day = dayElem.dateObj.getDate();

	    	const dateStr = `\${year}-\${month < 10 ? '0' + month : month}-\${day < 10 ? '0' + day : day}`;
            
            // 특정 날짜에 클래스 추가
            if (specialDates.includes(dateStr)) {
                dayElem.classList.add('custom-date');
            }
        },
	    onChange: function(selectedDates, dateStr, instance) {
            // selectedDates는 선택된 Date 객체의 배열입니다.
            // dateStr은 선택된 날짜의 문자열 표현입니다.
            // instance는 flatpickr 인스턴스입니다.
            console.log("Selected date: ", dateStr);
            
            var mngDt = instance.parseDate(dateStr, "Y-m-d");
           
            let year = mngDt.getFullYear().toString();
            let month = ("0" + (mngDt.getMonth() + 1)).slice(-2);
            let day = ("0" + mngDt.getDate()).slice(-2);
            let fomattedDate = year + "-" + month + "-" + day;
           
            let data ={
            	"mngDt":fomattedDate
            }
            
            $.ajax({
                url : "/mng/oneMng", // 요기에
                contentType:"application/json;charset=utf-8",
                data : JSON.stringify(data), 
                type : 'POST', 
                beforeSend:function(xhr){
                  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                },
                success : function(mngVOList) {
                	console.log(mngVOList);
                	
                	let str = "";
					str +=`<table id="dayTable">
						    <thead>
						        <tr>
						            <th>일정번호</th>
						            <th>가맹점명</th>
						            <th>가맹점 주소</th>
						            <th>방문예정일</th>
						            <th>방문 목적</th>
									<th>처리여부</th>						            
						            <th>담당 직원명</th>
						            <th>수정</th>
						        </tr>
						    </thead>
						    <tbody>`;
						    $.each(mngVOList,function(idx,mngVO){
						    	// Date 객체 생성
			                	const date = new Date(mngVO.mngDt);

			                	// 연도, 월, 일 가져오기
			                	const year = date.getFullYear();
			                	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
			                	const day = String(date.getDate()).padStart(2, '0');

			                	// 원하는 형식으로 변환
			                	const formattedDate = `\${year}-\${month}-\${day}`;
					str +=`<tr>
					           <td><button class="btn btn-outline-dark detail" type="button" data-bs-toggle="modal" data-bs-target="#detail" data-mng-yn="\${mngVO.mngYn}" data-mng-no="\${mngVO.mngNo}" >\${mngVO.mngNo}</button></td>
					           <td>\${mngVO.frcsNm}</td>
					           <td>\${mngVO.frcsAddr}</td>
					           <td>\${formattedDate}</td>
					           <td>\${mngVO.mngPp}</td>
					           <td>`;
					           if(mngVO.mngYn == 'Y'){
					        	   str+=`<div class="badge bg-primary text-white rounded-pill">완료</div>`;
					           }else{
					        	   str+=`<div class="badge bg-warning text-white rounded-pill">방문예정</div>`;
					           }
					str +=    `</td>
					           <td>\${mngVO.empNm}</td>
					           <td>
								 <button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#updateModal" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
								 <button class="btn btn-datatable btn-icon btn-transparent-dark del" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
							   </td>
					       </tr>`
							    });
					str += `</tbody>
							</table>`;
							
					console.log(str);		
					
					$('#oneDay').html(str);
                	
					const dayTable = document.getElementById('dayTable');
				 	if (dayTable) {
				 	    new simpleDatatables.DataTable(dayTable,{
				 	    		perPage: 5,
				 	    		perPageSelect: false,
				 	    		searchable:false,
				 	    		labels: {
				 	    		    placeholder: "Search...",
				 	    		    searchTitle: "Search within table",
				 	    		    pageTitle: "Page {page}",
				 	    		    perPage: "",
				 	    		    noRows: "해당 날짜에 방문 일정이 없습니다.",
				 	    		    info: " ",
				 	    		    noResults: "No results match your search query",
				 	    		}		
				 	    	}
				 	    );
				 	}
					
                }, // success 
        
            });	//ajax 끝
            
        }//onchange 끝
	});//피커 끝
	
	const mngTable = document.getElementById('mngTable');
 	if (mngTable) {
 	    new simpleDatatables.DataTable(mngTable,{
 	    		perPage: 10,
 	    		perPageSelect: false,
 	    		labels: {
 	    		    placeholder: "Search...",
 	    		    searchTitle: "Search within table",
 	    		    pageTitle: "Page {page}",
 	    		    perPage: "",
 	    		    noRows: "No entries found",
 	    		    info: " ",
 	    		    noResults: "No results match your search query",
 	    		}		
 	    	}
 	    );
 	}
 	
	const dayTable = document.getElementById('dayTable');
 	if (dayTable) {
 	    new simpleDatatables.DataTable(dayTable,{
 	    		perPage: 5,
 	    		perPageSelect: false,
 	    		searchable:false,
 	    		labels: {
 	    		    placeholder: "Search...",
 	    		    searchTitle: "Search within table",
 	    		    pageTitle: "Page {page}",
 	    		    perPage: "",
 	    		    noRows: "날짜를 선택해주세요",
 	    		    info: " ",
 	    		    noResults: "No results match your search query",
 	    		}		
 	    	}
 	    );
 	}
	
 	function selLoc() {
		$(".sel").on("change", function() {
			let comcdGroupcd = $(this).val();
			
			let data =  {
				"comcdGroupcd":comcdGroupcd
			};
	
			$.ajax({
				url:"/frcorder/locFrn",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
				    console.log("result : ", result);
				    let str = "";
			        str += "<option value='가맹점을 선택해주세요'>선택</option>";
				    $.each(result, function(idx, franchiseVO) {
				        str += "<option value='" + franchiseVO.frcsNo + "'>" + franchiseVO.frcsNm + "</option>";
				    });
				    $(".frnSel").html(str);
				}
			});
			
			console.log("data : ", data);
		});
 	}
 	selLoc();
 	function selLoc2() {
		$(".selUp").on("change", function() {
			let comcdGroupcd = $(this).val();
			
			let data =  {
				"comcdGroupcd":comcdGroupcd
			};
	
			$.ajax({
				url:"/frcorder/locFrn",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
				    console.log("result : ", result);
				    let str = "";
			        str += "<option value='가맹점을 선택해주세요'>선택</option>";
				    $.each(result, function(idx, franchiseVO) {
				        str += "<option value='" + franchiseVO.frcsNo + "'>" + franchiseVO.frcsNm + "</option>";
				    });
				    $(".frnSelUp").html(str);
				}
			});
			
			console.log("data : ", data);
		});
 	}
 	selLoc2();
 	
 	
 	$('.submit').on('click',function(){
 		Swal.fire({
			   title: '일정 생성을 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '생성', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   let empNo = $('#empNo').val();
			 		let frcsNo = $('#frcsNo').val();
			 		let mngDt = $('#mngDt').val();
			 		let mngPp = $('#mngPp').val();
			 		
			 		let data = {
						"empNo":empNo,
						"frcsNo":frcsNo,
						"mngDt":mngDt,
						"mngPp":mngPp,
			 		}
			 		
			 		$.ajax({
						url:"/mng/create",
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(data),
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(mngVOList){
							let str = "";
								str +=`<table id="mngTable">
									    <thead>
									        <tr>
									            <th>일정번호</th>
									            <th>가맹점명</th>
									            <th>가맹점 주소</th>
									            <th>방문예정일</th>
									            <th>방문 목적</th>
									            <th>처리여부</th>
									            <th>담당 직원명</th>
									            <th>수정</th>
									        </tr>
									    </thead>
									    <tbody>`;
									    $.each(mngVOList,function(idx,mngVO){
									    	// Date 객체 생성
						                	const date = new Date(mngVO.mngDt);
	
						                	// 연도, 월, 일 가져오기
						                	const year = date.getFullYear();
						                	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
						                	const day = String(date.getDate()).padStart(2, '0');
	
						                	// 원하는 형식으로 변환
						                	const formattedDate = `\${year}-\${month}-\${day}`;
								str +=`<tr>
										   <td><button class="btn btn-outline-dark detail" type="button" data-bs-toggle="modal" data-bs-target="#detail" data-mng-yn="\${mngVO.mngYn}" data-mng-no="\${mngVO.mngNo}" >\${mngVO.mngNo}</button></td>
								           <td>\${mngVO.frcsNm}</td>
								           <td>\${mngVO.frcsAddr}</td>
								           <td>\${formattedDate}</td>
								           <td>\${mngVO.mngPp}</td>
								           <td>`;
								           if(mngVO.mngYn == 'Y'){
								        	   str+=`<div class="badge bg-primary text-white rounded-pill">완료</div>`;
								           }else{
								        	   str+=`<div class="badge bg-warning text-white rounded-pill">방문예정</div>`;
								           }
								str +=    `</td>
								           <td>\${mngVO.empNm}</td>
								           <td>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#updateModal" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark del" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
										   </td>
								       </tr>`
										    });
								str += `</tbody>
										</table>`;
										
							$('.allList').html(str);
							
							let str1 =`<table id="dayTable">
											    <thead>
											        <tr>
											            <th>일정번호</th>
											            <th>가맹점명</th>
											            <th>가맹점 주소</th>
											            <th>방문예정일</th>
											            <th>방문 목적</th>
											            <th>담당 직원명</th>
											            <th>수정</th>
											        </tr>
											    </thead>
											    <tbody>
											    </tbody>
											</table>`;
							$('#oneDay').html(str1);
							
							const dayTable = document.getElementById('dayTable');
						 	if (dayTable) {
						 	    new simpleDatatables.DataTable(dayTable,{
						 	    		perPage: 5,
						 	    		perPageSelect: false,
						 	    		searchable:false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "날짜를 선택해주세요",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
							
							const mngTable = document.getElementById('mngTable');
						 	if (mngTable) {
						 	    new simpleDatatables.DataTable(mngTable,{
						 	    		perPage: 10,
						 	    		perPageSelect: false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "No entries found",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
						 	getCount();
						 	getMax();
						 	console.log(alrGlocd);
						 	setTimeout(function() {
							 	let alarmVO = {
							 		"alrGlocd": alrGlocd,
							 		"alrTg":empNo,
							 		"alrSrc":"mng",
							 		"alrInfo":"/mng/list",
							 	}
							 	
							 	alarm(alarmVO);
						    }, 1000);
						 	
						 	
						}
					});
			   		
				   
			   }
			});
 	}); //일정생성 끝

 	$(document).on('click','.edito',function(){
 		let mngNo = this.dataset.mngNo;
 		console.log(mngNo);
 		
 		$.ajax({
			url:"/mng/detail",
			contentType:"application/json;charset=utf-8",
			data:mngNo,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(mngVO){
				// Date 객체 생성
            	const date = new Date(${mngVO.mngDt});

            	// 연도, 월, 일 가져오기
            	const year = date.getFullYear();
            	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
            	const day = String(date.getDate()).padStart(2, '0');

            	// 원하는 형식으로 변환
            	const formattedDate = `\${year}-\${month}-\${day}`;
				console.log(formattedDate);
				
				$('#mngNoUp').val(mngNo);
				$('#updateLoc').val(mngVO.loc).change();
			    $('#empNoUp').val(mngVO.empNo);
			    $('#mngPpUp').val(mngVO.mngPp);
			    $('#mngDtUp').val(formattedDate);
			    setTimeout(function() {
			    	$('#frcsNoUp').val(mngVO.frcsNo);
			    }, 200); // 3000 밀리초(3초) 후에 실행
			}
		}); //값 가져오는 아작스 끝
 		
		
 		
 	});
 	
 	$(document).on('click','.detail',function(){
 		let mngNo = this.dataset.mngNo;
 		console.log(mngNo);
 		
 		$.ajax({
			url:"/mng/detail",
			contentType:"application/json;charset=utf-8",
			data:mngNo,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(mngVO){
				// Date 객체 생성
            	const date = new Date(${mngVO.mngDt});

            	// 연도, 월, 일 가져오기
            	const year = date.getFullYear();
            	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
            	const day = String(date.getDate()).padStart(2, '0');

            	// 원하는 형식으로 변환
            	const formattedDate = `\${year}-\${month}-\${day}`;
				console.log(formattedDate);
				
				$('#mngNoDe').val(mngNo);
				$('#mngYnDe').val(mngVO.mngYn);
				$('#detailLoc').val(mngVO.loc).change();
			    $('#empNoDe').val(mngVO.empNo);
			    $('#mngPpDe').val(mngVO.mngPp);
			    $('#mngDtDe').val(formattedDate);
			    setTimeout(function() {
			    	$('#frcsNoDe').val(mngVO.frcsNo);
			    }, 200); // 3000 밀리초(3초) 후에 실행
			}
		}); //값 가져오는 아작스 끝
 		
		
 		
 	});//업데이트 버튼 클릭이벤트 끝
 	
 	
 	$("#edit").on('click',function(){
 		
 		let mngNo = $('#mngNoUp').val();
 		let empNo = $('#empNoUp').val();
 		let frcsNo = $('#frcsNoUp').val();
 		let mngDt = $('#mngDtUp').val();
 		let mngPp = $('#mngPpUp').val();
 		
 		let data = {
 			"mngNo":mngNo,
			"empNo":empNo,
			"frcsNo":frcsNo,
			"mngDt":mngDt,
			"mngPp":mngPp,
 		}
 		
 		Swal.fire({
			   title: '일정 수정을 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '생성', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   if (result.isConfirmed) { 
				   $.ajax({
						url:"/mng/update",
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(data),
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(mngVOList){
								let str = "";
								str +=`<table id="mngTable">
									    <thead>
									        <tr>
									            <th>일정번호</th>
									            <th>가맹점명</th>
									            <th>가맹점 주소</th>
									            <th>방문예정일</th>
									            <th>방문 목적</th>
									            <th>처리여부</th>
									            <th>담당 직원명</th>
									            <th>수정</th>
									        </tr>
									    </thead>
									    <tbody>`;
									    $.each(mngVOList,function(idx,mngVO){
									    	// Date 객체 생성
						                	const date = new Date(mngVO.mngDt);
	
						                	// 연도, 월, 일 가져오기
						                	const year = date.getFullYear();
						                	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
						                	const day = String(date.getDate()).padStart(2, '0');
	
						                	// 원하는 형식으로 변환
						                	const formattedDate = `\${year}-\${month}-\${day}`;
								str +=`<tr>
								           <td><button class="btn btn-outline-dark detail" type="button" data-bs-toggle="modal" data-bs-target="#detail" data-mng-yn="\${mngVO.mngYn}" data-mng-no="\${mngVO.mngNo}" >\${mngVO.mngNo}</button></td>
								           <td>\${mngVO.frcsNm}</td>
								           <td>\${mngVO.frcsAddr}</td>
								           <td>\${formattedDate}</td>
								           <td>\${mngVO.mngPp}</td>
								           <td>`;
								           if(mngVO.mngYn == 'Y'){
								        	   str+=`<div class="badge bg-primary text-white rounded-pill">완료</div>`;
								           }else{
								        	   str+=`<div class="badge bg-warning text-white rounded-pill">방문예정</div>`;
								           }
								str +=    `</td>
								           <td>\${mngVO.empNm}</td>
								           <td>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#updateModal" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark del" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
										   </td>
								       </tr>`
										    });
								str += `</tbody>
										</table>`;
										
							$('.allList').html(str);
							
							let str1 =`<table id="dayTable">
										    <thead>
										        <tr>
										            <th>일정번호</th>
										            <th>가맹점명</th>
										            <th>가맹점 주소</th>
										            <th>방문예정일</th>
										            <th>방문 목적</th>
										            <th>담당 직원명</th>
										            <th>수정</th>
										        </tr>
										    </thead>
										    <tbody>
										    </tbody>
										</table>`;
							$('#oneDay').html(str1);
							
							const dayTable = document.getElementById('dayTable');
						 	if (dayTable) {
						 	    new simpleDatatables.DataTable(dayTable,{
						 	    		perPage: 5,
						 	    		perPageSelect: false,
						 	    		searchable:false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "날짜를 선택해주세요",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
							
							const mngTable = document.getElementById('mngTable');
						 	if (mngTable) {
						 	    new simpleDatatables.DataTable(mngTable,{
						 	    		perPage: 10,
						 	    		perPageSelect: false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "No entries found",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
						 	getCount();
							
						}
					}); //업데이트 아작스
				   
			   }
			});
 	});
 	
 	$(document).on('click','#done',function(){
 		let mngNo = $('#mngNoDe').val();
 		let mngYn = $('#mngYnDe').val();
 		
 		if(mngYn == 'Y'){
 			Swal.fire({
 				title: "이미 완료처리된 일정입니다.",
 				icon: "warning",
 			});
 			return;
 		}
 		
 		Swal.fire({
			   title: '일정 완료 처리를 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   if (result.isConfirmed) { 
					
				   $.ajax({
						url:"/mng/done",
						contentType:"application/json;charset=utf-8",
						data:mngNo,
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(mngVOList){
								let str = "";
								str +=`<table id="mngTable">
									    <thead>
									        <tr>
									            <th>일정번호</th>
									            <th>가맹점명</th>
									            <th>가맹점 주소</th>
									            <th>방문예정일</th>
									            <th>방문 목적</th>
									            <th>처리여부</th>
									            <th>담당 직원명</th>
									            <th>수정</th>
									        </tr>
									    </thead>
									    <tbody>`;
									    $.each(mngVOList,function(idx,mngVO){
									    	// Date 객체 생성
						                	const date = new Date(mngVO.mngDt);
	
						                	// 연도, 월, 일 가져오기
						                	const year = date.getFullYear();
						                	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
						                	const day = String(date.getDate()).padStart(2, '0');
	
						                	// 원하는 형식으로 변환
						                	const formattedDate = `\${year}-\${month}-\${day}`;
								str +=`<tr>
								           <td><button class="btn btn-outline-dark detail" type="button" data-bs-toggle="modal" data-bs-target="#detail" data-mng-yn="\${mngVO.mngYn}" data-mng-no="\${mngVO.mngNo}" >\${mngVO.mngNo}</button></td>
								           <td>\${mngVO.frcsNm}</td>
								           <td>\${mngVO.frcsAddr}</td>
								           <td>\${formattedDate}</td>
								           <td>\${mngVO.mngPp}</td>
								           <td>`;
								           if(mngVO.mngYn == 'Y'){
								        	   str+=`<div class="badge bg-primary text-white rounded-pill">완료</div>`;
								           }else{
								        	   str+=`<div class="badge bg-warning text-white rounded-pill">방문예정</div>`;
								           }
								str +=    `</td>
								           <td>\${mngVO.empNm}</td>
								           <td>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#updateModal" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark del" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
										   </td>
								       </tr>`
										    });
								str += `</tbody>
										</table>`;
										
							$('.allList').html(str);
							
							let str1 =`<table id="dayTable">
										    <thead>
										        <tr>
										            <th>일정번호</th>
										            <th>가맹점명</th>
										            <th>가맹점 주소</th>
										            <th>방문예정일</th>
										            <th>방문 목적</th>
										            <th>담당 직원명</th>
										            <th>수정</th>
										        </tr>
										    </thead>
										    <tbody>
										    </tbody>
										</table>`;
							$('#oneDay').html(str1);
							
							const dayTable = document.getElementById('dayTable');
						 	if (dayTable) {
						 	    new simpleDatatables.DataTable(dayTable,{
						 	    		perPage: 5,
						 	    		perPageSelect: false,
						 	    		searchable:false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "날짜를 선택해주세요",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
							
							const mngTable = document.getElementById('mngTable');
						 	if (mngTable) {
						 	    new simpleDatatables.DataTable(mngTable,{
						 	    		perPage: 10,
						 	    		perPageSelect: false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "No entries found",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
						 	getCount();
							
						}
					}); //완료처리 아작스
				   
				   
			   }
			});
 	});
 	
 	$(document).on('click','.del',function(){
 		let mngNo = this.dataset.mngNo;
 		
 		Swal.fire({
			   title: '일정 삭제를 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   if (result.isConfirmed) { 
				 		$.ajax({
							url:"/mng/delete",
							contentType:"application/json;charset=utf-8",
							data:mngNo,
							type:"post",
							dataType:"json",
							beforeSend:function(xhr){
								xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
							},
							success:function(mngVOList){
								let str = "";
								str +=`<table id="mngTable">
									    <thead>
									        <tr>
									            <th>일정번호</th>
									            <th>가맹점명</th>
									            <th>가맹점 주소</th>
									            <th>방문예정일</th>
									            <th>방문 목적</th>
									            <th>처리여부</th>
									            <th>담당 직원명</th>
									            <th>수정</th>
									        </tr>
									    </thead>
									    <tbody>`;
									    $.each(mngVOList,function(idx,mngVO){
									    	// Date 객체 생성
						                	const date = new Date(mngVO.mngDt);
	
						                	// 연도, 월, 일 가져오기
						                	const year = date.getFullYear();
						                	const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더해줍니다.
						                	const day = String(date.getDate()).padStart(2, '0');
	
						                	// 원하는 형식으로 변환
						                	const formattedDate = `\${year}-\${month}-\${day}`;
								str +=`<tr>
										   <td><button class="btn btn-outline-dark detail" type="button" data-bs-toggle="modal" data-bs-target="#detail" data-mng-yn="\${mngVO.mngYn}" data-mng-no="\${mngVO.mngNo}" >\${mngVO.mngNo}</button></td>
								           <td>\${mngVO.frcsNm}</td>
								           <td>\${mngVO.frcsAddr}</td>
								           <td>\${formattedDate}</td>
								           <td>\${mngVO.mngPp}</td>
								           <td>`;
								           if(mngVO.mngYn == 'Y'){
								        	   str+=`<div class="badge bg-primary text-white rounded-pill">완료</div>`;
								           }else{
								        	   str+=`<div class="badge bg-warning text-white rounded-pill">방문예정</div>`;
								           }
								str +=    `</td>
								           <td>\${mngVO.empNm}</td>
								           <td>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#updateModal" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
											 <button class="btn btn-datatable btn-icon btn-transparent-dark del" data-mng-no="\${mngVO.mngNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
										   </td>
								       </tr>`
										    });
								str += `</tbody>
										</table>`;
										
							$('.allList').html(str);
							
								let str1 =`<table id="dayTable">
											    <thead>
											        <tr>
											            <th>일정번호</th>
											            <th>가맹점명</th>
											            <th>가맹점 주소</th>
											            <th>방문예정일</th>
											            <th>방문 목적</th>
											            <th>담당 직원명</th>
											            <th>수정</th>
											        </tr>
											    </thead>
											    <tbody>
											    </tbody>
											</table>`;
							$('#oneDay').html(str1);
							
							const dayTable = document.getElementById('dayTable');
						 	if (dayTable) {
						 	    new simpleDatatables.DataTable(dayTable,{
						 	    		perPage: 5,
						 	    		perPageSelect: false,
						 	    		searchable:false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "날짜를 선택해주세요",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
							
							const mngTable = document.getElementById('mngTable');
						 	if (mngTable) {
						 	    new simpleDatatables.DataTable(mngTable,{
						 	    		perPage: 10,
						 	    		perPageSelect: false,
						 	    		labels: {
						 	    		    placeholder: "Search...",
						 	    		    searchTitle: "Search within table",
						 	    		    pageTitle: "Page {page}",
						 	    		    perPage: "",
						 	    		    noRows: "No entries found",
						 	    		    info: " ",
						 	    		    noResults: "No results match your search query",
						 	    		}		
						 	    	}
						 	    );
						 	}
						 	getCount();
						}
					}); //아작스끝
			  	 }
			});
 	});
 	
});
</script>
<style>
#mngTable td:nth-child(1),
#mngTable td:nth-child(4),
#mngTable td:nth-child(6),
#mngTable td:nth-child(7),
#mngTable td:nth-child(8){
	text-align: center;	
}
#dayTable td:nth-child(1),
#dayTable td:nth-child(4),
#dayTable td:nth-child(6),
#dayTable td:nth-child(7),
#dayTable td:nth-child(8){
	text-align: center;	
}
</style>
<main>
	<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
		<div class="container-fluid px-4">
			<div class="page-header-content">
				<div class="row align-items-center justify-content-between pt-3">
					<div class="col-auto mb-3">
						<h1 class="page-header-title">
							<div class="page-header-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-list"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
							</div>
							방문 일정 관리
						</h1>
					</div>
					<div class="col-12 col-xl-auto mb-3">
						<a class="btn btn-sm btn-light text-primary" href="#" data-bs-toggle="modal" data-bs-target="#createModal"> <i class="me-1" data-feather="plus"></i> 일정 생성 </a>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div class="row justify-content-center">
	    <div class="col-lg-6 col-xl-3 mb-4">
	        <div class="card bg-primary text-white h-100">
	            <div class="card-body">
	                <div class="d-flex justify-content-between align-items-center">
	                    <div class="me-3">
	                        <div class="text-white-75 small">전체 일정 현황</div>
	                        <div class="text-lg fw-bold total">${count.success} 완료 / ${count.total} 전체</div>
	                    </div>
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar feather-xl text-white-50"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-lg-6 col-xl-3 mb-4">
	        <div class="card bg-success text-white h-100">
	            <div class="card-body">
	                <div class="d-flex justify-content-between align-items-center">
	                    <div class="me-3">
	                        <div class="text-white-75 small">완료된 일정</div>
	                        <div class="text-lg fw-bold success">${count.success} 건</div>
	                    </div>
	                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-square feather-xl text-white-50"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-lg-6 col-xl-3 mb-4">
           <div class="card bg-warning text-white h-100">
               <div class="card-body">
                   <div class="d-flex justify-content-between align-items-center">
                       <div class="me-3">
                           <div class="text-white-75 small">방문 예정 일정</div>
                           <div class="text-lg fw-bold ing">${count.ing} 건</div>
                       </div>
                       <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit feather-xl text-white-50"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 1 1 3 3L13 14l-4 1 1-4 8.5-8.5z"/></svg>

                   </div>
               </div>
           </div>
       </div>
	
	<div class="container-fluid px-4">
		<div class="card card-collapsable">
	    	<a class="card-header" href="#allCard" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">전체 방문 일정
		        <div class="card-collapsable-arrow">
		            <i class="fas fa-chevron-down"></i>
		        </div>
	    	</a>
		    <div class="collapse show" id="allCard">
		        <div class="card-body allList">
		            <table id="mngTable">
					    <thead>
					        <tr>
					            <th>일정번호</th>
					            <th>가맹점명</th>
					            <th>가맹점 주소</th>
					            <th>방문예정일</th>
					            <th>방문 목적</th>
					            <th>처리여부</th>
					            <th>담당 직원명</th>
					            <th>수정</th>
					        </tr>
					    </thead>
					    <tbody>
					    <c:forEach var="mngVO" items="${mngVOList}" varStatus="stat">
					       <tr>
					           <td><button class="btn btn-outline-dark detail" type="button" data-bs-toggle="modal" data-bs-target="#detail" data-mng-yn="${mngVO.getMngYn()}" data-mng-no="${mngVO.getMngNo()}" >${mngVO.getMngNo()}</button></td>
					           <td>${mngVO.getFrcsNm()}</td>
					           <td>${mngVO.getFrcsAddr()}</td>
					           <td id="dt"><fmt:formatDate value="${mngVO.getMngDt()}" pattern="yyyy-MM-dd"/></td>
					           <td>${mngVO.getMngPp()}</td>
					           <td>
						           <c:choose>
							         	<c:when test="${mngVO.getMngYn() eq 'Y'}">
							           		<div class="badge bg-primary text-white rounded-pill">완료</div>
							          	</c:when>
							          	<c:otherwise><div class="badge bg-warning text-white rounded-pill">방문예정</div></c:otherwise>
						           </c:choose>
					           </td>
					           <td>${mngVO.getEmpNm()}</td>
					           <td>
								 <button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#updateModal" data-mng-no="${mngVO.getMngNo()}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
								 <button class="btn btn-datatable btn-icon btn-transparent-dark del" data-mng-no="${mngVO.getMngNo()}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
							   </td>
					       </tr>
					    </c:forEach>
					    </tbody>
					</table>
		        </div>
		    </div>
		</div>
	</div>
	<div class="container-fluid px-4 mt-4">
		<div class="card card-collapsable">
	    	<a class="card-header" href="#dayCard" data-bs-toggle="collapse" role="button" aria-expanded="true" aria-controls="collapseCardExample">일자별 방문 일정
		        <div class="card-collapsable-arrow">
		            <i class="fas fa-chevron-down"></i>
		        </div>
	    	</a>
		    <div class="collapse" id="dayCard">
		        <div class="card-body">
			       	<div class="row d-flex align-items-start">
			            <div class="col-auto" >
		                	<div class="border" id="picker"></div>
			            </div>
			            <div class="col" id="oneDay" class="oneDay">
				          	<table id="dayTable">
							    <thead>
							        <tr>
							            <th>일정번호</th>
							            <th>가맹점명</th>
							            <th>가맹점 주소</th>
							            <th>방문예정일</th>
							            <th>방문 목적</th>
							            <th>담당 직원명</th>
							            <th>수정</th>
							        </tr>
							    </thead>
							    <tbody>
							    </tbody>
							</table>
			            </div>
			        </div> 
		        </div>
		    </div>
		</div>
	</div>
	
	<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">일정 등록</h5>
	                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <div class="card">
					    <div class="card-body">
					    	<label class="small mb-1" for="empNo">담당자</label>
					    	<select class="form-control" id="empNo" name="empNo">
					            <option selected>사원선택</option>
					            <c:forEach var="employeeVO" items="${employeeVOList}" varStatus="stat">
					                <option value="${employeeVO.empNo}">${employeeVO.empNm} (
					                <c:choose>
					                    <c:when test="${employeeVO.deptNo eq 'A001'}">개발부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A002'}">영업부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A003'}">인사부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A004'}">회계부</c:when>
					                    <c:otherwise>기획부</c:otherwise>
					                </c:choose>
					                &nbsp;
					                <c:choose>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A105'}">사원</c:when>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A104'}">대리</c:when>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A103'}">과장</c:when>
					                    <c:otherwise>부장</c:otherwise>
					                </c:choose>
					                )</option>
					            </c:forEach>
					        </select>
					    	<div class="row gx-3 mb-3">
								<div class="col-md-6">
									<label class="small mb-1">지역</label> 
									<select class="form-control sel">
										<option selected>선택</option>
										<c:forEach var="location" items="${locationVOList}"
											varStatus="stat">
											<option value="${location.comcdGroupcd}">${location.comcdCdnm}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-6">
									<label class="small mb-1">가맹점명</label> <select
										class="form-control frnSel" id="frcsNo" name="frcsNo">
										<option>선택</option>
									</select>
								</div>
							</div>
							<label class="small mb-1">방문일</label>
							<input class="form-control" type="date" id="mngDt" name="mngDt"/>
					    	<label class="small mb-1" for="mngPp">방문 목적</label>
					    	<textarea class="form-control" id="mngPp" name="mngPp" rows="3"></textarea>
					    </div>
					</div>
	            </div>
	            <div class="modal-footer"><button class="btn btn-primary submit" type="button" data-bs-dismiss="modal">등록</button><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">일정 등록</h5>
	                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <div class="card">
					    <div class="card-body">
					    	<label class="small mb-1" for="empNoUp">담당자</label>
					    	<select class="form-control" id="empNoUp" name="empNoUp">
					            <option selected>사원선택</option>
					            <c:forEach var="employeeVO" items="${employeeVOList}" varStatus="stat">
					                <option value="${employeeVO.empNo}">${employeeVO.empNm} (
					                <c:choose>
					                    <c:when test="${employeeVO.deptNo eq 'A001'}">개발부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A002'}">영업부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A003'}">인사부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A004'}">회계부</c:when>
					                    <c:otherwise>기획부</c:otherwise>
					                </c:choose>
					                &nbsp;
					                <c:choose>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A105'}">사원</c:when>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A104'}">대리</c:when>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A103'}">과장</c:when>
					                    <c:otherwise>부장</c:otherwise>
					                </c:choose>
					                )</option>
					            </c:forEach>
					        </select>
					    	<div class="row gx-3 mb-3">
								<div class="col-md-6">
									<label class="small mb-1">지역</label> 
									<select class="form-control selUp" id="updateLoc">
										<option selected>선택</option>
										<c:forEach var="location" items="${locationVOList}"
											varStatus="stat">
											<option value="${location.comcdGroupcd}">${location.comcdCdnm}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-6">
									<label class="small mb-1">가맹점명</label> <select
										class="form-control frnSelUp" id="frcsNoUp" name="frcsNoUp">
										<option>선택</option>
									</select>
								</div>
							</div>
							<label class="small mb-1">방문일</label>
							<input class="form-control" type="date" id="mngDtUp" name="mngDtUp"/>
					    	<label class="small mb-1" for="mngPpUp">방문 목적</label>
					    	<textarea class="form-control" id="mngPpUp" name="mngPpUp" rows="3"></textarea>
					    	<input type="hidden" type="text" id="mngNoUp" name="mngNoUp">
					    </div>
					</div>
	            </div>
	            <div class="modal-footer"><button class="btn btn-primary update" type="button" data-bs-dismiss="modal" id="edit">수정</button><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade" id="detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">일정 상세</h5>
	                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <div class="card">
					    <div class="card-body">
					    	<label class="small mb-1" for="empNoDe">담당자</label>
					    	<select class="form-control" id="empNoDe" name="empNoDe" disabled>
					            <option selected>사원선택</option>
					            <c:forEach var="employeeVO" items="${employeeVOList}" varStatus="stat">
					                <option value="${employeeVO.empNo}">${employeeVO.empNm} (
					                <c:choose>
					                    <c:when test="${employeeVO.deptNo eq 'A001'}">개발부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A002'}">영업부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A003'}">인사부</c:when>
					                    <c:when test="${employeeVO.deptNo eq 'A004'}">회계부</c:when>
					                    <c:otherwise>기획부</c:otherwise>
					                </c:choose>
					                &nbsp;
					                <c:choose>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A105'}">사원</c:when>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A104'}">대리</c:when>
					                    <c:when test="${employeeVO.empJbgdNm eq 'A103'}">과장</c:when>
					                    <c:otherwise>부장</c:otherwise>
					                </c:choose>
					                )</option>
					            </c:forEach>
					        </select>
					    	<div class="row gx-3 mb-3">
								<div class="col-md-6">
									<label class="small mb-1">지역</label> 
									<select class="form-control selUp" id="detailLoc" disabled>
										<option selected>선택</option>
										<c:forEach var="location" items="${locationVOList}"
											varStatus="stat">
											<option value="${location.comcdGroupcd}">${location.comcdCdnm}</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-6">
									<label class="small mb-1">가맹점명</label> <select
										class="form-control frnSelUp" id="frcsNoDe" name="frcsNoDe" disabled>
										<option>선택</option>
									</select>
								</div>
							</div>
							<label class="small mb-1">방문일</label>
							<input class="form-control" type="date" id="mngDtDe" name="mngDtDe" disabled/>
					    	<label class="small mb-1" for="mngPpDe">방문 목적</label>
					    	<textarea class="form-control" id="mngPpDe" name="mngPpDe" rows="3" disabled></textarea>
					    	<input type="hidden" type="text" id="mngNoDe" name="mngNoDe" readonly>
					    	<input type="hidden" type="text" id="mngYnDe" name="mngYnDe" readonly>
					    </div>
					</div>
	            </div>
	            <div class="modal-footer"><button class="btn btn-primary" type="button" data-bs-dismiss="modal" id="done">완료</button><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
	        </div>
	    </div>
	</div>
</main>


