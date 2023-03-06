package com.spring.green2209S_10.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MemberAuthInterceptor extends HandlerInterceptorAdapter {

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("sId") == null ? "" : (String)session.getAttribute("sId");
		
		if(id.equals("")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/msg/memberNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		
		return true;
	}
	
}
