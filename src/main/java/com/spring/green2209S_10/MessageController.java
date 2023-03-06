package com.spring.green2209S_10;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String msg(@PathVariable String msgFlag,Model model,HttpSession session,
		@RequestParam(name="name", defaultValue = "", required = false) String name) {
		String msg = "";
		String url = "";
		
		if(msgFlag.equals("loginOk")) {
			msg = name+"님 로그인하셨습니다.";
			url = "";
		}
		else if(msgFlag.equals("loginNo")) {
			msg = "로그인에 실패하셨습니다.";
			url = "login";
		}
		else if(msgFlag.equals("logoutOk")) {
			msg = name+"님 로그아웃하셨습니다.";
			url = "";
		}
		else if(msgFlag.equals("joinOk")) {
			msg = "회원가입이 정상처리되셨습니다.";
			url = "";
		}
		else if(msgFlag.equals("joinNo")) {
			msg = "회원가입이 정상처리되지않았습니다.";
			url = "movie/join";
		}
		else if(msgFlag.equals("myInforUpdateOk")) {
			msg = "회원 정보 수정완료";
			url = "";
		}
		else if(msgFlag.equals("boardInputOk")) {
			msg = "글이 등록되었습니다.";
			url = "board/boardList";
		}
		else if(msgFlag.equals("boardInputNo")) {
			msg = "글을 등록하는데 실패하였습니다.";
			url = "";
		}
		else if(msgFlag.equals("memberNo")) {
			msg = "로그인을 먼저 하신 후 이용해주세요.";
			url = "";
		}
		else if(msgFlag.equals("notadmin")) {
			msg = "당신은 관리자가 아닙니다.\n관리자라면 정상적인 방법으로 다시 접근해주세요.";
			url = "";
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "include/message";
	}
}
