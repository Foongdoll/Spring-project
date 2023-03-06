package com.spring.green2209S_10.vo;

import org.springframework.validation.annotation.Validated;

import lombok.Data;

@Data
@Validated
public class CgvTicketingVO {
	private int nameIdx;
	private String movieName;
	
	private int regionIdx;
	private String regionMovieName;
	private String screenType;
	private String region1;
	private String region2;
	private String region3;
	private String region4;
	private String region5;
	private String region6;
	private String region7;
	private String region8;
	private String region9;
	
	private int townIdx;
	private String townMovieName;
	private String town1;
	private String town2;
	private String town3;
	private String town4;
	private String town5;
	private String town6;
	private String town7;
	private String town8;
	private String town9;
	
	private int scIdx;
	private String scMovieName;
	private String town;
	private String screenDate;
	private String screenTime;
	private String seat;
	
}
