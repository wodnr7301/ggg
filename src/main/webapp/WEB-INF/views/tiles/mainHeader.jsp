<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
$(function(){
    $('.logout').on('click', function(){
        $('#logout').submit();
    });
	
    var socket = null;
    console.log("문서 준비 완료");
    <% if (session.getAttribute("login") != null) { %>
        console.log("로그인 상태 확인됨");
        connectWs();
        alarmList();
        srvyList();
    <% } else { %>
        console.log("로그인 상태 아님");
    <% } %>

function alarmList() {
    const empNo = '${login.getEmployeeVO().empNo}';
    console.log("empNo", empNo);

    $.ajax({
        url: "/alarm/header",
        contentType: "application/json;charset=utf-8",
        data: empNo,
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(alarmVOList) {
            console.log(alarmVOList);
            let str = "";

            const promises = alarmVOList.map(alarmVO => {
                return new Promise((resolve, reject) => {
                    const date = new Date(alarmVO.alrTm);

                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1).padStart(2, '0');
                    const day = String(date.getDate()).padStart(2, '0');

                    const formattedDate = `\${year}-\${month}-\${day}`;
                    let itemStr = `<a class="dropdown-item dropdown-notifications-item" id="alarmA" data-alr-glocd="${alarmVO.alrGlocd}" data-alr-seq="${alarmVO.alrSeq}" href="${alarmVO.alrInfo}">
                                        <div class="dropdown-notifications-item-icon bg-primary"><i data-feather="bell"></i></div>
                                        <div class="dropdown-notifications-item-content">
                                            <div class="dropdown-notifications-item-content-details">\${formattedDate}</div>`;

                    if (alarmVO.alrSrc == "mng") {
                        $.ajax({
                            url: "/alarm/getMngDetail",
                            contentType: "application/json;charset=utf-8",
                            data: alarmVO.alrGlocd,
                            type: "post",
                            dataType: "json",
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                            },
                            success: function(mngVO) {
                                console.log(mngVO);
                                const date = new Date(mngVO.mngDt);

                                const year = date.getFullYear();
                                const month = String(date.getMonth() + 1).padStart(2, '0');
                                const day = String(date.getDate()).padStart(2, '0');
                                const formattedDate = `\${year}-\${month}-\${day}`;

                                itemStr += `<div class="dropdown-notifications-item-content-text">\${mngVO.frcsNm} 방문일정이 있습니다.</div>`;
                                itemStr += `</div></a>`;
                                str += itemStr;
                                resolve();
                            },
                            error: function(err) {
                                reject(err);
                            }
                        });
                    } else if (alarmVO.alrSrc == "edu") {
                        $.ajax({
                            url: "/alarm/getEduDetail",
                            contentType: "application/json;charset=utf-8",
                            data: alarmVO.alrGlocd,
                            type: "post",
                            dataType: "json",
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                            },
                            success: function(ednCndtnVO) {
                                itemStr += `<div class="dropdown-notifications-item-content-text">\${ednCndtnVO.epNm} 예정된 교육이 있습니다.</div>`;
                                itemStr += `</div></a>`;
                                str += itemStr;
                                resolve();
                            },
                            error: function(err) {
                                reject(err);
                            }
                        });
                    } else {
                        itemStr += `</div></a>`;
                        str += itemStr;
                        resolve();
                    }
                });
            });

            Promise.all(promises).then(() => {
                console.log(str);
                $('#here').html(str);
                feather.replace();
            }).catch(err => {
                console.error("Error handling alarm details:", err);
            });
        }
    });
} // 함수 종료

    $(document).on('click','#alarmA',function(){
    	 event.preventDefault();
    	
    	let alrGlocd = this.dataset.alrGlocd;
    	let alrSeq = this.dataset.alrSeq;
    	let href = this.href;
    	
    	let data ={
    			"alrGlocd":alrGlocd,
    			"alrSeq":alrSeq,
    	}
    	
    	$.ajax({
			url:"/alarm/updateY",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				window.location.href = href;				
			}
		}); 
    	
    });
    
    
    // WebSocket 연결 함수
    function connectWs(){
        console.log("WebSocket 연결 시도 중...");
        var ws = new SockJS("/echo");
        socket = ws;

        ws.onopen = function() {
            console.log('WebSocket 연결 열림');
        };

        ws.onmessage = function(event) {
            console.log("메시지 수신: " + event.data);
            alarmList();
            const Toast = Swal.mixin({
        	    toast: true,
        	    position: 'top-end',
        	    showConfirmButton: false,
        	    timer: 3000,
        	    timerProgressBar: true,
        	    didOpen: (toast) => {
        	        toast.addEventListener('mouseenter', Swal.stopTimer)
        	        toast.addEventListener('mouseleave', Swal.resumeTimer)
        	    }
        	});
            
            Toast.fire({
        	    icon: 'success',
        	    title: '알림',
        	    html: event.data
        	    
        	})
            
            
        };

        ws.onclose = function() {
            console.log('WebSocket 연결 닫힘');
        };

        ws.onerror = function(error) {
            console.log('WebSocket 오류 발생: ' + error);
        };
    };
});

