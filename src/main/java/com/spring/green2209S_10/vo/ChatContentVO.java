package com.spring.green2209S_10.vo;

import lombok.Data;

@Data
public class ChatContentVO {
	private String roomId;
  private String sender;
  private String message;
  private int readSw;
  private String mdate;
  
  private int timeDiff;
}
