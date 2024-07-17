<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
	                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-text-fill" viewBox="0 0 16 16">
								<path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1M4.5 9a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1zM4 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5m.5 2.5a.5.5 0 0 1 0-1h4a.5.5 0 0 1 0 1z"/>
							</svg>
                        </div>
                        	가맹점 계약 상세
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4">
	<!-- 계약 상세 card -->
	<div class="card mb-4">
		<div class="card-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col" class="table-light">계약명</th>
						<th scope="col" colspan="3" id="ctrtNm">${ctrtVO.ctrtNm}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row" class="table-light">계약 번호</th>
						<td>${ctrtVO.ctrtNo}</td>
						<th class="table-light">계약일</th>
						<td id="ctrtYmd"><fmt:formatDate value="${ctrtVO.ctrtYmd}"
								pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<th scope="row" class="table-light">가맹점주</th>
						<td>${ctrtVO.frcEmpNm}</td>
						<th class="table-light">계약 담당직원</th>
						<td>${ctrtVO.empNm}</td>
					</tr>
					<tr>
						<th scope="row" class="table-light">첨부파일</th>
						<td>
							<span id="ctrtFile">${fn:substringAfter(ctrtVO.attachVO.afNm, '_')}(${ctrtVO.attachVO.afSz}KB)&nbsp;</span>
							<a href="/download/${ctrtVO.ctrtNo}/1" id="downloadBtn" style="color: gray;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-download" viewBox="0 0 16 16">
								  <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
								  <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
								</svg>
							</a>
							<a id="viewerBtn" href="/resources/upload${ctrtVO.attachVO.afNm}" target="_blank" style="color: gray;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-pdf-fill" viewBox="0 0 16 16">
								  <path d="M5.523 12.424q.21-.124.459-.238a8 8 0 0 1-.45.606c-.28.337-.498.516-.635.572l-.035.012a.3.3 0 0 1-.026-.044c-.056-.11-.054-.216.04-.36.106-.165.319-.354.647-.548m2.455-1.647q-.178.037-.356.078a21 21 0 0 0 .5-1.05 12 12 0 0 0 .51.858q-.326.048-.654.114m2.525.939a4 4 0 0 1-.435-.41q.344.007.612.054c.317.057.466.147.518.209a.1.1 0 0 1 .026.064.44.44 0 0 1-.06.2.3.3 0 0 1-.094.124.1.1 0 0 1-.069.015c-.09-.003-.258-.066-.498-.256M8.278 6.97c-.04.244-.108.524-.2.829a5 5 0 0 1-.089-.346c-.076-.353-.087-.63-.046-.822.038-.177.11-.248.196-.283a.5.5 0 0 1 .145-.04c.013.03.028.092.032.198q.008.183-.038.465z"/>
								  <path fill-rule="evenodd" d="M4 0h5.293A1 1 0 0 1 10 .293L13.707 4a1 1 0 0 1 .293.707V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2m5.5 1.5v2a1 1 0 0 0 1 1h2zM4.165 13.668c.09.18.23.343.438.419.207.075.412.04.58-.03.318-.13.635-.436.926-.786.333-.401.683-.927 1.021-1.51a11.7 11.7 0 0 1 1.997-.406c.3.383.61.713.91.95.28.22.603.403.934.417a.86.86 0 0 0 .51-.138c.155-.101.27-.247.354-.416.09-.181.145-.37.138-.563a.84.84 0 0 0-.2-.518c-.226-.27-.596-.4-.96-.465a5.8 5.8 0 0 0-1.335-.05 11 11 0 0 1-.98-1.686c.25-.66.437-1.284.52-1.794.036-.218.055-.426.048-.614a1.24 1.24 0 0 0-.127-.538.7.7 0 0 0-.477-.365c-.202-.043-.41 0-.601.077-.377.15-.576.47-.651.823-.073.34-.04.736.046 1.136.088.406.238.848.43 1.295a20 20 0 0 1-1.062 2.227 7.7 7.7 0 0 0-1.482.645c-.37.22-.699.48-.897.787-.21.326-.275.714-.08 1.103"/>
								</svg>
							</a>
						</td>
						<th class="table-light">프랜차이즈 유형</th>
						<td>${ctrtVO.frcsTypeVO.ftNm}</td>
					</tr>
				</tbody>
			</table>
			<hr/>
			<div id="ctrtCn">
				<h6 style="margin: 50px;">${ctrtVO.ctrtCn}</h6>
			</div>
			<hr/>
		</div>
	</div>
	<!-- 목록 버튼 -->
	<div class="text-center mt-5" id="d1">
		<div class="mb-3">
			<c:if test="${ctrtVO.empNo eq loginEmpNo}">
			<button class="btn btn-success mx-2 px-3" role="button" id="updateBtn">수정</button>
			</c:if>
			<button class="btn btn-dark mx-2 px-3" role="button" onclick="location.href='/ctrt/list'">목록</button>
		</div>
	</div>	
	<!-- 수정모드 버튼 -->
	<div class="text-center mt-5" id="d2" style="display: none">
		<div class="mb-3">
			<button class="btn btn-primary mx-2 px-3" role="button" id="submitBtn">저장</button>
			<button class="btn btn-dark mx-2 px-3" role="button" id="cancelBtn">취소</button>
		</div>
	</div>
