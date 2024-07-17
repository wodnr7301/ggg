<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<header
	class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
	<div class="container-xl px-4">
		<div class="page-header-content">
			<div class="row align-items-center justify-content-between pt-3">
				<div class="col-auto mb-3">
					<h1 class="page-header-title">
						<div class="page-header-icon">
							<i data-feather="user"></i>
						</div>
						OHO KOREA
					</h1>
				</div>
			</div>
		</div>
	</div>
</header>
<br />
<br />
<br />
<br />
<style>
.profile-section {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	background-color: #f8f9fa;
	border: 1px solid #d3d3d3; /* Light gray border */
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-like {
	width: 100%;
	padding: 0;
	border: 1px solid #d3d3d3; /* Light gray border */
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
}

.profile-image-box, .profile-details-box {
	padding: 20px;
}

.profile-image-box {
	border-bottom: 1px solid #d3d3d3; /* Light gray border */
	display: flex;
	justify-content: center;
}

.profile-details-box {
	text-align: center;
}

#profileImage {
	width: 180px;
	height: 180px;
	object-fit: cover;
	border: 2px solid #d3d3d3; /* Light gray border */
	padding: 5px;
	border-radius: 50%;
}

.profile-details-box {
	margin-top: 20px;
	text-align: center;
}

.profile-details-box h4 {
	font-size: 24px;
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

.profile-details-box p {
	font-size: 18px;
	color: #555;
	margin: 5px 0;
}

.stamp-section {
	margin-top: 20px;
}

.stamp-section .card-body {
	border: 1px solid #d3d3d3; /* Light gray border */
	border-radius: 10px;
	padding: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	background-color: #ffffff;
}

#stampImage {
	width: 120px;
	height: 120px;
	object-fit: cover;
}

.card {
	background-color: #ffffff;
	border: 1px solid #d3d3d3; /* Light gray border */
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-body {
	padding: 20px;
}

.card-body .form-control {
	border: 1px solid #d3d3d3; /* Light gray border */
	border-radius: 5px;
}

#empZipBtn {
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
}

.card-body label {
	font-weight: bold;
	color: #333;
}

.card-body input {
	font-size: 14px;
	color: #555;
}

#myldgrList td:nth-child(1),
#myldgrList td:nth-child(3),
#myldgrList td:nth-child(4),
#myldgrList td:nth-child(5) {
	text-align: center;
}

#salary td:nth-child(3),
#aml td:nth-child(3),
#give td:nth-child(2),
#ddc td:nth-child(2) {
	text-align: right;
}

