package kr.or.oho.utils.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/echo")
@Slf4j
public class EchoHandler extends TextWebSocketHandler{
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		// TODO Auto-generated method stub
		logger.info("Socket 연결");
		sessions.add(session);
		logger.info(currentUserName(session));//현재 접속한 사람
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		// TODO Auto-generated method stub
		logger.info("ssesion"+currentUserName(session));
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		logger.info("msg="+msg);
		
		if (StringUtils.isNotEmpty(msg)) {
			logger.info("if문 들어옴?");
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 5) {
				
				String alrSrc = strs[0];
				String alrGlocd = strs[1];
				String alrTg = strs[2];
				String alrInfo = strs[3];
				String alrSd = strs[4];
				logger.info("length 성공?"+alrSrc);
				log.debug("alrTg:"+alrTg);
				
				WebSocketSession alrGlocdSession = userSessionsMap.get(alrGlocd);
				WebSocketSession alrTgSession = userSessionsMap.get(alrTg);
				logger.info("alrTgSession="+userSessionsMap.get(alrTg));
				logger.info("alrTgSession"+alrGlocdSession);
				
				if ("mng".equals(alrSrc) && alrTgSession != null) {
					logger.info("onmessage되나?");
					TextMessage tmpMsg = new TextMessage("<a href='"+alrInfo+"' style=\"color: black\">신규 방문일정이 있습니다.</a>");
					alrTgSession.sendMessage(tmpMsg);
				}
				
				if ("edu".equals(alrSrc) && alrTgSession != null) {
					logger.info("onmessage되나?");
					TextMessage tmpMsg = new TextMessage("<a href='"+alrInfo+"' style=\"color: black\">신규 교육일정이 있습니다.</a>");
					alrTgSession.sendMessage(tmpMsg);
				}
				
			
				
				
				
				
					
				
			}
			
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		logger.info("Socket 끊음");
		sessions.remove(session);
		userSessionsMap.remove(currentUserName(session),session);
	}

	
	private String currentUserName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		CustomUser loginUser = (CustomUser) httpSession.get("login");
		
		if(loginUser == null) {
			String EmpNo = session.getId();
			return EmpNo;
		}
		String EmpNo = loginUser.getEmployeeVO().getEmpNo();
		return EmpNo;
		
	}
}