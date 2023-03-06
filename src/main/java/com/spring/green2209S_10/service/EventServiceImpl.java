package com.spring.green2209S_10.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_10.dao.EventDAO;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	EventDAO EventDAO;
	

	
	
}