#salary td:nth-child(1),
#salary td:nth-child(2),
#salary td:nth-child(4),
#salary td:nth-child(5),
#aml td:nth-child(1),
#aml td:nth-child(2),
#aml td:nth-child(4),
#aml td:nth-child(5),
#give td:nth-child(1),
#ddc td:nth-child(1){
	text-align: center;
}
</style>
<div class="container-xl px-4 mt-n10">
	<div class="card mb-4">
		<div class="card-header border-bottom">
			<ul class="nav nav-tabs card-header-tabs" id="dashboardNav"
				role="tablist">
				<li class="nav-item me-1"><a class="nav-link active"
					id="overview-pill" href="#overview" data-bs-toggle="tab" role="tab"
					aria-controls="overview" aria-selected="true">
				<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
					직원 정보
				</c:if>
				<c:if test="${login.getEmployeeVO().empClsf == 'A302'}">
					가맹점주 정보
				</c:if>
				</a></li>
				<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
				<li class="nav-item"><a class="nav-link" id="activities-pill"
					href="#activities" data-bs-toggle="tab" role="tab"
					aria-controls="activities" aria-selected="false">직원 상세 정보</a></li>
				</c:if>
				<c:if test="${login.getEmployeeVO().empClsf == 'A302'}">
				<li class="nav-item"><a class="nav-link" id="activities-pill-5"
					href="#activities-5" data-bs-toggle="tab" role="tab"
					aria-controls="activities" aria-selected="false">가맹점 정보</a></li>
				</c:if>
				
				<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">	
				<li class="nav-item"><a class="nav-link" id="activities-pill-4"
					href="#activities-4" data-bs-toggle="tab" role="tab"
					aria-controls="activities" aria-selected="false">개인급여 지급내역</a></li>
				</c:if>	
					
				<li class="nav-item"><a class="nav-link" id="activities-pill-2"
					href="#activities-2" data-bs-toggle="tab" role="tab"
					aria-controls="activities" aria-selected="false">보안</a></li>
				
				<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
				<li class="nav-item"><a class="nav-link" id="activities-pill-3"
					href="#activities-3" data-bs-toggle="tab" role="tab"
					aria-controls="activities" aria-selected="false">법인차량 관리</a></li>
				</c:if>
				
				
			</ul>
		</div>
		<div class="card-body">
			<div class="tab-content" id="dashboardNavContent">
				<div class="tab-pane fade show active" id="overview" role="tabpanel"
					aria-labelledby="overview-pill">
					<!-- 직원정보 탭 -->
					<div class="mb-3">
						<input type="hidden" name="empNo" value="${empNo}" />
						<table id="datatablesSimple1">
							<div class="row justify-content-center">
								<div class="col-xl-4 profile-section">
									<div class="card-body text-center card-like">
										<div class="profile-image-box">
											<img id="profileImage" class="img-account-profile mb-2"
												src="/download/${empNo}/1" alt="Profile Image" />
										</div>
										<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
										<div class="profile-details-box">
											<h4 class="profile-name">${employee.empNm}</h4>
											<p class="profile-dept">부서명: ${employee.deptNm}</p>
											<p class="profile-comcd">직위: ${employee.comcdCdnm}</p>
											<p class="profile-phone">Tel: ${employee.empTelno}</p>
											<p class="profile-email">Email: ${employee.empEmlAddr}</p>
										</div>
										</c:if>
										<c:if test="${login.getEmployeeVO().empClsf == 'A302'}">
										<div class="profile-details-box">
											<c:forEach var="frcVO" items="${franchiseVOList}" varStatus="stat">
												<h4><strong>${frcVO.frcsNm}</strong></h4> 
												<h2><i>${frcVO.frcsTelno}</i></h2>
											</c:forEach>
										</div>
											<c:forEach var="franEmp" items="${franEmployee}" varStatus="stat">
												<h4><strong>${franEmp.empNm}</strong></h4> 
											</c:forEach>
										</c:if>
									</div>
									<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
									<div class="stamp-section text-center">
										<div class="card-body stamp-card">
											<img id="stampImage" class="img-account-profile mb-2"
												src="/download/${empNo}/2" alt="Stamp Image" />
										</div>
									</div>
									</c:if>
								</div>
								<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
								<div class="col-xl-8">
									<!-- Account details card-->
									<div class="card mb-4">
										<input type="hidden" name="empNo" value="${employee.empNo}" />
										<div class="card-body mb-1">
											<!-- Form Group (username)-->
											<div class="mb-3">
												<label class="small mb-1" for="inputUsername">이름</label> <input
													class="form-control form-control-solid" id="inputUsername"
													type="text" placeholder="Enter your username"
													value="${employee.empNm}" readonly />
											</div>
											<hr />
											<div class="row gx-3 mb-3">
												<!-- Form Group (gender)-->
												<div class="col-md-6">
													<label class="small mb-1" for="inputGender">성별</label>
													<c:if test="${employee.empGen eq 'M'}">
														<input class="form-control form-control-solid"
															id="inputGender" type="text"
															placeholder="Enter your gender" value="남자" readonly />
													</c:if>
													<c:if test="${employee.empGen eq 'F'}">
														<input class="form-control form-control-solid"
															id="inputGender" type="text"
															placeholder="Enter your gender" value="여자" readonly />
													</c:if>
												</div>
												<!-- Form Group (birthday)-->
												<div class="col-md-6">
													<label class="small mb-1" for="inputBirthday">생년월일</label>
													<input type="date" class="form-control form-control-solid"
														id="inputBirthday" name="birthday"
														placeholder="Enter your birthday"
														value="<fmt:formatDate value="${employee.empBrdt}" pattern="yyyy-MM-dd" />"
														readonly />
												</div>
											</div>
											<hr />
											<!-- Contact details -->
											<div class="row gx-3 mb-3">
												<div class="col-md-6">
													<label class="small mb-1" for="empEmlAddr">이메일</label> <input
														class="form-control" id="empEmlAddr" type="email"
														name="empEmlAddr" placeholder="Enter your email address"
														value="${employee.empEmlAddr}" />
												</div>
												<div class="col-md-6">
													<label class="small mb-1" for="empTelno">전화번호</label> <input
														class="form-control" id="empTelno" type="tel"
														name="empTelno" placeholder="Enter your phone number"
														value="${employee.empTelno}" />
												</div>
											</div>
											<br />
											<hr />
											<br />
											<!-- Address details -->
											<div class="row gx-3 mb-3">
												<div class="col-md-5">
													<label class="small mb-1" for="empZip">우편번호</label>
													<div class="input-group">
														<input class="form-control" id="empZip" type="text"
															name="empZip" placeholder="Enter your postal code"
															value="${employee.empZip}" />
														<button class="btn btn-primary px-4" type="button"
															id="empZipBtn">우편번호 검색</button>
													</div>
												</div>
											</div>
											<div class="mb-3">
												<label class="small mb-1" for="empAddr">주소</label> <input
													class="form-control" id="empAddr" type="text"
													name="empAddr" placeholder="Enter your address"
													value="${employee.empAddr}" />
											</div>
											<div class="mb-3">
												<label class="small mb-1" for="empDaddr">상세주소</label> <input
													class="form-control" id="empDaddr" type="text"
													name="empDaddr" placeholder="Enter your detailed address"
													value="${employee.empDaddr}" /><br />
											</div>
										</div>
									</div>
								</div>
								</c:if>
							</div>
						</table>
					</div>
					<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
					<div class="text-end">
						<button class="btn btn-primary" type="button" id="btnSave1"
							name="btnSave1">수정</button>
					</div>
					</c:if>
				</div>
								
				<div class="tab-pane fade" id="activities" role="tabpanel"
					aria-labelledby="activities-pill">
					<div class="mb-3">
						<input type="hidden" name="empNo" value="${empNo}" />
						<table id="datatablesSimple2" class="datatable-table">
							<thead>
								<tr>
									<th>항목</th>
									<th>정보</th>
								</tr>
							</thead>
							<tr>
								<td>사원 이름</td>
								<td>${employee.empNm}</td>
							</tr>
							<tbody>
								<tr>
									<td>부서명</td>
									<td><input class="form-control form-control-solid"
										name="deptNm" id="deptNm" type="text"
										value="${employee.deptNm}" readonly /></td>
								</tr>
								<tr>
									<td>직위</td>
									<td><input class="form-control form-control-solid"
										type="text" name="comcdCdnm" id="comcdCdnm"
										value="${employee.comcdCdnm}" readonly /></td>
								</tr>
								<tr>
									<td>입사일</td>
									<td><input class="form-control form-control-solid"
										id="empEmpymd" type="text" name="empEmpymd"
										value="<fmt:formatDate value='${employee.empEmpymd}' pattern='yyyy-MM-dd'/>"
										readonly /></td>
								</tr>
								<tr>
									<td>잔여연차</td>
									<td><input class="form-control form-control-solid"
										id="empRv" type="text" name="empRv" value='${employee.empRv}'
										readonly /></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td>연봉</td> -->
