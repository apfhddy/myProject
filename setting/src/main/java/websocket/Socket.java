package websocket;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class Socket {
	
	@RequestMapping("/echo")
	public class EchoHandler extends TextWebSocketHandler{
	    //세션 리스트
	    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	 
	 
	    //클라이언트가 연결 되었을 때 실행
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    	sessionList.add(session);
	    }
	 
	    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    	System.out.println("보내짐");
	        for(WebSocketSession sess : sessionList){
	        	System.out.println(message.getPayload());
	            sess.sendMessage(new TextMessage(message.getPayload()));
	        }
	    }
	    //클라이언트 연결을 끊었을 때 실행
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	        sessionList.remove(session);
	    }
	}

}
