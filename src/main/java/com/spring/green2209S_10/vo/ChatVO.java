package com.spring.green2209S_10.vo;

import lombok.Data;

@Data
public class ChatVO {
	private String type;
	private String roomId;
  private String sender;
  private String message;
  private String mdate;
  private int readSw;
}
