<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<style>
#comTable tbody{
	font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

.vertical-text {
    writing-mode: vertical-rl; /* 세로 쓰기 모드 */
    white-space: nowrap; /* 텍스트가 줄 바꿈 없이 한 줄로 표시되도록 설정 */
    padding: 0; /* 패딩 제거 */
    height: 50px; /* 높이 조정 (필요에 따라 수정 가능) */
    vertical-align: middle; /* 수직 정렬을 가운데로 설정 */
    text-align: center;
}


.atrlzStyle {
	border: 1px solid black;
}

.atrlzStyle tr {
	border: 1px solid black;
}

.atrlzStyle th {
	border: 1px solid black;
}

.syTbody td {
	border: 1px solid black;
    width:80px;
    height:80px;
} 

.buttonStyle{
	margin: 0 auto;
}

div#rightStyle {
	overflow:hidden;
	height:auto;
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
</style>
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
   <div class="container-fluid px-4">
      <div class="page-header-content">
         <div class="row align-items-center justify-content-between pt-3">
            <div class="col-auto mb-3">
               <h1 class="page-header-title">
                  <div class="page-header-icon"><i data-feather="file-plus"></i></div>
                  	전자결재 상세조회
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
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.emp"  var="eatrztEmp"  />
</sec:authorize>
	<div class="row gx-4">
		<div class="col-lg-8">
			<div class="card card-header-actions mb-4 mb-lg-0">
				<center>
				<div class="mb-3" id="pdfArea">
					<br /><br /><br /><br /><div style="color:black; font-weight: bold; font-size: 48px; font-family: 돋움체; text-align: center;">${getEatrzt.tmpltTtl}</div><br /><br />
			   <!-- ///////////////결재선 시작/////////////// -->
               <div class="row" style="color: black;">
                  <!-- /////////기안자 결재선 시작/////////-->
                  <div class="col-sm-5">
                     <table class="atrlzStyle" style="margin-right: 50px;">
                          <tr>
                              <th class="vertical-text" rowspan="3"> 신&nbsp;청 </th>
                              <th style="text-align: center;">${getEatrzt.comcdCdnm}</th>
                          </tr>
                          <tr style="height:70px">
                              <th><img src="/download/${getEatrzt.empNo}/2" style="height: 70px; margin-left: 10px"></th>
                          </tr>
                          <tr>
                              <th><fmt:formatDate value="${getEatrzt.eatrztRepdt}" pattern="yyyy-MM-dd" /></th>
                          </tr>
                     </table>
                  </div>
                  <!-- /////////기안자 결재선 끝/////////-->
               
                  <!-- /////////결재자 결재선 시작/////////-->
					<div class="col-sm-7">
    <table class="atrlzStyle" style="margin-left: 30px;">
        <tr>
            <th class="vertical-text" rowspan="3">결&nbsp;재</th>
            
            <c:choose>
                <c:when test="${stampAtrList2[1].atrzlnDt != null}">
                    <th style="text-align: center;">${stampAtrList2[1].comcdCdnm}</th>
                </c:when>
                <c:otherwise>
                    <th style="text-align: center; width: 98px; height: 27px;"></th>
                </c:otherwise>
            </c:choose>
            
            <c:choose>
                <c:when test="${stampAtrList2[2].atrzlnDt != null}">
                    <th style="text-align: center;">${stampAtrList2[2].comcdCdnm}</th>
                </c:when>
                <c:otherwise>
                    <th style="text-align: center; width: 98px; height: 27px;"></th>
                </c:otherwise>
            </c:choose>
            
             <c:if test="${fn:length(stampAtrList2) > 3}">
	            <c:choose>
	                <c:when test="${stampAtrList2[3].atrzlnDt != null}">
	                    <th style="text-align: center;">${stampAtrList2[3].comcdCdnm}</th>
	                </c:when>
	                <c:otherwise>
	                    <th style="text-align: center; width: 98px; height: 27px;"></th>
	                </c:otherwise>
	            </c:choose>
	           </c:if> 
        </tr>
        
        <tr style="height:70px">
            <c:choose>
                <c:when test="${stampAtrList2[1].atrzlnDt != null}">
                    <th><img src="/download/${stampAtrList[1].empNo}/2" style="height: 70px; margin-left: 10px"></th>
                </c:when>
                <c:otherwise>
                    <th style="height: 70px; width: 98px;"></th>
                </c:otherwise>
            </c:choose>
            
            <c:choose>
                <c:when test="${stampAtrList2[2].atrzlnDt != null}">
                    <th><img src="/download/${stampAtrList[2].empNo}/2" style="height: 70px; margin-left: 10px"></th>
                </c:when>
                <c:otherwise>
                    <th style="height: 70px; width: 98px;"></th>
                </c:otherwise>
            </c:choose>
            
            
            <c:if test="${fn:length(stampAtrList2) > 3}">
	            <c:choose>
	                <c:when test="${stampAtrList2[3].atrzlnDt != null}">
	                    <th><img src="/download/${stampAtrList[3].empNo}/2" style="height: 70px; margin-left: 10px"></th>
	                </c:when>
	                <c:otherwise>
	                    <th style="height: 70px; width: 98px;"></th>
	                </c:otherwise>
	            </c:choose>
            </c:if>
        </tr>
        
        <tr style="height:27px">
            <c:choose>
                <c:when test="${stampAtrList2[1].atrzlnDt != null}">
                    <th><fmt:formatDate value="${stampAtrList2[1].atrzlnDt}" pattern="yyyy-MM-dd" /></th>
                </c:when>
                <c:otherwise>
                    <th style="text-align: center; width: 98px; height: 27px;"></th>
                </c:otherwise>
            </c:choose>
            
            <c:choose>
                <c:when test="${stampAtrList2[2].atrzlnDt != null}">
                    <th><fmt:formatDate value="${stampAtrList2[2].atrzlnDt}" pattern="yyyy-MM-dd" /></th>
                </c:when>
                <c:otherwise>
                    <th style="text-align: center; width: 98px; height: 27px;"></th>
                </c:otherwise>
            </c:choose>
            
            <c:if test="${fn:length(stampAtrList2) > 3}">
	           <c:choose>
	               <c:when test="${stampAtrList2[3].atrzlnDt != null}">
	                   <th><fmt:formatDate value="${stampAtrList2[3].atrzlnDt}" pattern="yyyy-MM-dd" /></th>
	               </c:when>
	               <c:otherwise>
	                   <th style="text-align: center; width: 98px; height: 27px;"></th>
	               </c:otherwise>
	           </c:choose>
            </c:if>
        </tr>
    </table>
