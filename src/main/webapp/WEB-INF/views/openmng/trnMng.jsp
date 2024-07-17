<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#trnMngTable td:nth-child(1), td:nth-child(6){
	text-align: center;
	width: 9%;
}

#trnMngTable td:nth-child(3), td:nth-child(5){
	width: 11%;
}

#trnMngTable td:nth-child(4){
	width: 15%;
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
	                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-book" viewBox="0 0 16 16">
							  <path d="M1 2.828c.885-.37 2.154-.769 3.388-.893 1.33-.134 2.458.063 3.112.752v9.746c-.935-.53-2.12-.603-3.213-.493-1.18.12-2.37.461-3.287.811zm7.5-.141c.654-.689 1.782-.886 3.112-.752 1.234.124 2.503.523 3.388.893v9.923c-.918-.35-2.107-.692-3.287-.81-1.094-.111-2.278-.039-3.213.492zM8 1.783C7.015.936 5.587.81 4.287.94c-1.514.153-3.042.672-3.994 1.105A.5.5 0 0 0 0 2.5v11a.5.5 0 0 0 .707.455c.882-.4 2.303-.881 3.68-1.02 1.409-.142 2.59.087 3.223.877a.5.5 0 0 0 .78 0c.633-.79 1.814-1.019 3.222-.877 1.378.139 2.8.62 3.681 1.02A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.293-.455c-.952-.433-2.48-.952-3.994-1.105C10.413.809 8.985.936 8 1.783"/>
							</svg>
                        </div>
                        	교육 프로그램 관리
                    </h1>
                </div>
                <div class="col-12 col-xl-auto mb-3">
                    <button class="btn btn-sm btn-light text-primary" type="button" data-bs-toggle="modal" data-bs-target="#createGroupModal">
                        <i class="me-1" data-feather="plus"></i>
                        	교육 프로그램 등록
                    </button>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<!-- 개점 관리 페이지 탭 -->
<nav class="nav nav-borders">
    <a class="nav-link ms-0 active" href="/trnMng/list">교육 프로그램 관리</a>
    <a class="nav-link ms-0" href="/trnPrgrs/list">교육 이수 현황</a>
</nav>
<hr class="mt-0 mb-4" />
<pre>교육 참여자 : 해당 교육 참여 완료한 수 입니다.</pre>
    <div class="card">
        <div class="card-body">
            <table id="trnMngTable">
                <thead>
                    <tr>
                        <th>구분</th>
                        <th>프로그램명</th>
                        <th>소요시간</th>
                        <th>장소</th>
                        <th>교육 참여자</th>
                        <th>수정 | 삭제</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="prgrm" items="${ednPrgrmList}" varStatus="stat">
                    <tr>
                        <td><span style="color:
		<c:if test="${prgrm.epEsntlYn eq 'Y'}">red</c:if>
		<c:if test="${prgrm.epEsntlYn eq 'N'}">blue</c:if>
                        							;">
                        	<c:if test="${prgrm.epEsntlYn eq 'Y'}">필수</c:if>
                        	<c:if test="${prgrm.epEsntlYn eq 'N'}">선택</c:if>
                        </span></td>
                        <td>${prgrm.epNm}</td>
                        <td>${prgrm.epTm}시간</td>
                        <td>${prgrm.epPlcNm}</td>
                        <td>${prgrm.epEcYCnt}명</td>
                        <td>
                            <button class="btn btn-datatable btn-icon btn-transparent-dark me-2" id="editBtn" type="button" data-bs-toggle="modal" data-bs-target="#editGroupModal" data-epno="${prgrm.epNo}" data-epnm1="${prgrm.epNm1}" data-epnm2="${prgrm.epNm2}" data-eptm="${prgrm.epTm}" data-epplcnm="${prgrm.epPlcNm}" data-epesntlyn="${prgrm.epEsntlYn}"><i data-feather="edit"></i></button>
                            <a class="btn btn-datatable btn-icon btn-transparent-dark" id="delBtn" href="#!" data-epno="${prgrm.epNo}"><i data-feather="trash-2"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- 등록 모달 -->
