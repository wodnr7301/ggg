<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
    <div class="container-xl px-4">
        <div class="page-header-content">
            <div class="row align-items-center justify-content-between pt-3">
                <div class="col-auto mb-3">
                    <h1 class="page-header-title">
                        <div class="page-header-icon"><i data-feather="user"></i></div>
                        	OHO KOREA
                    </h1>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main page content-->
<div class="container-xl px-4 mt-4">
    <!-- Account page navigation-->
    <nav class="nav nav-borders">
        <a class="nav-link" href="profile?empNo=${empNo}">프로필</a>
        <a class="nav-link active ms-0" href="detailProfile">상세정보</a>
        <a class="nav-link" href="">보안</a>
        <a class="nav-link" href="">법인차량 관리</a>
    </nav>
    <hr class="mt-0 mb-4" />
    <div class="row">
        <div class="col-xl-8">
            <!-- Account details card-->
            <div class="card mb-4" style="width: 1400px;">
                <form action="/mypage/detailProfile" method="post">
                    <input type="hidden" name="empNo" value="${employee.empNo}" />
                    <div class="card-header">상세정보</div>
                    <div class="card-body mb-1">
                        <!-- Form Group (username)-->
                        <div class="mb-3">
                            <label class="small mb-1" for="inputUsername">이름</label>
                            <input class="form-control form-control-solid" id="inputUsername" type="text" placeholder="Enter your username" value="${employee.empNm}" readonly />
                        </div>
                        <!-- Form Row-->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (dept name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="deptNm">부서명 </label>
                                <input class="form-control form-control-solid" id="deptNm" type="text" name="deptNm" value="${employee.deptNm}" readonly />
                            </div>
                            <!-- Form Group (position)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="comcdCdnm">직위</label>
                                <input class="form-control form-control-solid" id="comcdCdnm" type="text" name="comcdCdnm" value="${employee.comcdCdnm}" readonly />
                            </div>
                        </div><hr/>
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (entry date)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="empEmpymd">입사일 </label>
                                <input class="form-control form-control-solid" id="empEmpymd" type="text" name="empEmpymd" value="<fmt:formatDate value='${employee.empEmpymd}' pattern='yyyy-MM-dd'/>" readonly  />
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="empRv">잔여연차 </label>
                                <input class="form-control form-control-solid" id="empRv" type="text" name="empRv" value='${employee.empRv}' readonly />
                            </div>
                        </div><hr/>
                        <div class="row gx-3 mb-3">
						    <!-- Form Group (salary)-->
						    <div class="col-md-6">
						        <label class="small mb-1" for="empAmt">연봉</label>
						        <input class="form-control form-control-solid" id="empAmt" type="text" name="empAmt" value="${employee.empAmt}" readonly />
						    </div>
						    <div class="col-md-6">
						        <td>
						            <c:choose>
						                <c:when test="${employee.empMrgYn eq 'Y'}">
						                    <label><input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="Y" checked/>기혼</label>
						                    <label><input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="N" />미혼</label>
						                </c:when>
						                <c:when test="${employee.empMrgYn eq 'N'}">
						                    <label><input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="Y" />기혼</label>
						                    <label><input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="N" checked/>미혼</label>
						                </c:when>
						                <c:otherwise>
						                    <label><input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="Y" />기혼</label>
						                    <label><input class="form-check" type="radio" name="empMrgYn" id="empMrgYn" value="N" />미혼</label>
						                </c:otherwise>
						            </c:choose>
						        </td>
						    </div>
						</div><hr/>
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (bank name)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="empJncmpYmd">은행명 </label>
                                <input class="form-control" id="empJncmpYmd" type="text" name="empJncmpYmd" value="${employee.empJncmpYmd}"  />
                            </div>
                            <!-- Form Group (account number)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="empActno">계좌번호 </label>
                                <input class="form-control" id="empActno" type="text" name="empActno" value="${employee.empActno}"  />
                            </div>
                        </div><hr/>
                        <!-- Save changes button-->
                        <button class="btn btn-primary" type="submit" style="float:right">저장하기</button><br/>
                    </div>
                    <sec:csrfInput />
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="js/scripts.js"></script>
