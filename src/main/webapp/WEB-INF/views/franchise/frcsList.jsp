<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function() {
    const datatablesSimple = document.getElementById('ListTable');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
            labels: {
                placeholder: "Search...",
                searchTitle: "Search within table",
                pageTitle: "Page {page}",
                perPage: "",
                noRows: "No entries found",
                info: " ",
                noResults: "No results match your search query",
            }
        });
    }

    $(function() {
        let frcsNo;
        let empNo;

        $(".frcsNo").on("click", function() {
            frcsNo = $(this).val();
            console.log("frcsNo : ", frcsNo);

            let data = {
                "frcsNo": frcsNo
            };
            console.log("data : ", data);

            $.ajax({
                url: "/frcs/detail",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify(data),
                type: "post",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    console.log("result : ", result.empNm);

                    // 성별값 변환
                    let gender = result.empGen === 'M' ? '남' : '여';
                    let str = "";
                    str += `<div class='card card-header-actions'>
                        <div class='card-header'>
                        \${result.empNm}
                        <div class='dropdown no-caret'>
                        <div class='dropdown-menu dropdown-menu-end animated--fade-in-up' aria-labelledby='dropdownMenuButton'>
                        </div></div></div>
                        <div class='card-body'>
                        <table class='datatablesSimple2'>
                        <thead>
                            <tr>
                                <th>항목</th><th>가맹점주 정보</th>
                            </tr>    
                        </thead>
                        <tbody>
                            <tr>
                                <td>이름</td><td>\${result.empNm}</td>
                            </tr>
                            <tr>
                                <td>성별</td><td>\${gender}</td>
                            </tr>
                            <tr>
                                <td>이메일 주소</td><td>\${result.empEmlAddr}</td>
                            </tr>
                            <tr>
                                <td>전화번호</td><td>\${result.empTelno}</td>
                            </tr>
                            <tr>
                                <td>주소</td><td>\${result.empAddr}</td>
                            </tr>
                            <tr>
                                <td>상세주소</td><td>\${result.empDaddr}</td>
                            </tr>
                            <tr>
                                <td>주거래 은행</td><td>\${result.empJncmpYmd}</td>
                            </tr>
                            <tr>
                                <td>계좌번호</td><td>\${result.empActno}</td>
                            </tr>
                        </tbody>
                        </table></div></div>`;
                    $(".modal-body-detail").html(str);

                    const datatablesSimple2 = document.querySelector('.datatablesSimple2');
                    if (datatablesSimple2) {
                        new simpleDatatables.DataTable(datatablesSimple2, {
                            searchable: false,
                            perPageSelect: false,
                            sortable: false,
                            labels: {
                                pageTitle: "Page {page}",
                                info: "",
                            }
                        });
                    }
                }
            });
        });

        $(".edito").on("click", function() {
            frcsNo = $(this).val();
        });
        $(document).on('click', '.edit', function() {
            console.log("frcsNo : " + frcsNo);

            location.href = "/frcs/update?frcsNo=" + frcsNo;
        });

        $(".delo").on("click", function() {
            frcsNo = $(this).val();
            empNo = this.dataset.empno;
        });
        
        $(document).on('click', '.del', function() {
            console.log("frcsNo : " + frcsNo);
            console.log("empNo : " + empNo);

            let data = {
                "frcsNo": frcsNo,
                "empNo" : empNo
            };
            console.log("data : ", data);
            
            $.ajax({
                url: "/frcs/deleteFranchiseAjax",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify(data),
                type: "post",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    console.log("result : ", result);
                    let success = "success";
                    let data ={
                    		"success":success
                    }
                    swal("폐점처리 되었습니다.","","success");
                    
                    $.ajax({
                        url: "/frcs/getAllList",
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify(data),
                        type: "post",
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function(result) {
                            console.log("result : ", result);
							
                            let str = "";
                            str +=`<table id="ListTable">
		                				<thead>
		            					<tr>
		            						<th>가맹점번호</th>
		            						<th>지점명</th>
		            						<th>주소</th>
		            						<th>상세주소</th>
		            						<th>전화번호</th>
		            						<th>가맹점분류</th>
		            						<th>수정</th>
		            					</tr>
		            				</thead>
		            				<tbody>`;
                            $.each(result, function(idx, frcsVO){
                    					str+=`<tr>
        								<td><button class="btn btn-transparent-dark frcsNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" value="\${frcsVO.frcsNo}">\${frcsVO.frcsNo}</button></td>
        								<td>\${frcsVO.frcsNm}</td>
        								<td>\${frcsVO.frcsAddr}</td>
        								<td>\${frcsVO.frcsDaddr}</td>
        								<td>\${frcsVO.frcsTelno}</td>
        								 `;
		                                     if(frcsVO.ftNo == '1') {
		                                     str += `<td>오호이피자</td>`;
		                                 } else if(frcsVO.ftNo == '2') {
		                                     str += `<td>오호 분식</td>`;
		                                 } else if(frcsVO.ftNo == '3') {
		                                     str += `<td>카페오호</td>`;
		                                 }
		                                 str += `
	             								<td>
	             									<button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#exampleModalCenter2" value="\${frcsVO.frcsNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true"  data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
	             									<button class="btn btn-datatable btn-icon btn-transparent-dark delo" data-bs-toggle="modal" data-bs-target="#exampleModalCenter3" value="\${frcsVO.frcsNo}" data-empno="\${frcsVO.empNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
	             								</td>
	            								</tr>
		                                 `;
                            	});
                            
                            str+=`</tbody>
                    			</table>`;
                            $(".here").html(str);
                            
                            const afterDelete = document.querySelector('#ListTable');
                            if (afterDelete) {
                                new simpleDatatables.DataTable(afterDelete, {
                                    perPage:10,
                                    labels: {
                                        placeholder: "Search...",
                                        searchTitle: "Search within table",
                                        pageTitle: "Page {page}",
                                        perPage: "",
                                        noRows: "No entries found",
                                        info: " ",
                                        noResults: "No results match your search query",
                                    }
                                });
                            }
                        }
                    });
                }
            });
        });
    });
});

