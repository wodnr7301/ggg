<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
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
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
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

<div class="container-fluid px-4">
	<!-- 편집내용 시작 -->
	<div id="margin" class="card card-header-actions mb-4 mb-lg-0">
		<div id="default">
			<div class="card mb-4">
				<!-- 문서 제목 시작 -->
				<div class="card-body" style="display: flex; justify-content: center;">
					<p><font size=6>휴가신청서 작성 폼이지롱</font></p>
				</div>
				<!-- 문서 제목 끝-->

				<!-- 테스트 시작 -->
<!-- 				<div class="card-body" -->
<!-- 					style="display: flex; justify-content: center;"> -->
<%-- 					<c:forEach var="tmpltVO" items="${tmpltVOList}" varStatus="stat"> --%>
<%-- 						<p>${tmpltVO.tmpltNo}</p> --%>
<%-- 						<p>${tmpltVO.tmpltTtl}</p> --%>
<%-- 						<p>${tmpltVO.tmpltCn}</p> --%>
<%-- 					</c:forEach> --%>
<!-- 				</div> -->
				<!-- 테스트 끝 -->

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
													<!-- 에디터 시작 -->
													<div id="hpropOpinion">
														<!-- ck Editer -->
														<p>테스트</p>
														<c:forEach var="tmpltVO" items="${tmpltVOList}"
															varStatus="stat">
															<p>${tmpltVO.tmpltNo}</p>
															<p>${tmpltVO.tmpltTtl}</p>
															<p>${tmpltVO.tmpltCn}</p>
														</c:forEach>
													</div>
													<!-- 에디터 끝 -->
												</div>
												<!-- 등록/취소 버튼 -->
												<div class="card-body"
													style="display: flex; justify-content: center;">
													<button class="btn btn-primary me-2 my-1" type="button">등록</button>
													<button class="btn btn-light me-2 my-1" type="button">취소</button>
												</div>
											</div>
										</div>
									</div>
									<!-- 에디터 커서 -->
									<div style="position: absolute; height: 33px; width: 1px; border-bottom: 0px solid transparent; top: 71px;"></div>
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
	<div class="col-lg-4">
		<div class="card card-header-actions">
			<div class="card-header">
				결재선 <button class="fw-500 btn btn-primary-soft text-primary">결재자 선택</button>
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

					<tbody>
						<tr>
							<td>1</td>
							<td>정찬우</td>
							<td>부장</td>
							<td>인사부</td>
						</tr>
						<tr>
							<td>2</td>
							<td>이미숙</td>
							<td>과장</td>
							<td>개발부</td>
						</tr>
						<tr>
							<td>3</td>
							<td>이평강</td>
							<td>대리</td>
							<td>개발부</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="card card-header-actions">
			<div class="card-header">
				첨부파일 <button class="fw-500 btn btn-primary-soft text-primary">파일업로드</button>
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

					<tbody>
						<tr>
							<td>1</td>
							<td>휴가신청서</td>
							<td>147bytes</td>
						</tr>
						<tr>
							<td>2</td>
							<td>휴가신청서</td>
							<td>147bytes</td>
						</tr>
						<tr>
							<td>3</td>
							<td>휴가신청서</td>
							<td>147bytes</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 오른쪽 구역 끝 -->
</div>

<script type="text/javascript">
ClassicEditor.create( document.querySelector('#hpropOpinion'),{ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
 .then(editor=>{window.editor=editor;})
 .catch(err=>{console.error(err.stack);});

$(function() { <!-- ck Editer -->
//checkEditor 내용 => textarea 복사
	$(".ck-blurred").keydown(function() {
    	console.log("str :" + window.editor.getData());
    $("#message").val(window.editor.getData());
	});

	$(".ck-blurred").on("focusout", function() {
    	$("#message").val(window.editor.getData());
	});
});
</script>