<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<div class="container-xl px-4 mt-4" style="width: 1200px;">
	<div class="card mb-4">
		<div class="card-header">
		<div class="row">
				<div align="left" style="width: 50%">
					새 설문지 만들기
				</div>
				<div align="right" style="width: 50%">
					<button class="btn btn-dark btn-sm lift" type="button" id="dataInsert">데이터 자동입력(문항3개까지)</button>
				</div>
		</div>
		</div>
		<div class="card-body">
			<h6 class="small text-muted fw-500">설문 정보 작성:</h6>
			<div class="sbp-preview mb-4">
				<div class="sbp-preview-content">
					<div class="mb-3">
						<div class="row">
							<label class="small mb-1" for="srvyTtl" style="width:10%; align-content: center;">설문 제목</label>
							<input class="form-control srvy" id="srvyTtl" type="text" placeholder="설문 제목" style="width:90%;" />
						</div>
					</div>
					<div class="mb-3">
						<div class="row">
							<label class="small mb-1" for="srvyYmd" style="width:10%; align-content: center;">설문 기간</label>
							<input class="form-control srvy" id="srvyYmd" type="date" style="width: 20%;" />&nbsp;<span style="width:auto; align-content: center;">~</span>&nbsp;
							<input class="form-control srvy" id="srvyEndDate" type="date" style="width: 20%;" />
						</div>
					</div>
					<div class="mb-3">
						<div class="row">
							<label class="small mb-1" for="srvyTrgt" style="width:10%; align-content: center;">설문 대상자</label>
		                    <div class="form-check" style="width:12%;">
								<input class="form-check-input" id="emp" type="radio" name="srvyTrgt" value="1" />
							    <label class="form-check-label" for="emp">본사 직원</label>
							</div>
							<div class="form-check" style="width:12%;">
							    <input class="form-check-input" id="empFrc" type="radio" name="srvyTrgt" value="2" />
							    <label class="form-check-label" for="empFrc">가맹점주</label>
							</div>
						</div>
					</div>
					<div class="mb-3">
						<div class="row">
							<label class="small mb-1" for="" style="width:10%; align-content: center;">설문 내용</label>
							<textarea class="form-control srvy" id="srvyCn" style="width:90%;" placeholder="설문 내용" rows="5"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h6 class="small text-muted fw-500">문항 작성:</h6>
			<div class="sbp-preview mb-4" id="setOutline">
				<div class="sbp-preview-content">
					<div>
						<div class="mb-3">
							<div class="row">
								<label class="small mb-1" for="qmTtl1" style="width:10%; align-content: center;">질문</label>
								<input class="form-control srvy" id="qmTtl1" type="text" placeholder="질문" style="width:90%;" />
							</div>
						</div>
						<div class="mb-3">
							<div class="row">
								<div style="width:10%;">
									<label class="small mb-1" for="empCn1" style="align-content: center;">보기</label>
								</div>
								<div style="width:90%;">
									<div class="form-check">
										<input class="form-check-input" type="radio" disabled />
										<input class="form-control srvy" id="empCn1_1" type="text" style="width:500px;" />
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" disabled />
										<input class="form-control srvy" id="empCn2_1" type="text" style="width:500px;" />
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" disabled />
										<input class="form-control srvy" id="empCn3_1" type="text" style="width:500px;" />
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" disabled />
										<input class="form-control srvy" id="empCn4_1" type="text" style="width:500px;" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 버튼 그룹 -->
			<div class="row">
				<div align="left" style="width: 50%">
					<button class="btn btn-dark btn-icon" type="button" id="plusQ"><span style="font-weight: bolder;">+</span></button>
				</div>
				<div align="right" style="width: 50%">
					<button class="btn btn-primary" type="button" id="submitBtn">완료</button>
					<button class="btn btn-outline-dark" type="button" onclick="location.href='/survey/list'">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
let cnt = 1;

$("#plusQ").on("click",function(){
	cnt += 1;
	
	let set = ``;
	set += `<div class="sbp-preview-content">`;
	set += `<div>`;
	set += `		<div class="mb-3">`;
	set += `			<div class="row">`;
	set += `				<label class="small mb-1" for="qmTtl`;
	set += cnt;
	set += `" style="width:10%; align-content: center;">질문</label>`;
	set += `				<input class="form-control srvy" id="qmTtl`;
	set += cnt;
	set += `" type="text" placeholder="질문" style="width:90%;" />`;
	set += `			</div>`;
	set += `		</div>`;
	set += `		<div class="mb-3">`;
	set += `			<div class="row">`;
	set += `				<div style="width:10%;">`;
	set += `					<label class="small mb-1" for="empCn1" style="align-content: center;">보기</label>`;
	set += `				</div>`;
	set += `				<div style="width:90%;">`;
	set += `					<div class="form-check">`;
	set += `						<input class="form-check-input" type="radio" disabled />`;
	set += `						<input class="form-control srvy" type="text" style="width:500px;" id="empCn1_`;
	set += cnt;
	set += `" />`;
	set += `					</div>`;
	set += `					<div class="form-check">`;
	set += `						<input class="form-check-input" type="radio" disabled />`;
	set += `						<input class="form-control srvy" type="text" style="width:500px;" id="empCn2_`;
	set += cnt;
	set += `" />`;
	set += `					</div>`;
	set += `					<div class="form-check">`;
	set += `						<input class="form-check-input" type="radio" disabled />`;
	set += `						<input class="form-control srvy" type="text" style="width:500px;" id="empCn3_`;
	set += cnt;
	set += `" />`;
	set += `					</div>`;
	set += `					<div class="form-check">`;
	set += `						<input class="form-check-input" type="radio" disabled />`;
	set += `						<input class="form-control srvy" type="text" style="width:500px;" id="empCn4_`;
	set += cnt;
	set += `" />`;
	set += `					</div>`;
	set += `				</div>`;
	set += `			</div>`;
	set += `		</div>`;
	set += `</div>`;
	set += `</div>`;
	
	$("#setOutline").append(set);
});