</script>
<style>
#ListTable td:nth-child(1),
#ListTable td:nth-child(5),
#ListTable td:nth-child(7) {
text-align: center;
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
								가맹점 목록
							</h1>
						</div>
					</div>
				</div>
			</div>
		</header>
		<div class="container-xl px-4 mt-n10">
	<div class="card">
		<div class="card-header fa-duotone">가맹점 목록</div>
		<div class="card-body main-card here">
			<table id="ListTable">
				<thead>
					<tr>
						<th>가맹점번호</th>
						<th>지점명</th>
						<th>주소</th>
						<th>상세주소</th>
						<th>전화번호</th>
						<th>가맹점분류</th>
						<th>수정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="frcsVO" items="${frcsList}" varStatus="stat">
							<tr>
								<td><button class="btn btn-outline-dark frcsNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" value="${frcsVO.frcsNo}">${frcsVO.frcsNo}</button></td>
								<td>${frcsVO.frcsNm}</td>
								<td>${frcsVO.frcsAddr}</td>
								<td>${frcsVO.frcsDaddr}</td>
								<td>${frcsVO.frcsTelno}</td>
								<td>
									<c:if test="${frcsVO.ftNo eq '1'}">오호이피자</c:if>
									<c:if test="${frcsVO.ftNo eq '2'}">오호 분식</c:if>
									<c:if test="${frcsVO.ftNo eq '3'}">카페오호</c:if>
								</td>
								<td>
									<button class="btn btn-datatable btn-icon btn-transparent-dark me-2 edito" data-bs-toggle="modal" data-bs-target="#exampleModalCenter2" value="${frcsVO.frcsNo}"><svg class="svg-inline--fa fa-ellipsis-vertical" aria-hidden="true"  data-prefix="fas" data-icon="ellipsis-vertical" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" data-fa-i2svg=""><path fill="currentColor" d="M56 472a56 56 0 1 1 0-112 56 56 0 1 1 0 112zm0-160a56 56 0 1 1 0-112 56 56 0 1 1 0 112zM0 96a56 56 0 1 1 112 0A56 56 0 1 1 0 96z"></path></svg></button>
									<button class="btn btn-datatable btn-icon btn-transparent-dark delo" data-bs-toggle="modal" data-bs-target="#exampleModalCenter3" value="${frcsVO.frcsNo}" data-empno="${frcsVO.empNo}"><svg class="svg-inline--fa fa-trash-can" aria-hidden="true" focusable="false" data-prefix="far" data-icon="trash-can" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M170.5 51.6L151.5 80h145l-19-28.4c-1.5-2.2-4-3.6-6.7-3.6H177.1c-2.7 0-5.2 1.3-6.7 3.6zm147-26.6L354.2 80H368h48 8c13.3 0 24 10.7 24 24s-10.7 24-24 24h-8V432c0 44.2-35.8 80-80 80H112c-44.2 0-80-35.8-80-80V128H24c-13.3 0-24-10.7-24-24S10.7 80 24 80h8H80 93.8l36.7-55.1C140.9 9.4 158.4 0 177.1 0h93.7c18.7 0 36.2 9.4 46.6 24.9zM80 128V432c0 17.7 14.3 32 32 32H336c17.7 0 32-14.3 32-32V128H80zm80 64V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16zm80 0V400c0 8.8-7.2 16-16 16s-16-7.2-16-16V192c0-8.8 7.2-16 16-16s16 7.2 16 16z"></path></svg></button>
								</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header"> 
                <h5 class="modal-title" id="exampleModalCenterTitle">가맹점주 정보</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body-detail">
            
            </div>
            <div class="modal-footer"><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">수정</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">수정화면으로 이동하시겠습니까?</div>
            <div class="modal-footer">
	            <button class="btn btn-primary edit" data-bs-dismiss="modal" type="button">수정</button>
	            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="exampleModalCenter3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">폐점처리</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">폐점처리 하시겠습니까?</div>
            <div class="modal-footer">
            	<button class="btn btn-danger del" data-bs-dismiss="modal" type="button">삭제</button>
            	<button class="btn btn-primary" type="button" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
