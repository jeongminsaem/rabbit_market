package handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import member.MemberVO;

public class ReplyEchoHandler extends TextWebSocketHandler {
	
	List<WebSocketSession> sessions = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>(); //접속되있는 유저 
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		//System.out.println("afterConnectionEstablished:" + session);
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//System.out.println("아이디:" + session + " 메세지: " + message);
		
		String senderId = getId(session); //웹소켓 세션
		String msg = message.getPayload();
		System.out.println("4개 메세지"+msg);
		if (StringUtils.isNotEmpty(msg)) {  //
			String[] strs = msg.split(",");
			
			if (strs != null && strs.length == 5) {			
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String title = strs[3];
				
				System.out.println("22222222"+replyWriter+replyWriter+title);
				WebSocketSession boardWriterSession = userSessions.get(boardWriter); //게시글 작성자가 있으면 
				if ("reply".equals(cmd) && boardWriterSession != null) {			
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
					/* + "<a href='/board/read?bno=" + bno + "'>" */ + title + " 게시글에 댓글을 달았습니다!");
					
					boardWriterSession.sendMessage(tmpMsg);
								
					
					
				}
			}
		}
	}

	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemberVO loginUser = (MemberVO)httpSession.get("login_info");		
		if(null == loginUser){
			return session.getId();
		} else { 
			return loginUser.getUserid();
		}
		
		 
	
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionEstablished:" + session + ":" + status);
	}
}
