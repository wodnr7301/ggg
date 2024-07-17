<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
$(function(){
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
	})
	
	$(document).on('click','#searchNm',function(){
		$('#jstree').jstree(true).search($("#schName").val());
	})
    
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
    function eventJsTree() {
    	$(document).on('click','#searchNm',function(){
    		$('#jstree').jstree(true).search($("#schName").val());
    	})
    	
	  	//이벤트
	    $('#jstree').on("changed.jstree", function (e, data) {
	        console.log(data.selected);
	    });
		
	 	// 전체 펼치기 버튼 클릭 핸들러
        $('#expandAll').on('click', function() {
            $('#jstree').jstree('open_all');
        });

        // 전체 닫기 버튼 클릭 핸들러
        $('#collapseAll').on('click', function() {
            $('#jstree').jstree('close_all');
        });
	  	
	    // Node 열렸을 땡
	    $('#jstree').on("open_node.jstree", function (e, data) {
	        console.log("open되었을땡", data.node);
	        $('.moveDept').attr('data-return-dept', data.node.id);
	        
	        $.ajax({
	        	url:"/dept/getDeptCn",
	        	contentType:"application/json;charset=utf-8",
	        	dataType:"json",
	        	data:JSON.stringify(data.node),
	        	type:"post",
	        	beforeSend:function(xhr){
	    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	    		},
	        	success:function(deptVO){
					str = "";
	        		str +='<table id="deptTable">';
	        		str +='<thead>';
	        		str +='<tr>';
	        		str +='<th>항목</th>';
	        		str +='<th>내용</th>';
	        		str +='</tr>';
	        		str +='</thead>';
	        		str +='<tbody>';
	        		str +='<tr>';
	        		str +='<td>부서 번호</td>';
	        		str +='<td>'+deptVO.deptNo+'</td>';
	        		str +='</tr>';
	        		str +='<tr>';
	        		str +='<td>부서명</td>';
	        		str +='<td>'+deptVO.deptNm+'</td>';
	        		str +='</tr>';
	        		str +='<tr>';
	        		str +='<td>부서 전화번호</td>';
	        		str +='<td>'+deptVO.deptTelno+'</td>';
	        		str +='</tr>';
	        		str +='</tbody>';
	        		str +='</table>';
	        		
	        		$('.dept').html(str);
	        		
	        		const deptTable = document.getElementById('deptTable');
	        	    if (deptTable) {
	        	        new simpleDatatables.DataTable(deptTable,{
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
	        	        	}
	        	        );
	        	    }
	        		
	        		
	        		
	        	}
	        });
	        
	        $.ajax({
	        	url:"/dept/getEmpCn",
	        	contentType:"application/json;charset=utf-8",
	        	dataType:"json",
	        	data:JSON.stringify(data.node),
	        	type:"post",
	        	beforeSend:function(xhr){
	    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	    		},
	        	success:function(empVOList){
					str = "";
	        		str +='<table id="empTable">';
	        		str +='<thead>';
	        		str +='<tr>';
	        		str +='<th>사번</th>';
	        		str +='<th>이름</th>';
	        		str +='<th>직급</th>';
	        		str +='<th>부서이동</th>';
	        		str +='</tr>';
	        		str +='</thead>';
	        		str +='<tbody>';
	        		$.each(empVOList,function(idx,empVO){
		        		str +='<tr>';
		        		str +='<td>'+empVO.empNo+'</td>';
		        		str +='<td>'+empVO.empNm+'</td>';
		        		if(empVO.empJbgdNm == 'A102'){
			        		str +='<td>부장</td>';
		        		}else if(empVO.empJbgdNm =='A103'){
		        			str +='<td>과장</td>';
		        		}else if(empVO.empJbgdNm =='A104'){
		        			str +='<td>대리</td>';
		        		}else if(empVO.empJbgdNm =='A105'){
		        			str +='<td>사원</td>';
		        		}else {
		        	        str += '<td>기타</td>';  // 예외 처리를 위해 추가
		        	    }
		        		str +='<td><button class="btn btn-datatable btn-icon btn-transparent-dark edit" data-emp-no="'+empVO.empNo+'" data-bs-toggle="modal" data-bs-target="#editModal" ><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16"><path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/><path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/></svg></button></td>'
		        		str +='</tr>';
	        		});
	        		str +='</tbody>';
	        		str +='</table>';
	        		
	        		
	        		$('.emp').html(str);
	        		
	        		const empTable = document.getElementById('empTable');
	        	    if (empTable) {
	        	        new simpleDatatables.DataTable(empTable,{
	        	        		searchable: false,
	        	        		perPage: 5,
	        	        		perPageSelect: false,
	        	        		labels: {
	        	        		    placeholder: "Search...",
	        	        		    searchTitle: "Search within table",
	        	        		    pageTitle: "Page {page}",
	        	        		    perPage: "",
	        	        		    noRows: "No entries found",
	        	        		    info: " ",
	        	        		    noResults: "No results match your search query",
	        	        		}		
	        	        	}
	        	        );
	        	    }
	        		
	        	}
	        });
	        
	    });
	
	    // Node 선택했을 땡
	    $('#jstree').on("select_node.jstree", function (e, data) {
	        console.log("select했을땡", data.node);
	    });
    	
    }
    
    eventJsTree();
    
    const deptTable = document.getElementById('deptTable');
    if (deptTable) {
        new simpleDatatables.DataTable(deptTable,{
        		searchable: false,
        		perPageSelect: false,
        		sortable: false,
        		labels: {
        		    placeholder: "Search...",
        		    searchTitle: "Search within table",
        		    pageTitle: "Page {page}",
        		    perPage: "",
        		    noRows: "선택된 부서가 없습니다.",
        		    info: " ",
        		    noResults: "No results match your search query",
        		}		
        	}
        );
    }
    const empTable = document.getElementById('empTable');
    if (empTable) {
        new simpleDatatables.DataTable(empTable,{
        		searchable: false,
        		perPageSelect: false,
        		labels: {
        		    placeholder: "Search...",
        		    searchTitle: "Search within table",
        		    pageTitle: "Page {page}",
        		    perPage: "",
        		    noRows: "선택된 부서가 없습니다.",
        		    info: " ",
        		    noResults: "No results match your search query",
        		}		
        	}
        );
    }
	
    $(document).on('click','.edit',function(){
    	let empNo = this.dataset.empNo;
    	console.log(empNo);
    	
    	$.ajax({
        	url:"/dept/getAllDept",
        	contentType:"application/json;charset=utf-8",
        	dataType:"json",
        	type:"post",
        	beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
        	success:function(deptVOList){
        		console.log(deptVOList);
				str="";
				str+='<select class="form-control" id="deptNo" name="deptNo">';
				str+='<option selected>부서선택</option>';
				$.each(deptVOList,function(idx,deptVO){
					str+='<option value="'+deptVO.deptNo+'">'+deptVO.deptNm+'</option>';
				});
				str+='</select>';
   		    	
				$('.moveDept').attr('data-emp-No', empNo);
				$('.deptNoCreate').html(str);
        	}
        });
    }); //.edit 이벤트 끝
    
    
    $('.moveDept').on('click',function(){
    	let empNo = this.dataset.empNo;
    	let deptNo = $('#deptNo').val();
    	let returnDept = this.dataset.returnDept;
    	console.log("파라미터값 : "+empNo+"  "+deptNo+"  "+returnDept);
    	
    	let data ={
    		"empNo":empNo,
    		"deptNo":deptNo,
    	}
    	
    	let returnDeptData={
    		"id":returnDept,		
    	}
    	
    	$.ajax({
        	url:"/dept/moveDept",
        	contentType:"application/json;charset=utf-8",
        	dataType:"json",
        	data:JSON.stringify(data),
        	type:"post",
        	beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
        	success:function(cnt){
				console.log(cnt +" 변경완료");
        	}
        });
    	
    	$.ajax({
        	url:"/dept/getDeptCn",
        	contentType:"application/json;charset=utf-8",
        	dataType:"json",
        	data:JSON.stringify(returnDeptData),
        	type:"post",
        	beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
        	success:function(deptVO){
				str = "";
        		str +='<table id="deptTable">';
        		str +='<thead>';
        		str +='<tr>';
        		str +='<th>항목</th>';
        		str +='<th>내용</th>';
        		str +='</tr>';
        		str +='</thead>';
        		str +='<tbody>';
        		str +='<tr>';
        		str +='<td>부서 번호</td>';
        		str +='<td>'+deptVO.deptNo+'</td>';
        		str +='</tr>';
        		str +='<tr>';
        		str +='<td>부서명</td>';
        		str +='<td>'+deptVO.deptNm+'</td>';
        		str +='</tr>';
        		str +='<tr>';
        		str +='<td>부서 전화번호</td>';
        		str +='<td>'+deptVO.deptTelno+'</td>';
        		str +='</tr>';
        		str +='</tbody>';
        		str +='</table>';
        		
        		$('.dept').html(str);
        		
        		const deptTable = document.getElementById('deptTable');
        	    if (deptTable) {
        	        new simpleDatatables.DataTable(deptTable,{
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
        	        	}
        	        );
        	    }
        		
        		
        		
        	}
        }); //부서테이블 생성끝
    	
    	$.ajax({
        	url:"/dept/getEmpCn",
        	contentType:"application/json;charset=utf-8",
        	dataType:"json",
        	data:JSON.stringify(returnDeptData),
        	type:"post",
        	beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
        	success:function(empVOList){
				str = "";
        		str +='<table id="empTable">';
        		str +='<thead>';
        		str +='<tr>';
        		str +='<th>사번</th>';
        		str +='<th>이름</th>';
        		str +='<th>직급</th>';
        		str +='<th>부서이동</th>';
        		str +='</tr>';
        		str +='</thead>';
        		str +='<tbody>';
        		$.each(empVOList,function(idx,empVO){
	        		str +='<tr>';
	        		str +='<td>'+empVO.empNo+'</td>';
	        		str +='<td>'+empVO.empNm+'</td>';
	        		if(empVO.empJbgdNm == 'A102'){
		        		str +='<td>부장</td>';
	        		}else if(empVO.empJbgdNm =='A103'){
	        			str +='<td>과장</td>';
	        		}else if(empVO.empJbgdNm =='A104'){
	        			str +='<td>대리</td>';
	        		}else if(empVO.empJbgdNm =='A105'){
	        			str +='<td>사원</td>';
	        		}else {
	        	        str += '<td>기타</td>';  // 예외 처리를 위해 추가
	        	    }
	        		str +='<td><button class="btn btn-datatable btn-icon btn-transparent-dark edit" data-emp-no="'+empVO.empNo+'" data-bs-toggle="modal" data-bs-target="#editModal" ><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16"><path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/><path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/></svg></button></td>'
	        		str +='</tr>';
        		});
        		str +='</tbody>';
        		str +='</table>';
        		
        		
        		$('.emp').html(str);
        		
        		const empTable = document.getElementById('empTable');
        	    if (empTable) {
        	        new simpleDatatables.DataTable(empTable,{
        	        		searchable: false,
        	        		perPage: 5,
        	        		perPageSelect: false,
        	        		labels: {
        	        		    placeholder: "Search...",
        	        		    searchTitle: "Search within table",
        	        		    pageTitle: "Page {page}",
        	        		    perPage: "",
        	        		    noRows: "No entries found",
        	        		    info: " ",
        	        		    noResults: "No results match your search query",
        	        		}		
        	        	}
        	        );
        	    }
        		
        	}
        }); //부서원 테이블 생성 끝
        
        $("#jstree").jstree("destroy").empty(); //기존 JsTree 부숴버려
        
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
        }); //JsTree 재생성
        
    	eventJsTree();
        
    	Toast.fire({
    	    icon: 'success',
    	    title: '부서 이동이 완료되었습니다.'
    	})
        
    });
    
    
});
</script>

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
                        부서관리
                    </h1>
                    <div class="page-header-subtitle"></div>
                </div>
            </div>
        </div>
    </div>
