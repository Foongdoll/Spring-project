package com.spring.green2209S_10.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.vo.CgvCouponVO;
import com.spring.green2209S_10.vo.CgvMovieChartVO;
import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.CgvMovieStillcutVO;
import com.spring.green2209S_10.vo.CgvReportVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvSeatVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvTicketingVO;
import com.spring.green2209S_10.vo.CgvWishListVO;

public interface MovieDAO {

	public CgvTicketingVO getRegion(@Param("movieName") String movieName);

	public CgvTicketingVO getTown(@Param("strSw") String strSw,@Param("movieName") String movieName);

	public ArrayList<CgvTicketingVO> getdateTime(@Param("town") String town,@Param("movieName") String movieName);

	public ArrayList<CgvTicketingVO> getScreenTime(@Param("date") String date,@Param("town") String town,@Param("movieName") String movieName);

	public String getImgName(@Param("movieName") String movieName);

	public int getResSeat(@Param("vo") CgvTicketingVO vo,@Param("sw") int sw);

	public ArrayList<CgvMovieChartVO> getMovieChartImg();

	public CgvMovieDetailVO getMoiveDetail(@Param("movieTitle") String movieTitle);

	public ArrayList<CgvMovieDetailVO> getMovieTrailer(@Param("movieTitle") String movieTitle);

	public ArrayList<CgvReviewVO> getMovieReview(@Param("movieTitle") String movieTitle,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public void setReviewInput(@Param("vo") CgvReviewVO vo);

	public String getFastticketingMovieImg(@Param("movieName") String movieName);

	public int getTotRecCnt(@Param("tableName") String tableName,@Param("movieTitle") String movieTitle);

	public ArrayList<CgvMovieStillcutVO> getMovieStillcut(@Param("movieTitle") String movieTitle);

	public ArrayList<CgvWishListVO> getWishList(@Param("id") String id);

	public int WishListAdd(@Param("movieTitle") String movieTitle,@Param("id") String id,@Param("img") String img);

	public int WishListDel(@Param("movieTitle") String movieTitle,@Param("id") String id);

	public String getMovieScreenType(@Param("movieTitle") String movieTitle);

	public void setTicketCreate(@Param("vo") CgvTicketingPaymentVO vo);

	public List<CgvTicketingPaymentVO> getReservedSeat(@Param("vo") CgvTicketingVO vo);

	public void setSeatTableInput(@Param("vo") CgvTicketingPaymentVO vo,@Param("seatCnt") int seatCnt);

	public CgvSeatVO getSeatTable(@Param("vo") CgvTicketingPaymentVO vo);

	public void setSeatTableUpdate(@Param("vo") CgvTicketingPaymentVO vo,@Param("seatCnt") int seatCnt);

	public List<CgvSeatVO> getReservedSeatAll(@Param("date") String date,@Param("movieName") String movieName,@Param("town") String town);

	public List<CgvTicketingPaymentVO> getTkSeatList(@Param("cvo") CgvSeatVO cvo);

	public void getTicketCancel(@Param("cd") String cd);

	public void setPointInput(@Param("id") String id,@Param("point") int point);

	public void setMemberUsePointMinus(@Param("usePoint") int usePoint,@Param("id") String id);

	public void setMemberJucklipPoint(@Param("jucklip") int jucklip,@Param("id") String id);

	public List<CgvCouponVO> getMyCouponList(@Param("id") String id);

	public List<CgvReviewVO> getRatingProcess(@Param("movieTitle") String movieTitle);

	public void setAdminTodayAmount(@Param("totPrice") int tk_totPrice);

	public String getMovieReviewCheck(@Param("id") String id,@Param("movieTitle") String movieTitle);

	public void setReviewUpdate(@Param("vo") CgvReviewVO vo);

	public void getReviewDelete(@Param("idx") int idx);

	public void setReviewReport(@Param("vo") CgvReportVO vo);

	public void setReviewReportSwUpdate(@Param("idx") int idx);

	public CgvTicketingPaymentVO getTicketInfor(@Param("cd") String cd);

	public void setTicketCancelSeatMinus(@Param("seatCnt") int seatCnt,@Param("vo") CgvTicketingPaymentVO vo);

	public void setMovieGood(@Param("idx") int idx);

	public String getMemberReportStatus(@Param("id") String id);

	public String getDuplicationReviewCheck(@Param("id") String id,@Param("movieTitle") String movieTitle);


}