//참여할 수 있는 설문 리스트
function srvyList() {
	const empClsf = "${login.getEmployeeVO().empClsf}";
	let surveyList = [];
	
	
	$.ajax({
		url:"/survey/header",
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			
			if (empClsf == 'A301') {
				surveyList = result[0];//본사직원
			} else {
				surveyList = result[1];//가맹점주
			}
			
			let sTtl;
			let endDate;
			let srvyStr = "";
			if(surveyList.length != 0){
				for (var i = 0; i < surveyList.length; i++) {
					sTtl = surveyList[i].srvyTtl;
					endDate = surveyList[i].srvyEndDateStr;
					
					srvyStr = `<a class="dropdown-item py-3" href="/survey/doSurvey?srvyNo=`;
					srvyStr += surveyList[i].srvyNo;
					srvyStr += `">`;
	                srvyStr += `<div class="icon-stack bg-primary-soft text-primary me-4"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file-text"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg></div>`;
	                srvyStr += `<div id="srvyTtlHeader`;
	                srvyStr += surveyList[i].srvyNo;
	                srvyStr += `" style="margin-right: 10px;">`;
	                srvyStr += `	<div class="small text-gray-500" id="srvySubTtl`;
	                srvyStr += surveyList[i].srvyNo;
	                srvyStr += `">`;
	                srvyStr += endDate;
	                srvyStr += ` 까지</div>`;
	                srvyStr += sTtl;
	                srvyStr += `</div>`;
	                srvyStr += `</a>`;
	                srvyStr += `<div class="dropdown-divider m-0"></div>`;
	                
					$("#srvyDiv").append(srvyStr);
				}
			}else{
				srvyStr = `<a class="dropdown-item py-3" href="#`;
				srvyStr += `">`;
                srvyStr += `<div class="icon-stack bg-primary-soft text-primary me-4"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file-text"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg></div>`;
                srvyStr += `<div id="srvyTtlHeader`;
                srvyStr += `" style="margin-right: 10px;">`;
                srvyStr += `	<div class="small text-gray-500" id="srvySubTtl`;
                srvyStr += `">`;
                srvyStr += `설문조사</div>`;
				srvyStr += `진행 중인 설문조사가 없습니다.`;
                srvyStr += `</div>`;
                srvyStr += `</a>`;
                srvyStr += `<div class="dropdown-divider m-0"></div>`;
                
				$("#srvyDiv").append(srvyStr);
			}
		}
	});
}
</script>
<style>
.navbar-nav .divider {
    width: 1px;
    height: 40px; /* 높이는 필요에 따라 조정하세요 */
    background-color: #ddd; /* 구분선 색상 */
    margin: 0 10px; /* 좌우 여백 */
}
</style>