</header>
<div class="container-xl px-4 mt-n10">
	<div class="row">
	    <div class="col-xl-4">
	        <div class="card mb-4">
	            <div class="card-header">부서 관리</div>
	            <div class="card-body">
	            	<div class="d-flex">
		            	<input class="form-control form-control-solid me-1" type="text" id="schName" value="">
						<button class="btn btn-primary" id="searchNm">탐색</button>
					</div>
					<button class="btn btn-sm" id="expandAll">open all</button>
    				<button class="btn btn-sm" id="collapseAll">close all</button>
					<div class="card card-scrollable">
					    <div class="card-body" style="min-height: 480px;">
					    	<div id="jstree"></div>
					    </div>
					</div>
	            </div>
	        </div>
	    </div>
	    <div class="col-xl-8">
        	<div class="card mb-4">
            	<div class="card-header">부서 정보</div>
            	<div class="card-body text-center dept" style="min-height: 240px;">
            		<table id="deptTable">
						<thead>
							<tr>
								<th>항목</th>
								<th>내용</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
                </div>
            </div>
        	<div class="card mb-4">
            	<div class="card-header">부서원 정보</div>
	            <div class="card-body text-center emp" style="min-height: 240px;">
	            	<table id="empTable">
						<thead>
							<tr>
								<th>사번</th>
								<th>이름</th>
								<th>직급</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
	            </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">부서이동</h5>
                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body deptNoCreate">
            </div>
            <div class="modal-footer"><button class="btn btn-primary moveDept" type="button" data-bs-dismiss="modal">부서이동</button><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">닫기</button></div>
        </div>
    </div>
</div>