</div>
					<!-- /////////결재자 결재선 끝/////////-->
               </div><br />
                <!-- ///////////////결재선 끝/////////////// -->
					<!-- 공통서식 시작 -->
					<span
						style="font-family: &amp; amp; quot; amp; quot; font-size: 10pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">
						<table id="comTable"
							style="border: 1px solid rgb(0, 0, 0); font-family: malgun gothic, dotum, arial, tahoma; margin-top: 30px; border-collapse: collapse;">
							<!-- User -->
							<colgroup>
								<col width="350">
								<col width="449">
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
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${getEatrzt.eatrztNo}</span><span
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
											${getEatrzt.empNm}
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
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${getEatrzt.deptNm}</span><span
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
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${getEatrzt.comcdCdnm}</span><span
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
											<fmt:formatDate value="${getEatrzt.eatrztRepdt}" pattern="yyyy-MM-dd" />
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
											style="font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt; line-height: normal; margin-top: 0px; margin-bottom: 0px;">${getEatrzt.eatrztTtl}</span><span
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
					</br>
					
<!-- 					<button class="btn btn-success approver-btn" type="button" id="hldyBtn">연차확인용</button> -->
					<div id="hldyDate" style="color: black; font-size: 12px; font-weight: bold;">
						${getEatrzt.eatrztCn}
					</div>	
				</div>
				<br /><br /><br /><br /><br /><br /><br /><br />
				</center>
			</div>
		</div>
		<!-- 오른쪽 구역 시작  -->
