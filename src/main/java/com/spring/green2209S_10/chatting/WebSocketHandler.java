package com.spring.green2209S_10.chatting;


import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class WebSocketHandler extends TextWebSocketHandler{
	
	private final ObjectMapper mapper = new ObjectMapper();
	private final ChatService chatService;
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload();
		log.info("{}", payload);
		ChatMessage chatMessage = mapper.readValue(payload, ChatMessage.class);
		
		ChatRoom chatRoom = chatService.findRoomById(chatMessage.getRoomId());
		
		chatRoom.handlerActions(session, chatMessage, chatService);
	}
	
}