<!-- 									<td><input class="form-control form-control-solid" -->
<!-- 										id="empAmt" type="text" name="empAmt" -->
<%-- 										value="${employee.empAmt}" readonly /></td> --%>
<!-- 								</tr> -->
								<tr>
									<td>결혼 여부</td>
									<td><c:choose>
											<c:when test="${employee.empMrgYn eq 'Y'}">
												<label><input class="form-check" type="radio"
													name="empMrgYn" id="empMrgYn" value="Y" checked />기혼</label>
												<label><input class="form-check" type="radio"
													name="empMrgYn" id="empMrgYn" value="N" />미혼</label>
											</c:when>
											<c:when test="${employee.empMrgYn eq 'N'}">
												<label><input class="form-check" type="radio"
													name="empMrgYn" id="empMrgYn" value="Y" />기혼</label>
												<label><input class="form-check" type="radio"
													name="empMrgYn" id="empMrgYn" value="N" checked />미혼</label>
											</c:when>
											<c:otherwise>
												<label><input class="form-check" type="radio"
													name="empMrgYn" id="empMrgYn" value="Y" />기혼</label>
												<label><input class="form-check" type="radio"
													name="empMrgYn" id="empMrgYn" value="N" />미혼</label>
											</c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<td>은행명</td>
									<td><input class="form-control" id="empJncmpYmd"
										type="text" name="empJncmpYmd" value="${employee.empJncmpYmd}" /></td>
								</tr>
								<tr>
									<td>계좌번호</td>
									<td><input class="form-control" id="empActno" type="text"
										name="empActno" value="${employee.empActno}" /></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="text-end">
						<button class="btn btn-primary" type="button" id="btnSave2"
							name="btnSave2">수정</button>
					</div>
				</div>
				
				<!-- 마이페이지-보안 -->
				<div class="tab-pane fade" id="activities-2" role="tabpanel"
					aria-labelledby="activities-pill-1">
					<!-- Change password card-->
					<div class="card mb-4">
						<div class="card-header">비밀번호 변경</div>
						<div class="card-body">
							<!-- Form Group (current password)-->
							<div class="mb-3">
								<label class="small mb-1" for="currentPassword">현재 비밀번호</label>
								<input class="form-control" id="empPswd" type="password"
									placeholder="현재 비밀번호를 입력해주세요." />
							</div>
							<!-- Form Group (new password)-->
							<div class="mb-3">
								<label class="small mb-1" for="newPassword">새 비밀번호</label> <input
									class="form-control" id="newPassword" type="password"
									placeholder="새 비밀번호" />
							</div>
							<!-- Form Group (confirm password)-->
							<div class="mb-3">
								<label class="small mb-1" for="confirmPassword">새 비밀번호
									확인</label> <input class="form-control" id="confirmPassword"
									type="password" placeholder="새 비밀번호 확인" />
							</div>
							<button class="btn btn-primary" type="button" id="complete"
								name="complete">확인</button>
						</div>
					</div>
				</div>
				
				<!-- 가맹점 정보 -->
				<div class="tab-pane fade" id="activities-5" role="tabpanel"
					aria-labelledby="activities-pill-5">
					<!-- Change password card-->
					<div class="card mb-4">
						<div class="card-header">가맹점 정보</div>
						<div class="card-body" >
							<table id="franchise">
								<thead>
									<tr>
										<th>가맹번호</th>
										<th>지점명</th>
										<th>주소</th>
										<th>상세주소</th>
										<th>지점 전화번호</th>
										<th>가맹점 유형</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="frcVO" items="${franchiseVOList}" varStatus="stat">
										<td>${frcVO.frcsNo}</td>
										<td>${frcVO.frcsNm}</td>
										<td>${frcVO.frcsAddr}</td>
										<td>${frcVO.frcsDaddr}</td>
										<td>${frcVO.frcsTelno}</td>
										<td>
											<c:if test="${frcVO.ftNo eq '1'}">오호이피자</c:if>
											<c:if test="${frcVO.ftNo eq '2'}">오호분식</c:if>
											<c:if test="${frcVO.ftNo eq '3'}">카페오호</c:if>
										</td>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="tab-pane fade" id="activities-4" role="tabpanel" aria-labelledby="activities-pill-4">
					<div class="card mb-4">
						<div class="card-header">개인급여 지급내역</div>
						<div class="card-body">
							<table id="salary">
								<thead>
									<tr>
										<th>급여관리번호</th>
										<th>입금일</th>
										<th>입금액</th>
										<th>사원번호</th>
										<th>사원명</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="salaryVO" items="${salaryVOList}" varStatus="stat">
										<tr>
											<td><button class="btn btn-outline-dark amlNo" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter" data-aml-no="${salaryVO.getAmlNo()}" data-give-no="${salaryVO.getGiveNo()}" data-ddc-no="${salaryVO.getDdcNo()}" >${salaryVO.getAmlNo()}</button></td>
											<td><fmt:formatDate value="${salaryVO.getAmlDt()}" pattern="yyyy-MM-dd"/></td>
											<td><fmt:formatNumber value="${salaryVO.getAmlAmt()}" pattern="#,###" />원</td>
											<td>${salaryVO.getEmpNo()}</td>
											<td>${salaryVO.getEmpNm()}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<!-- 마이페이지-법인차량 -->
				<div class="tab-pane fade" id="activities-3" role="tabpanel"
					aria-labelledby="activities-pill-2">
					<div class="card mb-4">
						<div class="card-header">나의 법인차량 대여</div>
						<div class="card-body returncar">
							<table id="myldgrList">
								<thead>
									<tr>
										<th>차량관리대장 번호</th>
										<th>차량 번호</th>
										<th>대여일자</th>
										<th>반납일자</th>
										<th>반납하기</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="myList" items="${corpVhrVO}" varStatus="stat">
										<tr>
											<td>${myList.cvmlNo}</td>
											<td>${myList.cvNo}</td>
											<td><fmt:formatDate value="${myList.cvmlRentYmd}"
													pattern="yyyy-MM-dd" /></td>
											<td><fmt:formatDate value="${myList.cvmlRtnYmd}"
													pattern="yyyy-MM-dd" /></td>
											<td>
												<button
													class="btn btn-outline-info rtn" type="button"
													 value="${myList.cvmlNo}">반납
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
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

