<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<style>
#comTable tbody{
	font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

.noBorder {
	border-width: 0;
}

.card-header input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}

.tableStyle {
   border-collapse: collapse;
}

.tableStyle th {
   background-color: WhiteSmoke;
   text-align: center;
   width: 250px;
}


div#margin {
   margin-top: 1em;
}
/* 컨테이너 스타일 */
.centered-container {
   max-width: 60%; /* 최대 너비를 60%로 설정 */
   margin: 0 auto; /* 가운데 정렬 */
   border-radius: 10px; /* 테두리 모서리 둥글게 설정 */
}

/* 카드 스타일 */
.card {
   margin-bottom: 1.5rem; /* 카드 아래 여백 추가 */
}

/* 폼 그룹 스타일 */
.form-group {
   margin-bottom: 1.5rem; /* 폼 그룹 아래 여백 추가 */
}

/* 에디터 컨테이너 스타일 */
.editor-container {
   margin-bottom: 1.5rem; /* 에디터 컨테이너 아래 여백 추가 */
}

/* Submit Button 스타일 */
.submit-button {
   width: 20%; /* 버튼 크기 20% 설정 */
   float: right; /* 오른쪽 정렬 */
}

/* 포스트 컨텐츠 컨테이너 스타일 */
.post-content-container {
   margin-top: 1rem; /* 헤더와의 간격을 추가 */
}
</style>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.0.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />

<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
   <div class="container-fluid px-4">
      <div class="page-header-content">
         <div class="row align-items-center justify-content-between pt-3">
            <div class="col-auto mb-3">
               <h1 class="page-header-title">
                  <div class="page-header-icon"><i data-feather="file-plus"></i></div>
                  	문서작성하기
               </h1>
            </div>
            <div class="col-12 col-xl-auto mb-3">
               <a class="btn btn-sm btn-light text-primary"
                  href="/eatrzt/eatrztHome"> <i class="me-1" data-feather="arrow-left"></i>전자결재 홈
               </a>
            </div>
         </div>
      </div>
   </div>
</header>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.Username" var="username" />
</sec:authorize>
<div class="container-fluid px-4">
	<form id="myForm" action="/eatrzt/eatrztPost" method="post" enctype="multipart/form-data">
	<input type="hidden" name="empId" value="${username}"  />
	<div class="row gx-4">
		<!-- 문서양식 선택 시작 -->
		<div class="col-lg-8">
			<div class="card card-header-actions mb-4 mb-lg-0">
				<div class="mb-3">
					<div class="card-header">
						문서양식 <i class="text-muted" data-feather="info"
							data-bs-toggle="tooltip" data-bs-placement="left"></i>
					</div>
					<select class="form-control" name="tmpltNo" id="exampleFormControlSelect1" onchange="ChangeVal(this)">
						<option value="-1" selected>선택</option>
						<c:forEach var="tmpltVO" items="${tmpltVOList}" varStatus="stat">
							<option value="${tmpltVO.tmpltNo}">${tmpltVO.tmpltTtl}</option>
						</c:forEach>
					</select>
					<!-- 공통서식 시작 -->
					<!-- ///////////////////////////////////////select 하면 문서 양식 제목 출력나와야됨/////////////////////////////////////// -->
