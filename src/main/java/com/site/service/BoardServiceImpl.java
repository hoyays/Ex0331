package com.site.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.site.dto.BoardDto;
import com.site.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	PageNumber pageNumber;
	
	//변수선언
	Map<String, Object> map;
	List<BoardDto> list;
	BoardDto boardDto;
	BoardDto preDto;
	BoardDto nextDto;

	@Override
	public Map<String, Object> boardListAll(String listPage, String category, String search) {
		
		
		int page = 1;    //첫 페이지 초기화
		int limit = 10;  //1개 페이지에 노출되는 게시글 수(10개씩)
		
		// page 데이터가 있으면 데이터 적용
		if (listPage != null && listPage != "") {
			page = Integer.parseInt(listPage);
		}
		
		int startRow = (page-1)*limit+1;   //선택한 페이지의 첫번째 줄 => 1, 11, 21...
		int endRow = startRow+limit-1;   //선택한 페이지의 마지막 줄 => 10, 20, 30 ...
		
		
		//검색기능
		if(category == null || category.equals("")) {    //검색어를 입력하지 않았을 때
			list = boardMapper.selectBoardListAll(startRow, endRow);
			
		}else if(category.equals("title")) {   //제목 검색
			list = boardMapper.selectBoardListTitle(startRow, endRow, search);
			
		}else if(category.equals("content")) {   //내용 검색
			list = boardMapper.selectBoardListContent(startRow, endRow, search);
			
		}else if(category.equals("all")) {    //전체 검색
			list = boardMapper.selectBoardListSearchAll(startRow, endRow, search);
			
		}
		
		
		//메소드 호출 - 페이지 넘버링 계산
		map = pageNumber.pageNumber(page, limit, category, search);
		map.put("list", list);
		
		return map;
	}

	@Override
	public Map<String, Object> boardContent_view(String bid, String category, String search, String page) {
		
		
		//content 1개 가져오기
		boardDto = boardMapper.selectBoardContent_view(bid);
		
		//조회수 1 증가
		boardMapper.selectUpHit(bid);
		
		
		
		//검색기능을 사용했을 경우
		//이전글, 다음글 가져오기
		if(category == null || category.equals("")) {    //검색어를 입력하지 않았을 때
			preDto = boardMapper.selectBoard_pre(bid);
			nextDto = boardMapper.selectBoard_next(bid);
			
		}else if(category.equals("title")) {   //제목 검색
			preDto = boardMapper.selectBoard_preTitle(bid, search);
			nextDto = boardMapper.selectBoard_nextTitle(bid, search);
			
		}else if(category.equals("content")) {   //내용 검색
			preDto = boardMapper.selectBoard_preContent(bid, search);
			nextDto = boardMapper.selectBoard_nextContent(bid, search);
			
		}else if(category.equals("all")) {    //전체 검색
			preDto = boardMapper.selectBoard_preSearchAll(bid, search);
			nextDto = boardMapper.selectBoard_nextSearchAll(bid, search);
			
		}
		
		
		
		
		
		
		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		map.put("boardDto", boardDto);
		map.put("preDto", preDto);
		map.put("nextDto", nextDto);
		
		return map;
	}

	@Override
	public void boardWrite(BoardDto boardDto, @RequestPart MultipartFile file) {   //@RequestPart는 생략가능
		
		//첨부파일 처리
		String fileName = file.getOriginalFilename();  //원본파일 이름
		String filenameExtension = FilenameUtils.getExtension(fileName).toLowerCase();  //확장자명 가져오기
		
		if(filenameExtension != "") {
			String fileUrl = "C:/workspace2/Ex0331/src/main/resources/static/upload/";  //파일저장위치(마지막에 반드시 슬래시(/))
			String uploadFileName = RandomStringUtils.randomAlphanumeric(32)+"."+filenameExtension;  //신규 파일 이름 - 32자리(중복방지)
			File f = new File(fileUrl+uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//위에서 처리한 파일이름까지 boardDto에 담아서 DB로 보낸다.
			boardDto.setFilename(uploadFileName);
		}else {
			boardDto.setFilename("");
		}
		
		
		//DB로 전송
		boardMapper.insertBoardWrite(boardDto);
		
	}

	@Override
	public Map<String, Object> boardModify_view(String bid, String category, String search, String page) {
		
		//content 1개 가져오기
		boardDto = boardMapper.selectBoardContent_view(bid);
		
		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		map.put("boardDto", boardDto);
		
		return map;
	}

	@Override
	public void boardModify(BoardDto boardDto, MultipartFile file, String page, String category, String search) {
		
		// 첨부파일 처리
		// 원본파일 이름
		String fileName = file.getOriginalFilename(); 
		
		if (file.getSize() != 0) {    //파일사이즈가 0이 아니면
			String fileUrl = "C:/workspace2/Ex0331/src/main/resources/static/upload/"; // 파일저장위치(마지막에 반드시 슬래시(/))
			//파일명에 업로드된 시간을 추가
			long time = System.currentTimeMillis();
			String uploadFileName = String.format("%d_%s", time, fileName);
			File f = new File(fileUrl + uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// 위에서 처리한 파일이름까지 boardDto에 담아서 DB로 보낸다.
			boardDto.setFilename(uploadFileName);
		} else {
			//기존 파일이름을 그대로 저장하면 됨.
			//boardDto.setFilename("");
		}

		// DB로 전송
		boardMapper.updateBoardModify(boardDto);
		
		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		
		
		
	}

	@Override
	public void boardReply(BoardDto boardDto, MultipartFile file, String page, String category, String search) {
		
		// 첨부파일 처리
		// 원본파일 이름
		String fileName = file.getOriginalFilename();

		if (file.getSize() != 0) { // 파일사이즈가 0이 아니면
			String fileUrl = "C:/workspace2/Ex0331/src/main/resources/static/upload/"; // 파일저장위치(마지막에 반드시 슬래시(/))
			// 파일명에 업로드된 시간을 추가
			long time = System.currentTimeMillis();
			String uploadFileName = String.format("%d_%s", time, fileName);
			File f = new File(fileUrl + uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 위에서 처리한 파일이름까지 boardDto에 담아서 DB로 보낸다.
			boardDto.setFilename(uploadFileName);
		} else {
			// 기존 파일이름을 그대로 저장하면 됨.
			boardDto.setFilename("");
		}

		// DB로 전송
		boardMapper.insertBoardReply(boardDto);
		
		//같은 그룹안에서
		//새로운 댓글 아래의 모든 글의 bstep+1 처리한다.
		boardMapper.insertBoardReplyPlus(boardDto);

		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		
	}

	@Override
	public void boardDelete(String bid, String page, String category, String search) {
		
		boardMapper.deleteBoardDelete(bid);
		
		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		
	}
	
	

}//class