<%-- 		<p>${atrzlnList}</p> --%>
		<div class="col-lg-4">
			<div class="card card-header-actions" id="rightStyle">
				<!-- 결재선 정보 -->
				<div id="atrInfo">
					<input type="hidden" name="atrzlnNo" value="${eatrztVO.atrzlnNo}" />
					<input type="hidden" name="eatrztNo" value="${eatrztVO.eatrztNo}" />
<%-- 					<input type="hidden" name="atrzlnPro" value="${eatrztVO.atrzlnPro}" /> --%>
				</div>
				<sec:csrfInput/>
				
				<div class="card-body buttonStyle">
					<!-- 지울까말까 -->
					<div class="d-grid mb-3"></div>
						<c:choose>
		                    <c:when test="${eatrztEmp.empNo eq getEatrzt.empNo and getEatrzt.eatrztPrcsYn ne 'Y' and getEatrzt.eatrztPrcsYn ne 'N'}">
			                    <!-- 기안자 버튼 / 완성-->
								<button class="btn btn-dark drafter-btn" type="button" id="printBtn">다운로드</button>
								<button class="btn btn-link drafter-btn" type="button"><a href="/eatrzt/docBoxList">목록</a></button>
							</c:when>
							<c:when test="${eatrztEmp.empNo eq getEatrzt.empNo and getEatrzt.eatrztPrcsYn eq 'Y'}">
								<button class="btn btn-dark approver-btn" type="button" id="printBtn" >다운로드</button>
								<button class="btn btn-link approver-btn" type="button"><a href="/eatrzt/docBoxList">목록</a></button>
							</c:when>
					
							<c:when test="${getEatrzt.eatrztPrcsYn eq 'N'}">
								<button class="btn btn-outline-primary" type="button"><a href="/eatrzt/create">재기안</a></button>
								<button class="btn btn-light clsEatrztNo" type="button" data-eatrzt-no="${getEatrzt.eatrztNo}">삭제</button>
								<button class="btn btn-dark" type="button" id="printBtn">다운로드</button>
								<button class="btn btn-link" type="button"><a href="/eatrzt/eatrztHome">목록</a></button>
							</c:when>
							
							<c:when test="${check.atrzlnDt ne null}">
								<button class="btn btn-dark approver-btn" type="button" id="printBtn" >다운로드</button>
								<button class="btn btn-link approver-btn" type="button"><a href="/eatrzt/eatrztHome">목록</a></button><!-- 살릴지 말지 고민.. -->
							</c:when>
							
							<c:otherwise>
								<!-- 결재자 버튼 -->
								<button class="btn btn-success approver-btn" type="button" id="updateBtn">결재</button>
								<button class="btn btn-danger approver-btn" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalLg">반려</button>
								<div class="modal fade" id="exampleModalLg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
								    <div class="modal-dialog modal-lg" role="document">
								        <div class="modal-content">
								            <div class="modal-header">
								                <h5 class="modal-title">반려사유</h5>
								                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
								            </div>
								            <div class="modal-body" style="margin: auto;">
								                <textarea cols="70" rows="7" placeholder="반려사유를 입력해주세요."></textarea>
								            </div>
								            <div class="modal-footer">
								            	<button class="btn btn-primary" type="button" id="noBtn">등록</button>
