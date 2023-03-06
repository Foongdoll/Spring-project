package com.spring.green2209S_10.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_10.dao.MyPageDAO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvWishListVO;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	MyPageDAO myPageDAO;

	@Override
	public ArrayList<CgvWishListVO> getWishList(String id) {
		return myPageDAO.getWishList(id);
	}

	@Override
	public void setWishCommentInput(CgvWishListVO vo,String id) {
		myPageDAO.setWishCommentInput(vo,id);
	}

	@Override
	public void getWishDelete(String movieTitle, String id) {
		myPageDAO.getWishDelete(movieTitle,id);
	}

	@Override
	public List<CgvTicketingPaymentVO> getMyTicket(String id) {
		return myPageDAO.getMyTicket(id);
	}

	@Override
	public List<CgvTicketingPaymentVO> getMyViewMovieList(String id) {
		return myPageDAO.getMyViewMovieList(id);
	}

	@Override
	public CgvMemberVO getMemberInfor(String id) {
		return myPageDAO.getMemberInfor(id);
	}

	@Override
	public void setMyInforUpdate(CgvMemberVO vo) {
		myPageDAO.setMyInforUpdate(vo);
	}

	@Override
	public List<CgvReviewVO> getMyReviewList(String id) {
		return myPageDAO.getMyReviewList(id);
	}

	
}
