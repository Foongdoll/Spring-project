package com.spring.green2209S_10.crawling;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class MovieDetailCrawling {
	public static void main(String[] args) throws IOException {
		
		String[] midx = {
				"86072","86157","86729","86728","86720","86750","83203","86751","86689","86503","86754","86715","86713","86765","86764","86678","86756","86489","80397"
		};
		for(int i = 0; i < midx.length; i++) {
		Connection conn = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/?midx=86720");
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
		
		System.out.println(movieGenre);
		
		
		System.out.println("영화 이미지 src:"+img);
		System.out.println("영화 상태 :"+movieStatus);
		System.out.println("영화 이름(한글) : "+movieTitleKo);
		System.out.println("영화 이름(영어) :"+movieTitleEn);
		System.out.println(movieRate);
		System.out.println(movieStory);
		System.out.println(screenType);
		System.out.println(movieDirector);
		System.out.println(movieActor);
		System.out.println(movieGenre);
		System.out.println(movieOpenDate);
//		
//		System.out.println(all);
		}
		
		
			
		}
}