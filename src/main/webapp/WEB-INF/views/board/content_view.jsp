<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>뷰페이지</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/read.css">
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script type="text/javascript">
  	function delete_check(){
  		if(confirm("삭제하시겠습니까?")){
  			location.href="./delete?bid=${map.boardDto.bid}&page=${map.page}&category=${map.category}&search=${map.search}";
	  		//location.href="./delete?page="+${map.page}+"&bid="+${map.boardDto.bid}+"&category="+${map.category}+"&search="+${map.search};
  		}else{
  			return false;
  		}//if 
  	}//delete_check()
  </script>
  <style type="text/css">
  	.list:hover{
  		cursor: pointer;
  	}
  </style>
</head>
<body>
<section>
    <h1>NOTICE</h1>

    <table>
      <colgroup>
        <col width="80%">
        <col width="10%">
        <col width="10%">
        
      </colgroup>
      <tr>
        <th colspan="3">제목</th>
      </tr>
      <tr>
        <td colspan="3"><strong>${map.boardDto.btitle}</strong></td>
      </tr>
      <tr>
        <td>${map.boardDto.bname}</td>
        <td> 조회수</td>
        <td>${map.boardDto.bhit}</td>
      </tr>
      <tr>
        <td colspan="3" class="article">${map.boardDto.bcontent}</td>
      </tr>
      <tr>
      	<td>파일첨부</td>
        <td colspan="2"><a href="/upload/${map.boardDto.filename}" download>${map.boardDto.filename}</a></td>
      </tr>
       <tr>
        <td colspan="3" class="article">
        	<img src="/upload/${map.boardDto.filename}">
        </td>
      </tr>
      <tr>
        <td colspan="3"><strong>다음글</strong> <span class="separator">|</span>
        <a href="./content_view?bid=${map.nextDto.bid}&page=${map.page}&category=${map.category}&search=${map.search}">${map.nextDto.btitle}</a>
        </td>
      </tr>
      <tr>
        <td colspan="3"><strong>이전글</strong> <span class="separator">|</span>
        <a href="./content_view?bid=${map.preDto.bid}&page=${map.page}&category=${map.category}&search=${map.search}">${map.preDto.btitle}</a>
        </td>
      </tr>
    </table>
    <a href="list?page=${map.page}&category=${map.category}&search=${map.search}"><div class="list">목록</div></a>
    <div class="list" onclick="delete_check()">삭제</div>
    <a href="./modify_view?page=${map.page}&bid=${map.boardDto.bid}&category=${map.category}&search=${map.search}"><div class="list">수정</div></a>
    <a href="./reply_view?page=${map.page}&bid=${map.boardDto.bid}&category=${map.category}&search=${map.search}"><div class="list">답변달기</div></a>
  </section>
</body>
</html>