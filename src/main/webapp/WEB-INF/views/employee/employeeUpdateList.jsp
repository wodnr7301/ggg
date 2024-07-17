<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<script>
    // jQuery가 로드된 후에 실행되도록 이벤트 리스너를 추가합니다.
    $(document).ready(function() {
        const datatablesSimple = document.getElementById('datatablesSimple1');
        if (datatablesSimple) {
            new simpleDatatables.DataTable(datatablesSimple,{
            		paging: false,
            		searchable: false,
            		perPageSelect: false,
            		sortable: false,
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
    });

    
	$(function() {
		$("#btnPost").on("click", function() {
			new daum.Postcode({
				oncomplete : function(data) {
					$("#empZip").val(data.zonecode);
					$("input[name='empAddr']").val(data.address);
					$("#empDaddr").val(data.buildingName)
				}
			}).open();
		});
		
		$("#btnSave").on("click", function() {
			
			var empNo = $('input[name=empNo]').val();
			var empNm = $('input[name=empNm]').val();
			var empZip = $('input[name=empZip]').val();
			var empAddr = $('input[name=empAddr]').val();
			var empDaddr = $('input[name=empDaddr]').val();
			var empTelno = $('input[name=empTelno]').val();
			var empMrgYn = $('input[name=empMrgYn]:checked').val();
			var empJncmpYmd = $('input[name=empJncmpYmd]').val();
			var empActno = $('input[name=empActno]').val();
			var empJbgdNm = $('select[name=empJbgdNm]').val();
			var empJbttlNm = $('select[name=empJbttlNm]').val();
			var deptNo = $('select[name=deptNo]').val();
			
			let data = {
				"empNo" : empNo,	
				"empNm" : empNm,		
				"empZip" : empZip,		
				"empAddr" : empAddr,		
				"empDaddr" : empDaddr,		
				"empTelno" : empTelno,		
				"empMrgYn" : empMrgYn,		
				"empJncmpYmd" : empJncmpYmd,		
				"empActno" : empActno,		
				"empJbgdNm" : empJbgdNm,		
				"empJbttlNm" : empJbttlNm,		
				"deptNo" : deptNo,		
			};
			
			console.log("data : " ,data);
			
			$.ajax({
				url:"/employee/updateAjax",
	            contentType:"application/json;charset=utf-8",
	            data : JSON.stringify(data), 
	            type : 'POST', 
	            beforeSend:function(xhr){
			          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			       }, 
	            success : function(result) {
	                console.log(result);
	               
	                swal("수정이 완료되었습니다.","","success").then(function() {
	                	window.location.href="/employee/update?empNo=" + empNo;
	                });
		                
		            },
		            error: function(xhr, status, error) {
			            console.error(xhr.responseText);
			            
			            swal("등록에 실패하였습니다.","","error");
			        }
			});
		});
	});
	
	$(function () {
		$(document).on('click', '.list', function() {
			
			location.href = "/employee/list"
		});
	});
	
	
    
</script>
<style>
.form-check {
	display: inline-block;
}
.text-end {
	float: right;
}	
</style>

<main>
<header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
    <div class="container-xl px-4">
        <div class="page-header-content pt-4">
            <div class="row align-items-center justify-content-between">
                <div class="col-auto mt-4">
                    <h1 class="page-header-title">
                        <div class="page-header-icon">
                            <i data-feather="layout"></i>
                        </div>
                        	회원 정보 수정
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
   
<div class="container-xl px-4 mt-n10">
    <div class="card">
        <div class="card-header fa-duotone">회원 정보 수정</div>
        <div class="card-body main-card">
        <form action="/employee/update" method="post" id="empUpdate">
        	<div class="mb-3">
	        	<input type="hidden" id="empNo" name="empNo" value="${employeeVO.empNo}">
	            <table id="datatablesSimple1">
	                <thead>
		                    <tr>
		                        <th>항목</th><th>정보</th>
		                    </tr>
	                </thead>
	                <tbody>
	                        <tr>
	                            <td>회원번호</td>
	                            <td>${employeeVO.empNo}<input type='hidden' name="empNo" value="${employeeVO.empNo}"/></td>
	                            
	                        </tr>
	                        <tr>
	                            <td>회원명</td>
	                            <td><input class="form-control" type="text" name="empNm" id="empNm" value="${employeeVO.empNm}" /></td>
	                        </tr>
	                        <tr>
	                            <td><button class="btn btn-primary" type="button" id="btnPost">우편번호</button></td>
	                            <td><input class="form-control" type="text" name="empZip" id="empZip" value="${employeeVO.empZip}" readonly/></td>
	                        </tr>
	                        <tr>
	                            <td>주소</td>
	                            <td><input class="form-control" type="text" name="empAddr" id="empAddr" value="${employeeVO.empAddr}"  readonly/></td>
	                        </tr>
	                        <tr>
	                            <td>상세주소</td>
	                            <td><input class="form-control" type="text" name="empDaddr" id="empDaddr" value="${employeeVO.empDaddr}" /></td>
	                        </tr>
	                        <tr>
	                            <td>전화번호</td>
	                            <td><input class="form-control" type="text" name="empTelno" id="empTelno" value="${employeeVO.empTelno}" /></td>
	                        </tr>
	                        <tr>
	                            <td>기혼여부</td>
		                        <td>
		                        	<c:choose>
			                        	<c:when test="${employeeVO.empMrgYn eq 'Y'}">
				                            <input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="Y" checked/>기혼
				                            <input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="N" />미혼
			                        	</c:when>
			                        	<c:when test="${employeeVO.empMrgYn eq 'N'}">
				                            <input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="Y" />기혼
				                            <input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="N" checked/>미혼
			                        	</c:when>
			                        	<c:otherwise>
			                        		<input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="Y" />기혼
				                            <input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="N" />미혼
			                        	</c:otherwise>
		                        	</c:choose>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>은행</td>
	                            <td><input class="form-control" name="empJncmpYmd" id="empJncmpYmd" type="text" value="${employeeVO.empJncmpYmd}" /></td>
	                        </tr>
	                        <tr>
	                            <td>계좌번호</td>
	                            <td><input class="form-control" type="text" name="empActno" id="empActno" value="${employeeVO.empActno}" /></td>
	                        </tr>
	                        <tr>
	                        	<td>직위</td>
	                        	<td>
	                        		<select class="form-control form-control-solid" id="empJbgdNm" name="empJbgdNm">
	                        			<c:choose>
			                              <c:when test="${employeeVO.empJbgdNm eq 'A102'}">
					                            <option value="A102" selected>부장</option>
												<option value="A103">과장</option>
												<option value="A104">대리</option>
												<option value="A105">사원</option>
			                              </c:when>
			                              <c:when test="${employeeVO.empJbgdNm eq 'A103'}">
					                            <option value="A102" >부장</option>
												<option value="A103" selected> 과장</option>
												<option value="A104">대리</option>
												<option value="A105">사원</option>
			                              </c:when>
			                              <c:when test="${employeeVO.empJbgdNm eq 'A104'}">
					                            <option value="A102" >부장</option>
												<option value="A103">과장</option>
												<option value="A104" selected>대리</option>
												<option value="A105">사원</option>
			                              </c:when>
			                              <c:when test="${employeeVO.empJbgdNm eq 'A105'}">
					                            <option value="A102" >부장</option>
												<option value="A103">과장</option>
												<option value="A104">대리</option>
												<option value="A105" selected>사원</option>
			                              </c:when>
			                              <c:otherwise>
			                              		<option value="A102">부장</option>
												<option value="A103">과장</option>
												<option value="A104">대리</option>
												<option value="A105">사원</option>
			                              </c:otherwise>
			                          </c:choose>
	                        		</select>
	                        	</td>
	                       	</tr>
	                       	<tr>
	                       		<td>직책</td>
	                       		<td>
	                       			<select class="form-control form-control-solid" id="empJbttlNm" name="empJbttlNm">
	                       			<c:choose>
										 <c:when test="${employeeVO.empJbttlNm eq 'A201'}">
					                            <option value="A201" selected>팀장</option>
												<option value="A202">부서장</option>
												<option value="A203">사업부장</option>
			                              </c:when>
										 <c:when test="${employeeVO.empJbttlNm eq 'A202'}">
					                            <option value="A201" >팀장</option>
												<option value="A202" selected>부서장</option>
												<option value="A203">사업부장</option>
			                              </c:when>
										 <c:when test="${employeeVO.empJbttlNm eq 'A203'}">
					                            <option value="A201" >팀장</option>
												<option value="A202">부서장</option>
												<option value="A203" selected>사업부장</option>
			                             </c:when>
			                             <c:otherwise>
			                            		<option value="A201">팀장</option>
												<option value="A202">부서장</option>
												<option value="A203">사업부장</option>
			                             </c:otherwise>
	                       			</c:choose>
									</select>
	                       		</td>
	                       	</tr>	
	                       	<tr>
	                       		<td>부서</td>
	                       		<td>
	                       			<select class="form-control form-control-solid" id="deptNo" name="deptNo">
	                       			<c:choose>
										<c:when test="${employeeVO.deptNo eq 'A002'}">
											<option value="A002" selected>영업부</option>
											<option value="A003">인사부</option>
											<option value="A004">회계부</option>
											<option value="A005">기획부</option>
											<option value="A001">개발부</option>
										</c:when>	                       				
										<c:when test="${employeeVO.deptNo eq 'A003'}">
											<option value="A002">영업부</option>
											<option value="A003" selected>인사부</option>
											<option value="A004">회계부</option>
											<option value="A005">기획부</option>
											<option value="A001">개발부</option>
										</c:when>	                       				
										<c:when test="${employeeVO.deptNo eq 'A004'}">
											<option value="A002">영업부</option>
											<option value="A003">인사부</option>
											<option value="A004" selected>회계부</option>
											<option value="A005">기획부</option>
											<option value="A001">개발부</option>
										</c:when>	                       				
										<c:when test="${employeeVO.deptNo eq 'A005'}">
											<option value="A002">영업부</option>
											<option value="A003">인사부</option>
											<option value="A004">회계부</option>
											<option value="A005" selected>기획부</option>
											<option value="A001">개발부</option>
										</c:when>	                       				
										<c:when test="${employeeVO.deptNo eq 'A001'}">
											<option value="A002">영업부</option>
											<option value="A003">인사부</option>
											<option value="A004">회계부</option>
											<option value="A005">기획부</option>
											<option value="A001" selected>개발부</option>
										</c:when>	                       				
	                       			</c:choose>
									</select>
	                       		</td>
	                       	</tr>	
		                </tbody>
		            </table>
		          </div>
			            <div class="text-end">
			            	<button class="btn btn-primary btn-md" type="button" id="btnSave" name="btnSave">수정</button>
			            	<button class="btn btn-primary btn-md list" type="button">목록</button>
			            </div>
	            <sec:csrfInput/>
			</form>
        </div>
    </div>
</div>

</main>


