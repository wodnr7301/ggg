<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
#submitBtn{
	float: right;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-add-fill" viewBox="0 0 16 16">
							  <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 1 1-1 0v-1h-1a.5.5 0 1 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
							  <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
							  <path d="m8 3.293 4.712 4.712A4.5 4.5 0 0 0 8.758 15H3.5A1.5 1.5 0 0 1 2 13.5V9.293z"/>
							</svg>
                        </div>
                        	신규 가맹점 등록
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
	<form>
    <div class="row">
        <div class="col-lg-6">
            <!-- 가맹점주 회원 정보 card-->
            <div class="card mb-4">
                <div class="card-header">가맹점주 회원 정보</div>
                <div class="card-body">
                	<div class="mb-3">
	                    <label class="small mb-1" for="rfNo">상담 완료 지원자</label>
						<select class="form-control" id="rfNo" name="rfNo">
							<option value="-1" selected>선택</option>
							<c:forEach var="cnsltY" items="${cnsltYList}" varStatus="stat">
								<option value="${cnsltY.rfNo}">${cnsltY.rfNm} : ${cnsltY.frcsTypeVO.ftNm}(${cnsltY.comcdCdnm})&emsp;상담일 <fmt:formatDate value="${cnsltY.itvBscInfoVO.ibiYmd}" pattern="yyyy-MM-dd HH:mm" /></option>
							</c:forEach>
						</select>
	                </div>
	                <hr/>
	                <br/>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empNm">가맹점주 명</label>
	                    <input class="form-control" id="empNm" type="text" placeholder="새로 등록할 상담 완료자를 선택하거나 입력하세요" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empEmlAddr">이메일</label>
	                    <input class="form-control" id="empEmlAddr" type="email" placeholder="email@email.com" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empTelno">전화번호</label>
	                    <input class="form-control" id="empTelno" type="tel" placeholder="010-0000-0000" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empZip">우편번호</label>&nbsp;
	                    <button class="btn btn-outline-primary btn-sm" type="button" id="empZipBtn">우편번호 검색</button>
	                    <input class="form-control form-control-solid" id="empZip" name="empZip" type="text" placeholder="04766" readonly="readonly" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empAddr">주소</label>
	                    <input class="form-control form-control-solid" id="empAddr" name="empAddr" type="text" placeholder="서울 성동구 서울숲길 17" readonly="readonly" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empDaddr">상세주소</label>
	                    <input class="form-control" id="empDaddr" name="empDaddr" type="text" placeholder="성수파크빌" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empId">아이디</label>
	                    <svg data-bs-toggle="tooltip" data-bs-placement="right" title="ex) frcEMP001" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
						</svg>
	                    <input class="form-control form-control-solid" id="empId" name="empId" type="text" placeholder="아이디" value="가맹점주 아이디는 frc + 사원번호로 등록됩니다." disabled="disabled" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empPswd">임시 비밀번호</label>
	                    <svg data-bs-toggle="tooltip" data-bs-placement="right" title="이름 + 전화번호 뒤 4자리 " xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
						</svg>
	                    <input class="form-control" id="empPswd" name="empPswd" type="text" placeholder="임시 비밀번호" value="" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empBrdt">생년월일</label>
	                    <input class="form-control" id="empBrdt" type="date" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empGen">성별</label>
	                    <div class="form-check">
						    <input class="form-check-input" id="empGenM" type="radio" name="empGen" value="M">
						    <label class="form-check-label" for="empGenM">남자</label>
						</div>
						<div class="form-check">
						    <input class="form-check-input" id="empGenF" type="radio" name="empGen" value="F">
						    <label class="form-check-label" for="empGenF">여자</label>
						</div>
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="empImg">사진</label>
	                    <input class="form-control" id="empImg" name="empImg" type="file" />
	                    <p id="pImg1"></p>
	                </div>
                </div>
            </div>
            <button class="btn btn-dark" id="dataInsert" type="button">데이터 자동입력</button>
        </div>
        <div class="col-lg-6">
        	<!-- 가맹점 기본 정보 card-->
            <div class="card mb-4">
                <div class="card-header">가맹점 기본 정보</div>
                <div class="card-body">
	                <div class="mb-3">
	                    <label class="small mb-1" for="frcsNo">새 가맹점 코드</label>&nbsp;
	                    <button class="btn btn-outline-primary btn-sm" type="button" id="newFrcsNoBtn">가맹점 코드 생성</button>
	                    <input class="form-control form-control-solid" id="frcsNo" type="text" placeholder="가맹점 코드 생성 버튼을 클릭하세요" readonly="readonly" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="frcsNm">가맹지점명</label>
	                    <input class="form-control" id="frcsNm" type="text" placeholder="빽다방 성수동점" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="frcsTelno">가맹점 전화번호</label>
	                    <input class="form-control" id="frcsTelno" type="tel" placeholder="010-0000-0000" />
	                </div>
                    <div class="row mb-3">
                    	<div class="col-md-6">
							<label class="small mb-1" for="ftRgnNm">지역 구분</label>
							<select class="form-control" id="ftRgnNm" name="ftRgnNm">
								<option value="-1" selected>선택</option>
								<c:forEach var="regn" items="${regionList}" varStatus="stat">
									<option value="${regn.comcdGroupcd}">${regn.comcdCdnm}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-6">
							<label class="small mb-1" for="ftNo">프랜차이즈 유형</label>
							<select class="form-control" id="ftNo" name="ftNo">
								<option value="-1" selected>선택</option>
								<c:forEach var="FrcsType" items="${FrcsTypeList}" varStatus="stat">
									<option value="${FrcsType.ftNo}">${FrcsType.ftNm}</option>
								</c:forEach>
							</select>
						</div>
					</div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="frcsZip">우편번호</label>&nbsp;
	                    <button class="btn btn-outline-primary btn-sm" type="button" id="zipBtn">우편번호 검색</button>
	                    <input class="form-control form-control-solid" id="frcsZip" name="frcsZip" type="text" placeholder="04766" readonly="readonly" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="frcsAddr">주소</label>
	                    <input class="form-control form-control-solid" id="frcsAddr" name="frcsAddr" type="text" placeholder="서울 성동구 서울숲길 17" readonly="readonly" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="frcsDaddr">상세주소</label>
	                    <input class="form-control" id="frcsDaddr" name="frcsDaddr" type="text" placeholder="성수파크빌" />
	                </div>
                </div>
            </div>
        	<!-- 계약 기본 정보 card-->
            <div class="card mb-4">
                <div class="card-header">계약 기본 정보</div>
                <div class="card-body">
	                <div class="mb-3">
	                    <label class="small mb-1" for="ctrtNm">계약명</label>
	                    <input class="form-control" id="ctrtNm" type="text" placeholder="서울 성수동 빽다방 가맹점 계약" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="ctrtYmd">계약일자</label>
	                    <input class="form-control" id="ctrtYmd" type="date" />
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="ctrtCn">계약 내용</label>
	                	<textarea class="form-control" id="ctrtCn" type="text" placeholder="계약 내용..." rows="2"></textarea>
	                </div>
	                <div class="mb-3">
	                    <label class="small mb-1" for="ctrtImg">계약서 첨부파일</label>
	                	<input class="form-control" id="ctrtImg" name="ctrtImg" type="file" accept=".pdf" />
	                </div>
                </div>
            </div>
	        <button class="btn btn-primary lift" id="submitBtn" type="button">등록</button>
        </div>
    </div>
    </form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
