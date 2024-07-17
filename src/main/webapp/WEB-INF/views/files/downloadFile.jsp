<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
<style>
    #jwsub{
        width:200px;
        border:1px solid black;
        display: none;
    }
    span {
        display: inline-block;
    }
</style>
</head>
<body>
    <div id="jw">
        <div onclick="fShow()">첨부파일</div>
        <div id="jwsub">
            <span><a href="./dummyData.json" download="성욱메롱.json"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down-square" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M15 2a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1zM0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm8.5 2.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293z"/>
              </svg></a></span>|
            <span>내PC에저장</span>
        </div>
    </div>
<script>
    const jwsub = document.querySelector("#jwsub")
    function fShow(){
        jwsub.style.display="block";
    }
</script>
</body>
</html>