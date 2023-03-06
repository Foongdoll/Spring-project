package com.spring.green2209S_10.crawling;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class MovieChartCrawling {
	public static void main(String[] args) throws IOException {
		Connection conn = Jsoup.connect("http://ticket.cgv.co.kr/Reservation/Reservation.aspx?MOVIE_CD=&MOVIE_CD_GROUP=&PLAY_YMD=&THEATER_CD=&PLAY_NUM=&PLAY_START_TM=&AREA_CD=&SCREEN_CD=&THIRD_ITEM=&SCREEN_RATING_CD=");
		
		
		Document doc = conn.get();

		String ss = doc.select(".section section-movie").text();
		
		System.out.println(ss);
		
		
//		Elements ranks = doc.select(".rank");
//		Elements imgs = doc.select(".thumb-image img");
//		Elements movieAges = doc.select(".cgvIcon");	
//		Elements movieTitles = doc.select(".box-contents strong.title");	
//		Elements movieRates = doc.select("strong.percent span");
//		Elements movieOpenDates = doc.select("span.txt-info");
//		Elements likeNums = doc.select(".egg-gage.small > span.percent");
//		for(int i = 0; i < ranks.size(); i++) {
//			String rank = ranks.get(i).text();
//			String img = imgs.get(i).attr("src");
//			String movieAge = movieAges.get(i).text();
//			String movieTitle = movieTitles.get(i).text();
//			String movieRate = movieRates.get(i).text();
//			String movieOpenDate = movieOpenDates.get(i).text();
//			String likeNum = likeNums.get(i).text();
//		}
		
	}
}