package com.spring.green2209S_10.crawling;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class FastTicketingCrawling {
	public static void main(String[] args) {
		
		Connection conn = Jsoup.connect("http://www.cgv.co.kr/movies/");
		
		
		Document doc;
		try {
			doc = conn.get();
			Elements movieTitles = doc.select("div.box-contents strong.title");	
			
			for(int i = 0; i < movieTitles.size(); i++) {
				String movieTitle = movieTitles.get(i).text();
				
				System.out.println(movieTitle);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
