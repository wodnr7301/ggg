<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Register Form</title>
<style>
.form-control, .form-check{
	display: inline-block;
}


#pImg2 {
    width: 200px; 
    height: auto; 
}
</style>


<script type="text/javascript">

$(document).ready(function(){
    $('.uploadFile').on('change', handleImg);
    $('.uploadStamp').on('change', handleStamp);
});

function handleImg(e){
    let files = e.target.files;
    let fileArr = Array.prototype.slice.call(files);
    fileArr.forEach(function(f){
       if(!f.type.match("image.*")){
          swal("이미지 확장자만 가능합니다.","","error");
          return;
       }
       let reader = new FileReader();
       
       $("#pImg1").html("");
       
       reader.onload = function(e){
          let img_html = "<img src=\"" + e.target.result + "\" style='width:50%;' />";
          $("#pImg1").append(img_html);
       }
       reader.readAsDataURL(f);
    });
 }
function handleStamp(e){
    let files = e.target.files;
    let fileArr = Array.prototype.slice.call(files);
    fileArr.forEach(function(f){
       if(!f.type.match("image.*")){
          swal("이미지 확장자만 가능합니다.","","error");
          return;
       }
       let reader = new FileReader();
       
       $("#pImg2").html("");
       
       reader.onload = function(e){
          let img_html = "<img src=\"" + e.target.result + "\" style='width:50%;' />";
          $("#pImg2").append(img_html);
       }
       reader.readAsDataURL(f);
    });
 }



	$(function() {
		
		$("#newEmpNoBtn").on("click", function() {
			$.ajax({
				url:"/employee/empNoId",
				type:"post",
				dataType:"text",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
					$("#empNo").val(result);
					empNo = result;
					
					var Toast3 = Swal.mixin({
						toast:true,
						position:"top-end",
						showConfirmButton:false,
						timer:2000
					});
					Toast3.fire({
					    icon:"success",
						title:"회원번호가 자동 생성되었습니다."
					});
				}
			});
		});
		
		$("#btnPost").on("click", function() {
			new daum.Postcode({
				oncomplete : function(data) {
					$("#empZip").val(data.zonecode);
					$("input[name='empAddr']").val(data.address);
					$("#empDaddr").val(data.buildingName)
				}
			}).open();
		});
	
		// 자동 등록 버튼
		$(".autoregister").on("click", function() {
			$("#empNm").val("육성재");
			$("#empBrdt").val("1995-05-02");
			$("#empEmlAddr").val("sixseongjae@gmail.com");
			$("#empZip").val("16944");
			$("#empAddr").val("경기 용인시 수지구 광교마을로 11");
			$("#empDaddr").val("광교더힐 102동 2003호");
			$("#empTelno").val("010-1020-2030");
			$('input[name="empMrgYn"][value="N"]').prop("checked", true);
			$("#empAmt").val(4000000);
			$("#empPswd").val("java");
			$('input[name="empGen"][value="M"]').prop("checked", true);
			$("#empJncmpYmd").val("농협");
			$("#empActno").val("356-1029-1234-23");
		});
		
		$("#btnSave").on("click", function() {

		    var formData = new FormData($("#empFrm")[0]);
		    
		    $.ajax({
		        url: "/employee/registerFormData",
		        type: "POST",
		        data: formData,
		        processData: false, // FormData를 문자열로 변환하지 않도록 설정
		        contentType:false,
		        beforeSend:function(xhr){
			          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			       },   
		    	success: function(result) {
		    		 console.log("result:", result);
		    		 
		    		 swal("등록이 완료되었습니다.","","success").then(function() {
		    			 window.location.href = "/employee/list";
		    		 });
		    	},
		        error: function(xhr, status, error) {
		            console.error(xhr.responseText);
		            
		            swal("등록에 실패하였습니다.","","error");
		        }
		    });
		});
	});