<!-- 								            	<button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button> -->
								            </div>
								        </div>
								    </div>
								</div>
								
								<button class="btn btn-dark approver-btn" type="button" id="printBtn">다운로드</button>
								<button class="btn btn-link approver-btn" type="button"><a href="/eatrzt/beforeApvBoxList">목록</a></button><!-- 살릴지 말지 고민.. -->
							</c:otherwise>
						</c:choose>
				</div><br/>
				
				<div class="card-header">
					첨부파일
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
						
						<!-- 파일이 1일 때만 출력 아니면 안 보이게 -->

						<tbody id="getFiles">
							<c:forEach var="attach" items="${attachList}" varStatus="stat">
								<c:if test="${attach.afSz != 0}">
									<tr>
										<td>${attach.afSeq}</td>
										<!-- 파일번호 -->
										<%-- <td>${attach.afNm}</td> --%>
										<td>${fn:substringAfter(attach.afNm, '_')}</td>
										<!-- 파일명 -->
										<td>${attach.afSz}KB</td>
										<!-- 파일크기 -->
									</tr>
								</c:if>
							</c:forEach>
							<!-- 선택된 파일 조회 -->
						</tbody>
						<c:if test="${attach.afSz == 0}">
							<!-- 파일이 0개이거나 1개가 아닐 때 출력할 내용이 있으면 여기에 추가 -->
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</c:if>

					</table>
				</div>
			</div>
		</div>
		<!-- 오른쪽 구역 끝 -->
	</div>
	<sec:csrfInput/>
</div>

<script type="text/javascript">
let atrzlnNo = "${eatrztVO.atrzlnNo}";
let eatrztNo = "${eatrztVO.eatrztNo}";