<!-- Main page content-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	//우편번호 api
	$("#empZipBtn").on("click", function() {
		new daum.Postcode({
			oncomplete : function(data) {
				$("#empZip").val(data.zonecode);
				$("#empAddr").val(data.address);
				$("#empDaddr").val(data.buildingName || '');

				var Toast = Swal.mixin({
					toast : true,
					position : "top-end",
					showConfirmButton : false,
					timer : 2000
				});
				Toast.fire({
					icon : "success",
					title : "우편번호가 검색되었습니다."
				});
			}
		}).open();
	});

	$(document).ready(function() {
		const datatablesSimple = document.getElementById('myldgrList');
		if (datatablesSimple) {
			new simpleDatatables.DataTable(datatablesSimple, {
				paging : false,
				searchable : false,
				perPageSelect : false,
				sortable : false,
				labels : {
					placeholder : "Search...",
					searchTitle : "Search within table",
					pageTitle : "Page {page}",
					perPage : "",
					noRows : "No entries found",
					info : " ",
					noResults : "No results match your search query",
				}
			});
		} // simpleDatatables 끝
	});
	
	$(document).ready(function() {
		const datatablesSimple = document.getElementById('franchise');
		if (datatablesSimple) {
			new simpleDatatables.DataTable(datatablesSimple, {
				paging : false,
				searchable : false,
				perPageSelect : false,
				sortable : false,
				labels : {
					placeholder : "Search...",
					searchTitle : "Search within table",
					pageTitle : "Page {page}",
					perPage : "",
					noRows : "No entries found",
					info : " ",
					noResults : "No results match your search query",
				}
			});
		} // simpleDatatables 끝
	});

	$(document).ready(function() {
		$('#uploadFile').on('change', handleImg);
		$('#uploadStamp').on('change', handleStamp);
	});

	//프로필 사진
	function handleImg(e) {
		let file = e.target.files[0];
		if (file && file.type.match("image.*")) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#profileImage').attr('src', e.target.result);
			}
			reader.readAsDataURL(file);
		} else {
			swal("이미지 확장자만 가능합니다.", "", "error");
		}
	}

	//디지털 지장
	function handleStamp(e) {
		let file = e.target.files[0];
		if (file && file.type.match("image.*")) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#stampImage').attr('src', e.target.result);
			}
			reader.readAsDataURL(file);
		} else {
			swal("이미지 확장자만 가능합니다.", "", "error");
		}
	}

	$(function() {
		
		$("#btnSave1").on("click", function() {

			var empNo = $('input[name=empNo]').val();
			var empZip = $('input[name=empZip]').val();
			var empAddr = $('input[name=empAddr]').val();
			var empDaddr = $('input[name=empDaddr]').val();
			var empTelno = $('input[name=empTelno]').val();
			var empEmlAddr = $('input[name=empEmlAddr]').val();

			let data = {
				"empNo" : empNo,
				"empZip" : empZip,
				"empAddr" : empAddr,
				"empDaddr" : empDaddr,
				"empTelno" : empTelno,
				"empEmlAddr" : empEmlAddr
			};

			console.log("data : ", data);

			$.ajax({
				url : "/mypage/updateProfile",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type : 'POST',
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(result) {
					console.log(result);
					swal("수정이 완료되었습니다.", "", "success");
				},
				error : function(xhr, status, error) {
					console.error(xhr.responseText);
					swal("수정이 실패하였습니다.", "", "error");
				}
			});
		});

		$("#btnSave2").on("click", function() {
			var empNo = $('input[name=empNo]').val();
			var empMrgYn = $('input[name=empMrgYn]').val();
			var empJncmpYmd = $('input[name=empJncmpYmd]').val();
			var empActno = $('input[name=empActno]').val();

			let data = {
				"empNo" : empNo,
				"empMrgYn" : empMrgYn,
				"empJncmpYmd" : empJncmpYmd,
				"empActno" : empActno
			};

			console.log("data : ", data);

			$.ajax({
				url : "/mypage/updateDetailProfile",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type : 'POST',
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(result) {
					console.log(result);
					swal("수정이 완료되었습니다.", "", "success");
				},
				error : function(xhr, status, error) {
					console.error(xhr.responseText);
					swal("수정이 실패하였습니다.", "", "error");
				}
			});
		});

		$(".rtn").on("click", function() {
			var empNo = $('input[name=empNo]').val();
			
			Swal.fire({
		           title: '반납처리를 하시겠습니까?',
		           icon: 'warning',
		           showCancelButton: true,
		           confirmButtonText: '확인',
		           cancelButtonText: '취소',
		           reverseButtons: false,
		       }).then(result => {
		           if (result.isConfirmed) {
		        	   var cvmlNo = $(this).val();
		   			
		   			let data = {
		   					"cvmlNo" : cvmlNo,
		   					"empNo" : empNo
		   			};
		   			$.ajax({
		   				url: "/mypage/returnAjax",
		   				contentType:"application/json;charset=utf-8",
		   	            data : JSON.stringify(data), 
		   	            type : 'POST',
		   	            beforeSend:function(xhr){
		   			          xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		   			       },
		   			       success : function(result) {
		   		                console.log(result);
		   		               
		   		                swal("반납처리 되었습니다.","","success").then(function() {
		   		                	window.location.href = "/mypage/profile?empNo=" + empNo
		   		                });
		   			            },
		   			            
		   			           
		   			        
	   			            error: function(xhr, status, error) {
	   				            console.error(xhr.responseText);
	   				        }
		   			});
		        	   
		           }
		       });
			
		});
		
		$("#complete").on("click", function() {
			var empNo = $('input[name=empNo]').val();
			var empPswd = $('#empPswd').val();
			var newPassword = $('#newPassword').val();
			var confirmPassword = $('#confirmPassword').val();

			if (newPassword !== confirmPassword) {
				swal("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.", "", "error");
				return;
			}
			let data = {
				"empNo" : empNo,
				"empPswd" : empPswd,
			}

			let data2 = {
				"empNo" : empNo,
				"empPswd" : newPassword,
			}

			$.ajax({
				url : "/employee/checkingPw",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type : 'POST',
				beforeSend : function(xhr) {
					xhr.setRequestHeader(
					"${_csrf.headerName}",
					"${_csrf.token}");
							},
					success : function(result) {
						console.log(result);
						if (result) {
							$.ajax({
								url : "/employee/updatePswd",
								contentType : "application/json;charset=utf-8",
								data : JSON
										.stringify(data2),
								type : 'POST',
								beforeSend : function(xhr) {
									xhr.setRequestHeader(
										"${_csrf.headerName}",
										"${_csrf.token}");
											},
									success : function(result) {
									console.log(result);
										swal("수정이 완료되었습니다.", "", 	"success");
											},
											error : function(
													xhr,
													status,
													error) {
												console.error(xhr.responseText);
												swal("수정이 실패하였습니다.",	"","error");
											}
										});
							} else {
								swal("현재비밀번호가 다릅니다. 다시입력해주세요.","","error");
							}
						}
					});
				});
			});
	
	$(function(){
		const salary = document.getElementById('salary');
	    new simpleDatatables.DataTable(salary,{
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
		    		var formattedDate = date.toLocaleString(); 
		    		
		    		let str = "";
		    		str += "<table id='aml'>";
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
		    		
		    		str1 += "<table id='give'>";
		    		str1 += "<thead>";
		    		str1 += "<tr>";
		    		str1 += "<th>항목</th><th>금액</th>";
		    		str1 += "</tr>";
		    		str1 += "</thead>";
		    		str1 += "<tbody>";
		    		str1 += "<tr>";
		    		str1 += "<td>기본급</td><td>"+amt1+"원</td>";
		    		str1 += "</tr>";
		    		str1 += "<tr>";
		    		str1 += "<td>연장근로수당</td><td>"+exts+"원</td>";
		    		str1 += "</tr>";
		    		str1 += "<tr>";
		    		str1 += "<td>야간근로수당</td><td>"+night+"원</td>";
		    		str1 += "</tr>";
		    		str1 += "<tr>";
		    		str1 += "<td>휴일근로수당</td><td>"+hldy+"원</td>";
		    		str1 += "</tr>";
		    		str1 += "</tbody>";
		    		str1 += "</table>";
		    		
		    		let str2 ="";
		    		
		    		str2 += "<table id='ddc'>";
		    		str2 += "<thead>";
		    		str2 += "<tr>";
		    		str2 += "<th>항목</th><th>금액</th>";
		    		str2 += "</tr>";
		    		str2 += "</thead>";
		    		str2 += "<tbody>";
		    		str2 += "<tr>";
		    		str2 += "<td>4대보험</td><td>"+insrnc+"원</td>";
		    		str2 += "</tr>";
		    		str2 += "<tr>";
		    		str2 += "<td>소득세</td><td>"+inctx+"원</td>";
		    		str2 += "</tr>";
		    		str2 += "</tbody>";
		    		str2 += "</table>";
		    		
		    		$(".card-body1").html(str);
		   			$(".card-text1").html(str1);
		   			$(".card-text2").html(str2);
		    		
		    		
		    		const aml = document.getElementById('aml');
				    if (aml) {
				        new simpleDatatables.DataTable(aml,{
				        	searchable: false,
				        	perPageSelect: false,
				              labels: {
				                  pageTitle: "Page {page}",
				                  info: "",
				              }      
				           }
				        );
				    }
				    
		    		const give = document.getElementById('give');
				    if (give) {
				        new simpleDatatables.DataTable(give,{
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
				    
		    		const ddc = document.getElementById('ddc');
				    if (ddc) {
				        new simpleDatatables.DataTable(ddc,{
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
	});
	
</script>