</script>
</head>
<body>
		<header
			class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
			<div class="container-xl px-4">
				<div class="page-header-content pt-4">
					<div class="row align-items-center justify-content-between">
						<div class="col-auto mt-4">
							<h1 class="page-header-title">
								<div class="page-header-icon">
									<i data-feather="layout"></i>
								</div>
								사원 등록
							</h1>
						</div>
					</div>
				</div>
			</div>
		</header>
		<!-- Main page content-->
		<div class="container-xl px-4 mt-n10">
			<div class="card">
				<div class="card-header">사원정보 등록</div>
				<div class="card-body">
					<form action="/employee/register" method="post" id="empFrm" enctype="multipart/form-data">
						<div class="mb-3">
							<button class="btn btn-outline-primary autoregister" type="button">자동등록</button><br /><hr>
							<label class="small mb-1" for="empNo">회원번호</label> 
								<button class="btn btn-outline-primary btn-sm" type="button" id="newEmpNoBtn">자동 생성</button>
								<input class="form-control form-control-solid" type="text" name="empNo" id="empNo" placeholder="사원번호" readonly="readonly"><br />
							<label class="small mb-1" for="empNm">회원명</label> 
								<input class="form-control" id="empNm" type="text" placeholder="회원명" name="empNm" /><br /> 
							<label class="small mb-1" for="empBrdt">생년월일</label>
								<input class="form-control" type="date" id="empBrdt" name="empBrdt"><br />
							<label class="small mb-1" for="empEmlAddr">이메일</label> 
								<input class="form-control" id="empEmlAddr" name="empEmlAddr" type="email" placeholder="이메일" /><br/>
							<label class="small mb-1" for="empZip"><br />
								<button	class="btn btn-primary" type="button" id="btnPost" >우편번호검색</button></label> 
								<input class="form-control" type="text" name="empZip" id="empZip" readonly /><br />
							<label class="small mb-1" for="empAddr">주소</label> <br />
								<input class="form-control" type="text" name="empAddr" id="empAddr" placeholder="주소" readonly><br />
							<label class="small mb-1" for="empDaddr">상세주소</label><br />
								<input class="form-control" type="text" name="empDaddr" id="empDaddr" placeholder="상세주소"><br />
							<label class="small mb-1" for="empTelno">연락처</label><br />
								<input class="form-control"	type="text" name="empTelno" id="empTelno" placeholder="연락처"><br /><br />
							<div class="mb-3">
								<label class="small mb-1" for="empMrgYn">기혼여부</label><br />
									<div class="form-check">
										<input class="form-check-input" id="empMrgYn" type="radio" name="empMrgYn" value="N">
										<label class="form-check-label" for="empMrgYn">미혼</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" id="empMrgYn" type="radio" name="empMrgYn" value="Y">
										<label class="form-check-label" for="empMrgYn">기혼</label>
									</div>
							</div>
							<label class="small mb-1" for="empAmt">급여</label>
								<input class="form-control" type="number" name="empAmt" id="empAmt" placeholder="급여"><br />
							<label class="small mb-1" for="empId">아이디</label> 
							 <svg data-bs-toggle="tooltip" data-bs-placement="right" title="ex) EMP001" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
								<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
								<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
							</svg>
								<input class="form-control form-control-solid" type="text" name="empId" id="empId" placeholder="아이디" value="사원의 기본아이디는 사원번호와 동일함. " disabled="disabled"><br />
							
							<label class="small mb-1" for="empPswd">비밀번호</label> 
								<input class="form-control" type="text" name="empPswd" id="empPswd" placeholder="비밀번호"><br /><br />
							
							<div class="mb-3">
								<label class="small mb-1" for="empGen">성별</label><br />
									<div class="form-check">
										<input class="form-check-input" id="empGen" type="radio" name="empGen" value="M">
										<label class="form-check-label" for="empGen">남자</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" id="empGen" type="radio" name="empGen" value="F">
										<label class="form-check-label" for="empGen">여자</label>
									</div>
							</div>
							
							<label class="small mb-1" for="empJncmpYmd">은행명</label>
								<input class="form-control" type="text" name="empJncmpYmd" id="empJncmpYmd" placeholder="은행명"><br />
							
							<label class="small mb-1" for="empActno">계좌번호</label>
								<input class="form-control" type="text" name="empActno" id="empActno" placeholder="계좌번호"><br />
						</div>
						
						<div class="mb-3">
							<label for="empJbgdNm">직위</label>
								<select class="form-control form-control-solid" id="empJbgdNm" name="empJbgdNm">
									<option value="A102">부장</option>
									<option value="A103">과장</option>
									<option value="A104">대리</option>
									<option value="A105">사원</option>
								</select><br />
								
							<label for="empJbttlNm">직책</label>
								<select class="form-control form-control-solid" id="empJbttlNm" name="empJbttlNm">
									<option value="A201">팀장</option>
									<option value="A202">부서장</option>
									<option value="A203">사업부장</option>
								</select><br />
								
							<label for="deptNo">부서</label>
								<select class="form-control form-control-solid" id="deptNo" name="deptNo">
									<option value="A002">영업부</option>
									<option value="A003">인사부</option>
									<option value="A004">회계부</option>
									<option value="A005">기획부</option>
									<option value="A001">개발부</option>
								</select><br/>
							</div>
							
							<div class="mb-3">
	                            <label class="small mb-1" for="uploadFile">프로필 사진</label>
	                            <input class="form-control uploadFile" type="file" name="uploadFile" id="uploadFile">
								<p id="pImg1"></p>
							</div><br />
							
							<div class="mb-3">
	                            <label class="small mb-1" for="uploadStamp">도장 사진</label>
	                            <input class="form-control uploadStamp" type="file" name="uploadFile" id="uploadFile">
								<p id="pImg2"></p>
							</div><br />
						
						<div>
 							<input type="button" class="btn btn-primary" id="btnSave" name="btnSave" value="등록" />
						</div>
						
						<sec:csrfInput/>
					</form>
				</div>
			</div>
		</div>