$(function () {
	 // jsPDF 객체를 가져오기 위해 jsPDF 네임스페이스에서 가져옴
    const { jsPDF } = window.jspdf;
    
    //기안문서 삭제 처리
    $(".clsEatrztNo").on("click",function(){
    	let delEatrztNo = $(this).data("eatrztNo");
    	console.log("delEatrztNo : " + delEatrztNo);//D059
    	
    	//비동기 처리
    	//EATRZ테이블의 EATRZT_DELTDT 컬럼의 값을 SYSDATE로 update처리
    	//success에 result를 받아서(dataType:"text")=>location.href="/eatrzt/eatrztHome";
    	//반려
   		let data = {
   			"eatrztNo" : delEatrztNo
   		};
   		
   		console.log("data : ", data);
   		
   		$.ajax({
   			url:"/eatrzt/delUpdate",
   			contentType:"application/json;charset=utf-8",
   			data:JSON.stringify(data),
   			type:"post",
   			dataType:"text",
   			beforeSend:function(xhr){
   				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
   			},
   			success:function(result){
   				location.href = '/eatrzt/eatrztHome';
   			}
   		});
    });
    
    //연차확인 버튼
    $("#hldyBtn").on('click', function() {
    	var period = $("#hldyDate").children().children().children().eq(0).children().eq(1).text().split('~');
    	var strDay = period[0].trim();
    	var endDay = period[1].trim();
    	
//     	table tbody tr:nth-child(2) td:nth-child(2)").text();
        console.log("연차 기간: ", period);
        console.log("시작일: ", strDay);
        console.log("종료일: ", endDay);
    });

    $("#printBtn").on('click', function() {
        // pdfArea 영역을 캡처
        html2canvas($('#pdfArea')[0], {
            allowTaint: true,  // 교차 출처 이미지를 캡처할 수 있도록 설정
            useCORS: true,     // CORS 사용한 서버로부터 이미지 로드할 것인지 여부
            scale: 2           // 기본 96dpi에서 해상도를 두 배로 증가
        }).then(function(canvas) {
            // 캔버스를 이미지로 변환
            const imgData = canvas.toDataURL('image/png');

            // 이미지와 페이지 크기 계산
            const imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
            const pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
            const imgHeight = canvas.height * imgWidth / canvas.width;
            let heightLeft = imgHeight;
            const margin = 10; // 출력 페이지 여백설정
            const doc = new jsPDF('p', 'mm');
            let position = 0;

            // 첫 페이지에 이미지 추가
            doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;

            // 여러 페이지가 필요한 경우 루프를 돌면서 이미지 추가
            while (heightLeft >= 20) {
                position = heightLeft - imgHeight;
                position -= 20; // 페이지 사이 간격 설정

                doc.addPage();
                doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }

            // PDF 파일 저장
            doc.save('filename.pdf');
        }).catch(function(error) {
            console.error('html2canvas error:', error);
        });
    });
	
	//반려
	$("#noBtn").on("click", function () {
		
		let data = {
			"eatrztNo" : eatrztNo
		};
		
		console.log("data : ", data);
		
		$.ajax({
			url:"/eatrzt/reAtrUpdatePost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				Swal.fire({
		            title: "결재를 반려하시겠습니까?",
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
		                    title: "반려되었습니다.",
		                    icon: "success"
		                }).then(() => {
		                    // 최종 확인 후 페이지를 리다이렉트합니다.
		                    location.href = '/eatrzt/eatrztHome';
		                });
		            }
		        });				
			}
		});
		
	});
	
	//결재 업데이트
	$("#updateBtn").on("click", function () {
// 		var period = $("#hldyDate").children().children().children().eq(1).children().eq(1).text().split('~');
		var period = "";
		//휴가1
		var period1 = $("#hldyDate").children().children().children().eq(6).children().eq(1).text().split('~');
		//출장2
		var period2 = $("#hldyDate").children().children().children().eq(0).children().eq(1).text().split('~');
		//연차3
		var period3 = $("#hldyDate").children().children().children().eq(1).children().eq(1).text().split('~');
		//휴가(조퇴,휴직)4
		var period4 = $("#hldyDate").children().children().children().eq(6).children().eq(1).text().split('~');
		var strDay = "";
    	var endDay = "";
		
    	var empNo = "${getEatrzt.empNo}";
    	var tmpltNo = "${getEatrzt.tmpltNo}";
    	var hsNo = "";
    	var hmlRsn = "${getEatrzt.eatrztTtl}";
		
    	if(tmpltNo == '6'){
    		hsNo = '3';
    		period = period3;
    	}else if (tmpltNo == '5') {
    		hsNo = '2';
    		period = period2;
		}else if (tmpltNo == '1') {
			hsNo = '1';
			period = period1;
		}else if (tmpltNo == '4'){
			hsNo = '4';
			period = period4;
		}
    	
    	if(period != ""){
	    	strDay = period[0].trim();
	    	endDay = period[1].trim();    		
    	}
    	
		let data = {
			"atrzlnNo" : atrzlnNo,
			"eatrztNo" : eatrztNo,
			"hmlUseDt" : strDay,
			"hmlEndDt" : endDay,
			"empNo" : empNo,
			"hsNo" : hsNo,
			"hmlRsn" : hmlRsn
		};
		
		console.log("data : ", data);
		
		$.ajax({
		    url: "/eatrzt/atrUpdatePost",
		    contentType: "application/json;charset=utf-8",
		    data: JSON.stringify(data),
		    type: "post",
		    dataType: "text",
		    beforeSend: function(xhr) {
		        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    success: function(result) {
		        Swal.fire({
		            title: "결재를 승인하시겠습니까?",
		            icon: "warning",
		            showCancelButton: true,
		            confirmButtonColor: "#3085d6",
		            cancelButtonColor: "#d33",
		            confirmButtonText: "승인",
		            cancelButtonText: "취소"
		        }).then((result) => {
		            if (result.isConfirmed) {
		                // 승인 확인 창을 띄운 후 페이지를 리다이렉트 합니다.
		                Swal.fire({
		                    title: "결재되었습니다.",
		                    icon: "success"
		                }).then(() => {
		                    // 최종 확인 후 페이지를 리다이렉트합니다.
		                    location.href = '/eatrzt/eatrztHome';
		                });
		            }
		        });
		    }
		});
		
	});
});


</script>