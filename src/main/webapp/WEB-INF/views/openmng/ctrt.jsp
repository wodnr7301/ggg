<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
#ctrtTable td:nth-child(1), td:nth-child(6), td:nth-child(7) {
	text-align: center;
	width: 9%;
}

#ctrtTable td:nth-child(3), td:nth-child(4), td:nth-child(5) {
	width: 10%;
}

#ctrtTable td:nth-child(2), td:nth-child(8) {
	width: 20%;
}

#newTable td:nth-child(1), td:nth-child(6), td:nth-child(7) {
	text-align: center;
	width: 10%;
}

#newTable td:nth-child(3), td:nth-child(4), td:nth-child(5) {
	width: 10%;
}

#newTable td:nth-child(2), td:nth-child(8) {
	width: 20%;
}
</style>
<header
	class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
	<div class="container-xl px-4">
		<div class="page-header-content">
			<div class="row align-items-center justify-content-between pt-3">
				<div class="col-auto mb-3">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-file-earmark-text-fill"
								viewBox="0 0 16 16">
								<path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1M4.5 9a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1zM4 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5m.5 2.5a.5.5 0 0 1 0-1h4a.5.5 0 0 1 0 1z" />
							</svg>
						</div>
						가맹점 계약 관리
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
<pre style="margin-bottom: 5px;">
<svg style="color: blue;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trophy" viewBox="0 0 16 16">
  <path d="M2.5.5A.5.5 0 0 1 3 0h10a.5.5 0 0 1 .5.5q0 .807-.034 1.536a3 3 0 1 1-1.133 5.89c-.79 1.865-1.878 2.777-2.833 3.011v2.173l1.425.356c.194.048.377.135.537.255L13.3 15.1a.5.5 0 0 1-.3.9H3a.5.5 0 0 1-.3-.9l1.838-1.379c.16-.12.343-.207.537-.255L6.5 13.11v-2.173c-.955-.234-2.043-1.146-2.833-3.012a3 3 0 1 1-1.132-5.89A33 33 0 0 1 2.5.5m.099 2.54a2 2 0 0 0 .72 3.935c-.333-1.05-.588-2.346-.72-3.935m10.083 3.935a2 2 0 0 0 .72-3.935c-.133 1.59-.388 2.885-.72 3.935M3.504 1q.01.775.056 1.469c.13 2.028.457 3.546.87 4.667C5.294 9.48 6.484 10 7 10a.5.5 0 0 1 .5.5v2.61a1 1 0 0 1-.757.97l-1.426.356a.5.5 0 0 0-.179.085L4.5 15h7l-.638-.479a.5.5 0 0 0-.18-.085l-1.425-.356a1 1 0 0 1-.757-.97V10.5A.5.5 0 0 1 9 10c.516 0 1.706-.52 2.57-2.864.413-1.12.74-2.64.87-4.667q.045-.694.056-1.469z" />
</svg> 우수 가맹점 : 오픈 1년이상 가맹점 중 지난 1년 동안의 매출액이 전체 가맹점 중 상위 10%에 해당하는 가맹점.
</pre>
<div class="row">
	<ul class="nav nav-tabs" style="width: 80%; margin-left: 15px">
	<c:forEach var="frcsType" items="${frcsTypeCnt}" varStatus="stat">
		<li class="nav-item"><a class="tabtab nav-link" href="#" onclick="fTab(this)" data-ftno="${frcsType.ftNo}">${frcsType.ftNm}
		<span class="badge bg-primary-soft text-primary ms-auto">${frcsType.ftCnt}</span></a></li>
	</c:forEach>
	</ul>
	<div style="width: auto; padding:1px;">
		<h3><span class="badge bg-blue-soft text-blue">정상영업 : <span id="clsNSpan">${cntN}</span></span></h3>
	</div>
	<div style="width: auto;padding:1px;">
		<h3><span class="badge bg-red-soft text-red">폐업 : <span id="clsYSpan">${cntY}</span></span></h3>
	</div>