<%-- 					<p>${emp}</p> --%>
					<div id="tmpltOut" style="font: bold 2.0em 돋움체; text-align: center;"> </div>
					<span 
						style="font-family: &amp; amp; quot; 맑은 고딕&amp;amp; quot;; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
						<table id="comTable"
							style="border: 1px solid rgb(0, 0, 0); font-family: malgun gothic, dotum, arial, tahoma; margin-top: 30px; margin-left: 40px; border-collapse: collapse;">
							<!-- User -->
							<colgroup>
								<col width="350">
								<col width="460">
							</colgroup>
							<tbody>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
										문서번호</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
										<span unselectable="on" contenteditable="false"
										class="comp_wrap" data-cid="11" data-dsl="{{label:draftUser}}"
										data-wrapper=""
										style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
										data-value="" data-autotype=""><span class="comp_item"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${comList.eatrztNo}</span><span
											contenteditable="false" class="comp_active"
											style="display: none; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<span class="Active_dot1"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot2"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
												<span class="Active_dot3"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot4"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
										</span> <span contenteditable="false" class="comp_hover"
											data-content-protect-cover="true" data-origin="11"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<a contenteditable="false"
												class="ic_prototype ic_prototype_trash"
												data-content-protect-cover="true"
												data-component-delete-button="true"></a>
										</span> </span><br>
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
										기안자</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
										<span unselectable="on" contenteditable="false"
										class="comp_wrap" data-cid="12" data-dsl="{{label:draftDept}}"
										data-wrapper=""
										style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
										data-value="" data-autotype=""><span class="comp_item"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											${comList.empNm}
											</span><span
											contenteditable="false" class="comp_active"
											style="display: none; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<span class="Active_dot1"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot2"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
												<span class="Active_dot3"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot4"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
										</span> <span contenteditable="false" class="comp_hover"
											data-content-protect-cover="true" data-origin="12"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<a contenteditable="false"
												class="ic_prototype ic_prototype_trash"
												data-content-protect-cover="true"
												data-component-delete-button="true"></a>
										</span> </span><br>
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
										부서</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
										<span unselectable="on" contenteditable="false"
										class="comp_wrap" data-cid="13" data-dsl="{{label:draftDate}}"
										data-wrapper=""
										style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
										data-value="" data-autotype=""><span class="comp_item"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${comList.deptNm}</span><span
											contenteditable="false" class="comp_active"
											style="display: none; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<span class="Active_dot1"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot2"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
												<span class="Active_dot3"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot4"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
										</span> <span contenteditable="false" class="comp_hover"
											data-content-protect-cover="true" data-origin="13"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<a contenteditable="false"
												class="ic_prototype ic_prototype_trash"
												data-content-protect-cover="true"
												data-component-delete-button="true"></a>
										</span> </span><br>
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
										직위</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
										<span unselectable="on" contenteditable="false"
										class="comp_wrap" data-cid="14" data-dsl="{{label:docNo}}"
										data-wrapper=""
										style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
										data-value="" data-autotype=""><span class="comp_item"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${comList.comcdCdnm}</span><span
											contenteditable="false" class="comp_active"
											style="display: none; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<span class="Active_dot1"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot2"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
												<span class="Active_dot3"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot4"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
										</span> <span contenteditable="false" class="comp_hover"
											data-content-protect-cover="true" data-origin="14"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<a contenteditable="false"
												class="ic_prototype ic_prototype_trash"
												data-content-protect-cover="true"
												data-component-delete-button="true"></a>
										</span> </span><br>
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
										기안일</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
										<span unselectable="on" contenteditable="false"
										class="comp_wrap" data-cid="14" data-dsl="{{label:docNo}}"
										data-wrapper=""
										style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
										data-value="" data-autotype=""><span class="comp_item"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<fmt:formatDate value="${comList.eatrztRepdt}" pattern="yyyy-MM-dd" />
											</span><span
											contenteditable="false" class="comp_active"
											style="display: none; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<span class="Active_dot1"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot2"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
												<span class="Active_dot3"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot4"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
										</span> <span contenteditable="false" class="comp_hover"
											data-content-protect-cover="true" data-origin="14"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<a contenteditable="false"
												class="ic_prototype ic_prototype_trash"
												data-content-protect-cover="true"
												data-component-delete-button="true"></a>
										</span> </span><br>
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 12px; font-weight: bold; vertical-align: middle;">
										제목</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 12px; font-weight: normal; vertical-align: middle;">
										<span unselectable="on" contenteditable="false"
										class="comp_wrap" data-cid="14" data-dsl="{{label:docNo}}"
										data-wrapper=""
										style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"
										data-value="" data-autotype=""><span class="comp_item"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
											<input class="noBorder" type="text" name="eatrztTtl" id="eatrztTtl" value="" style="width:100%;" />
											</span><span
											contenteditable="false" class="comp_active"
											style="display: none; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<span class="Active_dot1"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot2"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
												<span class="Active_dot3"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span><span
												class="Active_dot4"
												style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;"></span>
										</span> <span contenteditable="false" class="comp_hover"
											data-content-protect-cover="true" data-origin="14"
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
												<a contenteditable="false"
												class="ic_prototype ic_prototype_trash"
												data-content-protect-cover="true"
												data-component-delete-button="true"></a>
										</span> </span><br>
									</td>
								</tr>
							</tbody>
						</table>
					</span>
					<!-- 공통서식 끝 -->
				</div>
			</div>
			<!-- 문서양식 선택 끝 -->

			<!-- 편집내용 시작 -->
			<div id="margin" class="card card-header-actions mb-4 mb-lg-0">
				<div id="default">
					<div class="card mb-4">
						<div class="card-body">
							<!-- 에디터 컨테이너 -->
							<div class="EasyMDEContainer editor-container" role="application">
								<!-- 에디터 -->
								<div class="CodeMirror cm-s-easymde CodeMirror-wrap"
									translate="no" style="clip-path: inset(0px);">
									<!-- 에디터 스크롤 영역 -->
									<div class="CodeMirror-scroll" tabindex="-1"
										style="min-height: 10px;">
										<!-- 에디터 크기 조절기 -->
										<div class="CodeMirror-sizer"
											style="margin-left: 0px; margin-bottom: 100px; border-right-width: 33px; min-height: 111px; padding-right: 0px; padding-bottom: 0px;">
											<!-- 에디터 내용 -->
											<div style="position: relative; top: 0px;">
												<!-- 에디터 라인 -->
												<div class="CodeMirror-lines" role="presentation">
													<div role="presentation"
														style="position: relative; outline: none;">
														<!-- 에디터 메져러 -->
														<div class="CodeMirror-measure"></div>
														<div style="position: relative; z-index: 1;"></div>
														<!-- 커서 -->
														<div class="CodeMirror-cursors">
															<div class="CodeMirror-cursor">&nbsp;</div>
															<!-- 에디터 -->
															<div id="hpropOpinion" style="color: black;"></div>
															<textarea rows="5" cols="30" name="eatrztCn" id="hpropOpinionTemp"></textarea>
															<!-- ck Editer -->
														</div>
													</div>
													<!-- 등록/취소 버튼 -->
													<div class="card-body"
														style="display: flex; justify-content: center;">
														<button class="btn btn-primary me-2 my-1" type="submit">상신</button>
														<button class="btn btn-light me-2 my-1" type="button">취소</button>
													</div>
												</div>
											</div>
										</div>
										<!-- 에디터 커서 -->
										<div
											style="position: absolute; height: 33px; width: 1px; border-bottom: 0px solid transparent; top: 71px;"></div>
										<!-- 에디터 가터 -->
										<div class="CodeMirror-gutters" style="display: none;"></div>
									</div>
								</div>
								<!-- 에디터 미리보기 -->
								<div class="editor-preview-side editor-preview"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 편집내용 끝 -->
		</div>
		<!-- 오른쪽 구역 시작  -->
