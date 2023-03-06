package com.spring.green2209S_10.vo;

import lombok.Data;

@Data
public class CgvCommentVO {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String wDate;
	private String hostIp;
	private String content;
	private int groupId;
	private int level;
	private int levelOrder;
}