//가맹점주 사원번호 보관
let frcEmpNo;

//가맹점 코드 보관
let frcsNo;

//가맹점 코드 자동 생성
$("#newFrcsNoBtn").on("click",function(){
	$.ajax({
		url:"/ctrt/getFrcsNo",
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			$("#frcsNo").val(result);
			frcsNo = result;
			
			var Toast3 = Swal.mixin({
				toast:true,
				position:"top-end",
				showConfirmButton:false,
				timer:2000
			});
			Toast3.fire({
			    icon:"success",
				title:"가맹점 코드가 자동 생성되었습니다."
			});
		}
	});	
});

//다음 우편번호 api
$("#empZipBtn").on("click",function(){
	new daum.Postcode({
        oncomplete: function(data) {
			$("#empZip").val(data.zonecode);
			$("#empAddr").val(data.address);
			$("#empDaddr").val(data.buildingName);
			
			var Toast = Swal.mixin({
				toast:true,
				position:"top-end",
				showConfirmButton:false,
				timer:2000
			});
			Toast.fire({
			    icon:"success",
				title:"우편번호가 검색되었습니다."
			});
        }
	}).open();
});

//다음 우편번호 api
$("#zipBtn").on("click",function(){
	new daum.Postcode({
        oncomplete: function(data) {
			$("#frcsZip").val(data.zonecode);
			$("#frcsAddr").val(data.address);
			$("#frcsDaddr").val(data.buildingName);
			
			var Toast2 = Swal.mixin({
				toast:true,
				position:"top-end",
				showConfirmButton:false,
				timer:2000
			});
			Toast2.fire({
			    icon:"success",
				title:"우편번호가 검색되었습니다."
			});
        }
	}).open();
});