</div>
	<div class="card">
		<div class="card-body" id="tableStart">
			<table id="ctrtTable">
				<thead>
					<tr>
						<th>계약 번호</th>
						<th>계약명</th>
						<th>가맹점유형</th>
						<th>가맹점주</th>
						<th>계약 담당직원</th>
						<th>계약일</th>
						<th>영업상태</th>
						<th>계약서 첨부파일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ctrt" items="${ctrtList}" varStatus="stat">
						<tr>
							<td>${ctrt.ctrtNo}</td>
							<td><a href="/ctrt/detail?ctrtNo=${ctrt.ctrtNo}">${ctrt.ctrtNm}</a></td>
							<td>${ctrt.frcsTypeVO.ftNm}</td>
							<td>${ctrt.frcEmpNm}
								<c:if test="${ctrt.goodFrc eq 'Y'}">
									<svg style="color: blue;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trophy" viewBox="0 0 16 16">
										<path d="M2.5.5A.5.5 0 0 1 3 0h10a.5.5 0 0 1 .5.5q0 .807-.034 1.536a3 3 0 1 1-1.133 5.89c-.79 1.865-1.878 2.777-2.833 3.011v2.173l1.425.356c.194.048.377.135.537.255L13.3 15.1a.5.5 0 0 1-.3.9H3a.5.5 0 0 1-.3-.9l1.838-1.379c.16-.12.343-.207.537-.255L6.5 13.11v-2.173c-.955-.234-2.043-1.146-2.833-3.012a3 3 0 1 1-1.132-5.89A33 33 0 0 1 2.5.5m.099 2.54a2 2 0 0 0 .72 3.935c-.333-1.05-.588-2.346-.72-3.935m10.083 3.935a2 2 0 0 0 .72-3.935c-.133 1.59-.388 2.885-.72 3.935M3.504 1q.01.775.056 1.469c.13 2.028.457 3.546.87 4.667C5.294 9.48 6.484 10 7 10a.5.5 0 0 1 .5.5v2.61a1 1 0 0 1-.757.97l-1.426.356a.5.5 0 0 0-.179.085L4.5 15h7l-.638-.479a.5.5 0 0 0-.18-.085l-1.425-.356a1 1 0 0 1-.757-.97V10.5A.5.5 0 0 1 9 10c.516 0 1.706-.52 2.57-2.864.413-1.12.74-2.64.87-4.667q.045-.694.056-1.469z" />
									</svg>
								</c:if>
							</td>
							<td>${ctrt.empNm}</td>
							<td><fmt:formatDate value="${ctrt.ctrtYmd}"
									pattern="yyyy-MM-dd" /></td>
							<td>
							
								<div
									class="badge 
                        						<c:if test="${ctrt.frcsClsbizYn eq 'Y'}">bg-red-soft text-red</c:if>
                        						<c:if test="${ctrt.frcsClsbizYn eq 'N'}">bg-blue-soft text-blue</c:if>
                        							">
									<c:if test="${ctrt.frcsClsbizYn eq 'Y'}">폐업</c:if>
									<c:if test="${ctrt.frcsClsbizYn eq 'N'}">정상영업</c:if>
								</div>
							</td>
							<td><a href="/download/${ctrt.ctrtNo}/1">${fn:substringAfter(ctrt.attachVO.afNm, '_')}</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function() {
	const ctrtTable = document.getElementById('ctrtTable');
	if (ctrtTable) {
		new simpleDatatables.DataTable(ctrtTable, {
			perPage : 10,
			labels : {
				placeholder : "Search...",
				searchTitle : "Search within table",
				pageTitle : "Page {page}",
				perPage : "",
				noRows : "가맹점 계약이 없습니다.",
				info : "",
				noResults : "검색결과가 없습니다.",
			}
		});
	}
	
	$("a[data-ftno=0]").prop("class","nav-link active");
	$("a[data-ftno=0]").prop("aria-current","page");
});

