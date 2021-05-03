package com.site.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.dto.CommentDto;
import com.site.mapper.EventMapper;

@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	EventMapper eventMapper;

	@Override
	public CommentDto commentWrite_check(CommentDto commentDto) {
		
		//댓글 insert
		eventMapper.insertCommentWrite(commentDto);
		
		//mapper xml파일의 keyProperty="commentNo" 값은
		//아래와 같이 commentDto.getCommentNo()으로 읽을 수 있다.
		int commentNo = commentDto.getCommentNo();
		
		
		//위에서 받은 commentNo를 포함한 commentDto(insert가 완료된)를
		//select를 이용하여 DB로부터 받아온다.
		CommentDto dto = eventMapper.selectCommentWrite(commentNo);
		
		
		
		return dto;
	}

	
	
	
	
}//class
