<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
$(function(){
	
    const datatablesSimple = document.getElementById('datatablesSimple1');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple,{
        		labels: {
        		    placeholder: "Search...",
        		    searchTitle: "Search within table",
        		    pageTitle: "Page {page}",
        		    perPage: "",
        		    noRows: "No entries found",
        		    info: " ",
        		    noResults: "No results match your search query",
        		}		
        	}
        );
    }


	$(document).on("click",".amlNo",function(){
		console.log("amlNo에 왔다.")
		
		//this : 클래스 오브젝트 배열 중에서 클릭한 바로 그 오브젝트
		var amlNo = this.dataset.amlNo;
		var giveNo = this.dataset.giveNo;
		var ddcNo = this.dataset.ddcNo;

		//JSON 오브젝트
		let data = {
				"amlNo" : amlNo,
				"giveNo" : giveNo,
				"ddcNo" : ddcNo
		};
		
		console.log("data : " , data);
		
		/*
	    요청URI : /detailAjax
	    요청파라미터(JSON.stringify) : {"bookId":"130"}
	    요청방식 : post
	    */
	    $.ajax({
	    	url:"/salary/detail",
	    	contentType:"application/json;charset=utf-8",
	    	dataType:"json",
	    	data:JSON.stringify(data),
	    	type:"post",
	    	beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	    	success:function(result){
	    		console.log("result : ", result);
	    		var amt = new Intl.NumberFormat().format(result.salary.amlAmt);
	    		
	    		var amt1 = new Intl.NumberFormat().format(result.giveVO.giveAmt);
	    		var exts = new Intl.NumberFormat().format(result.giveVO.giveExts);
	    		var night = new Intl.NumberFormat().format(result.giveVO.giveNight);
	    		var hldy = new Intl.NumberFormat().format(result.giveVO.giveHldy);
	    		
	    		var	insrnc = new Intl.NumberFormat().format(result.ddcVO.ddcInsrnc);
	    		var inctx = new Intl.NumberFormat().format(result.ddcVO.ddcInctx);
	    		
	    		var date = new Date(result.salary.amlDt); 
	    		var year = date.getFullYear();
    			var month = ('0' + (date.getMonth() + 1)).slice(-2);
    			var day = ('0' + date.getDate()).slice(-2);

    			var formattedDate = `\${year}-\${month}-\${day}`;
	    		
	    		let str = "";
	    		str += "<table id='datatablesSimple2'>";
	    		str += "<thead>";
	    		str += "<tr>";
	    		str += "<th>급여관리번호</th><th>입금일</th><th>입금액</th><th>사원번호</th><th>사원명</th>";
	    		str += "</tr>";
	    		str += "</thead>";
	    		str += "<tbody>";
	    		str += "<tr>";
	    		str += "<td>"+result.salary.amlNo+"</td><td>"+formattedDate+"</td><td>"+amt+"원</td><td>"+result.salary.empNo+"</td><td>"+result.salary.empNm+"</td>";
	    		str += "</tr>";
	    		str += "</tbody>";
	    		str += "</table>";
	    		
	    		
	    		let str1 = "";
	    		
	    		str1 += "<table id='datatablesSimple3'>";
	    		str1 += "<thead>";
	    		str1 += "<tr>";
	    		str1 += "<th>항목</th><th>금액</th>";
	    		str1 += "</tr>";
	    		str1 += "</thead>";
	    		str1 += "<tbody>";
	    		str1 += "<tr>";
	    		str1 += "<td>기본급</td><td>"+amt1+"</td>";
	    		str1 += "</tr>";
	    		str1 += "<tr>";
	    		str1 += "<td>연장근로수당</td><td>"+exts+"</td>";
	    		str1 += "</tr>";
	    		str1 += "<tr>";
	    		str1 += "<td>야간근로수당</td><td>"+night+"</td>";
	    		str1 += "</tr>";
	    		str1 += "<tr>";
	    		str1 += "<td>휴일근로수당</td><td>"+hldy+"</td>";
	    		str1 += "</tr>";
	    		str1 += "</tbody>";
	    		str1 += "</table>";
	    		
	    		let str2 ="";
	    		
	    		str2 += "<table id='datatablesSimple4'>";
	    		str2 += "<thead>";
	    		str2 += "<tr>";
	    		str2 += "<th>항목</th><th>금액</th>";
	    		str2 += "</tr>";
	    		str2 += "</thead>";
	    		str2 += "<tbody>";
	    		str2 += "<tr>";
	    		str2 += "<td>4대보험</td><td>"+insrnc+"</td>";
	    		str2 += "</tr>";
	    		str2 += "<tr>";
	    		str2 += "<td>소득세</td><td>"+inctx+"</td>";
	    		str2 += "</tr>";
	    		str2 += "</tbody>";
	    		str2 += "</table>";
	    		
	    		$(".card-body1").html(str);
	   			$(".card-text1").html(str1);
	   			$(".card-text2").html(str2);
	    		
	    		
	    		const datatablesSimple2 = document.getElementById('datatablesSimple2');
			    if (datatablesSimple2) {
			        new simpleDatatables.DataTable(datatablesSimple2,{
			        	searchable: false,
			        	perPageSelect: false,
			              labels: {
			                  pageTitle: "Page {page}",
			                  info: "",
			              }      
			           }
			        );
			    }
			    
	    		const datatablesSimple3 = document.getElementById('datatablesSimple3');
			    if (datatablesSimple3) {
			        new simpleDatatables.DataTable(datatablesSimple3,{
			        	searchable: false,
			        	perPageSelect: false,
			        	sortable: false,
			              labels: {
			                  pageTitle: "Page {page}",
			                  info: "",
			              }      
			           }
			        );
			    }
			    
	    		const datatablesSimple4 = document.getElementById('datatablesSimple4');
			    if (datatablesSimple4) {
			        new simpleDatatables.DataTable(datatablesSimple4,{
			        	searchable: false,
			        	perPageSelect: false,
			        	sortable: false,
			              labels: {
			                  pageTitle: "Page {page}",
			                  info: "",
			              }      
			           }
			        );
			    }
			    
	    	}
	    });
	    
	});
    
    $(document).on('click','.del',function(){
    	console.log("삭제버튼 활성화");
    		
    	var amlNo = $(this).attr("data-aml-no");
        console.log("amlNo : " + amlNo);
        var giveNo = $(this).attr("data-give-no");
        console.log("giveNo : " + giveNo);
        var ddcNo = $(this).attr("data-ddc-no");
        console.log("ddcNo : " + ddcNo);
    	
    	var data = {
    			"amlNo" : amlNo,
    			"giveNo" : giveNo,
    			"ddcNo" : ddcNo
    	}
    	
    	console.log("data : ",data);
    	
    	$.ajax({
	    	url:"/salary/delete",
	    	contentType:"application/json;charset=utf-8",
	    	dataType:"json",
	    	data:JSON.stringify(data),
	    	type:"post",
	    	beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	    	success:function(result){
				console.log("성공하면 result가 3 : "+result )
				
				if(result>0){
					
					$.ajax({
						url:"/salary/allAjax",
						contentType:"application/json;charset=utf-8",
						dataType:"json",
						type:"post",
						beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
						success:function(salaryVOList){
							console.log(salaryVOList);
							
							
							let str = "";
				    		str += "<table id='afterDel'>";
				    		str += "<thead>";
				    		str += "<tr>";
				    		str += "<th>급여관리번호</th><th>입금일</th><th>입금액</th><th>사원번호</th><th>사원명</th><th>수정</th>";
				    		str += "</tr>";
				    		str += "</thead>";
				    		str += "<tbody>";
				    		$.each(salaryVOList,function(idx,salaryVO){
				    			var amt = new Intl.NumberFormat().format(salaryVO.amlAmt);
				    			var date = new Date(salaryVO.amlDt); 
				    			var year = date.getFullYear();
				    			var month = ('0' + (date.getMonth() + 1)).slice(-2);
				    			var day = ('0' + date.getDate()).slice(-2);

				    			var formattedDate = `\${year}-\${month}-\${day}`;
				    			
					    		str += "<tr>";
					    		str += '<td><button class="btn btn-outline-dark amlNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-aml-no="'+salaryVO.amlNo+'" data-give-no="'+salaryVO.giveNo+'" data-ddc-no="'+salaryVO.ddcNo+'" >'+salaryVO.amlNo+'</button></td>';
					    		str += '<td>'+formattedDate+'</td>';
					    		str += '<td>'+amt+'원</td>';
					    		str += '<td>'+salaryVO.empNo+'</td>';
					    		str += '<td>'+salaryVO.empNm+'</td>';
					    		str += '<td><button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#exampleModalCenter2" data-aml-no="'+salaryVO.amlNo+'" data-give-no="'+salaryVO.giveNo+'" data-ddc-no="'+salaryVO.ddcNo+'"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button><button class="btn btn-datatable btn-icon btn-transparent-dark delo" data-bs-toggle="modal" data-bs-target="#exampleModalCenter1" data-aml-no="'+salaryVO.amlNo+'" data-give-no="'+salaryVO.giveNo+'" data-ddc-no="'+salaryVO.ddcNo+'"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button></td>'
					    		str += "</tr>";
				    		});
				    		str += "</tbody>";
				    		str += "</table>";
							
				    		$('.main-card').html(str);
							
				    		Swal.fire({
				 				title: "삭제가 완료되었습니다.",
				 				icon: "success",
				 			});
				    		
				    		const afterDel = document.getElementById('afterDel');
				    	    if (afterDel) {
				    	        new simpleDatatables.DataTable(afterDel,{
				    	        		labels: {
				    	        		    placeholder: "Search...",
				    	        		    searchTitle: "Search within table",
				    	        		    pageTitle: "Page {page}",
				    	        		    perPage: "",
				    	        		    noRows: "No entries found",
				    	        		    info: " ",
				    	        		    noResults: "No results match your search query",
				    	        		}		
				    	        	}
				    	        );
				    	    }
							
						}
					});
					
		    	}
			}
	    	
	    });
    	
    });
    
    $(document).on('click','.edit',function(){
    	var amlNo = this.dataset.amlNo;
		var giveNo = this.dataset.giveNo;
		var ddcNo = this.dataset.ddcNo;
        console.log("amlNo : " + amlNo);
        console.log("giveNo : " + giveNo);
        console.log("ddcNo : " + ddcNo);
    	
    	location.href = "/salary/update?amlNo="+amlNo+"&giveNo="+giveNo+"&ddcNo="+ddcNo;
    	
    });
    
    $(document).on('click','.edito',function(){
    	
    	var amlNo = this.dataset.amlNo;
		var giveNo = this.dataset.giveNo;
		var ddcNo = this.dataset.ddcNo;
    	console.log("amlNo : "+amlNo);
    	console.log("giveNo : "+giveNo);
    	console.log("ddcNo : "+ddcNo);
    	
    	$('.edit').removeAttr('data-aml-no')
        .removeAttr('data-give-no')
        .removeAttr('data-ddc-no');
    	
    	$('.edit').attr('data-aml-no', amlNo)
        .attr('data-give-no', giveNo)
        .attr('data-ddc-no', ddcNo);
		    	
    });
    
    $(document).on('click','.delo',function(){
    	
    	var amlNo = $(this).data("amlNo");
    	console.log("amlNo : "+amlNo);
    	var giveNo = $(this).data("giveNo");
    	console.log("giveNo : "+giveNo);
    	var ddcNo = $(this).data("ddcNo");
    	console.log("ddcNo : "+ddcNo);
    	
    	$('.del').removeAttr('data-aml-no', amlNo)
        .removeAttr('data-give-no', giveNo)
        .removeAttr('data-ddc-no',ddcNo);
    	
    	$('.del').attr('data-aml-no', amlNo)
        .attr('data-give-no', giveNo)
        .attr('data-ddc-no', ddcNo);
    	
    });
    
});
</script>
<style>
#datatablesSimple1 td:nth-child(1),
#datatablesSimple1 td:nth-child(2),
#datatablesSimple1 td:nth-child(3),
#datatablesSimple1 td:nth-child(5),
#datatablesSimple1 td:nth-child(7),
#datatablesSimple2 td:nth-child(1),
#datatablesSimple2 td:nth-child(2),
#datatablesSimple2 td:nth-child(4),
#afterDel td:nth-child(1),
#afterDel td:nth-child(2),
#afterDel td:nth-child(3),
#afterDel td:nth-child(5),
#afterDel td:nth-child(7){
	text-align: center;
}

