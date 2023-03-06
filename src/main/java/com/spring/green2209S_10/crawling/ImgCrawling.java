package com.spring.green2209S_10.crawling;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class ImgCrawling {
	public static void main(String[] args) throws Exception {
		Connection conn = Jsoup.connect("https://www.cgv.co.kr/");
		Document doc = conn.get();
		Elements imgs = doc.select(".swiper-slide img");	
		Elements movieNames = doc.select(".movieName");
		
		String[] movieNameArr = movieNames.html().split("\n");
		for(String movieName : movieNameArr) {
			System.out.println(movieName);
		}
		 
		String movieName = "";
		String directory = "";
		
		int cnt = 0;
		for(int i = 0; i < imgs.size(); i++) {
			Element iEl = imgs.get(i);
			String img = iEl.attr("src").substring(iEl.attr("src").lastIndexOf("/")+1,iEl.attr("src").length());
			System.out.println(img);
			
//			Map<String, String> map = new HashMap<String, String>();
//			if(img.contains(".jpg")) {
//				if(i < 39) directory = movieNameArr[i]; cnt++; 
//			}
//			if(i > 39) movieNameArr[i] = "";
//				map.put("rank", cnt+"");
//				map.put("img", img);
//				map.put("movieName", movieNameArr[i]);
//				System.out.println(movieNameArr[i]);
//				saveFileDB(map,movieName);
//				saveFileImg(img,directory);		
		}
	}

	private static void saveFileDB(Map<String, String> map, String movieName) {
			String rank = map.get("rank");
			String img = map.get("img");
	}

	private static void saveFileImg(String img,String directory) throws Exception {
		File file = new File("D:/Develop/SpringFrameWork/Work/Project/Work/Images/"+directory);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		
//		InputStream is = url.openStream();
		
		FileOutputStream fos = new FileOutputStream(file+"/"+img);
		int b = 0;
		
//		while((b = is.read()) != -1) {
			fos.write(b);
//		fos.close();
			
			System.out.println(img + ":: 작업 완료");
		}
		
	}