<div class="modal fade" id="createGroupModal" tabindex="-1" role="dialog" aria-labelledby="createGroupModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createGroupModalLabel">신규 교육 프로그램 등록</h5>
                <button class="btn-close closeBtn" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-0">
                        <div class="row">
	                        <label class="mb-1 small text-muted" for="newEpNm1">프로그램명</label>
	                        <div class="col-sm-5">
	                        	<input class="form-control" id="newEpNm1" type="text" placeholder="ex) 개인정보보호" />
	                        </div>
	                        <div class="col-sm-2 text-muted" style="padding: 10px;">
	                        	<p>교육</p>
	                        </div>
	                        <div class="col-sm-3">
	                        	<input class="form-control" id="newEpNm2" type="number" placeholder="ex) 1" />
	                        </div>
	                        <div class="col-sm-1 text-muted" style="padding: 10px;">
	                        	<p>차</p>
	                        </div>
                        </div>
                    </div>
                    <div class="mb-0">
                        <label class="mb-1 small text-muted" for="newEpPlcNm">장소</label>
                        <input class="form-control" id="newEpPlcNm" type="text" placeholder="ex) 오호코리아 교육센터" />
                    </div>
                    <div class="mb-0">
                    	<div class="row">
	                        <div class="col-sm-5">
	                        	<label class="mb-1 small text-muted" for="newEpTm">소요시간 (단위:시)</label>
	                        	<input class="form-control" id="newEpTm" type="number" placeholder="ex) 3" />
							</div>
	                        <div class="col-sm-5">
	                        	<label class="mb-1 small text-muted" for="newEpEsntlYn">구분</label>
		                    	<div class="row">
		                        	<div class="form-check">
			                        	<input class="form-check-input" id="newEpEsntlY" name="newEpEsntlYn" value="Y" type="radio" />
			                        	<label class="form-check-label" for="newEpEsntlY">필수</label>
		                        	</div>
		                        	<div class="form-check">
			                        	<input class="form-check-input" id="newEpEsntlN" name="newEpEsntlYn" value="N" type="radio" />
			                        	<label class="form-check-label" for="newEpEsntlN">선택</label>
		                        	</div>
	                        	</div>
	                        </div>
	                    </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-dark btn-sm lift" type="button" id="dataInsert">데이터 자동입력</button>
                <button class="btn btn-primary-soft text-primary" id="addBtn" type="button">등록</button>
                <button class="btn btn-danger-soft text-danger closeBtn" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- 수정 모달 -->
