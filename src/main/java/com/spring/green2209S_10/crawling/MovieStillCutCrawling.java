package com.spring.green2209S_10.crawling;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class MovieStillCutCrawling {
	public static void main(String[] args) throws IOException {
		
		Connection conn = Jsoup.connect("http://www.cgv.co.kr/movies/detail-view/still-cut.aspx?midx=86072#menu");
		
		Document doc = conn.get();

		Elements els = doc.select("img");
		
		for(int i = 0; i < els.size(); i++) {
			System.out.println(els);
		}
	}
}