<nav class="topnav navbar navbar-expand shadow justify-content-between justify-content-sm-start navbar-light bg-white" id="sidenavAccordion">
            <!-- Sidenav Toggle Button-->
            <button class="btn btn-icon btn-transparent-dark order-1 order-lg-0 me-2 ms-lg-2 me-lg-0" id="sidebarToggle"><i data-feather="menu"></i></button>
            <!-- Navbar Brand-->
            <!-- * * Tip * * You can use text or an image for your navbar brand.-->
            <!-- * * * * * * When using an image, we recommend the SVG format.-->
            <!-- * * * * * * Dimensions: Maximum height: 32px, maximum width: 240px-->
            
<!--         권한에 따라 홈 다른곳으로 가게하기 -->
            <c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
            	<a class="navbar-brand pe-3 ps-4 ps-lg-2" href="/dashboard/home">OHO KOREA</a>
            </c:if>
            <c:if test="${login.getEmployeeVO().empClsf == 'A302'}">
            	<a class="navbar-brand pe-3 ps-4 ps-lg-2" href="/">OHO KOREA</a>
            </c:if>
            
            <!-- Navbar Items-->
            <ul class="navbar-nav align-items-center ms-auto">
            	<!-- 근무버튼 -->
            	<c:if test="${login.getEmployeeVO().empClsf == 'A301'}">
	           		<a href="/attend/list" class="btn btn-transparent-dark btn-sm nav-item" role="button">근무</a>
	           		<a href="/mtgRoom/list" class="btn btn-transparent-dark btn-sm nav-item" role="button">예약</a>
	           		<a href="/eatrzt/eatrztHome" class="btn btn-transparent-dark btn-sm nav-item" role="button">전자결재</a>
           		</c:if>
           		<!-- 구분선 -->
           		<div class="nav-item divider"></div>
           		<!-- 설문드롭다운 -->
            	<li class="nav-item dropdown no-caret d-none d-md-block me-3">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownDocs" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="fw-500">설문조사</div>
                        <svg class="svg-inline--fa fa-chevron-right dropdown-arrow" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"></path></svg><!-- <i class="fas fa-chevron-right dropdown-arrow"></i> Font Awesome fontawesome.com -->
                    </a>
                    <div id="srvyDiv" class="dropdown-menu dropdown-menu-end py-0 me-sm-n15 me-lg-0 o-hidden animated--fade-in-up" aria-labelledby="navbarDropdownDocs">
                    <!-- 설문 들어올 자리 -->
                    </div>
                </li>
                <!-- Navbar Search Dropdown-->
                <!-- * * Note: * * Visible only below the lg breakpoint-->
                <li class="nav-item dropdown no-caret me-3 d-lg-none">
                    <a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="searchDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="search"></i></a>
                    <!-- Dropdown - Search-->
                    <div class="dropdown-menu dropdown-menu-end p-3 shadow animated--fade-in-up" aria-labelledby="searchDropdown">
                        <form class="form-inline me-auto w-100">
                            <div class="input-group input-group-joined input-group-solid">
                                <input class="form-control pe-0" type="text" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" />
                                <div class="input-group-text"><i data-feather="search"></i></div>
                            </div>
                        </form>
                    </div>
                </li>
                <!-- Alerts Dropdown-->
                <li class="nav-item dropdown no-caret d-none d-sm-block me-3 dropdown-notifications">
                    <a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownAlerts" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="bell"></i></a>
                    <div class="dropdown-menu dropdown-menu-end border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownAlerts">
                        <h6 class="dropdown-header dropdown-notifications-header">
                            <i class="me-2" data-feather="bell"></i>
                            Alerts Center
                        </h6>
                        <!-- Example Alert 1-->
                        <div id="here">
                        </div>
                    </div>
                </li>
                <!-- User Dropdown-->
                <li class="nav-item dropdown no-caret dropdown-user me-3 me-lg-4">
                <c:choose>
    				<c:when test="${not empty login}">
                    	<a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownUserImage" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="img-fluid" src="/download/${login.getEmployeeVO().empNo}/1" /></a>
                    </c:when>
                    <c:otherwise>
                    	<a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownUserImage" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="img-fluid" src="/resources/assets/img/illustrations/profiles/profile-1.png" /></a>
                    </c:otherwise>	
                </c:choose>
                    <div class="dropdown-menu dropdown-menu-end border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownUserImage">
                        <h6 class="dropdown-header d-flex align-items-center">
                        <c:choose>
        					<c:when test="${not empty login}">
                            	<img class="dropdown-user-img" src="/download/${login.getEmployeeVO().empNo}/1" />
                            </c:when>
                            <c:otherwise>
                            	<img class="dropdown-user-img" src="/resources/assets/img/illustrations/profiles/profile-1.png" />
                            </c:otherwise>
                        </c:choose>
                            <div class="dropdown-user-details">
                            <c:choose>
	        					<c:when test="${not empty login and login.getEmployeeVO().empClsf == 'A302'}">
	                                <div class="dropdown-user-details-name">${login.getEmployeeVO().empNm} 점주님</div>
	        					</c:when>
	        					<c:when test="${not empty login and login.getEmployeeVO().empClsf == 'A301'}">
	                                <div class="dropdown-user-details-name">${login.getEmployeeVO().empNm}</div>
			                        <c:choose>
										<c:when test="${login.getEmployeeVO().deptNo eq 'A002'}">
											<div class="dropdown-user-details-deptNo">영업부</div>
										</c:when>	                       				
										<c:when test="${login.getEmployeeVO().deptNo eq 'A003'}">
											<div class="dropdown-user-details-deptNo">인사부</div>
										</c:when>	                       				
										<c:when test="${login.getEmployeeVO().deptNo eq 'A004'}">
											<div class="dropdown-user-details-deptNo">회계부</div>
										</c:when>	                       				
										<c:when test="${login.getEmployeeVO().deptNo eq 'A005'}">
											<div class="dropdown-user-details-deptNo">기획부</div>
										</c:when>	                       				
										<c:when test="${login.getEmployeeVO().deptNo eq 'A001'}">
											<div class="dropdown-user-details-deptNo">개발부</div>
										</c:when>	                       				
                       				</c:choose>
	                                <c:choose>
			                              <c:when test="${login.getEmployeeVO().empJbgdNm eq 'A102'}">
					                            <div class="dropdown-user-details-jbgdNm">부장</div>
			                              </c:when>
			                              <c:when test="${login.getEmployeeVO().empJbgdNm eq 'A103'}">
					                            <div class="dropdown-user-details-jbgdNm">과장</div>
			                              </c:when>
			                              <c:when test="${login.getEmployeeVO().empJbgdNm eq 'A104'}">
					                            <div class="dropdown-user-details-jbgdNm">대리</div>
			                              </c:when>
			                              <c:when test="${login.getEmployeeVO().empJbgdNm eq 'A105'}">
					                            <div class="dropdown-user-details-jbgdNm">사원</div>
			                              </c:when>
			                              <c:otherwise>
			                              		<div class="dropdown-user-details-jbgdNm">로그인하세요</div>
			                              </c:otherwise>
			                          </c:choose>
	                            </c:when>
                            </c:choose>
                            </div>
                        </h6>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/mypage/profile?empNo=${login.getEmployeeVO().empNo}">
                            <div class="dropdown-item-icon"><i data-feather="settings"></i></div>
                            내 정보
                        </a>
                        <form action="/logout" id="logout" method="post">
	                        <a class="dropdown-item logout" href="#!">
	                            <div class="dropdown-item-icon"><i data-feather="log-out"></i></div>
	                            로그아웃
	                        </a>
							<sec:csrfInput/>
						</form>
                    </div>
                </li>
            </ul>
        </nav>