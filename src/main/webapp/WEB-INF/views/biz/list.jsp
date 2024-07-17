<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
$(function(){
	$('.ck-blurred').keydown(function(){
        console.log("str: " + window.editor1.getData());
        $("#bizCn").val(window.editor1.getData());
    });
	
    $(".ck-blurred").on("focusout", function(){
    	console.log("str: " + window.editor1.getData());
        $("#bizCn").val(window.editor1.getData());
    });
    
	$('.ck-blurred').keydown(function(){
        console.log("str: " + window.editor2.getData());
        $("#updateBizCn").val(window.editor2.getData());
    });
    
    
    $(".ck-blurred").on("focusout", function(){
    	console.log("str: " + window.editor2.getData());
        $("#updateBizCn").val(window.editor2.getData());
    });

//     $("#uploadFile").on("change", handleImg);
	
	function formatDate(date) {
	    var year = date.getFullYear();
	    var month = ('0' + (date.getMonth() + 1)).slice(-2);
	    var day = ('0' + date.getDate()).slice(-2);
	    return year + '-' + month + '-' + day;
	}
	
	const datatablesSimple = document.getElementById('datatablesSimple1');
	if (datatablesSimple) {
	    new simpleDatatables.DataTable(datatablesSimple,{
	    		perPage: 5,
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
	
	let leng = 0;
	let leng2 = 0;
	
	$('.plus').on('click',function(){
		var empNo = $('#empNo').val();
		var empNm = $('#empNo option:selected').text().replace(/\s+/g, '');
		console.log(empNo);
		console.log("나옴? :"+empNm);
		console.log("나옴? :"+leng);
		
		let str ="<div id='leng'>";
			str +='<input class="form-control" type="text" id="empNm['+leng+']" name="empNm['+leng+']" value="'+empNm+'" readonly required>';
			str +='<input class="form-control" type="hidden" id="empNo['+leng+']" name="empNo['+leng+']" value="'+empNo+'" required>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="PL['+leng+']" type="radio" name="role['+leng+']" value="C101">';
			str +='<label class="form-check-label" for="PL['+leng+']">PL</label>';
			str +='</div>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="AA['+leng+']" type="radio" name="role['+leng+']" value="C103">';
			str +='<label class="form-check-label" for="AA['+leng+']">AA</label>';
			str +='</div>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="DA['+leng+']" type="radio" name="role['+leng+']" value="C102">';
			str +='<label class="form-check-label" for="DA['+leng+']">DA</label>';
			str +='</div>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="UA['+leng+']" type="radio" name="role['+leng+']" value="C104">';
			str +='<label class="form-check-label" for="UA['+leng+']">UA</label>';
			str +='</div>';
		
			$('.card-text2').append(str);
			leng++;
	});
	
	$('.plusUpdate').on('click',function(){
		var empNo = $('#updateEmpNo').val();
		var empNm = $('#updateEmpNo option:selected').text().replace(/\s+/g, '');
		console.log(empNo);
		console.log("나옴? :"+empNm);
		console.log("나옴? :"+leng2);
		
		let str ="<div id='leng2'>";
			str +='<input class="form-control" type="text" id="empNm['+leng2+']" name="empNm['+leng2+']" value="'+empNm+'" readonly required>';
			str +='<input class="form-control" type="hidden" id="empNo['+leng2+']" name="empNo['+leng2+']" value="'+empNo+'" required>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="PL['+leng2+']" type="radio" name="role['+leng2+']" value="C101">';
			str +='<label class="form-check-label" for="PL['+leng2+']">PL</label>';
			str +='</div>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="AA['+leng2+']" type="radio" name="role['+leng2+']" value="C103">';
			str +='<label class="form-check-label" for="AA['+leng2+']">AA</label>';
			str +='</div>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="DA['+leng2+']" type="radio" name="role['+leng2+']" value="C102">';
			str +='<label class="form-check-label" for="DA['+leng2+']">DA</label>';
			str +='</div>';
			str +='<div class="form-check form-check-inline">';
			str +='<input class="form-check-input" id="UA['+leng2+']" type="radio" name="role['+leng2+']" value="C104">';
			str +='<label class="form-check-label" for="UA['+leng2+']">UA</label>';
			str +='</div>';
		
			$('.card-textUpdate').append(str);
			leng2++;
	});
	
	$('.minus').on('click',function(){
		$('.card-text2 #leng').last().remove(); // 마지막으로 추가된 항목 제거
		leng--;
	});
	
	$('.minusUpdate').on('click',function(){
		$('.card-textUpdate #leng2').last().remove(); // 마지막으로 추가된 항목 제거
		leng2--;
	});
	
	$('.ins').on('click',function(){
		Swal.fire({
			   title: '프로젝트 생성을 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '생성', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   
			      Swal.fire('생성이 완료되었습니다.', '', 'success');
					var bizNm =$('input[name=bizNm]').val();
					var bizCn =$("#bizCn").val();
					
					let bizMemberVOList = [];
					   $('.card-text2 #leng').each(function() {
						   let empNm = $(this).find('input[type="text"]').val();
					       let empNo = $(this).find('input[type="hidden"]').val();
					       let bizRole = $(this).find('input[type="radio"]:checked').val();
					       bizMemberVOList.push({ empNm ,empNo, bizRole });
					   });
					
					console.log("bizNm : "+ bizNm);
					console.log("bizCn : "+ bizCn);
					console.log("bizMemberVOList : ", bizMemberVOList);
					   
					let data = {
							"bizNm" : bizNm,
							"bizCn" : bizCn,
							"bizMemberVOList" : bizMemberVOList
					}
					
					console.log("data : ",data);
					
			
					
					$.ajax({
			            url : "/biz/create", // 요기에
			            contentType:"application/json;charset=utf-8",
			            data : JSON.stringify(data), 
			            type : 'POST', 
			            beforeSend:function(xhr){
			              xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			            },
			            success : function(bizVOList) {
			                console.log(bizVOList);
			               	$('.card-text2').html('');
			               	$('input[name=bizNm]').val('');
			           		$("#bizCn").val('');
			           		$("#updateBizCn").val('');
			           		window.editor1.setData('');
							leng = 0;
			           		
			           		let str="";
			           		str +='<table id="insert">';
			           		str +='<thead>';
			           		str +='<tr><th>번호</th><th>프로젝트 번호</th><th>프로젝트 명</th><th>프로젝트 시작일</th><th>프로젝트 종료일</th><th>프로젝트 완료여부</th></tr>';
			           		str +='</thead>';
			           		str +='<tbody>';
			           		$.each(bizVOList,function(idx,bizVO){
				           		str +='<tr>';
				           		str +='<td>'+(idx+1)+'</td>';
				           		str +='<td><button class="btn btn-outline-dark bizNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-biz-no="'+bizVO.bizNo+'" >'+bizVO.bizNo+'</button></td>';
				           		str +='<td>'+bizVO.bizNm+'</td>';
			           			var stdt = new Date(bizVO.bizStdt);
			    				var formattedStdt = formatDate(stdt);
			
			    				var edt = new Date(bizVO.bizEdt);
			    				var formattedEdt = formatDate(edt);
			           			
			           			str +='<td>'+formattedStdt+'</td>'
			           			str +='<td>'+formattedEdt+'</td>'
				           		str +='<td>';
				           		if(bizVO.bizCmptnYn=='Y'){
				           			str +='<div class="badge bg-primary text-white rounded-pill">프로젝트 완료</div>';
				           		}else if(bizVO.bizCmptnYn=='N'){
					           		str +='<div class="badge bg-danger text-white rounded-pill">프로젝트 중단</div>';
				           		}else{
				           			str +='<div class="badge bg-warning text-white rounded-pill">프로젝트 진행</div>'
				           		}
			           			str +='</td>';
			           			str +='</tr>';
				           	});
			           		str +='</tbody>';
			           		str +='</table>';
			           		
							$('.main-card').html(str);           		
			           		
							if($('#insert').length){
								const insert = document.getElementById('insert');
					    	    if (insert) {
					    	        new simpleDatatables.DataTable(insert,{
					    	        		perPage: 5,
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
							}
							
			            }, // success 
			    
			        });
			   }
			});
		   
	});
	
	
	$(document).on('click','.bizNo',function(){
		//this : 클래스 오브젝트 배열 중에서 클릭한 바로 그 오브젝트
		var bizNo = this.dataset.bizNo;
		console.log(bizNo);
		
		//JSON 오브젝트
		let data = {
				"bizNo" : bizNo,
		};
		
	    $.ajax({
	    	url:"/biz/detail",
	    	contentType:"application/json;charset=utf-8",
	    	dataType:"json",
	    	data:JSON.stringify(data),
	    	type:"post",
	    	beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	    	success:function(bizVO){
	    		console.log(bizVO);
	    		
	    		$('#exampleModalCenterTitle1').html(bizVO.bizNm);
	    		
	    		$(".bizCn").html(bizVO.bizCn);
	    		
				let str2 ="";
	    		
	    		str2 += "<table id='bizMember' class='datatable-table'>";
	    		str2 += "<thead>";
	    		str2 += "<tr>";
	    		str2 += "<th style='width: 40%;'>이름</th><th style='width: 60%;'>역할</th>";
	    		str2 += "</tr>";
	    		str2 += "</thead>";
	    		str2 += "<tbody>";
	    		$.each(bizVO.bizMemberVOList,function(idx,bizMemberVO){
	    			str2 += "<tr data-index='"+idx+"'>";
		    		str2 += "<td>"+bizMemberVO.empNm+"</td>";
		    		
		    		if(bizMemberVO.bizRole=='C101'){
			    		str2 += "<td><div class='badge bg-primary text-white rounded-pill'>PL</div></td>";
		    		}else if(bizMemberVO.bizRole=='C102'){
		    			str2 += "<td><div class='badge bg-primary text-white rounded-pill'>DA</div></td>";
		    		}else if(bizMemberVO.bizRole=='C103'){
		    			str2 += "<td><div class='badge bg-primary text-white rounded-pill'>AA</div></td>";
		    		}else if(bizMemberVO.bizRole=='C104'){
		    			str2 += "<td><div class='badge bg-primary text-white rounded-pill'>UA</div></td>";
		    		}
		    		
		    		str2 += "</tr>";
	    		});
	    		str2 += "</tbody>";
	    		str2 += "</table>";
	    		
	    		$('.member').html(str2);
	    		
	    		let str4 ="";
	    		
	    		if(bizVO.bizCmptnYn=='I'){
	    			str4 +='<div class="step step-primary mb-5">';
		    		str4 +='<div class="step-item step1">';
		    		str4 +='<a class="step-item-link disabled" href="#!">Start</a>';
		    		str4 +='</div>';
		    		str4 +='<div class="step-item step2 active">';
		    		str4 +='<a class="step-item-link disabled" href="#!">Work In Progress</a>';
		    		str4 +='</div>';
		    		str4 +='<div class="step-item">';
		    		str4 +='<a class="step-item-link step3 comp" href="#!" tabindex="-1" data-bs-dismiss="modal" data-biz-no="'+bizVO.bizNo+'">Complete</a>';
		    		str4 +='</div>';
	    		}else if(bizVO.bizCmptnYn=='Y'){
	    			str4 +='<div class="step step-primary mb-5">';
		    		str4 +='<div class="step-item step1">';
		    		str4 +='<a class="step-item-link disabled" href="#!">Start</a>';
		    		str4 +='</div>';
	    			str4 +='<div class="step-item step2">';
		    		str4 +='<a class="step-item-link disabled" href="#!">Work In Progress</a>';
		    		str4 +='</div>';
		    		str4 +='<div class="step-item active">';
		    		str4 +='<a class="step-item-link step3 disabled" href="#!" tabindex="-1" aria-disabled="true">Complete</a>';
		    		str4 +='</div>';
	    		}else{
	    			str4 +='<div class="step step-danger mb-5">';
		    		str4 +='<div class="step-item step1">';
		    		str4 +='<a class="step-item-link disabled" href="#!">Start</a>';
		    		str4 +='</div>';
		    		str4 +='<div class="step-item step2">';
		    		str4 +='<a class="step-item-link disabled" href="#!">Work In Progress</a>';
		    		str4 +='</div>';
		    		str4 +='<div class="step-item">';
		    		str4 +='<a class="step-item-link step3 disabled" href="#!" tabindex="-1" aria-disabled="true">Cancel</a>';
		    		str4 +='</div>';
	    		}
	    		str4 +='</div>';
	    		
	    		$('.step-place').html(str4);
	    		
	    		var stdt = new Date(bizVO.bizStdt);
	    		var formattedStdt = formatDate(stdt);

	    		var edt = new Date(bizVO.bizEdt);
	    		var formattedEdt = formatDate(edt);
	    		
	    		$('.bizStdt').html(formattedStdt);
	    		
	    		str5 ="";
	    		str5 += '<div class="timeline-item-marker">';
	    		str5 += '<div class="timeline-item-marker-text bizEdt"></div>';
	    		str5 += '<div class="timeline-item-marker-indicator bg-success-soft text-success"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-gift"><polyline points="20 12 20 22 4 22 4 12"></polyline><rect x="2" y="7" width="20" height="5"></rect><line x1="12" y1="22" x2="12" y2="7"></line><path d="M12 7H7.5a2.5 2.5 0 0 1 0-5C11 2 12 7 12 7z"></path><path d="M12 7h4.5a2.5 2.5 0 0 0 0-5C13 2 12 7 12 7z"></path></svg></i></div>';
	    		str5 += '</div>';
	    		str5 += '<div class="timeline-item-content pt-0">';
	    		str5 += '<br/><h5 class="text-success">Complete</h5>';
	    		str5 += '</div>';
	    		
	    		str6 ="";
	    		str6 += '<div class="timeline-item-marker">';
	    		str6 += '<div class="timeline-item-marker-text bizEdt"></div>';
	    		str6 += '<div class="timeline-item-marker-indicator bg-danger-soft text-danger"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-send"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg><i data-feather="send"></i></div>';
	    		str6 += '</div>';
	    		str6 += '<div class="timeline-item-content pt-0">';
	    		str6 += '<br/><h5 class="text-danger">Cancel</h5>';
	    		str6 += '</div>';
	    		
	    		if(bizVO.bizCmptnYn=='Y'){
	    			$('.change').html(str5);
	    			$('.bizEdt').html(formattedEdt);
	    		}else if(bizVO.bizCmptnYn=='I'){
	    			$('.change').html(str5);
	    		}else{
	    			$('.change').html(str6);
	    			$('.bizEdt').html(formattedEdt);
	    		}
	    		
	    		str7 ="";
	    		if(bizVO.bizCmptnYn=='I'){
		    		str7 +='<button class="btn btn-warning edit" type="button" data-bs-toggle="modal" data-bs-target="#updateModal">수정</button>';
		    		str7 +='<button class="btn btn-danger cancel" type="button" data-bs-dismiss="modal">중단</button>';
	    		}
	    		str7 +='<input type="hidden" name="bizNo" value="'+bizVO.bizNo+'"/>';
	    		str7 +='<button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>';
	    		$('.edit').html(str7);
	
	    		
	    		$('#updateBizNm').val(bizVO.bizNm);
	    		window.editor2.setData(bizVO.bizCn);
	    		
	    		let str8 ="";
	    		$.each(bizVO.bizMemberVOList,function(idx,bizMemberVO){
	    			str8 +="<div id='leng2'>";
					str8 +='<input class="form-control" type="text" id="empNm['+idx+']" name="empNm['+idx+']" value="'+bizMemberVO.empNm+'" readonly required>';
					str8 +='<input class="form-control" type="hidden" id="empNo['+idx+']" name="empNo['+idx+']" value="'+bizMemberVO.empNo+'" required>';
					str8 +='<div class="form-check form-check-inline">';
					if(bizMemberVO.bizRole=='C101'){
						str8 +='<input class="form-check-input" id="PL['+idx+']" type="radio" name="role['+idx+']" value="C101" checked>';
						str8 +='<label class="form-check-label" for="PL['+idx+']">PL</label>';
					}else{
						str8 +='<input class="form-check-input" id="PL['+idx+']" type="radio" name="role['+idx+']" value="C101">';
						str8 +='<label class="form-check-label" for="PL['+idx+']">PL</label>';
					}
					str8 +='</div>';
					str8 +='<div class="form-check form-check-inline">';
					if(bizMemberVO.bizRole=='C103'){
						str8 +='<input class="form-check-input" id="AA['+idx+']" type="radio" name="role['+idx+']" value="C103" checked>';
						str8 +='<label class="form-check-label" for="AA['+idx+']">AA</label>';
					}else{
						str8 +='<input class="form-check-input" id="AA['+idx+']" type="radio" name="role['+idx+']" value="C103">';
						str8 +='<label class="form-check-label" for="AA['+idx+']">AA</label>';
					}
					str8 +='</div>';
					str8 +='<div class="form-check form-check-inline">';
					if(bizMemberVO.bizRole=='C102'){
						str8 +='<input class="form-check-input" id="DA['+idx+']" type="radio" name="role['+idx+']" value="C102" checked>';
						str8 +='<label class="form-check-label" for="DA['+idx+']">DA</label>';
					}else{
						str8 +='<input class="form-check-input" id="DA['+idx+']" type="radio" name="role['+idx+']" value="C102">';
						str8 +='<label class="form-check-label" for="DA['+idx+']">DA</label>';
					}
					str8 +='</div>';
					str8 +='<div class="form-check form-check-inline">';
					if(bizMemberVO.bizRole=='C104'){
						str8 +='<input class="form-check-input" id="UA['+idx+']" type="radio" name="role['+idx+']" value="C104" checked>';
						str8 +='<label class="form-check-label" for="UA['+idx+']">UA</label>';
					}else{
						str8 +='<input class="form-check-input" id="UA['+idx+']" type="radio" name="role['+idx+']" value="C104">';
						str8 +='<label class="form-check-label" for="UA['+idx+']">UA</label>';
					}
					str8 +='</div>';
					str8 +='</div>';
					leng2 =idx+1;
	    		});
	    		
	    		$('.card-textUpdate').html(str8);
	    		
	    	}
		
	    });
	});
	
	
	
	$(document).on('click','.update',function(){
		Swal.fire({
			   title: '프로젝트 수정을 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '완료', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   var bizNm =$('input[name=updateBizNm]').val();
					var bizNo =$('input[name=bizNo]').val();
					var bizCn =$("#updateBizCn").val();
					
					let bizMemberVOList = [];
					   $('.card-textUpdate #leng2').each(function() {
						   let empNm = $(this).find('input[type="text"]').val();
					       let empNo = $(this).find('input[type="hidden"]').val();
					       let bizRole = $(this).find('input[type="radio"]:checked').val();
					       bizMemberVOList.push({ empNm ,empNo, bizRole });
					   });
					
					console.log("bizNm : "+ bizNm);
					console.log("bizCn : "+ bizCn);
					console.log("bizMemberVOList : ", bizMemberVOList);
					   
					let data = {
							"bizNo" : bizNo,
							"bizNm" : bizNm,
							"bizCn" : bizCn,
							"bizMemberVOList" : bizMemberVOList
					}
					
					console.log("data : ",data);
					
					$.ajax({
			            url : "/biz/update", // 요기에
			            contentType:"application/json;charset=utf-8",
			            data : JSON.stringify(data), 
			            type : 'POST', 
			            beforeSend:function(xhr){
			              xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			            },
			            success : function(bizVOList) {
			                console.log(bizVOList);
			               	$('.card-text2').html('');
			               	$('input[name=bizNm]').val('');
			           		$("#bizCn").val('');
			           		$("#updateBizCn").val('');
			           		window.editor2.setData('');
							leng = 0;
			           		
			           		let str="";
			           		str +='<table id="update">';
			           		str +='<thead>';
			           		str +='<tr><th>번호</th><th>프로젝트 번호</th><th>프로젝트 명</th><th>프로젝트 시작일</th><th>프로젝트 종료일</th><th>프로젝트 완료여부</th></tr>';
			           		str +='</thead>';
			           		str +='<tbody>';
			           		$.each(bizVOList,function(idx,bizVO){
				           		str +='<tr>';
				           		str +='<td>'+(idx+1)+'</td>';
				           		str +='<td><button class="btn btn-outline-dark bizNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-biz-no="'+bizVO.bizNo+'" >'+bizVO.bizNo+'</button></td>';
				           		str +='<td>'+bizVO.bizNm+'</td>';
			           			var stdt = new Date(bizVO.bizStdt);
			    				var formattedStdt = formatDate(stdt);

			    				var edt = new Date(bizVO.bizEdt);
			    				var formattedEdt = formatDate(edt);
			           			
			           			str +='<td>'+formattedStdt+'</td>'
			           			str +='<td>'+formattedEdt+'</td>'
				           		str +='<td>';
				           		if(bizVO.bizCmptnYn=='Y'){
				           			str +='<div class="badge bg-primary text-white rounded-pill">프로젝트 완료</div>';
				           		}else if(bizVO.bizCmptnYn=='N'){
					           		str +='<div class="badge bg-danger text-white rounded-pill">프로젝트 중단</div>';
				           		}else{
				           			str +='<div class="badge bg-warning text-white rounded-pill">프로젝트 진행</div>'
				           		}
			           			str +='</td>';
			           			str +='</tr>';
				           	});
			           		str +='</tbody>';
			           		str +='</table>';
			           		
							$('.main-card').html(str);           		
			           		
							if($('#update').length){
								const update = document.getElementById('update');
					    	    if (update) {
					    	        new simpleDatatables.DataTable(update,{
					    	        		perPage: 5,
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
							}
							
						   Swal.fire('수정이 완료되었습니다.','','success');
			            }, // success 
			    
			        });		
			   }
			   
			});
		
				
	});
	
	$(document).on('click','.comp',function(){
		Swal.fire({
			   title: '프로젝트 완료 처리를 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '완료', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					var bizNo = this.dataset.bizNo;
					console.log(bizNo);
					
					let data = {
							"bizNo" : bizNo,
					}
					
					$.ajax({
			            url : "/biz/updateStatus", // 요기에
			            contentType:"application/json;charset=utf-8",
			            data : JSON.stringify(data), 
			            type : 'POST', 
			            beforeSend:function(xhr){
			              xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			            },
			            success : function(bizVOList) {
			                console.log(bizVOList);
			           		
			           		let str="";
			           		str +='<table id="insert">';
			           		str +='<thead>';
			           		str +='<tr><th></th><th>프로젝트 번호</th><th>프로젝트 명</th><th>프로젝트 시작일</th><th>프로젝트 종료일</th><th>프로젝트 완료여부</th></tr>';
			           		str +='</thead>';
			           		str +='<tbody>';
			           		$.each(bizVOList,function(idx,bizVO){
				           		str +='<tr>';
				           		str +='<td>'+(idx+1)+'</td>';
				           		str +='<td><button class="btn btn-outline-dark bizNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-biz-no="'+bizVO.bizNo+'" >'+bizVO.bizNo+'</button></td>';
				           		str +='<td>'+bizVO.bizNm+'</td>';
			           			var stdt = new Date(bizVO.bizStdt);
			    				var formattedStdt = formatDate(stdt);
			
			    				var edt = new Date(bizVO.bizEdt);
			    				var formattedEdt = formatDate(edt);
			           			
			           			str +='<td>'+formattedStdt+'</td>'
			           			str +='<td>'+formattedEdt+'</td>'
				           		str +='<td>';
				           		if(bizVO.bizCmptnYn=='Y'){
				           			str +='<div class="badge bg-primary text-white rounded-pill">프로젝트 완료</div>';
				           		}else if(bizVO.bizCmptnYn=='N'){
					           		str +='<div class="badge bg-danger text-white rounded-pill">프로젝트 중단</div>';
				           		}else{
				           			str +='<div class="badge bg-warning text-white rounded-pill">프로젝트 진행</div>'
				           		}
			           			str +='</td>';
			           			str +='</tr>';
				           	});
			           		str +='</tbody>';
			           		str +='</table>';
			           		
							$('.main-card').html(str);           		
			           		
							if($('#insert').length){
								const insert = document.getElementById('insert');
					    	    if (insert) {
					    	        new simpleDatatables.DataTable(insert,{
					    	        		perPage: 5,
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
							}
							$('#exampleModalCenter').modal('hide'); // 모달을 닫습니다.
			            }, // success 
			    
			        });
			   
			   }
			});
		
		
	});
	
	$(document).on('click','.cancel',function(){
		Swal.fire({
			   title: '프로젝트 중단 처리를 하시겠습니까?',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonText: '중단', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정

			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   		var bizNo =$('input[name=bizNo]').val();
					
			   		console.log(bizNo);
					
					let data = {
							"bizNo" : bizNo,
					}
					$.ajax({
			            url : "/biz/updateStatusN", // 요기에
			            contentType:"application/json;charset=utf-8",
			            data : JSON.stringify(data), 
			            type : 'POST', 
			            beforeSend:function(xhr){
			              xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			            },
			            success : function(bizVOList) {
			                console.log(bizVOList);
			           		
			           		let str="";
			           		str +='<table id="insert">';
			           		str +='<thead>';
			           		str +='<tr><th>번호</th><th>프로젝트 번호</th><th>프로젝트 명</th><th>프로젝트 시작일</th><th>프로젝트 종료일</th><th>프로젝트 완료여부</th></tr>';
			           		str +='</thead>';
			           		str +='<tbody>';
			           		$.each(bizVOList,function(idx,bizVO){
				           		str +='<tr>';
				           		str +='<td>'+(idx+1)+'</td>';
				           		str +='<td><button class="btn btn-outline-dark bizNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-biz-no="'+bizVO.bizNo+'" >'+bizVO.bizNo+'</button></td>';
				           		str +='<td>'+bizVO.bizNm+'</td>';
			           			var stdt = new Date(bizVO.bizStdt);
			    				var formattedStdt = formatDate(stdt);
			
			    				var edt = new Date(bizVO.bizEdt);
			    				var formattedEdt = formatDate(edt);
			           			
			           			str +='<td>'+formattedStdt+'</td>'
			           			str +='<td>'+formattedEdt+'</td>'
				           		str +='<td>';
				           		if(bizVO.bizCmptnYn=='Y'){
				           			str +='<div class="badge bg-primary text-white rounded-pill">프로젝트 완료</div>';
				           		}else if(bizVO.bizCmptnYn=='N'){
					           		str +='<div class="badge bg-danger text-white rounded-pill">프로젝트 중단</div>';
				           		}else{
				           			str +='<div class="badge bg-warning text-white rounded-pill">프로젝트 진행</div>'
				           		}
			           			str +='</td>';
			           			str +='</tr>';
				           	});
			           		str +='</tbody>';
			           		str +='</table>';
			           		
							$('.main-card').html(str);           		
			           		
							if($('#insert').length){
								const insert = document.getElementById('insert');
					    	    if (insert) {
					    	        new simpleDatatables.DataTable(insert,{
					    	        		perPage: 5,
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
							}
			            }, // success 
					    
			        });
				   
			      Swal.fire('승인이 완료되었습니다.', 'success');
			   }
			});
		
		
		
		
	});	
});
</script>
<style>
.badge {
	font-size: 15px;
}
#datatablesSimple1 td:nth-child(1),
#datatablesSimple1 td:nth-child(2),
#datatablesSimple1 td:nth-child(4),
#datatablesSimple1 td:nth-child(5),
#datatablesSimple1 td:nth-child(6) {
	text-align: center;
}
.right {
	text-align: right;
	margin-left: 800px;
}
#bizMember td {
	text-align: center;
}
</style>
<header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
    <div class="container-xl px-4">
        <div class="page-header-content pt-4">
            <div class="row align-items-center justify-content-between">
                <div class="col-auto mt-4">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layout">
                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="3" y1="9" x2="21" y2="9"></line>
                                <line x1="9" y1="21" x2="9" y2="9"></line>
                            </svg>
                        </div>
                        프로젝트
                    </h1>
                    <div class="page-header-subtitle"></div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone">프로젝트 목록</div>
		<div class="card-body main-card">
			<table id="datatablesSimple1">
				<thead>
					<tr>
						<th>번호</th>
						<th>프로젝트 번호</th>
						<th>프로젝트 명</th>
						<th>프로젝트 시작일</th>
						<th>프로젝트 종료일</th>
						<th>프로젝트 완료여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="bizVO" items="${bizVOList}" varStatus="stat">
						<tr>
							<td>${stat.index + 1}</td>
							<td><button class="btn btn-outline-dark bizNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-biz-no="${bizVO.getBizNo()}" >${bizVO.getBizNo()}</button></td>
							<td>${bizVO.getBizNm()}</td>
							<td><fmt:formatDate value="${bizVO.getBizStdt()}" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${bizVO.getBizEdt()}" pattern="yyyy-MM-dd" /></td>
							<td>
								<c:choose>
						            <c:when test="${bizVO.getBizCmptnYn() eq 'Y'}">
										<div class="badge bg-primary text-white rounded-pill">프로젝트 완료</div>
						            </c:when>
						            <c:when test="${bizVO.getBizCmptnYn() eq 'N'}">
										<div class="badge bg-danger text-white rounded-pill">프로젝트 중단</div>
						            </c:when>
						            <c:otherwise>
										<div class="badge bg-warning text-white rounded-pill">프로젝트 진행</div>
						            </c:otherwise>
						        </c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#insertModal">프로젝트 생성</button>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">프로젝트 생성</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            	<div class="card card-header-actions mb-4 mb-lg-0">
			        <div class="card-header">
			            프로젝트 생성
			        </div>
			        <div class="card-body">
			            <form action="/frcowner/boardCreate" method="post">
			                <div class="form-group mb-4">
			                    <label for="textArea">프로젝트 명</label>
			                    <input class="form-control" type="text" id="textArea" name="bizNm" placeholder="프로젝트명" required>
			                </div>
			                
			                <div class="classic">
			                    <label for="bizCn">프로젝트 내용</label>
			                    <div id="ckClassic"></div>
			                    <textarea id="bizCn" class="form-control" name="bizCn"
			                        rows="4" cols="30" style="display: none;">
			                    </textarea>
			                </div><br />
			            </form>
			        </div>
			    </div>
			    <div class="row">
				    <!-- Card Image Cap (Top) Example -->
					<div class="col-6">
						<div class="card">
						    <div class="card-body">
						        <h5 class="card-title">구성원 선택</h5>
						        <hr/>
						        <div class="card-text1">
								    <div class="input-group">
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
								        <div class="input-group-append">
								            <button class="btn btn-primary plus">+</button>
								        </div>
								    </div>
								</div>
						    </div>
						</div>
					</div>
					<div class="col-6">
					    <div class="card">
					        <div class="card-body">
					            <div class="d-flex justify-content-between align-items-center">
					                <h5 class="card-title">역할 선택</h5>
					                <button class="btn btn-primary minus">-</button>
					            </div>
					            <hr>
					            <div class="card-text2">
					                <!-- 추가된 항목들이 들어가는 곳 -->
					            </div>  
					        </div>
					    </div>
					</div>
				</div>
            </div>
            <div class="modal-footer"><button class="btn btn-primary ins" type="button" data-bs-dismiss="modal">생성</button><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title" id="exampleModalCenterTitle2">프로젝트 상세</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            <form>
            	<div class="step-place">
			    	
				</div>
				<div class="card card-scrollable">
				    <div class="card-header ">프로젝트 내용</div>
				    <div class="card-body">
				        <p class="card-text bizCn"></p>
				    </div>
				</div>
				<hr/>
				
				<div class="row">
				    <!-- Card Image Cap (Top) Example -->
					<div class="col-6">
						<div class="card">
						    <div class="card-body">
						        <h5 class="card-title">구성원</h5>
						        <div class="card-text member">
						        </div>
						    </div>
						</div>
					</div>
					<div class="col-6">
						<div class="card">
						    <div class="card-body">
						        <h5 class="card-title"></h5>
						        <div class="card-text timelines">
				        			<div class="timeline">
									    <div class="timeline-item">
									        <div class="timeline-item-marker">
									        	<div class="timeline-item-marker-text bizStdt"></div>
									            <div class="timeline-item-marker-indicator bg-primary-soft text-primary"><i data-feather="flag"></i></div>
									        </div>
									        <div class="timeline-item-content pt-0">
							                    <br/><h5 class="text-primary">Start</h5>
									        </div>
									    </div>
									    <div class="timeline-item">
									        <div class="timeline-item-marker">
									        	<div class="timeline-item-marker-text"></div>
									            <div class="timeline-item-marker-indicator bg-secondary-soft text-secondary"><i data-feather="map"></i></div>
									        </div>
									        <div class="timeline-item-content pt-0">
							                    <br/><h5 class="text-secondary">WIP</h5>
									        </div>
									    </div>
									    <div class="timeline-item change">
									    </div>
									</div>
						        </div>
						    </div>
						</div>
					</div>
				</div>
            </form>
            </div>
            <div class="modal-footer edit"></div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalTitle">프로젝트 수정</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            	<div class="card card-header-actions mb-4 mb-lg-0">
			        <div class="card-header">
			            프로젝트 수정
			        </div>
			        <div class="card-body">
		                <div class="form-group mb-4">
		                    <label for="textArea">프로젝트 명</label>
		                    <input class="form-control" type="text" id="updateBizNm" name="updateBizNm" placeholder="프로젝트명" required>
		                </div>
		                
		                <div class="classic">
		                    <label for="bizCn">프로젝트 내용</label>
		                    <div id="ckClassic2"></div>
		                    <textarea id="updateBizCn" class="form-control" name="updateBizCn"
		                        rows="4" cols="30" style="display: none;">
		                    </textarea>
		                </div><br />
			        </div>
			    </div>
			    <div class="row">
					<div class="col-6">
						<div class="card">
						    <div class="card-body">
						        <h5 class="card-title">구성원 선택</h5>
						        <hr/>
						        <div class="card-text1">
								    <div class="input-group">
								        <select class="form-control" id="updateEmpNo" name="updateEmpNo">
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
								        <div class="input-group-append">
								            <button class="btn btn-primary plusUpdate">+</button>
								        </div>
								    </div>
								</div>
						    </div>
						</div>
					</div>
					<div class="col-6">
					    <div class="card">
					        <div class="card-body">
					            <div class="d-flex justify-content-between align-items-center">
					                <h5 class="card-title">역할 선택</h5>
					                <button class="btn btn-primary minusUpdate">-</button>
					            </div>
					            <hr>
					            <div class="card-textUpdate">
					                <!-- 추가된 항목들이 들어가는 곳 -->
					            </div>  
					        </div>
					    </div>
					</div>
				</div>
            </div>
            <div class="modal-footer"><button class="btn btn-primary update" type="button" data-bs-dismiss="modal">수정</button><button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter">닫기</button></div>
        </div>
    </div>
</div>
<script>
ClassicEditor.create(document.querySelector("#ckClassic"), {ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
.then(editor => { window.editor1 = editor;})
.catch(err => { console.error(err.stack) });

ClassicEditor.create(document.querySelector("#ckClassic2"), {ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
.then(editor => { window.editor2 = editor;})
.catch(err => { console.error(err.stack) });
</script>