<%-- 		<p>${atrzlnList}</p> --%>
		<div class="col-lg-4">
			<div class="card card-header-actions">
				<div class="card-header">
					결재선
					<button class="fw-500 btn btn-primary-soft text-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalLg">결재자 선택</button>
					<div class="modal fade" id="exampleModalLg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">결재자 선택</h5>
									<button class="btn-close closeBtn" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<!-- modal시작 -->
								<div class="modal-body" style="display: flex;">
									<div>
									<!-- 왼쪽 구역 시작 -->
									<div class="datatable-search" style="flex: 1; display: flex; align-items: center;">
										<input class="datatable-input" placeholder="결재자 검색" type="text" title="Search within table" id="schName" style="width: 70%;" />
										<button type="button" class="btn btn-primary" onclick="fSch()" style="margin-left: 5px;">검색</button>
									</div>
									<div id="jstree" style="flex: 1px;"></div>
									</div>
									<!-- 왼쪽 구역 끝 -->
									<div style="flex: 2; margin-left: 20px;">		
										<table class="table">
											<thead>
												<tr>
													<th>순번</th>
													<th>결재자명</th>
													<th>부서</th>
													<th>직위</th>
													<th>선택</th>
												</tr>
											</thead>
											<tbody id="list">
											</tbody>
										</table>
									</div> 	
								</div>
								<div class="modal-footer">
									<button class="btn btn-primary" type="button" onclick="fn_ATR()">확인</button>
								</div>
								<!-- modal끝 -->
							</div>
						</div>
					</div>
				</div>
				<div class="card-body">
					<!-- 지울까말까 -->
					<div class="d-grid mb-3"></div>
					<table class="table">
						<thead>
							<tr>
								<th>순번</th>
								<th>결재자명</th>
								<th>직위</th>
								<th>부서</th>
							</tr>
						</thead>
						<tbody id="selectedAtrs">
							<!-- 결재자 select 값 불러오는 영역-->
						</tbody>
					</table>
				</div>
			</div>

			<div class="card card-header-actions">
				<div class="card-header">
					<label for="file1">첨부파일</label>
					<input type="file" id="file" name="file" multiple />
					<div class="fw-500 btn btn-primary-soft text-primary" 
						onclick="document.getElementById('file').click()">파일업로드</div>
				</div>

				<div class="card-body">
					<!-- 지울까말까 -->
					<div class="d-grid mb-3"></div>
					<!-- 테이블 시작 -->
					<table class="table">
						<thead>
							<tr>
								<th>순번</th>
								<th>파일명</th>
								<th>크기</th>
							</tr>
						</thead>

						<tbody id="selectedFiles">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 오른쪽 구역 끝 -->
	</div>
	<sec:csrfInput/>
	</form>