//상담완료자 선택 시 기본 정보 자동 입력
$("#rfNo").on("change",function(){
	let selrfNo = $("select[name='rfNo'] option:selected").val();

	let rfNoObject = {
		"rfNo":selrfNo
	}
	console.log("rfNoObject : ",rfNoObject);
	
	$.ajax({
		url:"/ctrt/getCnsltYOne",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(rfNoObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			$("#empNm").val(resp.rfNm);
			$("#empEmlAddr").val(resp.rfEmlAddr);
			$("#empZip").val(resp.rfZip);
			$("#empAddr").val(resp.rfAddr);
			$("#empDaddr").val(resp.rfDaddr);
			$("#empTelno").val(resp.rfTelno);
			let pwdpwd = resp.rfNm + (resp.rfTelno).slice(-4);
			$("#empPswd").val(pwdpwd);
			
			var Toast4 = Swal.mixin({
				toast:true,
				position:"top-end",
				showConfirmButton:false,
				timer:2000
			});
			Toast4.fire({
			    icon:"success",
				title:"선택한 사람의 기본 정보가 자동 입력되었습니다."
			});
		}
	});
});

$("#submitBtn").on("click",function(){
	//유효성체크
	let isCheck = validationCheck();
	if(isCheck==false){return;};
	//아작스 사원 인서트
	addEmp();
	//아작스 가맹점 인서트
	addFrc();
	//아작스 계약 인서트
	addCtrt();
});

//유효성 체크
function validationCheck() {
    let empNm = $("#empNm").val().trim();
    let empEmlAddr = $("#empEmlAddr").val().trim();
    let empTelno = $("#empTelno").val().trim();
    let empZip = $("#empZip").val().trim();
    let empAddr = $("#empAddr").val().trim();
    let empDaddr = $("#empDaddr").val().trim();
    let empPswd = $("#empPswd").val().trim();
    let empBrdt = $("#empBrdt").val();
    let empGen = $("input[name='empGen']:checked").val();
	let empImg = $("#empImg");
	let empImgType = empImg[0].files[0];
    let frcsNo = $("#frcsNo").val().trim();
    let frcsNm = $("#frcsNm").val().trim();
    let frcsTelno = $("#frcsTelno").val().trim();
    let ftNo = $("select[name='ftNo'] option:selected").val();
    let ftRgnNm = $("select[name='ftRgnNm'] option:selected").val();
    let frcsZip = $("#frcsZip").val().trim();
    let frcsAddr = $("#frcsAddr").val().trim();
    let frcsDaddr = $("#frcsDaddr").val().trim();
    let ctrtNm = $("#ctrtNm").val().trim();
    let ctrtYmd = $("#ctrtYmd").val();
    let ctrtCn = $("#ctrtCn").val().trim();
	let ctrtImg = $("#ctrtImg");
	let ctrtImgType = ctrtImg[0].files[0];
    
    if (empNm === "" || empEmlAddr === "" || empTelno === "" || empZip === "" || empAddr === "" || empDaddr === "" || empPswd === "" || empBrdt === "" || empGen === undefined || empImg.val() === "") {
		Swal.fire({
			title: "모든 가맹점주 회원 정보를 입력하세요.",
			icon: "warning"
		});
        return false;
    }
    
    if (frcsNo === "" || frcsNm === "" || frcsAddr === "" || frcsDaddr === "" || frcsZip === "" || frcsTelno === "" || ftNo === "-1" || ftRgnNm === "-1") {
		Swal.fire({
			title: "모든 가맹점 기본 정보를 입력하세요.",
			icon: "warning"
		});
        return false;
    }
    
    if (ctrtNm === "" || ctrtYmd === "" || ctrtCn === "" || ctrtImg.val() === "") {
		Swal.fire({
			title: "모든 계약 기본 정보를 입력하세요.",
			icon: "warning"
		});
        return false;
    }
    
	if(!empImgType.type.match("image.*")){
		Swal.fire({
			title: "가맹점주 사진 파일은 이미지만 가능합니다.",
			icon: "warning"
		});
		$("#empImg").val("");
    	return false;
   	}
    
    //대괄호들어가면 뷰어 안열림
	let regex = /^[가-힣a-zA-Z0-9\s]+$/;
	if(!regex.test(ctrtNm)){
		Swal.fire({
			title: "계약명에는 특수문자를 사용할 수 없습니다.",
			icon: "warning"
		});
		return false;
	}
    
	if(!ctrtImgType.type.match("pdf")){
		Swal.fire({
			title: "계약서 첨부파일 확장자는 pdf만 가능합니다.",
			icon: "warning"
		});
		$("#ctrtImg").val("");
    	return false;
   	}
    
    return true;
}

