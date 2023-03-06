package com.spring.green2209S_10.chatting;


import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.green2209S_10.dao.ChatDAO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class ChatService {
	
		@Autowired
	 	ChatDAO chatDAO;
   
	
	 private final ObjectMapper objectMapper = new ObjectMapper();
	    private Map<String, ChatRoom> chatRooms;

	    @PostConstruct
	    private void init() {
	        chatRooms = new LinkedHashMap<>();
	    }

	    public List<ChatRoom> findAllRoom() {
	        return new ArrayList<>(chatRooms.values());
	    }

	    public ChatRoom findRoomById(String roomId) {
	        return chatRooms.get(roomId);
	    }

	    public ChatRoom createRoom(String name) {
	        String randomId = UUID.randomUUID().toString();
	        ChatRoom chatRoom = ChatRoom.builder()
	                .roomId(randomId)
	                .name(name)
	                .build();
	        
	        chatRooms.put(randomId, chatRoom);
	        return chatRoom;
	    }

	    public <T> void sendMessage(WebSocketSession session, T message) {
	        try{
	            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
	        } catch (IOException e) {
	            log.error(e.getMessage(), e);
	        }
	    }

			public ChatRoom setRoomSw(String roomId,HttpSession session, String sender) {
				ChatRoom chatRoom = null;
				if(sender.equals("")) {
					String nickName = (String)session.getAttribute("sNickName");
					chatRoom = ChatRoom.builder()
							.roomId(roomId)
							.name(nickName)
							.build();
					chatRooms.put(roomId, chatRoom); 
				}
				else {
					chatRoom = ChatRoom.builder()
							.roomId(roomId)
							.name(sender)
							.build();
					chatRooms.put(roomId, chatRoom); 
				}
				
				return chatRoom;
			}

			public ChatRoom getChatRoom(String roomId) {
				
				ChatRoom cr = chatRooms.get(roomId);
				
				return cr;
			}

}
