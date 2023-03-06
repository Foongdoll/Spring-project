package com.spring.green2209S_10.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_10.dao.CrawlingDAO;
import com.spring.green2209S_10.vo.CgvMovieDetailVO;
import com.spring.green2209S_10.vo.MovieCrawlingVO;

@Service
public class ImgCrawlingServiceImpl implements ImgCrawlingService{
	@Autowired
	CrawlingDAO crawlingDAO;

	@Override
	public void setDBSave(HttpServletRequest request) throws Exception {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/cgv/cgvMainImg/");
		Connection conn = Jsoup.connect("https://www.cgv.co.kr/");
		Document doc = conn.get();
		Elements imgs = doc.select(".swiper-slide img");	
		Elements movieNames = doc.select(".movieName");
		
		String[] movieNameArr = movieNames.html().split("\n");
		
		
		int cnt = 0;
		for(int i = 0; i < imgs.size(); i++) {
			Element iEl = imgs.get(i);
			String imgHttp = iEl.attr("src");
			String img = iEl.attr("src").substring(imgHttp.lastIndexOf("/")+1,imgHttp.length());
			Map<String, String> map = new HashMap<String, String>();
				
			if(img.contains(".jpg")) {
				if(i < 39) {
					map.put("movieName", movieNameArr[cnt]);
					cnt++;
				}
				else {
					map.put("movieName", "");
				}
				
			}
				
			map.put("img", img);
			
			saveFileDB(map);
			saveFileImg(img,imgHttp,realPath);		
		}
	}

	@SuppressWarnings("unused")
	private void saveFileDB(Map<String, String> map) {
			String img = map.get("img");
			String movieName = map.get("movieName");
			if(movieName == null) movieName = "";
			else if(img.contains(".jpg")) crawlingDAO.setCGV_MainImgInput(img,movieName);
			else crawlingDAO.setCGV_MainImgInput(img,"");
		
	}

	private void saveFileImg(String img, String imgHttp, String realPath) throws Exception {
//		File file = new File(realPath+directory);
			File file = new File(realPath);
		
			if(!file.exists()) {
				file.mkdirs();
			}
			
			URL url = new URL(imgHttp);
			
			InputStream is = url.openStream();
			
			FileOutputStream fos = new FileOutputStream(file+"/"+img);
			int b = 0;
			
			while((b = is.read()) != -1) {
				fos.write(b);
			}
			fos.close();
			
			System.out.println(img + ":: 작업 완료");		
	}

	@Override
	public ArrayList<MovieCrawlingVO> getCGV_MainImg() {
		return crawlingDAO.getCGV_MainImg();
	}

	@Override
	public void setDBSave2(HttpServletRequest request) {
		Connection conn = Jsoup.connect("http://www.cgv.co.kr/movies/?lt=1&ft=0");
		
		
		Document doc;
		try {
			doc = conn.get();
			Elements ranks = doc.select(".rank");
			Elements imgs = doc.select(".thumb-image img");
			Elements movieAges = doc.select(".cgvIcon");	
			Elements movieTitles = doc.select(".box-contents strong.title");	
			Elements movieRates = doc.select("strong.percent span");
			Elements movieOpenDates = doc.select("span.txt-info");
			Elements likeNums = doc.select(".egg-gage.small > span.percent");
			for(int i = 0; i < 18; i++) {
				String rank = ranks.get(i).text();
				String img = imgs.get(i).attr("src");
				String movieAge = movieAges.get(i).text();
				String movieTitle = movieTitles.get(i).text();
				String movieRate = movieRates.get(i).text();
				String movieOpenDate = movieOpenDates.get(i).text();
				String likeNum = likeNums.get(i).text();
				
				
				crawlingDAO.setCGV_ChartInfoInput(rank,img,movieAge,movieTitle,movieRate,movieOpenDate,likeNum);
			}
			for(int i = 0; i < movieTitles.size();i++) {
				String movieTitle = movieTitles.get(i).text();
				
				crawlingDAO.setCGV_FastTicketingMovieNameInput(movieTitle);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void setDBSave3(HttpServletRequest request) {
		
//		String[] midx = {
//				"86072","86157","86729","86728","86720","86750","83203","86751","86689","86503","86754","86715","86713","86765","86764","86678","86756","86489","80397"
//		};
		String[] midx = {
					"86796","86793","86798","86772","86752","86748","86770","86794","86827","86757","86701","86799","86720","86750","86072","86756","86729","83203","86503"
				};
		
		for(int i = 0; i < midx.length; i++) {
			
			Connection conn = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/?midx="+midx[i]);
			try {
				Document doc = conn.get();
				
				String img = doc.selectFirst(".box-image img").attr("src");
				String movieStatus = doc.selectFirst(".box-contents em span").text();
				String movieTitleKo = doc.selectFirst(".box-contents .title strong").text();
				String movieTitleEn = doc.selectFirst(".box-contents .title p").text();
				String movieRate = doc.selectFirst(".score").text();
				String all = doc.selectFirst(".spec").text();
				String movieStory = doc.selectFirst(".sect-story-movie").text();
				
				String screenType = doc.selectFirst(".screentype").text(); 
				
				String movieDirector = all.substring(0,all.indexOf("/")); 
				String movieActor = "";
				if(all.contains("배우")) {
					movieActor = all.substring(all.indexOf("배우"),all.indexOf("장르"));
				}
				String movieGenre = all.substring(all.indexOf("장르"),all.indexOf("개봉"));
				String movieOpenDate = all.substring(all.lastIndexOf("개봉"));
				
				
				CgvMovieDetailVO vo = new CgvMovieDetailVO();
				vo.setImg(img);
				vo.setMovieStatus(movieStatus);
				vo.setMovieTitleKo(movieTitleKo);
				vo.setMovieTitleEn(movieTitleEn);
				vo.setMovieRate(movieRate);
				vo.setMovieStory(movieStory);
				vo.setScreenType(screenType);
				vo.setMovieDirector(movieDirector);
				vo.setMovieActor(movieActor);
				vo.setMovieGenre(movieGenre);
				vo.setMovieOpenDate(movieOpenDate);
				
				crawlingDAO.setCGV_MovieDetailDBsave(vo);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		
		
	}
		
}
