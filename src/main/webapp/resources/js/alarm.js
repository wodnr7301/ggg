$(function(){
	var socket = null;
	var ws = new SockJS("/echo");
    socket = ws;
	
	 function getCsrfToken() {
        return $('meta[name="_csrf"]').attr('content');
    }

    function getCsrfHeader() {
        return $('meta[name="_csrf_header"]').attr('content');
    }


	window.alarm = function(data){
		console.log("알람호출댐");
		console.log(data);
	    $.ajax({
	        url : "/alarm/create", // 요기에
	        contentType:"application/json;charset=utf-8",
	        data : JSON.stringify(data), 
	        type : 'POST', 
	        beforeSend:function(xhr){
	          	var csrfToken = getCsrfToken();
                var csrfHeader = getCsrfHeader();
                console.log("Setting CSRF token:", csrfHeader, csrfToken);
                xhr.setRequestHeader(csrfHeader, csrfToken);
	        },
	        success : function(cnt) {
	            console.log("알람테이블 등록:"+cnt);

                let socketMsg = data.alrSrc+","+data.alrGlocd+","+data.alrTg+","+data.alrInfo+","+data.alrSd;
                console.log(socketMsg);
                socket.send(socketMsg);

	        },
            error: function(xhr, status, error) {
                console.log("AJAX 요청 실패:", status, error);
            } 
	    });
	}
});

//data에는 아래와 같은 친구들이 들어있어야 한다.
// alr_glocd = 발생한 곳의 기본키라고 해야되나?
// alr_src = 메시지를 보냈을때 도착한 값에서 해당 값을 통해 구분 ex)doc=전자결재
// alr_tg = 알람을 받을 대상
// alr_sd = 알람을 보낸 대상(이 없을경우 안보내줘도댐)
// alr_info = 해당 알림에 담을 내용? 정보?


// alr_seq = 같은 글로벌 코드에서 여러명에게 기본키가 발생되는 것을 위해 존재하는 복합키
// 아래 두개는 알아서 넣어짐
// alr_idnty = 알림 확인여부 체크 X,O
// alr_tm = 알람이 발생한 시간 sysdate로 처리