#datatablesSimple1 td:nth-child(4) {
	text-align: right;
}
#datatablesSimple2 td:nth-child(3) {
	text-align: right;
}
#afterDel td:nth-child(4) {
	text-align: right;
}
#datatablesSimple3 td:nth-child(1), #datatablesSimple3 td:nth-child(2), #datatablesSimple3 td:nth-child(3), #datatablesSimple3 td:nth-child(4) {
	text-align: right;
}
#datatablesSimple4 td:nth-child(1), #datatablesSimple4 td:nth-child(2) {
	text-align: right;
}
</style>
<header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
    <div class="container-xl px-4">
        <div class="page-header-content pt-4">
            <div class="row align-items-center justify-content-between">
                <div class="col-auto mt-4">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layout">
                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="3" y1="9" x2="21" y2="9"></line>
                                <line x1="9" y1="21" x2="9" y2="9"></line>
                            </svg>
                        </div>
                        급여관리대장
                    </h1>
                    <div class="page-header-subtitle"></div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone d-flex justify-content-between align-items-center">
	        <span>급여관리대장</span>
	        <a href="/salary/create" class="btn btn-outline-primary">급여관리대장 작성</a>
    	</div>
		<div class="card-body main-card">
			<table id="datatablesSimple1">
				<thead>
					<tr>
						<th>번호</th>
						<th>급여관리번호</th>
						<th>입금일</th>
						<th>입금액</th>
						<th>사원번호</th>
						<th>사원명</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="salaryVO" items="${salaryVOList}" varStatus="stat">
						<tr>
							<td>${stat.index+1}</td>
							<td><button class="btn btn-outline-dark amlNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-aml-no="${salaryVO.getAmlNo()}" data-give-no="${salaryVO.getGiveNo()}" data-ddc-no="${salaryVO.getDdcNo()}" >${salaryVO.getAmlNo()}</button></td>
							<td><fmt:formatDate value="${salaryVO.getAmlDt()}" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatNumber value="${salaryVO.getAmlAmt()}" pattern="#,###" />원</td>
							<td>${salaryVO.getEmpNo()}</td>
							<td>${salaryVO.getEmpNm()}</td>
							<td>
								<button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#exampleModalCenter2" data-aml-no="${salaryVO.getAmlNo()}" data-give-no="${salaryVO.getGiveNo()}" data-ddc-no="${salaryVO.getDdcNo()}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
								<button class="btn btn-datatable btn-icon btn-transparent-dark delo" data-bs-toggle="modal" data-bs-target="#exampleModalCenter1" data-aml-no="${salaryVO.getAmlNo()}" data-give-no="${salaryVO.getGiveNo()}" data-ddc-no="${salaryVO.getDdcNo()}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">급여 내역 상세</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            <form>
            	<!-- Waves Styled Card -->
				<div class="card card-waves">
				    <div class="card-header">급여 내역</div>
				    <div class="card-body1">
				    
				    </div>
				</div>
				<hr/>
				
				<div class="row">
				    <!-- Card Image Cap (Top) Example -->
					<div class="col-6">
						<div class="card">
						    <div class="card-body">
						        <h5 class="card-title">지급</h5>
						        <div class="card-text1">
						        
						        </div>
						    </div>
						</div>
					</div>
					
					<!-- Card Image Cap (Bottom) Example -->
					<div class="col-6">
						<div class="card">
						    <div class="card-body">
						        <h5 class="card-title">공제</h5>
						        <div class="card-text2">
						        	
						        </div>
						    </div>
						</div>
					</div>
				</div>
            </form>
            </div>
            <div class="modal-footer"><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">삭제 확인</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">정말 삭제하시겠습니까?</div>
            <div class="modal-footer">
            	<button class="btn btn-danger del" data-bs-dismiss="modal" type="button">삭제</button>
            	<button class="btn btn-primary" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">수정 확인</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">수정화면으로 이동하시겠습니까?</div>
            <div class="modal-footer"><button class="btn btn-secondary edit" data-bs-dismiss="modal" type="button">수정</button><button class="btn btn-primary" type="button" data-bs-dismiss="modal">닫기</button></div>
        </div>
    </div>
</div>
