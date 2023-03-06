package com.spring.green2209S_10.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.ChatRoomsVO;

public interface HomeService {

	public int setJoinInput(CgvMemberVO vo, String kakao);

	public void setMemberVisitCnt(CgvMemberVO vo);

	public CgvMemberVO getMemberIdCheck(String id);

	public ArrayList<CgvTicketingVO> getTicketingMovieName();

	public CgvMemberVO getMemberIdCheckNickName(String nickName);

	public String getIdSearch(String name, String nickName, String scnumber);

	public String getPswdSearch(String id, String nickName, String email);

	public void setNewPswdInput(String newPswd, String id);

	public CgvMemberVO getMemberNickNameEmailCheck(String nickName);

	public String getAuthEmailSearch(String email);

	public void setAuthNumber(String email, String authNumber, String authSw);

	public String getAuhNumberEmail(String email, String authNumber);

	public String profilePhotoUpload(MultipartFile file, HttpServletRequest request);

	public void setAdminToday();

	public void setOnOff(String id, int sw);

}
