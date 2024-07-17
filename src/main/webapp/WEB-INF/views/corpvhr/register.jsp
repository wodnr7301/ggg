<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#btnSave").on("click", function() {
		var formData = new FormData($("#corpVhr")[0]);
		
			$.ajax({
				url: "/corpvhr/registerFormData",
				type: "post",
				data: formData,
				processData: false,
				contentType: false,
				beforeSend:function(xhr){
			          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			       },
			     	success: function(result) {
			    		 console.log("result:", result);
			    		 
			    		 swal("등록이 완료되었습니다.","","success").then(function() {
			    			 window.location.href = "/corpvhr/list";
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
<style>
.save{
	float : right;
}
</style>

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
						법인차량 등록
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>

<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header">법인차량 등록</div>
		<div class="card-body">
			<form action="/corpvhr/register" method="post" id="corpVhr">
				<div class="mb-3">
					<label class="small mb-1" for="cvNo">차량번호</label>
						<input class="form-control" id="cvNo" name="cvNo" type="text" placeholder="차량번호"  /><br/>
					<label class="small mb-1" for="cvMdlNm">모델명</label>
						<input class="form-control" id="cvMdlNm" name="cvMdlNm" type="text" placeholder="모델명  ex)제네시스"  /><br/>
					<label class="small mb-1" for="cvPrchsYmd">구매일자</label>
						<input class="form-control" id="cvPrchsYmd" name="cvPrchsYmd" type="date" /><br/>
					<div>
						<input type="button" class="btn btn-primary save" id="btnSave" name="btnSave" value="등록" />
					</div>
				</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>
