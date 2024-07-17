<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
div#layoutSidenav_content:has(div.container-xl) {
	background-image: linear-gradient(135deg, #8a9be7 0%, #9d7bbf 100%);
}

.btn-bd-primary {
  --bs-btn-font-weight: 600;
  --bs-btn-color: white;
  --bs-btn-bg: #8a9be7;
  --bs-btn-border-color: #8a9be7;
  --bs-btn-border-radius: .5rem;
  --bs-btn-hover-color: white;
  --bs-btn-hover-bg: #9d7bbf;
  --bs-btn-hover-border-color: #9d7bbf;
}
</style>
<div class="container-xl px-4">
    <div class="row justify-content-center">
        <div class="col-xl-8 col-lg-9">
            <div class="card my-5">
                <div class="card-body p-5 text-center">
                    <div class="h3 mb-4" style="font-weight: bold;">${srvy.srvyTtl}</div>
                    <div class="small text-muted mb-2">${srvy.srvyCn}</div>
                </div>
                <hr class="my-0" />
                <div class="card-body" style="padding: 3em; padding-left: 4em;">
               		<input type="hidden" id="qstnLength" value="${fn:length(srvy.qstnMcList)}">
                	<c:forEach var="qstn" items="${srvy.qstnMcList}" varStatus="stat">
                        <div style="margin-bottom: 4em;">
                            <h4 class="text-gray-800 mb-3" for="qstnGroup${qstn.qmNo}">${stat.index+1}. ${qstn.qmTtl}</h4>
                            <c:forEach var="exp" items="${qstn.exampleList}" varStatus="stat2">
			                    <div class="form-check" style="margin: 5px; margin-left: 15px;">
								    <input class="form-check-input exp${stat2.index+1}" id="${exp.expNo}" type="radio" name="qstnGroup${qstn.qmNo}" value="${exp.expNo}">
								    <label class="form-check-label" for="${exp.expNo}">${exp.empCn}</label>
								</div>
							</c:forEach>
                        </div>
                    </c:forEach>
                </div>
                <hr class="my-0" />
                <div class="card-body px-5 py-4">
                    <div class="small text-center">
						<button class="btn btn-bd-primary" id="submitBtn">제출</button>
						<button class="btn btn-bd-primary" id="dataInsert">데이터 자동생성</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
let qstnLength = $("#qstnLength").val();

//유효성 체크
function validationCheck() {
	let cnt = $(".form-check-input:checked").length;
	let valid = true;
	
	console.log(qstnLength,",",cnt);
	if (qstnLength != cnt) {
	    valid = false;
	}
	
	return valid;
}

//제출 버튼 클릭
$("#submitBtn").on("click",function(){
	//유효성 체크
	let isCheck = validationCheck();
	if(isCheck==false){
		Swal.fire({
			title: "모든 문항을 체크해주세요.",
			icon: "warning"
		});
		return;
	};
	
	Swal.fire({
		title: "설문을 제출하시겠습니까?",
		text: "제출하면 취소할 수 없습니다",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "제출",
		cancelButtonText: "취소"
	}).then((result) => {
		if (result.isConfirmed) {
			let checkInputs = $(".form-check-input:checked");
			console.log("checkInputs",checkInputs);
			
			let expNo = "";
			let sbmSrvyObject = [];
			
			for (var i = 0; i < qstnLength; i++) {
				expNo = checkInputs.eq(i).val();
				sbmSrvyObject.push({"expNo":expNo});
			}	
			console.log("sbmSrvyObject : ",sbmSrvyObject);
			
			$.ajax({
				url:"/survey/submit",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(sbmSrvyObject),
				type:"post",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(resp){
					console.log("resp : "+resp);
					if(resp=="success"){
						Swal.fire({
							title: "설문에 참여해주셔서 감사합니다",
							icon: "success"
						}).then((result) => {
							if (result.isConfirmed) {
								location.href="/dashboard/home";
							}
						});
					}else{
						Swal.fire({
							title: "작업에 실패하였습니다.",
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
	let selRadio = "";
	for (var i = 1; i <= qstnLength; i++) {
		$("input[class='form-check-input exp"+(i*4)+"']").attr("checked",true);
	}
});
</script>