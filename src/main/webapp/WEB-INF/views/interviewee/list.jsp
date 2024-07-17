<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!DOCTYPE html>
<style>
#preFrcTable td:nth-child(5), td:nth-child(4), td:nth-child(1){
	text-align: center;
	width: 15%;
}
#preFrcTable td:nth-child(1){
	width: 10%;
}
</style>
<script>
$(function(){
	$('#submit').on('click',function(){
		Swal.fire({
			   title: '예비창업자 등록을 하시겠습니까?',
			   icon: 'warning',
			   showCancelButton: true,
			   confirmButtonText: '등록', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   reverseButtons: false, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   let file = $("#file")[0].files[0];
					
					let formData = new FormData();
					
					formData.append("file",file);
					
					$.ajax({
						url:"/excel/read",
						async:false,
						processData:false,
						contentType:false,
						data:formData,
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(result){
						    var str = `
						    <table id="preFrcTable">
						        <thead>
							        <tr>
					                	<th>번호</th>
					                    <th>신청자명</th>
					                    <th>프랜차이즈 유형</th>
					                    <th>연락처</th>
					                    <th>신청일</th>
				                	</tr>
						        </thead>
						        <tbody>
						    `;
						   $.each(result.reserveFounderList,function(idx,preFrc){
							    var date = new Date(preFrc.rfYmd); 
					    		var year = date.getFullYear();
				    			var month = ('0' + (date.getMonth() + 1)).slice(-2);
				    			var day = ('0' + date.getDate()).slice(-2);

				    			var formattedDate = `\${year}-\${month}-\${day}`;
							   
						    	str += `
						            <tr>
						    			<td>\${idx+1}</td>
						                <td>\${preFrc.rfNm}</td>
						                <td>\${preFrc.frcsTypeVO.ftNm}</td>
						                <td>\${preFrc.rfTelno}</td>
						                <td>\${formattedDate}</td>
						            </tr>
						        `;
						    });

						    str += `
						        </tbody>
						    </table>
						    `;
							
						    console.log(result);
						    
						    $('.here').html(str);
						    
						    const preFrcTable = document.getElementById('preFrcTable');
							if (preFrcTable) {
								new simpleDatatables.DataTable(preFrcTable, {
									perPage : 5,
									labels : {
										placeholder : "Search...",
										searchTitle : "Search within table",
										pageTitle : "Page {page}",
										perPage : "",
										noRows : "아직 창업 신청이 없습니다.",
										info : "",
										noResults : "검색결과가 없습니다.",
									}
								});
							}
							Swal.fire('등록이 '+result.result+'건 완료되었습니다.', '', 'success');
						}
					});
			   }
			});
	}); //등록 이벤트 끝
	
	const preFrcTable = document.getElementById('preFrcTable');
	if (preFrcTable) {
		new simpleDatatables.DataTable(preFrcTable, {
			perPage : 5,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "아직 창업 신청이 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
	
	
});
</script>
<main>
	<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
		<div class="container-fluid px-4">
			<div class="page-header-content">
				<div class="row align-items-center justify-content-between pt-3">
					<div class="col-auto mb-3">
						<h1 class="page-header-title">
							<div class="page-header-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-list"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
							</div>
							예비 창업자 등록
						</h1>
					</div>
					<div class="col-12 col-xl-auto mb-3">
					    <form action="/excel/read" method="POST" enctype="multipart/form-data">
					        <div class="d-flex">
					            <input class="form-control form-control-solid me-2" type="file" id="file" name="file">
					            <input class="btn btn-outline-primary" type="button" id="submit" value="등록">
					        </div>
					    </form>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div class="container-fluid px-4">
		<div class="card">
			<div class="card-body">
				<h1>예비 창업자 목록</h1>
				<div id="here" class="here">
					<table id="preFrcTable">
		                <thead>
		                    <tr>
		                    	<th>번호</th>
		                        <th>신청자명</th>
		                        <th>프랜차이즈 유형</th>
		                        <th>연락처</th>
		                        <th>신청일</th>
		                    </tr>
		                </thead>
		                <tbody>
		           <c:forEach var="preFrc" items="${preFrcList}" varStatus="stat">
		                    <tr>
		                    	<td>${stat.index+1}</td>
		                        <td>${preFrc.rfNm}</td>
		                        <td>${preFrc.frcsTypeVO.ftNm}</td>
		                        <td>${preFrc.rfTelno}</td>
		                        <td><fmt:formatDate value="${preFrc.rfYmd}" pattern="yyyy-MM-dd" /></td>
		                    </tr>
		           </c:forEach>
		                </tbody>
		            </table>
				</div>
			</div>
		</div>
	</div>
</main>



