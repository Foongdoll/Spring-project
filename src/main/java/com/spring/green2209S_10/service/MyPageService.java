package com.spring.green2209S_10.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvWishListVO;

public interface MyPageService {

	public ArrayList<CgvWishListVO> getWishList(String id);

	public void setWishCommentInput(CgvWishListVO vo, String id);

	public void getWishDelete(String movieTitle, String id);

	public List<CgvTicketingPaymentVO> getMyTicket(String id);

	public List<CgvTicketingPaymentVO> getMyViewMovieList(String id);

	public CgvMemberVO getMemberInfor(String id);

	public void setMyInforUpdate(CgvMemberVO vo);

	public List<CgvReviewVO> getMyReviewList(String id);


	
	
}
