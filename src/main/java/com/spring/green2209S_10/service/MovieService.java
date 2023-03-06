package com.spring.green2209S_10.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.spring.green2209S_10.vo.CgvMovieChartVO;
import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.CgvMovieStillcutVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvSeatVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.CgvWishListVO;

public interface MovieService {

	public CgvTicketingVO getRegion(String movieName);

	public CgvTicketingVO getTown(String strSw, String movieName);

	public ArrayList<CgvTicketingVO> getdateTime(String town, String movieName);

	public ArrayList<CgvTicketingVO> getScreenTime(String date, String town, String movieName);

	public String getImgName(String movieName);

	public int getResSeat(CgvTicketingVO vo, int sw);

	public ArrayList<CgvMovieChartVO> getMovieChartImg();

	public CgvMovieDetailVO getMoiveDetail(String movieTitle);

	public ArrayList<CgvMovieDetailVO> getMovieTrailer(String movieTitle);

	public ArrayList<CgvReviewVO> getMovieReview(String movieTitle, int startIndexNo, int pageSize);

	public void setReviewInput(CgvReviewVO vo);

	public String getFastticketingMovieImg(String movieName);

	public ArrayList<CgvMovieStillcutVO> getMovieStillcut(String movieTitle);

	public ArrayList<CgvWishListVO> getWishList(String id);

	public int WishListAddDel(String movieTitle, String id, String img, int sw);

	public String getMovieScreenType(String movieName);
	
	public void setTicketCreate(CgvTicketingPaymentVO vo);

	public CgvTicketingPaymentVO qrCreate(String realPath, CgvTicketingPaymentVO vo, HttpServletRequest request);

	public List<CgvTicketingPaymentVO> getReservedSeat(CgvTicketingVO vo);

	public void setSeatTableInput(CgvTicketingPaymentVO vo, int seatCnt);

	public CgvSeatVO getSeatTable(CgvTicketingPaymentVO vo);

	public void setSeatTableUpdate(CgvTicketingPaymentVO vo, int seatCnt);

	public List<CgvSeatVO> getReservedSeatAll(String date,String movieName, String town);

	public List<CgvTicketingPaymentVO> getTkSeatList(CgvSeatVO cvo);

}