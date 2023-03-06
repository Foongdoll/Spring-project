package com.spring.green2209S_10;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.spring.green2209S_10.dao.EventDAO;
import com.spring.green2209S_10.service.EventService;
import com.spring.green2209S_10.vo.CgvEventVO;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	EventService eventService;

	@Autowired
	EventDAO eventDAO;
	
	@RequestMapping(value = "/eventHome", method = RequestMethod.GET)
	public String eventHomeGet(Model model) {
		
		List<CgvEventVO> vos = eventDAO.getEventList();  
		model.addAttribute("vos",vos);
		
		return "event/eventHome";
	}
	@RequestMapping(value = "/eventDetail", method = RequestMethod.GET)
	public String eventDetailGet(Model model,String content, String edate,String title) {
		
		model.addAttribute("title",title);
		model.addAttribute("content",content);
		model.addAttribute("edate",edate);
		
		return "event/eventDetail";
	}  
	
	
}
