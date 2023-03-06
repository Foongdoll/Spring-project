package com.spring.green2209S_10.vo;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.PositiveOrZero;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class CgvMemberVO {
		private int mem_idx;
		
		private String mem_nickName;
		
		@NotBlank
		@Max(value = 20,message = "성명은 필수입력사항입니다.")
		private String mem_name;
		
		@NotBlank(message = "아이디는 필수입력사항입니다.")
		@Max(value = 20,message = "아이디의 최대 길이를 초과하였습니다.")
		private String mem_id;
		
		@NotBlank(message = "비밀번호는 필수입력사항입니다.")
		private String mem_pswd;
		
		@NotBlank
		@PositiveOrZero
		@Max(value = 11, message = "주민등록번호의 최대길이를 초과하였습니다.")
		private String mem_scNumber;
		
		@NotBlank
		@PositiveOrZero
		@Max(value = 13, message = "전화번호의 최대 길이를 초과하였습니다.")
		@Min(value = 9, message = "전화번호의 최소 길이에 못 미침니다..")
		private String mem_tel;
		
		@NotBlank
		@Email
		private String mem_email;
		
		
		private String mem_startDate;
		private String mem_lastDate;
		private int mem_point; 
		private int mem_level; 
		private String mem_mStatus;
		private int mem_pswdQ;
		private String mem_pswdA;
		private String mem_photo;
		private String mem_sPhoto;
		
		private int mem_authSw;
		private int mem_onoff;
		private int kakaoSw;
		private int googleSw;
		private int naverSw;
		private String mem_reportContent;
		private String mem_reportDate;
}