// 이미지 미리보기------------------------------------------------
$(document).ready(function(){
    $('#empImg').on('change', handleImg);
});
function handleImg(e){
    let files = e.target.files;
    let fileArr = Array.prototype.slice.call(files);
    fileArr.forEach(function(f){
       if(!f.type.match("image.*")){
          alert("가맹점주 사진 파일은 이미지만 가능합니다.");
          $("#pImg1").html("");
  		  $("#empImg").val("");
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
//---------------------------------------------------------

//사원 인서트
function addEmp(){
	let empNm = $("#empNm").val();
	let empEmlAddr = $("#empEmlAddr").val();
	let empTelno = $("#empTelno").val();
	let empZip = $("#empZip").val();
	let empAddr = $("#empAddr").val();
	let empDaddr = $("#empDaddr").val();
	let empPswd = $("#empPswd").val();
	let empBrdt = $("#empBrdt").val();
	let empGen = $("input[name='empGen']:checked").val();
	let empImg = $("#empImg")[0].files[0];
	
	let empFormData = new FormData();
	
	empFormData.append("empNm",empNm);
	empFormData.append("empEmlAddr",empEmlAddr);
	empFormData.append("empTelno",empTelno);
	empFormData.append("empZip",empZip);
	empFormData.append("empAddr",empAddr);
	empFormData.append("empDaddr",empDaddr);
	empFormData.append("empPswd",empPswd);
	empFormData.append("empBrdt",empBrdt);
	empFormData.append("empGen",empGen);
	empFormData.append("uploadFileOne",empImg);
	
	$.ajax({
		url:"/ctrt/addEmp",
		async:false,
		processData:false,
		contentType:false,
		data:empFormData,
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			if(resp=="fail"){
				console.log("사원저장 실패");
			}else{
				console.log("사원저장");
				frcEmpNo = resp;
			}
		}
	});
}

//가맹점 인서트
function addFrc(){
	let frcsNo = $("#frcsNo").val();
	let frcsNm = $("#frcsNm").val();
	let frcsAddr = $("#frcsAddr").val();
	let frcsDaddr = $("#frcsDaddr").val();
	let frcsZip = $("#frcsZip").val();
	let frcsTelno = $("#frcsTelno").val();
	let ftNo = $("select[name='ftNo'] option:selected").val();
	let ftRgnNm = $("select[name='ftRgnNm'] option:selected").val();
	
	let frcObject = {
		"frcsNo":frcsNo,
		"frcsNm":frcsNm,
		"frcsAddr":frcsAddr,
		"frcsDaddr":frcsDaddr,
		"frcsZip":frcsZip,
		"frcsTelno":frcsTelno,
		"empNo":frcEmpNo,
		"ftNo":ftNo,
		"ftRgnNm":ftRgnNm
	}	
	
	$.ajax({
		url:"/ctrt/addFrc",
		async:false,
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(frcObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			if(resp=="success"){
				console.log("가맹점저장");
			}else{
				console.log("가맹점저장 실패");
			}
		}
	});
}

//계약 인서트
function addCtrt(){
	let ctrtNm = $("#ctrtNm").val();
	let ctrtYmd = $("#ctrtYmd").val();
	let ctrtCn = $("#ctrtCn").val();
	let ctrtImg = $("#ctrtImg")[0].files[0];
	let rfNo = $("select[name='rfNo'] option:selected").val();
	
	let ctrtFormData = new FormData();
	
	ctrtFormData.append("frcsNo",frcsNo);
	ctrtFormData.append("ctrtNm",ctrtNm);
	ctrtFormData.append("ctrtCn",ctrtCn);
	ctrtFormData.append("ctrtYmd",ctrtYmd);
	ctrtFormData.append("rfNo",rfNo);
	ctrtFormData.append("uploadFile",ctrtImg);
	
	$.ajax({
		url:"/ctrt/addCtrt",
		async:false,
		processData:false,
		contentType:false,
		data:ctrtFormData,
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log("resp : "+resp);
			if(resp=="success"){
				Swal.fire({
					title: "신규사원, 신규가맹점, 계약 등록이 완료되었습니다!",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						location.href="/ctrt/list";
					}
				});
			}else{
				Swal.fire({
					title: "등록에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
}

//시연용 데이터 자동입력 버튼
$("#dataInsert").on("click",function(){
	$("#empDaddr").val("수원 달빛 아파트 101호");
	$("#empBrdt").val("1999-03-01");
	$("#empGenM").attr("checked",true);
	$("#frcsNm").val("카페오호 경기 수원 2호점");
	$("#frcsTelno").val("010-1234-5678");
	$("option[value='D102']").attr("selected",true);
	$("option[value='3']").attr("selected",true);
	$("#frcsZip").val("16668");
	$("#frcsAddr").val("경기 수원시 권선구 곡반정로 30-5");
	$("#frcsDaddr").val("수원빌딩 1층");
	$("#ctrtNm").val("카페오호 경기 수원 2호점 신규계약");
	$("#ctrtYmd").val("2024-07-15");
	$("#ctrtCn").val("7월 15일에 진행한 카페오호 경기 수원 2호점 신규 계약입니다. 계약서 첨부파일을 확인하세요.");	
});
</script>