<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	var socket = null;
	var ws = new SockJS("/echo");
    socket = ws;
	
	$('#test').on('click',function(){
		let socketMsg = "reply,a001,b001,bNo,readTitle";
		console.log(socketMsg);
		socket.send(socketMsg);
	});
	
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
	
});
</script>

<button id="test">알림 생성</button>