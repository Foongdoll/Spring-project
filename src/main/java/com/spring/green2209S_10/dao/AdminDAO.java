package com.spring.green2209S_10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.pagnation.PageVO;
import com.spring.green2209S_10.vo.CgvAdminContentVO;
import com.spring.green2209S_10.vo.CgvAdminMainVO;
import com.spring.green2209S_10.vo.CgvBoardVO;
import com.spring.green2209S_10.vo.CgvCouponVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvMovieChartVO;
import com.spring.green2209S_10.vo.CgvReportVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;

public interface AdminDAO {

	public void todayReset();

	public CgvAdminMainVO getAdminMain();

	public List<CgvTicketingPaymentVO> getTicketList(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("part") String part,@Param("searchStr") String searchStr);

	public int getTotRecCnt(@Param("part") String part,@Param("searchStr") String searchStr,@Param("tableName") String tableName,@Param("sw") int sw);

	public int getMemberPoint(@Param("id") String id);

	public void setTicketCancelCdSwUpdate(@Param("cd") String cd);

	public List<CgvTicketingPaymentVO> getTicketInforList();

	public String[] getMovieTitleList();

	public void todayAmountReset();

	public CgvMovieChartVO getMoiveChartSelect(String movieTitle);

	public void setMainContetnInput(@Param("title") String title,@Param("content") String content,@Param("img") String img,@Param("sw") int sw);

	public List<CgvMemberVO> getMemberList(@Param("searchStr") String searchStr,@Param("part") String part,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public List<CgvAdminContentVO> getMainHeaderImgGet();

	public void setMainHeaderImgDelete(@Param("movieTitle") String movieTitle);

	public List<CgvReportVO> getReviewReportList(@Param("searchStr") String searchStr,@Param("part") String part,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public CgvReviewVO getReportContentMemberGet(@Param("idx") int idx);

	public void setReportStatusUpdate(@Param("vo") CgvReportVO vo);

	public void setMemberReportContentUpdate(@Param("reportStatus") String reportStatus,@Param("id") String id);

	public List<CgvMemberVO> getMemberAllList();

	public void setMemberReportContentUpdateCron(@Param("id") String mem_id,@Param("reportDate") String mem_reportDate,@Param("sw") int sw);

	public List<CgvCouponVO> getAdminCouponAllList(@Param("searchStr") String searchStr,@Param("part") String part,@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize);

	public void setAdminCreateCoupon(@Param("vo") CgvCouponVO vo);

	public void setAdminMemberPointUpdate(@Param("id") String id,@Param("point") int point);

	public void setAdminCouponDelete(@Param("idx") int idx);

	public void setAdminPointDeduction(@Param("idx") int idx,@Param("point") int point);

	public String getMoiveImg(@Param("movieTitle") String movieTitle);

	public List<CgvReportVO> getAdminReport();
	
	public List<CgvBoardVO> getAdminBoard();

	public List<CgvTicketingPaymentVO> getTotTicketSale();

	public void getAdminMemberDel(@Param("id") String id);
 
}
// 모선생