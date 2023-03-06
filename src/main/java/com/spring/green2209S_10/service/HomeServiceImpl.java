package com.spring.green2209S_10.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_10.dao.HomeDAO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.ChatRoomsVO;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	HomeDAO homeDAO;
	
	@Override
	public int setJoinInput(CgvMemberVO vo,String kakao) {
		return homeDAO.setJoinInput(vo,kakao);
	}

	@Override
	public void setMemberVisitCnt(CgvMemberVO vo) {
		homeDAO.setMemberVisitCnt(vo);
	}

	@Override
	public CgvMemberVO getMemberIdCheck(String id) {
		return homeDAO.getMemberIdCheck(id);
	}

	@Override
	public ArrayList<CgvTicketingVO> getTicketingMovieName() {
		return homeDAO.getTicketingMovieName();
	}

	@Override
	public CgvMemberVO getMemberIdCheckNickName(String nickName) {
		return homeDAO.getMemberIdCheckNickName(nickName);
	}

	@Override
	public String getIdSearch(String name, String nickName, String scnumber) {
		return homeDAO.getIdSearch(name,nickName,scnumber);
	}

	@Override
	public String getPswdSearch(String id, String nickName, String email) {
		return homeDAO.getPswdSearch(id,nickName,email);
	}

	@Override
	public void setNewPswdInput(String newPswd,String id) {
		homeDAO.setNewPswdInput(newPswd,id);
	}

	@Override
	public CgvMemberVO getMemberNickNameEmailCheck(String nickName) {
		return homeDAO.getMemberNickNameEmailCheck(nickName);
	}

	@Override
	public String getAuthEmailSearch(String email) {
		return homeDAO.getAuthEmailSearch(email);
	}

	@Override
	public void setAuthNumber(String email, String authNumber, String authSw) {
		homeDAO.setAuthNumber(email,authNumber,authSw);
	}

	@Override
	public String getAuhNumberEmail(String email, String authNumber) {
		return homeDAO.getAuhNumberEmail(email,authNumber);
	}

	@Override
	public String profilePhotoUpload(MultipartFile file, HttpServletRequest request) {
		String mem_SPhoto = "";
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/memberprofile/");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String uid = UUID.randomUUID().toString().substring(0,8);
		String addMsg = sdf.format(new Date())+"_"+uid;
		
		mem_SPhoto = addMsg +"_"+file.getOriginalFilename();
		
		File photo = new File(realPath+mem_SPhoto);
		
		try {
			byte[] data = file.getBytes();
			OutputStream os = new FileOutputStream(photo);
			os.write(data);
			os.close();
			
		}  catch (IOException e) {
			e.printStackTrace();
		}		
		
		
		return mem_SPhoto;
	}

	@Override
	public void setAdminToday() {
		homeDAO.setAdminToday();
	}

	@Override
	public void setOnOff(String id,int sw) {
		homeDAO.setOnOff(id,sw);
	}

}
