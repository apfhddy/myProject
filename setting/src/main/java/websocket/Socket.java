package websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

	
	@RequestMapping("/echo")
	public class Socket extends TextWebSocketHandler{
	    //세션 리스트
	    private Map<String,Map<String,Object>> sessionMap = new HashMap<>();
	    private Map<Integer,List<WebSocketSession>> room = new HashMap<>();
	 
	    //클라이언트가 연결 되었을 때 실행
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    	sessionMap.put((String)session.getAttributes().get("id"), session.getAttributes());
	    	session.getAttributes().put("session", session);
	    }
	 
	    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	        
	    }
	    //클라이언트 연결을 끊었을 때 실행
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	        sessionMap.remove((String)session.getAttributes().get("id"));
	    }

	    
	    public void joinRoom(int roomno,String sessionid) {
	    	if(room.get(roomno) == null) {
	    		List<WebSocketSession> inwon = new ArrayList<>();
	    		inwon.add((WebSocketSession)getSessionMap(sessionid).get("session"));
	    		System.out.println(inwon.toString());
	    	}else {
	    		
	    	}
	    }
	    
		public Map<String,Object> getSessionMap(String sessionid) {
			return sessionMap.get(sessionid);
		}

	}

