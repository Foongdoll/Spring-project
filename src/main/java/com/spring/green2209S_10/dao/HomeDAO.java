package com.spring.green2209S_10.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.vo.CgvMainHeaderImgVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.ChatRoomsVO;

public interface HomeDAO {

	public int setJoinInput(@Param("vo") CgvMemberVO vo,@Param("sw") String sw);

	public void setMemberVisitCnt(@Param("vo") CgvMemberVO vo);

	public CgvMemberVO getMemberIdCheck(@Param("id") String id);

	public ArrayList<CgvTicketingVO> getTicketingMovieName();

	public CgvMemberVO getMemberIdCheckNickName(@Param("nickName") String nickName);

	public String getIdSearch(@Param("name") String name,@Param("nickName") String nickName,@Param("scnumber") String scnumber);

	public String getPswdSearch(@Param("id") String id,@Param("nickName") String nickName,@Param("email") String email);

	public void setNewPswdInput(@Param("newPswd") String newPswd,@Param("id") String id);

	public CgvMemberVO getMemberNickNameEmailCheck(@Param("nickName") String nickName);

	public String getAuthEmailSearch(@Param("email") String email);

	public void setAuthNumber(@Param("email") String email,@Param("authNumber") String authNumber,@Param("authSw") String authSw);

	public void Auth3MinitSearch();

	public String getAuhNumberEmail(@Param("email") String email,@Param("authNumber") String authNumber);

	public void setAdminToday();

	public void setOnOff(@Param("id") String id,@Param("sw") int sw);

	public void setADminJoinToday();

	public List<CgvMainHeaderImgVO> getHeaderImgList();

	public CgvMemberVO getMemberReportContent(@Param("id") String id);

}
