<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>주간 매출 현황</title>
<!--  
<script type="text/javascript">
$(function(){
	$(".clsEmpNo").on("click", function(){
		console.log("clsEmpNo에 왔다");
		
		// data-emp-no="A014"
		// this: 동일 클래스 속성의 오브젝트 배열 중에서 클릭한 바로 그 오브젝트
		let empNo = $(this).data("empNo");
		console.log("empNo: " + empNo);
		
		//JSON
		let data = {
				"empNo": empNo
		};
		
		console.log("data: ", data);
		
		/* 	요청 URI: /employee/detailAjax
			요청 파라미터: (JSON.stringify): {"empNo": "A013"}
			요청 방식: Post
		*/
		$.ajax({
			url: "/employee/detailAjax",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(data),
			type: "post",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log("result: ", result);

				$("input[name='empNo']").val(result.empNo);
				$("input[name='empName']").val(result.empName);
				$("input[name='empAddress']").val(result.empAddress);
				$("input[name='empTelno']").val(result.empTelno);
				$("input[name='empSalary']").val(result.empSalary);
				$("img[name='filename']").attr("src", "/resources/upload" + result.filename);
				
			},
			error:function(request,status,error){
				console.log("request", request);
				console.log("status", status);
				console.log("error", error);
			}
		});
	});
</script>
-->
<style>
.bigTable {
  background-color: white; /* 배경색을 하얀색으로 설정 */
  width: 80%; /* 너비를 80%로 설정, 필요에 따라 조절 가능 */
  margin: 0 auto; /* 화면의 중심에 위치하도록 설정 */
  margin-top: -90px;
  padding: 20px; /* 테이블 주위에 패딩 추가 */
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 테이블에 그림자 효과 추가 */
  border-radius: 10px; /* 테이블 모서리를 둥글게 설정 */
}

.topTable {
  display: flex; /* Flexbox로 설정 */
  justify-content: space-between; /* 좌우로 정렬 */
  align-items: center; /* 중앙 정렬 */
}

.table {
  width: 100%; /* 테이블 너비를 부모 요소에 맞게 설정 */
  border-collapse: collapse; /* 테이블 경계선이 겹치지 않도록 설정 */
}

.table th, .table td {
  padding: 8px; /* 셀 내부 여백 설정 */
  text-align: left; /* 셀 내용 왼쪽 정렬 */
  border: 1px solid #ddd; /* 셀 경계선 설정 */
}

.table thead {
  background-color: #f9f9f9; /* 테이블 헤더 배경색 설정 */
}

.table-hover tbody tr:hover {
  background-color: #f1f1f1; /* 행에 마우스를 올렸을 때 배경색 변경 */
}
</style>
</head>
<body>
<main>
	<header
	class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
		<div class="container-xl px-4">
			<div class="page-header-content pt-4">
				<div class="row align-items-center justify-content-between">
					<div class="col-auto mt-4">
						<h1 class="page-header-title">
							<div class="page-header-icon">
								<i data-feather="bar-chart"></i>
							</div>
							주간 매출 현황 / bbq 대전 목동점
						</h1>
						<div class="page-header-subtitle">OHO KOREA FRANCHISE MANAGEMENT</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div class="bigTable">
		<div class="topTable">
	  		<a href="revenue" style="color: #2E9AFE; font-size: 14px;"> 매출관리 > </a><br /><br />
			<div class="dropdown">
					<button class="btn btn-gray btn-sm dropdown-toggle" type="button"
						data-bs-toggle="dropdown" aria-expanded="false">매출현황 월별</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">1월</a></li>
						<li><a class="dropdown-item" href="#">2월</a></li>
						<li><a class="dropdown-item" href="#">3월</a></li>
						<li><a class="dropdown-item" href="#">4월</a></li>
						<li><a class="dropdown-item" href="#">5월</a></li>
						<li><a class="dropdown-item" href="#">6월</a></li>
						<li><a class="dropdown-item" href="#">7월</a></li>
						<li><a class="dropdown-item" href="#">8월</a></li>
						<li><a class="dropdown-item" href="#">9월</a></li>
						<li><a class="dropdown-item" href="#">10월</a></li>
						<li><a class="dropdown-item" href="#">11월</a></li>
						<li><a class="dropdown-item" href="#">12월</a></li>
					</ul>
			 </div>
		</div><hr />
		<table class="table table-striped table-hover table-bordered table-sm">
	    <thead class="table-light">
	      <tr>
	        <th scope="col">#</th>
	        <th scope="col">수익(매출액)</th>
	        <th scope="col">매출원가</th>
	        <th scope="col">매출 총 이익</th>
	        <th scope="col">영업 이익</th>
	        <th scope="col">인건비</th>
	        <th scope="col">관리비</th>
	        <th scope="col">판매비</th>
	        <th scope="col">작성일</th>
	        <th scope="col">수정일</th>
	        <th scope="col">작성년도</th>
	        <th scope="col">작성분기</th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
	        <th scope="row">1월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">2월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">3월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">4월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">5월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">6월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">7월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">8월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">9월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">10월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">11월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	      <tr>
	        <th scope="row">12월</th>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>10,000,000</td>
	        <td>06-05</td>
	        <td>06-07</td>
	        <td>2024</td>
	        <td>2분기</td>
	      </tr>
	    </tbody>
	  </table>
	  <div class="d-grid gap-2 d-md-flex justify-content-md-end">
		  <button class="btn btn-primary btn-sm lift" type="button">매출 등록</button>
	  </div>
	</div>
</main>
</body>
</html>
