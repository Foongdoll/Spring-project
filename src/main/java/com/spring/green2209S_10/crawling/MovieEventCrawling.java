package com.spring.green2209S_10.crawling;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class MovieEventCrawling {
	public static void main(String[] args) throws IOException {
		
		Connection conn = Jsoup.connect("http://www.cgv.co.kr/culture-event/event/defaultNew.aspx?mCode=001#1");
		
		Document doc = conn.get();
		
		
	}
}