$("#submitBtn").on("click",function(){
	
	let srvyTtl = $("#srvyTtl").val();
	let srvyYmd = $("#srvyYmd").val();
	let srvyEndDate = $("#srvyEndDate").val();
	let srvyTrgt = $("input[name='srvyTrgt']:checked").val();
	let srvyCn = $("#srvyCn").val();
	
	let qmTtl = "";
	let empCn1 = "";
	let empCn2 = "";
	let empCn3 = "";
	let empCn4 = "";
	
	let qstnMcList = [];
	let qstnMc;
	
	for (var i = 1; i <= cnt; i++) {
		qmTtl = $("#qmTtl"+i).val();
		
		empCn1 = $("#empCn1_"+i).val();
		empCn2 = $("#empCn2_"+i).val();
		empCn3 = $("#empCn3_"+i).val();
		empCn4 = $("#empCn4_"+i).val();
		
		qstnMc = {
			"qmTtl" : qmTtl,
			"exampleList" : [
				{"empCn" : empCn1},
				{"empCn" : empCn2},
				{"empCn" : empCn3},
				{"empCn" : empCn4}
		]};
		
		qstnMcList.push(qstnMc);
	}
	
	//유효성 체크
	let isCheck = validationCheck();
	if(isCheck==false){
		Swal.fire({
			title: "모든 입력값을 채워주세요.",
			icon: "warning"
		});
		return;
	};
	
	if(srvyYmd>srvyEndDate){
		Swal.fire({
			title: "설문 종료일은 설문 시작일 이후 날짜여야 합니다.",
			icon: "warning"
		});
		return;
	}
	
	let srvyObject = {
		"srvyTtl" : srvyTtl,
		"srvyYmd" : srvyYmd,
		"srvyEndDate" : srvyEndDate,
		"srvyTrgt" : srvyTrgt,
		"srvyCn" : srvyCn,
		"qstnMcList" : qstnMcList
	}
	console.log("srvyObject : ",srvyObject);
	
	$.ajax({
		url:"/survey/add",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(srvyObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log("resp : "+resp);
			if(resp=="success"){
				Swal.fire({
					title: "새 설문 등록이 완료되었습니다!",
					icon: "success"
				}).then((result) => {
					if (result.isConfirmed) {
						location.href="/survey/list";
					}
				});
			}else{
				Swal.fire({
					title: "설문 등록에 실패하였습니다.",
					icon: "error"
				});
			}
		}
	});
});

//유효성 체크
function validationCheck() {
	const srvyInputs = document.querySelectorAll("input[class='form-control srvy']");
	const dates = document.querySelectorAll("input[type='date']");
	let valid = true;
	
	srvyInputs.forEach(srvy => {
		if (!srvy.value.trim()) {
			valid = false;
		}
	});
	
	dates.forEach(date => {
		if (!date.value.trim()) {
			valid = false;
		}
	});
	
	if (!$("#srvyCn").val().trim()) {
		valid = false;
	}
	
	if ($("input[name='srvyTrgt']:checked").val() === undefined) {
	    valid = false;
	}
	
	return valid;
}

//시연용 데이터 자동입력 버튼
$("#dataInsert").on("click",function(){
	$("#srvyTtl").val("오호코리아 직원 하계 워크샵 설문조사");
	$("#emp").attr("checked",true);
	$("#srvyYmd").val("2024-07-16");
	$("#srvyEndDate").val("2024-07-30");
	$("#srvyCn").val("오호코리아 직원 하계 워크샵 설문조사를 실시합니다.\r\n모든 직원 여러분께서는 꼭 기간 안에 설문을 완료하시길 바랍니다.\r\n감사합니다.");
	$("#qmTtl").val("04766");
	$("#empCn").val("서울 성동구 서울숲길 17");
	
	$("#qmTtl1").val("워크샵 장소");
	$("#empCn1_1").val("대전컨벤션센터");
	$("#empCn2_1").val("롯데시티호텔");
	$("#empCn3_1").val("KT&G 상상마당");
	$("#empCn4_1").val("대전 유성 호텔");
	
	$("#qmTtl2").val("워크샵 날짜");
	$("#empCn1_2").val("7월 22일 월요일");
	$("#empCn2_2").val("8월 9일 금요일");
	$("#empCn3_2").val("8월 19일 월요일");
	$("#empCn4_2").val("8월 23일 금요일");
	
	$("#qmTtl3").val("즐거운 워크샵~");
	$("#empCn1_3").val("정말 즐거워요!");
	$("#empCn2_3").val("그냥 저냥 이에요");
	$("#empCn3_3").val("사실 가고싶지 않아요");
	$("#empCn4_3").val("아파서 못가요");
});
</script>