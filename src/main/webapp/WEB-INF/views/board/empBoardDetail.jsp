<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Post Detail</title>
<style>
.detail-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   border-bottom: 1px solid #ddd;
   padding-bottom: 10px;
   margin-bottom: 15px;
}

.detail-header .info {
   display: flex;
   gap: 20px;
}

.content-box {
   border: 1px solid #ddd;
   padding: 15px;
   border-radius: 5px;
}

.card {
   max-width: 1100px;
   margin: 0 auto;
}

.button {
   float: right;
}

.textarea-container {
   position: relative;
   width: 100%;
   border: 1px solid #D8D8D8;
   padding: 15px;
   border-radius: 5px;
   transition: all 0.3s ease;
}

.textarea-container.focused {
   border-color: #BDBDBD;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.textarea-small {
   width: 100%;
   height: 30px;
   border: none;
   resize: none;
   transition: height 0.3s ease;
}

.textarea-large {
   height: 110px;
}

.submit-button {
   position: absolute;
   bottom: 10px;
   right: 10px;
   display: none;
}

.textarea-container.focused .submit-button {
   display: inline-block;
}

textarea:focus {
   outline:none;
}

.comentArea-left {
    display: flex;
    justify-content: space-between;
}

.comentArea-right {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

</style>
</head>
<body>
   <!-- Main page content-->
   <br/><br/>
   <div class="container-fluid px-4">
      <div class="card">
         <div class="card-body" style="height: auto;">
            <a href="empBoardList" style="color: #2E9AFE; font-size: 14px;">질의응답 목록 ></a><br />
            <div class="detail-header mt-3">
               <div class="title">
                  <h5>${freeBbs.fbTtl}</h5>
               </div>
               <div class="info">
                  <div>작성자: 익명</div>
                  <div>작성일: ${freeBbs.fbPstdt}</div>
                  <div>조회수: ${freeBbs.fbCount}</div>
               </div>
            </div>
            <div class="content-box"
               style="height: auto; border: solid transparent;">
               <p>${freeBbs.fbCn}</p>
            </div>
            <div class="button">
               <br />
               <c:if test="${user.empNo eq freeBbs.empNo}">
               		<button class="btn btn-light btn-sm" type="button" onclick="location='empBoardUpdate?fbNo=${freeBbs.fbNo}'">수정</button>
               		<button class="btn btn-light btn-sm" type="button" onclick="confirmDelete('${freeBbs.fbNo}')">삭제</button>
               </c:if>
            </div><br /><br /><br /><hr />
			<div class="textarea-container" id="textareaContainer">
				<textarea id="qual" class="textarea-small" name="cmntCn"
					placeholder="다양한 의견이 서로 존중될 수 있도록 비하의 표현이나 타인의 권리를 침해하는 내용은 주의해주세요."></textarea>
				<button class="btn btn-light btn-sm submit-button" id="cmtBtn"
					type="button">댓글작성</button>
				<button class="btn btn-light btn-sm submit-button"
					id="updateCmtBtn" type="button" style="display: none;">댓글수정</button>
			</div>
			<br />
			<!-- 댓글 시작 -->
			<c:forEach var="cmt" items="${freeBbs.comentList}" varStatus="stat">
				<c:if test="${cmt.cmntDelYn eq 'B102'}">
					<div class="content-box"
						style="height: auto; border: 1px solid transparent;">
						<div class="comentArea-left">
							<div>익명${stat.index + 1}</div>
							<div class="comentArea-right">
								<div>${cmt.cmntWrtDt }</div>
								<div class="dropdown no-caret">
							    <button class="btn btn-transparent-dark btn-icon dropdown-toggle" id="dropdownPeople1" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-vertical"><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg></button>
								<c:if test="${user.empNo eq cmt.empNo}">
									<div class="dropdown-menu dropdown-menu-end animated--fade-in-up" aria-labelledby="dropdownPeople1${stat.index}" style="">
										<a class="dropdown-item update-comment" href="#" data-cmnt-no="${cmt.cmntNo}" data-cmnt-cn="${cmt.cmntCn}">수정</a>
										<a class="dropdown-item delete-comment" href="#" data-cmnt-no="${cmt.cmntNo}">삭제</a>
									</div>
								</c:if>
								</div>
							</div>
						</div><br />
					   <div>${cmt.cmntCn}</div>
					</div><hr />
				</c:if>
		    </c:forEach>
		    <!-- 댓글 끝 -->
         </div>
      </div>
   </div>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="/resources/js/datatables/datatables-simple-demo.js"></script>
<script>
    // ckEditor 작성
    const textarea = document.getElementById('qual');
    const textareaContainer = document.getElementById('textareaContainer');

    textarea.addEventListener('focus', () => {
        textarea.classList.add('textarea-large');
        textareaContainer.classList.add('focused'); 
    });

    textarea.addEventListener('blur', () => {
        if (textarea.value.trim() === '') {
            textarea.classList.remove('textarea-large');
            textareaContainer.classList.remove('focused');
        }
    });

    // 게시글 삭제
    function confirmDelete(fbNo) {
        if (confirm("정말로 삭제하시겠습니까?")) {
            location.href = 'empBoardDelete?fbNo=' + fbNo;
        } else {
            alert("삭제를 취소하였습니다");
        }
    }

    // 댓글 생성 AJAX
    $('#cmtBtn').on('click', function() {
        let cmntCn = $("textarea[name='cmntCn']").val();
        let cmntCd = '${freeBbs.fbNo}';

        // EmployeeVO 정보 가져오기
        $.ajax({
            url: "/frcowner/getEmp",
            contentType: "application/json;charset=utf-8",
            type: "get",
            dataType: "json",
            success: function(emp) {
                console.log("Logged in user: ", emp);
                
                let data = {
                    "cmntCn": cmntCn,
                    "cmntCd": cmntCd,
                    "empNo": emp.empNo  // empNo를 포함
                };

                console.log("data: ", data);

                $.ajax({
                    url: "/frcowner/cmtCreate",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data),
                    type: "post",
                    dataType: "json",
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(result) {
                        console.log("result: ", result);

                        if (result != null) {
                            location.reload();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error: " + error);
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching logged in user: " + error);
            }
        });
    });

    // 댓글 삭제 AJAX
    $('.delete-comment').on('click', function(e) {
        e.preventDefault();
        let cmntNo = $(this).data('cmnt-no');
        let fbNo = '${freeBbs.fbNo}';
        
        let data = {
            "cmntNo": cmntNo
        };

        console.log("data: ", data);

        $.ajax({
            url: "/frcowner/cmtDelete",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("result: ", result);
                if (result != null) {
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
            }
        });
    });

    // 댓글 수정 AJAX
    $('.update-comment').on('click', function(e) {
        e.preventDefault();
        let cmntNo = $(this).data('cmnt-no');
        let cmntCn = $(this).data('cmnt-cn');
        
        // 텍스트 영역에 기존 댓글 내용 표시
        $('#qual').val(cmntCn);
        
        // 댓글 등록 버튼 숨기고 수정 버튼 보이기
        $('#cmtBtn').hide();
        $('#updateCmtBtn').show();
        
        // 수정 버튼 클릭 이벤트 핸들러
        $('#updateCmtBtn').off('click').on('click', function() {
            let updatedCmntCn = $('#qual').val();
            
            let data = {
                "cmntNo": cmntNo,
                "cmntCn": updatedCmntCn
            };
            
            console.log("data: ", data);
            
            $.ajax({
                url: "/frcowner/cmtUpdate",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(data),
                type: "post",
                dataType: "json",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    console.log("result: ", result);
                    if (result != null) {
                        location.reload();
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error: " + error);
                }
            });
        });
    });
</script>
</body>
</html>
