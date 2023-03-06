package com.spring.green2209S_10.crawling;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class EventInforCrawling {
	public static void main(String[] args) throws IOException {
		
		Connection conn = Jsoup.connect("http://www.cgv.co.kr/culture-event/event/defaultNew.aspx#1");
		
		Document doc = conn.get();
		
		Elements els = doc.select("#contents");
		
		for(int i = 0; i < els.size(); i++) {
			Element el = els.get(i);
			System.out.println(el);
			
		}
	}
}