</div>

<script type="text/javascript">
//결재자 모달 초기화 함수
function resetModal(){
	document.getElementById("empNo").value = -1;
    document.getElementById("list").innerHTML = "";
    emptySel.length = 0;
}

//결재자 모달 닫기버튼
$(".closeBtn").on("click", function(){
	$("#empNo option:selected").prop("selected", false);
	resetModal();
});

//결재자 목록 출력
const tbody = document.querySelector("#list");
var emptySel = [];
	
const deptName = {
	"A001":"개발부"		
	,"A002":"영업부"		
	,"A003":"인사부"		
	,"A004":"회계부"
	,"A005":"기획부"
}

const empJbgdNm = {
	"A105":"사원"		
	,"A104":"대리"		
	,"A103":"과장"				
	,"A102":"부장"				
	,"A101":"사장"				
}

function fn_atrzln(node) {
	const empNo = node.original.id;
    if(!empNo.includes("EMP")){
		return;  // 암것도 안하깅!
	}	

	const empNm = node.original.text.split(" ")[0];
	const deptNo = node.original.parent;
	const empJbgdNmCode = node.original.text.split(" ")[1];
	
	if (emptySel.includes(empNo)) {
		    alert("결재자를 중복할 수 없습니다. 다시 선택해주세요");
		    return;
	}
	  	
	emptySel.push(empNo);	  
	console.log(emptySel);
	let rowCount = document.querySelector("#list").rows.length + 1;
	console.log("선영아님",rowCount);
	  	
  	let listRow = `
		<tr class="form-group" id="\${empNo}">
            <td>\${rowCount}</td>
            <td>\${empNm}</td>
            <td>\${deptName[deptNo]}</td>
            <td>\${empJbgdNmCode}</td>
            <td>
            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
            		class="bi bi-trash3" viewBox="0 0 16 16" role="button">
            	<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
            	</svg></td>
		</tr>
  	`;
  	
  	let selectedAtrsRow = `
		<tr class="form-group2" id="\${empNo}">
            <td>\${rowCount}</td>
            <td>\${empNm}<input type="hidden" name="atrzlnVOList[\${rowCount - 1}].empNo" value="\${empNo}" /></td>
            <td>\${deptName[deptNo]}</td>
            <td>\${empJbgdNmCode}</td>
            <td></td>
		</tr>
  	`;
  	
  	document.querySelector("#list").innerHTML += listRow;
    document.querySelector("#selectedAtrs").innerHTML += selectedAtrsRow;
}           

//jstree 클릭이벤트
 $('#jstree').on("select_node.jstree", function (e, data) {
	console.log("select했을땡", data.node);
  	
	// 선택된 노드 정보로 테이블에 행 추가
	fn_atrzln(data.node);    
 });

 //jstree 검색
function fSch() {
    $('#jstree').jstree(true).search($("#schName").val());
}
 // 오자마자 하는 아작스
$.ajax({
	url:"/dept/getJsTree",
	contentType:"application/json;charset=utf-8",
	dataType:"json",
	type:"post",
	beforeSend:function(xhr){
		xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	},
	success:function(result){
		$("#jstree").jstree({
			"plugins": ["search"],
			'core': {
			'data': result,
			"check_callback": true,  // 요거이 없으면, create_node 안먹음
			}
		});
	}
});

