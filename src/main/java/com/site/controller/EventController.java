package com.site.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.site.dto.CommentDto;
import com.site.service.EventService;

@Controller
public class EventController {
	
	@Autowired
	EventService eventService;
	
	@RequestMapping("/event/event")
	public String event() {
		return "/event/event";
	}
	
	@RequestMapping("/event/event_view")
	public String event_view() {
		return "/event/event_view";
	}
	
	@RequestMapping("/event/commentWrite_check")
	@ResponseBody
	public Map<String, Object> commentWrite_check(CommentDto commentDto) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		CommentDto dto = eventService.commentWrite_check(commentDto);
		
		map.put("dto", dto);
		
		return map;
	}
	
	
	

}//class
