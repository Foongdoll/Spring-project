package com.spring.green2209S_10.vo;

import lombok.Data;

@Data
public class CgvTicketingPaymentVO {
	private int tk_idx;
	private String tk_cd;
	private String tk_Id;
	private String tk_movieName;
	private String tk_screenType;
	private String tk_town;
	private String tk_screenDate;
	private String tk_screenTime;
	private String tk_seat;
	private String tk_movieImg;
	private int tk_adultno;
	private int tk_teenno;
	private int tk_childno;
	private int tk_preferentialno;
	private int tk_totPrice;
	private String tk_QRcode;
	private String tk_email;
	private String tk_tel;
	private String tk_name;
	private int tk_cancelSw;
	private int tk_usePoint;
	private int tk_useCoupon;
	
	private int tk_saleCnt;
}