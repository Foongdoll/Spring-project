package com.spring.green2209S_10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.ChatContentVO;

public interface ChatDAO {

	public void setChatRoom(@Param("roomId") String roomId,@Param("nickName") String nickName);

	public String getRoomSw(@Param("nickName") String nickName);

	public void setContentSave(@Param("roomId") String rId,@Param("sender") String senderMember,@Param("message") String message);

	public List<ChatContentVO> getChatContentList();

	public List<ChatContentVO> getChatSenderList();

	public List<ChatContentVO> getChatRoomContent(@Param("sender") String sender);

	public List<ChatContentVO> getChatDiffList(@Param("sender") String sender);

	public CgvMemberVO getMemberLastDate(@Param("sender") String sender);

	public List<CgvMemberVO> getMemberOnOff();

	public void setChatDelete(@Param("sender") String sender);

	public void setChatReadSwONE(@Param("sender") String sender);

	public String getReadSw(@Param("sender") String sender);


}
