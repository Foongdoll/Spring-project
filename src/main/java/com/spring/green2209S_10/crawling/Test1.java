package com.spring.green2209S_10.crawling;

import java.util.Calendar;
import java.util.Date;

public class Test1 {
	public static void main(String[] args) {
		
		Date now = new Date();
		
		Calendar calendar = Calendar.getInstance();
		
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		
		System.out.println(dayOfWeek); 
		
		// 일요일 1 월요일 2 화요일 3 수요일 4 목요일 5 금요일 6 토요일 7 
	}
}