//문서서식 출력	
function ChangeVal(sySelect){
   if(sySelect.value == -1){
      return;
   }
   
   const selectedText = sySelect.options[sySelect.selectedIndex].text;
   const tmpltOut = document.getElementById('tmpltOut');
   tmpltOut.textContent = selectedText;
   
   let data = {
      "tmpltNo":sySelect.value   
   };
   
   //console.log("data : ", data);
   
   $.ajax({
      url:"/eatrzt/createPost",
      contentType:"application/json;charset=utf-8",
      data:JSON.stringify(data),
      type:"post",
      dataType:"json",
	  beforeSend:function(xhr){
		xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  },
      success:function(result){
         CKEDITOR.instances.hpropOpinionTemp.setData(result.tmpltCn);
//          document.getElementById("hpropOpinionTemp").value = result.tmpltCn;
         console.log("result:", result.tmpltCn);
      }
   });
}

CKEDITOR.replace("eatrztCn");

$(function() { <!-- ck Editer -->
//checkEditor 내용 => textarea 복사

//      editor.setData($("#hpropOpinionTemp").val());
   
   $(".ck-blurred").keydown(function() {
       console.log("str :" + window.editor.getData());
    $("#message").val(window.editor.getData());
   });

   $(".ck-blurred").on("focusout", function() {
       $("#message").val(window.editor.getData());
   });
});

//결재자 선택
function fn_ATR() {
        // 모달닫기
        var myModalEl = document.getElementById('exampleModalLg');
        var modal = bootstrap.Modal.getInstance(myModalEl);
        modal.hide();
}

function resetModal() {
    // 필요한 경우 모달을 초기화하는 함수
}

// jQuery를 사용하여 SVG 클릭 이벤트를 처리하여 행을 삭제하는 함수
$(document).on('click', '.bi-trash3', function() {
	 var rowToDelete = $(this).closest('tr');
     var empNo = rowToDelete.attr('id'); // 삭제할 행의 empNo 값을 가져옵니다.

     // listTable에서 empNo에 해당하는 행을 삭제합니다.
     $('#list').find('tr[id="' + empNo + '"]').remove();

     // selectedAtrsTable에서 empNo에 해당하는 행을 삭제합니다.
     $('#selectedAtrs').find('tr[id="' + empNo + '"]').remove();
	 
	 $('.form-group2').each(function(index) {
         $(this).find('input[type="hidden"]').attr('name', 'atrzlnVOList[' + index + '].empNo');
         $(this).find('td:first').text(index + 1);
     });
	 $('.form-group').each(function(index) {
         $(this).find('td:first').text(index + 1);
     });
	
	 emptySel = emptySel.filter(item => item !== empNo);
	 console.log(emptySel);
	 
});

//파일 목록 출력하깅
document.addEventListener('DOMContentLoaded', function() {
	var fileInput = document.getElementById('file');
	var fileList = document.getElementById('selectedFiles');
	var fileCount = 0; // 파일의 총 개수를 추적하기 위한 변수
	
	if (!fileInput || !fileList) {
	    console.error('필수 요소가 없습니다. HTML 구조를 확인하세요.');
	    return;
	}
	
	fileInput.addEventListener('change', function(event) {
	    var selectedFiles = event.target.files;
	
	    for (var i = 0; i < selectedFiles.length; i++) {
	        var file = selectedFiles[i];
	        var row = document.createElement('tr');
	        fileCount++; // 새로운 파일이 추가될 때마다 증가
	
	        var cellIndex = document.createElement('td');
	        cellIndex.textContent = fileCount; // 파일 순번
	        row.appendChild(cellIndex);
	
	        var cellName = document.createElement('td');
	        cellName.textContent = file.name;
	        row.appendChild(cellName);
	
	        var cellSize = document.createElement('td');
	        cellSize.textContent = (file.size / 1024).toFixed(2) + ' KB';
	        row.appendChild(cellSize);
	
	        fileList.appendChild(row);
	    }
	});
});
	
document.getElementById('myForm').addEventListener('submit', function(event) {
    event.preventDefault(); // 폼 제출 기본 동작을 막음

    // SweetAlert을 사용하여 확인 메시지 표시
    Swal.fire({
        title: "결재를 상신하시겠습니까?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "네",
        cancelButtonText: "아니오"
    }).then((result) => {
        if (result.isConfirmed) {
            // 승인 확인 창을 띄운 후 페이지를 리다이렉트 합니다.
            Swal.fire({
                title: "상신되었습니다.",
                icon: "success"
            }).then(() => {
                // 최종 확인 후 폼을 제출하여 서버로 전송합니다.
                document.getElementById('myForm').submit();
            });
        }
    });
});
	
</script>