</div>
<script type="text/javascript">
let ctrtYmd = $("#ctrtYmd").text();
let ctrtCn = $("#ctrtCn").children().text();
// let ctrtFile = $("#ctrtFile").text();

//수정버튼 클릭
$("#updateBtn").on("click",function(){
	//수정모드로 버튼 전환
	$('#d1').css("display","none");
	$('#d2').css("display","block");
	
	//수정 모드로 바꾸기
	const inputCtrtYmd = document.createElement('input');
	inputCtrtYmd.setAttribute("type", "date");
	inputCtrtYmd.setAttribute("id", "newCtrtYmd");
	inputCtrtYmd.setAttribute("class", "form-control");
	inputCtrtYmd.setAttribute("value", ctrtYmd);
	
	let inputCtrtCn = `<textarea id="newCtrtCn" class="form-control" rows="7">\${ctrtCn}</textarea>`;
	console.log("inputCtrtCn",inputCtrtCn);
	
// 	const inputUploadFile = document.createElement('input');
// 	inputUploadFile.setAttribute("type", "file");
// 	inputUploadFile.setAttribute("id", "newCtrtFile");
// 	inputUploadFile.setAttribute("class", "form-control");
	
// 	$("#ctrtFile").text("");
// 	$("#ctrtFile").prepend(inputUploadFile);
// 	$('#downloadBtn').css("display","none");
// 	$('#viewerBtn').css("display","none");
    
    $("#ctrtYmd").text("");
    $("#ctrtYmd").append(inputCtrtYmd);
    
    $("#ctrtCn").html("");
    $("#ctrtCn").append(inputCtrtCn);
});

//수정취소 버튼 클릭
$("#cancelBtn").on("click",function(){
	//일반모드로 버튼 전환
	$('#d1').css("display","block");
	$('#d2').css("display","none");
	
    $("#ctrtYmd").text(ctrtYmd);
    let orgCtrtCn = `<h6 style="margin: 50px;">\${ctrtCn}</h6>`;
    $("#ctrtCn").html("");
    $("#ctrtCn").append(orgCtrtCn);
//     $("#ctrtFile").text(ctrtFile);
});

//수정저장 버튼 클릭
$("#submitBtn").on("click",function(){
	//일반모드로 버튼 전환
	$('#d1').css("display","block");
	$('#d2').css("display","none");
	
	//아작스 업데이트
	let ctrtNo = "${ctrtVO.ctrtNo}";
	let newCtrtYmd = $("#newCtrtYmd").val();
	let newCtrtCn = $("#newCtrtCn").val();
// 	let newCtrtFile = $("#newCtrtFile").val();
	
	let ctrtObject = {
		"ctrtNo":ctrtNo,
		"ctrtYmd":newCtrtYmd,
		"ctrtCn":newCtrtCn
	}
	console.log("ctrtObject",ctrtObject);
	
	$.ajax({
		url:"/ctrt/updateCtrt",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(ctrtObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			if(resp=="success"){
				Swal.fire({
					title: "계약 내용 수정이 완료되었습니다.",
					icon: "success"
				});
			}else{
				Swal.fire({
					title: "변경 내용 저장에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
	
	//화면에 수정버전으로 보여주기
    $("#ctrtYmd").text(newCtrtYmd);
    let newCtrtCnStr = `<h6 style="margin: 50px;">\${newCtrtCn}</h6>`;
    $("#ctrtCn").html("");
    $("#ctrtCn").append(newCtrtCnStr);
//     $("#ctrtFile").text(newCtrtFile);
    
    //전역변수 값 바꿔주기
    ctrtYmd = newCtrtYmd;
    ctrtCn = newCtrtCn;
//     ctrtFile = newCtrtFile;
});

</script>