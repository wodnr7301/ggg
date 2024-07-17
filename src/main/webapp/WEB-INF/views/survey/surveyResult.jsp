<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ui-checks" viewBox="0 0 16 16">
								<path d="M7 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zM2 1a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm0 8a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2zm.854-3.646a.5.5 0 0 1-.708 0l-1-1a.5.5 0 1 1 .708-.708l.646.647 1.646-1.647a.5.5 0 1 1 .708.708zm0 8a.5.5 0 0 1-.708 0l-1-1a.5.5 0 0 1 .708-.708l.646.647 1.646-1.647a.5.5 0 0 1 .708.708zM7 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5zm0-5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 8a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5"/>
							</svg>
                        </div>
                        	설문 결과 조회
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<!-- <div class="container-xl px-4 mt-4" style="width: 1200px;"> -->
<div class="container-xl px-4 mt-4">
	<div class="card mb-4" style="padding: 15px;">
<!-- 		<div class="card-header"> -->
<!-- 		<div class="row"> -->
<!-- 			<div align="left" style="width: 50%"> -->
<!-- 				새 설문지 만들기 -->
<!-- 			</div> -->
<!-- 			<div align="right" style="width: 50%"> -->
<!-- 				<button class="btn btn-dark btn-sm lift" type="button" id="dataInsert">데이터 자동입력(문항3개까지)</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		</div> -->
		<div class="card-body">
			<div class="row">
				<div align="left" style="width: 50%">
					<h1>${srvyDetail.srvyTtl}</h1>
					<input type="hidden" id="srvyNo" value="${srvyDetail.srvyNo}" />
				</div>
				<div align="right" style="width: 50%">
					<h6 style="color: gray;">설문 기간 : <fmt:formatDate value="${srvyDetail.srvyYmd}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${srvyDetail.srvyEndDate}" pattern="yyyy-MM-dd" /></h6>
				</div>
			</div>
			<br/>
			<div class="row">
				<div align="left" style="width: 50%">
					<h6>전체 참여자:85  참여완료:20   미참여:65</h6>
				</div>
				<div align="right" style="width: 50%">
<!-- 					<h6 style="color: gray;">미참여자에게 알림보내기    설문결과 다운로드(인쇄)</h6> -->
				</div>
			</div>
			<hr/>
			<br/>
			<h6 class="fw-500">1.질문제목</h6>
			<div class="sbp-preview mb-4">
				<div class="sbp-preview-content">
					<div class="mb-3">
						<div class="row">
							<div style="border: 2px solid #c3c3c3; border-radius: 5px; width: auto; padding: 5px;">
								<div class="row">
									<div style="width: auto;">전체 참여자:85명   참여율:20명</div>
									<div class="progress" style="width: 300px; padding: 0px; align-self: center;">
										<div class="progress-bar progress-bar-striped progress-bar-animated bg-info" role="progressbar" style="width: 23%" aria-valuenow="23" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									<div style="width: auto;">23.53%</div>
								</div>
							</div>
							<div style="width: auto;">
								<select class="form-select" aria-label="Default select example" id="qstnSel">
<!-- 									<option id="seloption" selected>문항 선택</option> -->
									<option selected>오호코리아의 전반적인 가맹점 지원에 얼마나 만족하십니까?</option>
									<c:forEach var="qstn" items="${qstnList}" varStatus="stat">
										<option id="${stat.index}" value="${qstn.qmNo}">${qstn.qmTtl}</option>
									</c:forEach>
								</select>
							</div>
			       			<div class="mb-4 row">
					            <div class="card-body" style="width: 50%;">
									<div>
										<canvas id="myChart"></canvas>
									</div>
					            </div>
					            <div class="card-body" style="width: 50%; align-content: center;">
									<div id="resultTableDiv">
<!-- 										<p>결과를 확인할 문항을 선택하세요</p> -->
											<table id="resultTable" class="table table-hover">
												<tr>
													<th>응답</th>
													<th>응답수</th>
												</tr>
												<tr>
													<td>1. 매우 만족</td>
													<td>21.4%</td>
												</tr>
												<tr>
													<td>2. 만족</td>
													<td>15.7%</td>
												</tr>
												<tr>
													<td>3. 보통</td>
													<td>60.3%</td>
												</tr>
												<tr>
													<td>4. 불만족</td>
													<td>2.6%</td>
												</tr>
											</table>
									</div>
					            </div>
					        </div>                 
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="card-body">
			<!-- 버튼 그룹 -->
			<div class="row">
				<div align="left" style="width: 50%">
				</div>
				<div align="right" style="width: 50%">
					<button class="btn btn-outline-dark" type="button" onclick="location.href='/survey/list'">목록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
const ctx = document.querySelector('#myChart').getContext('2d');

const myC = new Chart(ctx, {

	type : 'doughnut', // 파이/도넛
	data : {
		labels: ['1번 문항', '2번 문항', '3번 문항', '4번 문항'],
		datasets: [
			{
				data:[21.4, 15.7, 60.3, 2.6],
				backgroundColor: [
					'rgb(255, 99, 132)',
					'rgb(255, 205, 86)',
					'rgb(75, 192, 192)',
					'rgb(54, 162, 235)'
				],
			}
		]
	},
	options : {
		responsive : true,
		plugins : {
		legend : {
			position : 'top',
			}
		}
	}
});

// $(document).on("change", "#qstnSel", function(){
// 	let qmNo = $(this).find(":selected").val();
// 	let srvyNo = $("#srvyNo").val();
	
// 	let srQsNoObject = {
// 		"srvyNo" : srvyNo,
// 		"qmNo" : qmNo
// 	}
// 	console.log("srQsNoObject : ",srQsNoObject);
	
// 	$.ajax({
// 		url:"/survey/getExp",
// 		contentType:"application/json;charset=utf-8",
// 		data:JSON.stringify(srQsNoObject),
// 		type:"post",
// 		beforeSend:function(xhr){
// 			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
// 		},
// 		success:function(resp){
// 			console.log("resp : ",resp);
			
// 			let text = ``;
// 			text +=	`<table id="resultTable">`;
// 			text +=	`<tr>`;
// 			text +=	`	<th>응답</th>`;
// 			text +=	`	<th>응답수</th>`;
// 			text +=	`</tr>`;
			
// 			$.each(resp, function(i, v){
// 				console.log("i : ",i," v : ",v);
				
// 				text +=	`<tr>
// 							<td>
// 				\${i+1}. \${v.empCn}
// 				</td>`;
// 					if(i==0){
// 					text +=	`<td>21.4%</td>`;
// 					}else if(i==1){
// 					text +=	`<td>15.7%</td>`;
// 					}else if(i==2){
// 					text +=	`<td>60.3%</td>`;
// 					}else{
// 					text +=	`<td>2.6%</td>`;
// 					}
// 				text +=	`</tr>`;
// 			});
// 			text +=	`</table>`;
// 			$("#resultTableDiv").empty();
// 			$("#resultTableDiv").append(text);
// 		}
// 	});
// });
</script>