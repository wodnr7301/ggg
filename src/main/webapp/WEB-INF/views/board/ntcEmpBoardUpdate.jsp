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
    width: 100%;
    height: 30px;
    border: 1px solid #BDBDBD; /* 테두리 색을 파란색으로 설정 */
    box-sizing: border-box;
}

.separator {
    height: 1px; /* 원하는 높이 설정 */
    background-color: #E2DFDF; /* 원하는 색상 설정 */
    margin: 1px 0; /* 위아래로 여백 설정 */
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
            공지사항
        </div>
        <div class="card-body">
            <form action="/employee/ntcEmpBoardUpdate?nbNo=${ntcBbs.nbNo}" method="post">
                <div class="form-group mb-4">
                    <input type="hidden" id="empNoInput" name="empNo" value="${empNo}">
                    <div class="dropdown">
                        <button class="btn btn-gray btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                           	 중요도(✔숫자가 높을수록 중요도  <span id="nbImpDisplay">1</span>)
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="setNbImp(1);">1</a></li>
                            <li><a class="dropdown-item" href="#" onclick="setNbImp(2);">2</a></li>
                            <li><a class="dropdown-item" href="#" onclick="setNbImp(3);">3</a></li>
                        </ul>
                        <input type="hidden" id="nbImpInput" name="nbImp" value="1">
                    </div>
                    <label for="textArea"></label>
                    <input type="text" id="textArea" name="nbTtl" value="${ntcBbs.nbTtl}" required>
                </div>
                <div class="classic">
                    <label for="nbCn"></label>
                    <div id="ckClassic"></div>
                    <textarea id="nbCn" class="form-control" name="nbCn"
                        rows="4" cols="30" style="display: none;" required>${ntcBbs.nbCn}</textarea>
                </div><br />
                <div class="separator"></div><br />
                <div class="d-grid md-3">
                    <button class="fw-500 btn btn-primary submit-button" type="submit">수정하기</button>
                </div>
                <sec:csrfInput />
                <input type="hidden" id="nbCnHidden" value="${ntcBbs.nbCn}">
                <input type="hidden" id="csrfParameterNameHidden" value="${_csrf.parameterName}">
                <input type="hidden" id="csrfTokenHidden" value="${_csrf.token}">
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    var nbCnValue = document.getElementById('nbCnHidden').value;
    var csrfParameterName = document.getElementById('csrfParameterNameHidden').value;
    var csrfToken = document.getElementById('csrfTokenHidden').value;

    /*
    ClassicEditor: ckeditor5.js에서 제공해주는 객체
    uploadUrl: 이미지 업로드를 수행할 URL
    window.editor=editor: editor 객체를 window.editor라고 부름
    */
    ClassicEditor.create(document.querySelector("#ckClassic"), {
        ckfinder: {
            uploadUrl: `/image/upload?${csrfParameterName}=${csrfToken}`
        }
    })
    .then(editor => {
        window.editor = editor;
        editor.setData(nbCnValue);
    })
    .catch(err => {
        console.error(err.stack);
    });

    $(function(){
        $('.ck-blurred').keydown(function(){
            console.log("str: " + window.editor.getData());
            $("#nbCn").val(window.editor.getData());
        });

        $(".ck-blurred").on("focusout", function(){
            $("#nbCn").val(window.editor.getData());
        });
    });

});
    
function setNbImp(nbImpValue) {
    document.getElementById('nbImpInput').value = nbImpValue;
    document.getElementById('nbImpDisplay').innerText = nbImpValue; // 선택된 중요도 표시 업데이트
}
</script>
</body>
</html>
