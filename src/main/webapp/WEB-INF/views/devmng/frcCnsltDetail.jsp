<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-dots-fill" viewBox="0 0 16 16">
								<path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353zM5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 1 0-2 1 1 0 0 1 0 2"/>
							</svg>
                        </div>
                        	가맹 상담 관리 - 상세
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
    <div class="row">
        <div class="col-xl-12">
            <!-- 상세 상담 관리 card-->
            <div class="card mb-4">
                <div class="card-header">상세 상담 관리</div>
                <div class="card-body">
                    <form>
                        <!-- Form Row-->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (프랜차이즈 유형)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputFirstName">프랜차이즈 유형</label>
                                <input class="form-control form-control-solid" id="inputFirstName" type="text" placeholder="프랜차이즈 유형" value="${preFrcDetail.frcsTypeVO.ftNm}" readonly="readonly" />
                            </div>
                            <!-- Form Group (진행 상태)-->
                            <div class="col-md-6">
                                <label class="small mb-1">진행 상태✔</label>
                                <input class="form-control" id="stsYNHdn" type="hidden" placeholder="Y/N" value="${preFrcDetail.itvBscInfoVO.ibiPassYn}" required="required" />
								<div class="form-check">
									<input class="form-check-input" id="inputStsN" type="radio" name="inputStsYn" value="N" />
									<label class="form-check-label" for="inputStsN">대기 중</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" id="inputStsY" type="radio" name="inputStsYn" value="Y" />
									<label class="form-check-label" for="inputStsY">상담 완료</label>
								</div>
							</div>
                        </div>
                        <!-- Form Row -->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (신청자명)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputOrgName">신청자명</label>
                                <input class="form-control form-control-solid" id="inputOrgName" type="text" placeholder="신청자명" value="${preFrcDetail.rfNm}" readonly="readonly" />
                            </div>
                            <!-- Form Group (연락처)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputLocation">연락처</label>
                                <input class="form-control form-control-solid" id="inputLocation" type="text" placeholder="010-0000-0000" value="${preFrcDetail.rfTelno}" readonly="readonly" />
                            </div>
                        </div>
                        <!-- Form Row -->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (창업 희망 지역)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputOrgName">창업 희망 지역</label>
                                <input class="form-control form-control-solid" id="inputOrgName" type="text" placeholder="창업 희망 지역" value="${preFrcDetail.comcdCdnm}" readonly="readonly" />
                            </div>
                            <!-- Form Group (이메일)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputLocation">이메일</label>
                                <input class="form-control form-control-solid" id="inputLocation" type="text" placeholder="email@email.com" value="${preFrcDetail.rfEmlAddr}" readonly="readonly" />
                            </div>
                        </div>
                        <!-- Form Row -->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (우편번호)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputOrgName">우편번호</label>
                                <input class="form-control form-control-solid" id="inputOrgName" type="text" placeholder="11111" value="${preFrcDetail.rfZip}" readonly="readonly" />
                            </div>
                            <!-- Form Group (주소)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputLocation">주소</label>
                                <input class="form-control form-control-solid" id="inputLocation" type="text" placeholder="주소" value="${preFrcDetail.rfAddr}" readonly="readonly" />
                            </div>
                        </div>
                        <!-- Form Row -->
                        <div class="mb-3">
                            <!-- Form Group (상세주소)-->
                                <label class="small mb-1" for="inputOrgName">상세주소</label>
                                <input class="form-control form-control-solid" id="inputOrgName" type="text" placeholder="상세 주소" value="${preFrcDetail.rfDaddr}" readonly="readonly" />
                        </div>
                        <!-- Form Group (상담내용)-->
                        <div class="mb-3">
                            <label class="small mb-1" for="inputContents">상담내용✔</label>
                            <textarea class="form-control" id="inputContents" type="text" placeholder="상담내용..." rows="4" maxlength="660">${preFrcDetail.itvBscInfoVO.ibiCon}</textarea>
                        </div>
                        <!-- 버튼 그룹 -->
                        <div class="row">
	                        <div align="left" style="width: 50%">
		                        <button class="btn btn-primary lift" id="submitBtn" type="button">변경 저장</button>
		                        <button class="btn btn-outline-primary lift" type="button" onclick="location='/frcCnslt/list'">목록</button>
	                        </div>
	                        <div align="right" style="width: 50%">
	                        	<button class="btn btn-dark lift" id="cancelBtn" type="button">상담 배정 취소</button>
	                        </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
//화면 로드시 진행상태 자동 체크표시
$(function(){
	let stsYn = $("#stsYNHdn").val();
	if(stsYn=='Y'){
		$("#inputStsY").prop("checked", true);
	}else{
		$("#inputStsN").prop("checked", true);		
	}
})

//변경저장 버튼 클릭
$("#submitBtn").on("click",function(){
	let ibiPassYn = $("input:radio[name='inputStsYn']:checked").eq(0).val();
	let ibiCon = $("#inputContents").val();
	let ibiNo = '${preFrcDetail.itvBscInfoVO.ibiNo}';
	
	//유효성체크
	if(!ibiPassYn){
		Swal.fire({
			title: "진행 상태선택해야 합니다.",
			icon: "warning",
		});
		return;
	}
	
	if(ibiPassYn == 'Y' && !ibiCon){
		Swal.fire({
			title: "상담 내용을 입력해주세요.",
			icon: "warning",
		});
		return;
	}
	
	let itvObject = {
		"ibiNo":ibiNo,
		"ibiPassYn":ibiPassYn,
		"ibiCon":ibiCon
	}
	console.log("itvObject : ",itvObject);
	
	$.ajax({
		url:"/frcCnslt/update",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(itvObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			if(resp=="success"){
				Swal.fire({
					title: "상담 내용이 저장되었습니다.",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						location.href="/frcCnslt/list";
					}
				});
			}else{
				Swal.fire({
					title: "저장 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});

//상담배정취소 버튼 클릭
$("#cancelBtn").on("click",function(){
	Swal.fire({
		title: "상담 배정을 취소하시겠습니까?",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "네",
		cancelButtonText: "아니오"
	}).then((result) => {
		if (result.isConfirmed) {
			let ibiNo = '${preFrcDetail.itvBscInfoVO.ibiNo}';
			
			let itvNoObject = {
				"ibiNo":ibiNo
			}
			console.log("itvNoObject : ",itvNoObject);
			  
			$.ajax({
				url:"/frcCnslt/cancel",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(itvNoObject),
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(resp){
					console.log(resp);
					if(resp=="success"){
					    Swal.fire({
							title: "상담 배정이 정상적으로 취소되었습니다.",
							icon: "success"
					    }).then((result) => {
							if (result.isConfirmed) {
								location.href="/frcCnslt/list";
							}
						});
					}else{
						Swal.fire({
							title: "상담 배정 취소에 실패하였습니다.",
							icon: "error"
		                });
					}
				}
			});
		}
	});
});
</script>