//탭 클릭
function fTab(no){
	let ftNo = $(no).data("ftno");
	
	if(ftNo=='0'){
		location.href="/ctrt/list";
	}
	
	$("a[data-ftno=0]").attr("class","nav-link");
	$("a[data-ftno=0]").removeAttr("aria-current");

	let ftNoObject = {
		"ftNo":ftNo
	}
    console.log("ftNoObject : ", ftNoObject);
	
	$.ajax({
		url:"/ctrt/getList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(ftNoObject),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			console.log(resp);
			
			//리스트 바꿔주기
			$("#tableStart").empty();
			
			let str = `<table id="newTable">`;
			str += `<thead>`;
			str += `<tr>`;
			str += `<th>계약 번호</th>`;
			str += `<th>계약명</th>`;
			str += `<th>가맹점유형</th>`;
			str += `<th>가맹점주</th>`;
			str += `<th>계약 담당직원</th>`;
			str += `<th>계약일</th>`;
			str += `<th>영업상태</th>`;
			str += `<th>계약서 첨부파일</th>`;
			str += `</tr>`;
			str += `</thead>`;
			str += `<tbody>`;
		    
		    let clsYnBadgeClass = '';
		    let clsYnText = '';
		    let goodFrcIcon = ` <svg style="color: blue;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trophy" viewBox="0 0 16 16">`;
	    	goodFrcIcon += `<path d="M2.5.5A.5.5 0 0 1 3 0h10a.5.5 0 0 1 .5.5q0 .807-.034 1.536a3 3 0 1 1-1.133 5.89c-.79 1.865-1.878 2.777-2.833 3.011v2.173l1.425.356c.194.048.377.135.537.255L13.3 15.1a.5.5 0 0 1-.3.9H3a.5.5 0 0 1-.3-.9l1.838-1.379c.16-.12.343-.207.537-.255L6.5 13.11v-2.173c-.955-.234-2.043-1.146-2.833-3.012a3 3 0 1 1-1.132-5.89A33 33 0 0 1 2.5.5m.099 2.54a2 2 0 0 0 .72 3.935c-.333-1.05-.588-2.346-.72-3.935m10.083 3.935a2 2 0 0 0 .72-3.935c-.133 1.59-.388 2.885-.72 3.935M3.504 1q.01.775.056 1.469c.13 2.028.457 3.546.87 4.667C5.294 9.48 6.484 10 7 10a.5.5 0 0 1 .5.5v2.61a1 1 0 0 1-.757.97l-1.426.356a.5.5 0 0 0-.179.085L4.5 15h7l-.638-.479a.5.5 0 0 0-.18-.085l-1.425-.356a1 1 0 0 1-.757-.97V10.5A.5.5 0 0 1 9 10c.516 0 1.706-.52 2.57-2.864.413-1.12.74-2.64.87-4.667q.045-.694.056-1.469z" />`;
	    	goodFrcIcon += `</svg>`;
	    	let goodFrc = '';
	    	let fName = '';
			
			$.each(resp, function(i, v){
				
			    if (v.frcsClsbizYn === 'N') {
			    	clsYnBadgeClass = 'badge bg-blue-soft text-blue';
			        clsYnText = '정상영업';
			    } else if (v.frcsClsbizYn === 'Y') {
			    	clsYnBadgeClass = 'badge bg-red-soft text-red';
			        clsYnText = '폐업';
			    }
			    
			    if (v.goodFrc === 'Y') {
			    	goodFrc = goodFrcIcon;
			    } else {
			    	goodFrc = '';
			    }
			    
			    fAtch = v.attachVO;
			    if(fAtch){
				    fNameArr = v.attachVO.afNm.split('_');
				    fName = fNameArr[fNameArr.length-1];
			    }
		        
				str += `<tr>`;
				str += `<td>`+v.ctrtNo+`</td>`;
				str += `<td><a href="/ctrt/detail?ctrtNo=`+v.ctrtNo+`">`+v.ctrtNm+`</a></td>`;
				str += `<td>`+v.frcsTypeVO.ftNm+`</td>`;
				str += `<td>`+v.frcEmpNm + goodFrc+`</td>`;
				str += `<td>`+v.empNm+`</td>`;
				str += `<td>`+new Date(v.ctrtYmd).toISOString().split('T')[0]+`</td>`;
				str += `<td><div class="`;
				str += clsYnBadgeClass
				str += `">`;
				str += clsYnText;
				str += `	</div></td>`;
				str += `<td><a href="/download/`+v.ctrtNo+`/1">`+ fName +`</a></td>`;
		        str += `</tr>`;				
			});
			
	        str += `</tbody>`;
	        str += `</table>`;
            
			$('#tableStart').html(str);
			
			if($('#newTable').length){
				const insert = document.getElementById('newTable');
	    	    if (insert) {
	    	        new simpleDatatables.DataTable(insert,{
	    				perPage : 10,
	    				labels : {
	    					placeholder : "Search...",
	    					searchTitle : "Search within table",
	    					pageTitle : "Page {page}",
	    					perPage : "",
	    					noRows : "해당 가맹점 유형의 계약이 없습니다.",
	    					info : "",
	    					noResults : "검색결과가 없습니다.",
	    				}		
	    	        });
	    	    }
			}
		}//end success
	});//end ajax
	
	$.ajax({
		url:"/ctrt/getClsCnt",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(ftNoObject),
		type:"post",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(resp){
			$("#clsNSpan").text(resp.cntN);
			$("#clsYSpan").text(resp.cntY);
		}//end success
	});//end ajax
}//end function
</script>