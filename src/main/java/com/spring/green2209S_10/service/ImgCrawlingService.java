package com.spring.green2209S_10.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.spring.green2209S_10.vo.MovieCrawlingVO;

public interface ImgCrawlingService {

	public void setDBSave(HttpServletRequest request) throws Exception;

	public ArrayList<MovieCrawlingVO> getCGV_MainImg();

	public void setDBSave2(HttpServletRequest request);

	public void setDBSave3(HttpServletRequest request);

}
