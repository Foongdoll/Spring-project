package com.spring.green2209S_10.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.MovieCrawlingVO;

public interface CrawlingDAO {

	public void setCGV_MainImgInput(@Param("img") String img,@Param("movieName") String movieName);

	public ArrayList<MovieCrawlingVO> getCGV_MainImg();

	public void setCGV_ChartInfoInput(@Param("rank") String rank,@Param("img") String img,@Param("movieAge") String movieAge,@Param("movieTitle") String movieTitle,
			@Param("movieRate") String movieRate, @Param("movieOpenDate") String movieOpenDate,@Param("likeNum") String likeNum);

	public void setCGV_FastTicketingMovieNameInput(@Param("movieTitle") String movieTitle);

	public void setCGV_MovieDetailDBsave(@Param("vo") CgvMovieDetailVO vo);




}
