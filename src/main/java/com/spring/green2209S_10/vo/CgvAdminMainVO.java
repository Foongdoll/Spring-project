package com.spring.green2209S_10.vo;

import javax.validation.constraints.PositiveOrZero;

import lombok.Data;

@Data
public class CgvAdminMainVO {
	@PositiveOrZero
	private int today;
	@PositiveOrZero
	private int todayAmount;
	@PositiveOrZero
	private int todayJoin;
	@PositiveOrZero
	private int allDay;
}
