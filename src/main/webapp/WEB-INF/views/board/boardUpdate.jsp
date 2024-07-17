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
            자유게시판
        </div>
        <div class="card-body">
            <form action="/frcowner/boardUpdate?fbNo=${freeBbs.fbNo}" method="post">
                <div class="form-group mb-4">
                    <label for="textArea"></label>
                    <input type="text" id="textArea" name="fbTtl" value="${freeBbs.fbTtl}" required>
                </div>
                <div class="classic">
                    <label for="fbCn"></label>
                    <div id="ckClassic"></div>
                    <textarea id="fbCn" class="form-control" name="fbCn"
                        rows="4" cols="30" style="display: none;" required>${freeBbs.fbCn}
                    </textarea>
                </div><br />
                <div class="separator"></div><br />
                <div class="d-grid md-3">
                    <button class="fw-500 btn btn-primary submit-button" type="submit">수정하기</button>
                </div>
                <sec:csrfInput />
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
/*
ClassicEditor: ckeditor5.js에서 제공해주는 객체
uploadUrl: 이미지 업로드를 수행할 URL
window.editor=editor: editor 객체를 window.editor라고 부름
*/
ClassicEditor.create(document.querySelector("#ckClassic"), {ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
    .then(editor => { 
    	window.editor = editor; 
    	editor.setData("${freeBbs.fbCn}");
    })
    .catch(err => { console.error(err.stack) });
    
$(function(){
    $('.ck-blurred').keydown(function(){
        console.log("str: " + window.editor.getData());
        $("#fbCn").val(window.editor.getData());
    });
    
    $(".ck-blurred").on("focusout", function(){
        $("#fbCn").val(window.editor.getData());
    });

});
</script>
</body>
</html>