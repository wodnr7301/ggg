<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        const datatablesSimple1 = document.getElementById('datatablesSimple1');
        if (datatablesSimple1) {
            new simpleDatatables.DataTable(datatablesSimple1, {
                sortable: false,
                searchable: false,
                perPageSelect: false,
                labels: {
                    pageTitle: "Page {page}",
                    info: "",
                }
            }
            );
        }

        const god = document.getElementById('god');
        if (god) {
            new simpleDatatables.DataTable(god, {
                sortable: false,
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
            new simpleDatatables.DataTable(datatablesSimple3, {
                sortable: false,
                searchable: false,
                perPageSelect: false,
                labels: {
                    pageTitle: "Page {page}",
                    info: "",
                }
            }
            );
        }
	
        var ddcInsrnc = $('input[name=ddcInsrnc]');
        var ddcInctx = $('input[name=ddcInctx]');
        var amlAmt = $('input[name=amlAmt]');
        
        const num = document.querySelector('.num');
        num.addEventListener('keyup', function (e) {
            let value = e.target.value;
            value = Number(value.replaceAll(',', ''));
            
            var giveAmt = Number($('input[name=giveAmt]').val().replaceAll(',',''));
            var giveExts = Number($('input[name=giveExts]').val().replaceAll(',',''));
            var giveNight = Number($('input[name=giveNight]').val().replaceAll(',',''));
            var giveHldy = Number($('input[name=giveHldy]').val().replaceAll(',',''));
           
            giveAmt = value;
            
            var give = (giveAmt + giveExts + giveNight + giveHldy);
            
            var insrnc = give * 0.08945;
            var inctx = give * 0.09;
            
            var result = give - (insrnc + inctx);
            
            const format = insrnc.toLocaleString('ko-KR');
        	ddcInsrnc.val(format);
        	
        	const format1 = inctx.toLocaleString('ko-KR');
        	ddcInctx.val(format1);
            
        	const format2 = result.toLocaleString('ko-KR');
        	amlAmt.val(format2);
        	
            if(isNaN(value)) {         //NaN인지 판별
                num.value = 0;   
            }else {                   //NaN이 아닌 경우
                const formatValue = value.toLocaleString('ko-KR');
                num.value = formatValue;
            }
        });
        
        const num2 = document.querySelector('.num2');
        num2.addEventListener('keyup', function (e) {
            let value = e.target.value;
            value = Number(value.replaceAll(',', ''));
            
            var giveAmt = Number($('input[name=giveAmt]').val().replaceAll(',',''));
            var giveExts = Number($('input[name=giveExts]').val().replaceAll(',',''));
            var giveNight = Number($('input[name=giveNight]').val().replaceAll(',',''));
            var giveHldy = Number($('input[name=giveHldy]').val().replaceAll(',',''));
           
            giveExts = value;
            
 			var give = (giveAmt + giveExts + giveNight + giveHldy);
            
            var insrnc = give * 0.08945;
            var inctx = give * 0.09;
            
            var result = give - (insrnc + inctx);
            
            const format = insrnc.toLocaleString('ko-KR');
        	ddcInsrnc.val(format);
        	
        	const format1 = inctx.toLocaleString('ko-KR');
        	ddcInctx.val(format1);
        	
        	const format2 = result.toLocaleString('ko-KR');
        	amlAmt.val(format2);
            
            if(isNaN(value)) {         //NaN인지 판별
            	num2.value = 0;   
            }else {                   //NaN이 아닌 경우
                const formatValue = value.toLocaleString('ko-KR');
                num2.value = formatValue;
            }
        });
        
        const num3 = document.querySelector('.num3');
        num3.addEventListener('keyup', function (e) {
            let value = e.target.value;
            value = Number(value.replaceAll(',', ''));
            
            var giveAmt = Number($('input[name=giveAmt]').val().replaceAll(',',''));
            var giveExts = Number($('input[name=giveExts]').val().replaceAll(',',''));
            var giveNight = Number($('input[name=giveNight]').val().replaceAll(',',''));
            var giveHldy = Number($('input[name=giveHldy]').val().replaceAll(',',''));
           
            giveNight = value;
            
			var give = (giveAmt + giveExts + giveNight + giveHldy);
            
            var insrnc = give * 0.08945;
            var inctx = give * 0.09;
            
            var result = give - (insrnc + inctx);
            
            const format = insrnc.toLocaleString('ko-KR');
        	ddcInsrnc.val(format);
        	
        	const format1 = inctx.toLocaleString('ko-KR');
        	ddcInctx.val(format1);
        	
        	const format2 = result.toLocaleString('ko-KR');
        	amlAmt.val(format2);
            
            if(isNaN(value)) {         //NaN인지 판별
            	num3.value = 0;   
            }else {                   //NaN이 아닌 경우
                const formatValue = value.toLocaleString('ko-KR');
                num3.value = formatValue;
            }
        });
        
        const num4 = document.querySelector('.num4');
        num4.addEventListener('keyup', function (e) {
            let value = e.target.value;
            value = Number(value.replaceAll(',', ''));
            
            var giveAmt = Number($('input[name=giveAmt]').val().replaceAll(',',''));
            var giveExts = Number($('input[name=giveExts]').val().replaceAll(',',''));
            var giveNight = Number($('input[name=giveNight]').val().replaceAll(',',''));
            var giveHldy = Number($('input[name=giveHldy]').val().replaceAll(',',''));
           
            giveHldy = value;
            
			var give = (giveAmt + giveExts + giveNight + giveHldy);
            
            var insrnc = give * 0.08945;
            var inctx = give * 0.09;
            
            var result = give - (insrnc + inctx);
            
            const format = insrnc.toLocaleString('ko-KR');
        	ddcInsrnc.val(format);
        	
        	const format1 = inctx.toLocaleString('ko-KR');
        	ddcInctx.val(format1);
        	
        	const format2 = result.toLocaleString('ko-KR');
        	amlAmt.val(format2);
            
            if(isNaN(value)) {         //NaN인지 판별
            	num4.value = 0;   
            }else {                   //NaN이 아닌 경우
                const formatValue = value.toLocaleString('ko-KR');
                num4.value = formatValue;
            }
        });

        
		$("#btnSave").on("click",function(){
			
			//사원번호
			var empNo = $('select[name=empNo]').val();
			var amlNo = $('input[name=amlNo]').val();
			
			//지급
			var giveNo = $('input[name=giveNo]').val();
			var giveAmt = Math.round(Number($('input[name=giveAmt]').val().replaceAll(',','')));
            var giveExts = Math.round(Number($('input[name=giveExts]').val().replaceAll(',','')));
            var giveNight = Math.round(Number($('input[name=giveNight]').val().replaceAll(',','')));
            var giveHldy = Math.round(Number($('input[name=giveHldy]').val().replaceAll(',','')));
			
            //공제
            var ddcNo = $('input[name=ddcNo]').val();
            var ddcInsrncVal = Math.round(Number(ddcInsrnc.val().replaceAll(',','')));
            var ddcInctxVal = Math.round(Number(ddcInctx.val().replaceAll(',','')));
            
            //입금액
            var amlAmtVal = Math.round(Number(amlAmt.val().replaceAll(',','')));
            
            console.log("empNo : "+empNo);
            console.log("giveAmt : "+giveAmt);
            console.log("giveExts : "+giveExts);
            console.log("giveNight : "+giveNight);
            console.log("giveHldy : "+giveHldy);
            console.log("ddcInsrncVal : "+ddcInsrncVal);
            console.log("ddcInctxVal : "+ddcInctxVal);
            console.log("amlAmtVal : "+amlAmtVal);
            
			//JSON 오브젝트
			let data = {
				"empNo" : empNo,
				"amlNo" : amlNo,
				"giveNo" : giveNo,
				"ddcNo" : ddcNo,
				"giveAmt" : giveAmt,
				"giveExts" : giveExts,
				"giveNight" : giveNight,
				"giveHldy" : giveHldy,
				"ddcInsrnc" : ddcInsrncVal,
				"ddcInctx" : ddcInctxVal,
				"amlAmt" : amlAmtVal,
			};
			
			
	        $.ajax({
	            url : "/salary/updateAjax", // 요기에
	            contentType:"application/json;charset=utf-8",
	            data : JSON.stringify(data), 
	            type : 'POST',
	            beforeSend:function(xhr){
		              xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		            },
	            success : function(result) {
	                console.log(result);
	                if(result==3){
	                	location.href="/salary/all";
	                	$('.toast').toast('show');
	                }
	            }, // success 
	    
	        });
	        
		});

		
	$(".list").on('click',function(){
		window.location.href="/salary/all";
		
		
	});
	
		
    });
