package com.site.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.site.dto.BoardDto;

@Mapper
public interface BoardMapper {
	
	//게시판 출력하기
	List<BoardDto> selectBoardListAll(int startRow, int endRow);
	List<BoardDto> selectBoardListTitle(int startRow, int endRow, String search);
	List<BoardDto> selectBoardListContent(int startRow, int endRow, String search);
	List<BoardDto> selectBoardListSearchAll(int startRow, int endRow, String search);
	
	//게시글 수 확인하기
	int listCount();
	int listCountTitle(String search);
	int listCountContent(String search);
	int listCountSearchAll(String search);
	
	//게시글 내용보기(content_view)
	BoardDto selectBoardContent_view(String bid);
	
	//조회수 1 증가
	void selectUpHit(String bid);
	
	//글쓰기 DB에 저장하기
	void insertBoardWrite(BoardDto boardDto);
	
	//글 수정하기
	void updateBoardModify(BoardDto boardDto);
	
	//답글 저장하기
	void insertBoardReply(BoardDto boardDto);
	
	//새 댓글 아래 글 bstep+1 처리하기
	void insertBoardReplyPlus(BoardDto boardDto);
	
	//글 삭제하기
	void deleteBoardDelete(String bid);
	
	//이전글 가져오기
	BoardDto selectBoard_pre(String bid);
	BoardDto selectBoard_preTitle(String bid, String search);  //제목검색
	BoardDto selectBoard_preContent(String bid, String search);  //내용검색
	BoardDto selectBoard_preSearchAll(String bid, String search);   //제목+내용 검색
	
	//다음글 가져오기
	BoardDto selectBoard_next(String bid);
	BoardDto selectBoard_nextTitle(String bid, String search);   //제목검색
	BoardDto selectBoard_nextContent(String bid, String search);  //내용검색
	BoardDto selectBoard_nextSearchAll(String bid, String search);  //제목+내용 검색
	
	
	
	
	
	
	
	
	
	
	
	
	

}//interface