<div class="modal fade" id="editGroupModal" tabindex="-1" role="dialog" aria-labelledby="editGroupModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editGroupModalLabel">교육 프로그램 수정</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-0">
                    	<div class="row">
	                        <label class="mb-1 small text-muted" for="epNm1">프로그램명</label>
	                        <div class="col-sm-5">
	                        	<input class="form-control" id="epNm1" type="text" placeholder="ex) 개인정보보호" />
	                        </div>
	                        <div class="col-sm-2 text-muted" style="padding: 10px;">
	                        	<p>교육</p>
	                        </div>
	                        <div class="col-sm-3">
	                        	<input class="form-control" id="epNm2" type="number" placeholder="ex) 1" />
	                        </div>
	                        <div class="col-sm-1 text-muted" style="padding: 10px;">
	                        	<p>차</p>
	                        </div>
                        </div>
                    </div>
                    <div class="mb-0">
                        <label class="mb-1 small text-muted" for="epPlcNm">장소</label>
                        <input class="form-control" id="epPlcNm" type="text" placeholder="ex) 오호코리아 교육센터" />
                    </div>
                    <div class="mb-0">
                    	<div class="row">
	                        <div class="col-sm-5">
	                        	<label class="mb-1 small text-muted" for="epTm">소요시간 (단위:시)</label>
	                        	<input class="form-control" id="epTm" type="number" placeholder="ex) 3" />
							</div>
	                        <div class="col-sm-5">
	                        	<label class="mb-1 small text-muted" for="epEsntlYn">구분</label>
		                    	<div class="row">
		                        	<div class="form-check">
			                        	<input class="form-check-input" id="epEsntlY" name="epEsntlYn" value="Y" type="radio" />
			                        	<label class="form-check-label" for="epEsntlY">필수</label>
		                        	</div>
		                        	<div class="form-check">
			                        	<input class="form-check-input" id="epEsntlN" name="epEsntlYn" value="N" type="radio" />
			                        	<label class="form-check-label" for="epEsntlN">선택</label>
		                        	</div>
	                        	</div>
	                        </div>
	                    </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary-soft text-primary" id="udtBtn" type="button">수정</button>
                <button class="btn btn-danger-soft text-danger" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$(function(){
	const trnMngTable = document.getElementById('trnMngTable');
	if (trnMngTable) {
		new simpleDatatables.DataTable(trnMngTable, {
			perPage : 10,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "진행중인 가맹점 교육이 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
});

//수정아이콘 클릭시 프로그램번호 저장용
let clkEpNo;

//등록모달 닫을 때 값 초기화
$('#createGroupModal').on('hidden.bs.modal', function () {
    $(this).find('input').val('');
    $(this).find('input').prop("checked", false);
});

//등록버튼
$("#addBtn").on("click",function(){	
	let newEpNm1 = $("#newEpNm1").val();
	let newEpNm2 = $("#newEpNm2").val();
	let newEpTm = $("#newEpTm").val();
	let newEpPlcNm = $("#newEpPlcNm").val();
	let newEpEsntlYn = $("input:radio[name=newEpEsntlYn]:checked").val();
	
	//유효성체크
	if(!newEpNm1){
	    Swal.fire({
	        title: "프로그램명은 반드시 입력해야 합니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#newEpNm1").focus();
	        }
	    });
	    return;
	}

	if(!newEpNm2){
	    Swal.fire({
	        title: "교육 차수는 반드시 입력해야 하며 숫자만 입력해야 합니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#newEpNm2").focus();
	        }
	    });
	    return;
	}

	if(newEpNm2 < 1){
	    Swal.fire({
	        title: "교육 차수는 1차부터 입니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#newEpNm2").focus();
	        }
	    });
	    return;
	}

	if(!newEpTm){
	    Swal.fire({
	        title: "소요시간은 반드시 입력해야 하며 숫자만 입력해야 합니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#newEpTm").focus();
	        }
	    });
	    return;
	}

	if(newEpTm < 1){
	    Swal.fire({
	        title: "소요시간은 최소 1시간이어야 합니다.",
	        icon: "warning",
	        didClose: () => {
	            $("#newEpTm").focus();
	        }
	    });
	    return;
	}
	
	if (newEpEsntlYn === undefined) {
	    Swal.fire({
	        title: "필수여부는 반드시 선택해야 합니다.",
	        icon: "warning"
	    });
	    return;
	}
	
	let newEpNm = newEpNm1 + " 교육-" + newEpNm2 + "차";
	
	let addPgmObject = {
		"epNm":newEpNm,
		"epTm":newEpTm,
		"epPlcNm":newEpPlcNm,
		"epEsntlYn":newEpEsntlYn
	};
	console.log("addPgmObject : ",addPgmObject);
	
	$.ajax({
		url:"/trnMng/add",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(addPgmObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			if(resp=="success"){
				Swal.fire({
					title: "새 교육프로그램이 성공적으로 등록되었습니다.",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						$("#createGroupModal").modal('hide');
						location.href="/trnMng/list";
					}
				});
			}else{
				Swal.fire({
					title: "교육프로그램 등록에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});

//수정아이콘
$(document).on("click", "#editBtn", function(){
	clkEpNo = $(this).data("epno");
    let epNm1 = $(this).data("epnm1").slice(0,-3);
    let epNm2 = $(this).data("epnm2").slice(0,-1);
    let epTm = $(this).data("eptm");
    let epPlcNm = $(this).data("epplcnm");
    let epEsntlYn = $(this).data("epesntlyn");
    
    $("#epNm1").val(epNm1);
    $("#epNm2").val(epNm2);
    $("#epTm").val(epTm);
    $("#epPlcNm").val(epPlcNm);
	if(epEsntlYn=='Y'){
		$("#epEsntlY").prop("checked", true);
	}else{
		$("#epEsntlN").prop("checked", true);		
	}
});

//수정버튼
$("#udtBtn").on("click",function(){
    let udtEpNm1 = $("#epNm1").val();
    let udtEpNm2 = $("#epNm2").val();
	let udtEpNm = udtEpNm1 + " 교육-" + udtEpNm2 + "차";
    let udtEpTm = $("#epTm").val();
    let udtEpPlcNm = $("#epPlcNm").val();
	let udtEpEsntlYn = $("input:radio[name=epEsntlYn]:checked").val();
    
	//유효성체크
    if(!udtEpNm1){
        Swal.fire({
            title: "프로그램명은 반드시 입력해야 합니다.",
            icon: "warning",
            didClose: () => {
                $("#epNm1").focus();
            }
        });
        return;
    }

    if(!udtEpNm2){
        Swal.fire({
            title: "교육 차수는 반드시 입력해야 하며 숫자만 입력해야 합니다.",
            icon: "warning",
            didClose: () => {
                $("#epNm2").focus();
            }
        });
        return;
    }

    if(udtEpNm2 < 1){
        Swal.fire({
            title: "교육 차수는 1차부터 입니다.",
            icon: "warning",
            didClose: () => {
                $("#epNm2").focus();
            }
        });
        return;
    }

    if(!udtEpTm){
        Swal.fire({
            title: "소요시간은 반드시 입력해야 하며 숫자만 입력해야 합니다.",
            icon: "warning",
            didClose: () => {
                $("#epTm").focus();
            }
        });
        return;
    }

    if(udtEpTm < 1){
        Swal.fire({
            title: "소요시간은 최소 1시간이어야 합니다.",
            icon: "warning",
            didClose: () => {
                $("#epTm").focus();
            }
        });
        return;
    }
    
	if (udtEpEsntlYn === undefined) {
	    Swal.fire({
	        title: "필수여부는 반드시 선택해야 합니다.",
	        icon: "warning"
	    });
	    return;
	}
    
	let udtEpObject = {
		"epNo":clkEpNo,
		"epNm":udtEpNm,
		"epTm":udtEpTm,
		"epPlcNm":udtEpPlcNm,
		"epEsntlYn":udtEpEsntlYn
	}
    console.log("udtEpObject : ", udtEpObject);
	
	$.ajax({
		url:"/trnMng/update",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(udtEpObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			if(resp=="success"){
				Swal.fire({
					title: "프로그램 정보가 수정되었습니다.",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						$("#editGroupModal").modal('hide');
						location.href="/trnMng/list";
					}
				});
			}else{
				Swal.fire({
					title: "정보 수정에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});

//삭제버튼
$(document).on("click", "#delBtn", function(){
	let epNo = $(this).data("epno");
    console.log("클릭된 epNo: ", epNo);
    
	Swal.fire({
		title: "정말 삭제하시겠습니까?",
		text: "삭제하면 복구할 수 없습니다",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "네",
		cancelButtonText: "아니오"
	}).then((result) => {
		if (result.isConfirmed) {
			let epNoObject = {
				"epNo":epNo
			}
			
			$.ajax({
				url:"/trnMng/delete",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(epNoObject),
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(resp){
					console.log(resp);
					if(resp=="success"){
					    Swal.fire({
							title: "프로그램이 삭제되었습니다.",
							icon: "success"
					    }).then((result) => {
							if (result.isConfirmed) {
								location.href="/trnMng/list";
							}
						});
					}else{
						Swal.fire({
							title: "삭제에 실패하였습니다.",
							icon: "error"
		                });
					}
				}
			});
		}
	});
});

//시연용 데이터 자동입력 버튼
$("#dataInsert").on("click",function(){
	$("#newEpNm1").val("창업가 정신 신규");
	$("#newEpNm2").val("1");
	$("#newEpPlcNm").val("대덕 교육 센터");
	$("#newEpTm").val("5");
	$("#newEpEsntlN").attr("checked",true);
});
</script>