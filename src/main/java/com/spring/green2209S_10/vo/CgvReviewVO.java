package com.spring.green2209S_10.vo;

import javax.validation.constraints.Max;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;

import lombok.Data;

@Data
@Validated
public class CgvReviewVO {
	private int idx;
	
	@Max(value = 50,message = "글자수가 초과되었습니다.")
	private String re_ScreenType;
	
	@NotBlank
	@Max(value = 20,message = "글자수가 초과되었습니다.")
	private String re_Id;
	
	@NotBlank
	@Max(value = 50,message = "글자수가 초과되었습니다.")
	private String re_Title;
	
	private String re_Date;
	
	private int re_Good;
	
	@NotBlank
	private String re_Content;
	
	private String re_MovieTitle;
	private int re_Rating;
	private int re_reportSw;
	
	private int re_sumRating;
	private int re_cntRating;
}
