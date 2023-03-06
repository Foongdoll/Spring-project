package com.spring.green2209S_10;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Test1 {
	public static void main(String[] args) throws IOException {
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
	}
	}
}