</script>
<style>
.block{
    display:inline-block;
    width:90%;
}
#div1{
	text-align: center;
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
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-layout">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                    <line x1="3" y1="9" x2="21" y2="9"></line>
                                    <line x1="9" y1="21" x2="9" y2="9"></line>
                                </svg>
                            </div>
                            급여관리대장 수정
                        </h1>
                        <div class="page-header-subtitle"></div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Main page content-->
    <div class="container-xl px-4 mt-n10">
        <div class="card">
            <div class="card-header">급여관리대장</div>
            <div class="card-body" id="div1">
                <form id="frm" name="frm" method="post">
                    <table id="datatablesSimple1">
                        <thead>
                            <tr>
                                <th>사원번호</th>
                                <th>입금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select class="form-control" id="empNo" name="empNo">
                                        <option selected>사원선택</option>
                                        <c:forEach var="employeeVO" items="${employeeVOList}" varStatus="stat">
                                        	<c:choose>
									            <c:when test="${salary.empNo eq employeeVO.empNo}">
									                <option value="${employeeVO.empNo}" selected="selected">${employeeVO.empNm}</option>
									            </c:when>
									            <c:otherwise>
									                <option value="${employeeVO.empNo}">${employeeVO.empNm}</option>
									            </c:otherwise>
									        </c:choose>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input class="form-control block" id="amlAmt" name="amlAmt" type="text" placeholder="지급입력시 자동반영됩니다." value="${salary.getComma(salary.amlAmt)}" readonly>원</td>
                            </tr>
                        </tbody>
                    </table>

                    <br/>

                    <div class="row">
                        <div class="col-6">
                            <div class="card">
                                <div class="card-header">지급</div>
                                <div class="card-body">
                                	<input type="hidden" id="amlNo" name="amlNo" value="${salary.amlNo}" />
                                	<input type="hidden" id="giveNo" name="giveNo" value="${giveVO.giveNo}" />
                                	<input type="hidden" id="ddcNo" name="ddcNo" value="${ddcVO.ddcNo}" />
                                    <table id='god'>
                                        <thead>
                                            <tr>
                                                <th>항목</th>
                                                <th>금액</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>기본급</td>
                                                <td><input class="form-control num block" id="giveAmt" name="giveAmt" type="text" placeholder="숫자만 입력" value="${giveVO.getComma(giveVO.giveAmt)}">원</td>
                                            </tr>
                                            <tr>
                                                <td>연장근로수당</td>
                                                <td><input class="form-control num2 block" id="giveExts" name="giveExts" type="text" placeholder="미입력시 0원으로 처리" value="${giveVO.getComma(giveVO.giveExts)}">원</td>
                                            </tr>
                                            <tr>
                                                <td>야간근로수당</td>
                                                <td><input class="form-control num3 block" id="giveNight" name="giveNight" type="text" placeholder="미입력시 0원으로 처리" value="${giveVO.getComma(giveVO.giveNight)}">원</td>
                                            </tr>
                                            <tr>
                                                <td>휴일근로수당</td>
                                                <td><input class="form-control num4 block" id="giveHldy" name="giveHldy" type="text" placeholder="미입력시 0원으로 처리" value="${giveVO.getComma(giveVO.giveHldy)}">원</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-6">
                            <div class="card">
                                <div class="card-header">공제</div>
                                <div class="card-body">
                                    <table id='datatablesSimple3'>
                                        <thead>
                                            <tr>
                                                <th>항목</th>
                                                <th>금액</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>4대보험</td>
                                                <td><input class="form-control block" id="ddcInsrnc" name="ddcInsrnc" type="text" placeholder="지급입력시 자동반영됩니다." value="${ddcVO.getComma(ddcVO.ddcInsrnc)}" readonly>원</td>
                                            </tr>
                                            <tr>
                                                <td>소득세</td>
                                                <td><input class="form-control block" id="ddcInctx" name="ddcInctx" type="text" placeholder="지급입력시 자동반영됩니다." value="${ddcVO.getComma(ddcVO.ddcInctx)}" readonly>원</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
		                    <br/><br/>
		                    <div class="text-end">
	                    		<!-- Button trigger modal -->
								<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModalCenter">수정</button>
								<button class="btn btn-secondary list" type="button">목록</button>
	                    	</div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="exampleModalCenterTitle">수정 확인</h5>
	                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">정말 수정 하시겠습니까?</div>
	            <div class="modal-footer"><button class="btn btn-primary" id="btnSave" type="button">수정하기</button><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
	        </div>
	    </div>
	</div>
    
	
	<!-- Position it -->
	<div class="toast-container" style="position: absolute; top: 0; right: 0;">
		
		<div class="toast" role="alert" aria-live="assertive" aria-atomic="true" >
	    <div class="toast-header bg-success text-white">
	        <i data-feather="alert-circle"></i>
	        <strong class="mr-auto">수정 성공!</strong>
	        <small class="text-white-50 ml-2">just now</small>
	        <button class="ml-2 mb-1 btn-close btn-close-white" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
	    </div>
	    <div class="toast-body">급여관리대장 수정 성공!</div>
		</div>
		
	 
	</div>
</main>