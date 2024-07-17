<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<style>
.centered-container {
    max-width: 60%;
    margin: 0 auto;
    border-radius: 10px;
}

.submit-button {
    width: 20%;
    float: left;
}

.post-content-container {
    margin-top: 3rem;
}

.ck.ck-editor {
    max-width: 100%;
    box-sizing: border-box;
}

.ck-editor__editable {
    height: 400px;
}

#textArea {
    width: 100%; /* 본문 제목 입력 너비 조정 */
    height: 30px;
    border: 1px solid #BDBDBD;
    box-sizing: border-box;
}

.dropdown {
    display: inline-block;
    margin-left: px; /* 드롭다운과 제목 사이 여백 설정 */
}

.dropdown-toggle::after {
}

.dropdown-menu {
    min-width: 3rem; /* 드롭다운 메뉴 최소 너비 설정 */
}

.dropdown-item.active, .dropdown-item:active {
    background-color: #007bff; /* 선택된 드롭다운 아이템 배경색 설정 */
    color: #fff; /* 선택된 드롭다운 아이템 글자색 설정 */
}

.separator {
    height: 1px;
    background-color: #E2DFDF;
    margin: 1px 0;
}

#ttlBox {
	border: 1px solid #BDBDBD;
	padding: 20px;
	border-radius: 10px;
	margin: 0;
}

#dropBox {
	border: 1px solid #BDBDBD;
	padding: 5px;
	border-radius: 5px;
}
</style>
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
</head>
<body>
<div class="centered-container post-content-container">
    <div class="card card-header-actions mb-4 mb-lg-0">
        <div class="card-header">
            공지사항 게시판
       	<div><a href="ntcBoardList" style="color: #2E9AFE; font-size: 15px;"> 공지목록 > </a></div>
        </div>
        <div class="card-body">
            <form action="/frcowner/ntcBoardCreate" method="post">
                <div class="form-group" id="ttlBox">
                    <div class="dropdown" id="dropBox">
                        <button class="btn btn-gray btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            	중요도(✔숫자가 높을수록 중요도  <span id="nbImpDisplay">1</span>)
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="setNbImp(1);">1</a></li>
                            <li><a class="dropdown-item" href="#" onclick="setNbImp(2);">2</a></li>
                            <li><a class="dropdown-item" href="#" onclick="setNbImp(3);">3</a></li>
                        </ul>
                        <input type="hidden" id="nbImpInput" name="nbImp" value="1">
                    </div><br/>
                    <label for="textArea"></label>
                    <input type="text" id="textArea" name="nbTtl" class="form-control" style="height: 48px;" placeholder="본문 제목을 입력해주세요">
                </div>
                <div class="classic">
                    <label for="nbCn"></label>
                    <div id="ckClassic"></div>
                    <textarea id="nbCn" class="form-control" name="nbCn" rows="4" cols="30" style="display: none;"></textarea>
                </div><br />
                <div class="separator"></div><br />
                <input type="hidden" name="empNo" value="${empNo}" />
                <div>
                    <button class="btn btn-primary submit-button" type="submit" style="float: right;">등록하기</button> 
                </div>
                <sec:csrfInput />
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
ClassicEditor.create(document.querySelector("#ckClassic"), {
    ckfinder: {
        uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'
    }
})
.then(editor => { window.editor = editor; })
.catch(err => { console.error(err.stack) });

$(function(){
    $('.ck-blurred').on("focusout", function(){
        $("#nbCn").val(window.editor.getData());
    });

    // 인증된 사용자 정보 가져와서 empNo 필드에 설정
    $.ajax({
        url: "/ntcGetEmp",
        type: "GET",
        success: function(data) {
            $("#empNo").val(data.empNo);
        },
        error: function(err) {
            console.error("Failed to fetch employee info", err);
        }
    });
});

function setNbImp(nbImpValue) {
    document.getElementById('nbImpInput').value = nbImpValue;
    document.getElementById('nbImpDisplay').innerText = nbImpValue; // 선택된 중요도 표시 업데이트
}
</script>
</body>
</html>
