package com.spring.green2209S_10;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.green2209S_10.chatting.ChatRoom;
import com.spring.green2209S_10.chatting.ChatService;
import com.spring.green2209S_10.dao.ChatDAO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.ChatContentVO;

import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@RestController
@RequestMapping("/chat")
public class ChatController {
    private final ChatService chatService;
    
    @Autowired
	 	ChatDAO chatDAO;
    
    
    @PostMapping("/chatReadSwGet")
    public String chatReadSwGet(String sender) {
    	String readSw = chatDAO.getReadSw(sender);
    	return readSw;
    }
    
    
    @PostMapping("/chatDelete")
    public String chatDeletePost(@RequestParam(name = "sender", defaultValue = "" , required = false) String sender) {
    	
    	chatDAO.setChatDelete(sender);
    	chatDAO.setChatReadSwONE(sender);
    	
    	return "";
    }
    
    
    
    // 채팅한 회원의 마지막 접속일가져가기
    @PostMapping("/chatMemberLastDate")
    public String chatMemberLastDatePost(String sender) {
    	CgvMemberVO vo = chatDAO.getMemberLastDate(sender); 
    	return vo.getMem_lastDate();
    }
    
    // 채팅의 각 메시지의 시간차이 가져가기 
    @PostMapping("/chatDiffList")
    public List<ChatContentVO> chatDiffListPost(String sender){
    	List<ChatContentVO> diff = chatDAO.getChatDiffList(sender);
    	return diff;   
    }
    
    
    // 채팅 춤으로 들어갈떄 지금까지 있던 대화내용 가져가서 뿌리기
    @PostMapping("/chatRoomGo")
    public List<ChatContentVO> chatRoomGoPost(String sender) {
    	
    	List<ChatContentVO> vos = chatDAO.getChatRoomContent(sender);
    	
    	return vos;
    }
    
    // 채팅방의 채팅 내용 저장
    @PostMapping("/chatContentSave")
    public String chatContentSavePost(String rId, String senderMember, String message) {
    	chatDAO.setContentSave(rId,senderMember,message);
    	
    	return "";
    }
    
    // 채팅방이 있나 없나 sw 로 체크
		@GetMapping("/chatroomSw")
    public String chatroomSwGet(HttpServletRequest request,
    		@RequestParam(name = "sender",defaultValue = "", required = false) String sender) {
    	String nickName = (String)request.getSession().getAttribute("sNickName");
    	String roomId = "";
    	if(sender.equals("")) {
    		roomId = chatDAO.getRoomSw(nickName);
    	}
    	else {
    		roomId = chatDAO.getRoomSw(sender);
    	}
    	
    	ChatRoom cr = chatService.getChatRoom(roomId);
    	
    	if(cr == null) {
    		if(sender.equals("")) {
    			if(roomId != null) {
    				chatService.setRoomSw(roomId,request.getSession(),"");
    			}
    		}
    		else {
    			if(roomId != null) {
    				chatService.setRoomSw(roomId,request.getSession(),sender);
    			}
    		}
    	}
    	
    	return roomId;
    }
    
    // 채팅방 내용 db저장
    @PostMapping("/chatDBSave")
    public String chatDBSavePost(String roomId,HttpServletRequest request) {
    	
    	String nickName = (String)request.getSession().getAttribute("sNickName");
    	
    	chatDAO.setChatRoom(roomId,nickName);
    	
    	return "";
    }
    
    
    // 처음 채팅방을 만들떄
    @PostMapping
    public ChatRoom createRoom(@RequestBody String name) {
        return chatService.createRoom(name);
    }

    // 모든 채팅방 가져옴
    @GetMapping
    public List<ChatRoom> findAllRoom() {
        return chatService.findAllRoom();
    }
}