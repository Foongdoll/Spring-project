package com.spring.green2209S_10.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.vo.CgvCouponVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvReportVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvWishListVO;

public interface MyPageDAO {

	public ArrayList<CgvWishListVO> getWishList(@Param("id") String id);

	public void setWishCommentInput(@Param("vo") CgvWishListVO vo,@Param("id") String id);

	public void getWishDelete(@Param("movieTitle") String movieTitle,@Param("id") String id);

	public List<CgvTicketingPaymentVO> getMyTicket(@Param("id") String id);

	public List<CgvTicketingPaymentVO> getMyViewMovieList(@Param("id") String id);

	public CgvMemberVO getMemberInfor(@Param("id") String id);

	public void setMyInforUpdate(@Param("vo") CgvMemberVO vo);

	public List<CgvReviewVO> getMyReviewList(@Param("id") String id);

	public void setMyCouponInput(@Param("id") String id,@Param("couponCode") String couponCode,@Param("content") int content);

	public CgvCouponVO getMyCoupon(@Param("id") String id);

	public List<CgvCouponVO> getMyCouponList(@Param("id") String id);

	public List<CgvReportVO> getMyReportList(@Param("id") String id);

	public void setMemberDel(@Param("id") String id);

	public CgvReportVO getMyReport(@Param("idx") int reportContentIdx);

}
