<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>게시판</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/notice_list.css">
</head>
<body>
<section>
    <h1>NOTICE</h1>
    <div class="wrapper">
      <form action="./list" name="search" method="post">
        <select name="category" id="category">
          <option value="all" ${map.category eq 'all'? 'selected':''}>전체</option>
          <option value="title" ${map.category eq 'title'? 'selected':''}>제목</option>
          <option value="content" ${map.category eq 'content'? 'selected':''}>내용</option>
        </select>

        <div class="title">
          <input type="text" size="16" name="search" value="${map.search}">
        </div>
  
        <button type="submit"><i class="fas fa-search"></i></button>
      </form>
    </div>

    <table>
      <colgroup>
        <col width="12%">
        <col width="44%">
        <col width="17%">
        <col width="17%">
        <col width="10%">
      </colgroup>
      <!-- 제목부분 -->
      <tr>
        <th>No.</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
      </tr>
      <!-- 내용부분 -->
      <c:forEach var="dto" items="${map.list}">
	      <tr>
	        <td><span class="table-notice">${dto.bid}</span></td>
	        <td class="table-title">
	      	<c:forEach begin="1" end="${dto.bindent}">
	      		<img alt="" src="/img/reply_img.png"> 
	      	</c:forEach>
	        <a href="./content_view?bid=${dto.bid}&page=${map.page}&category=${map.category}&search=${map.search}">${dto.btitle}</a>
	        </td>
	        <td>${dto.bname}</td>
	        <td>${dto.bdate}</td>
	        <td>${dto.bhit}</td>
	      </tr>
      </c:forEach>
      
    </table>

    <ul class="page-num">
      <a href="./list?page=1&category=${map.category}&search=${map.search}"><li class="first"></li></a>   <!-- 제일 첫 페이지로 -->
      <c:choose>
      	<c:when test="${map.page <= 1}">
			<li class="prev"></li>	    <!-- 이전 페이지로(링크없음) -->
      	</c:when>
      	<c:otherwise>
	      <a href="./list?page=${map.page-1}&category=${map.category}&search=${map.search}"><li class="prev"></li></a>    <!-- 이전 페이지로(링크있음) -->
      	</c:otherwise>
      </c:choose>
      
      
      <!-- 번호 반복 시작 -->
      <c:forEach var="nowPage" begin="${map.startPage}" end="${map.endPage}">
      	<c:choose>
      		<c:when test="${nowPage == map.page}">
      			<li class="num"><div>${nowPage}</div></li>
      		</c:when>
      		<c:otherwise>
		      <a href="./list?page=${nowPage}&category=${map.category}&search=${map.search}"><li class="num"><div>${nowPage}</div></li></a>
      		</c:otherwise>
      	</c:choose>
      </c:forEach>
      <!-- 번호 반복 끝 -->
      
      
      <c:choose>
      	<c:when test="${map.page >= map.maxPage}">
      		<li class="next"></li>    <!-- 다음 페이지로(링크없음) -->
      	</c:when>
      	<c:otherwise>
		      <a href="./list?page=${map.page+1}&category=${map.category}&search=${map.search}"><li class="next"></li></a>     <!-- 다음 페이지로(링크있음) -->
      	</c:otherwise>
      </c:choose>
      
      <a href="./list?page=${map.maxPage}&category=${map.category}&search=${map.search}"><li class="last"></li></a>   <!-- 제일 마지막 페이지로 -->
    </ul>

    <a href="./write_view"><div class="write">쓰기</div></a>
  </section>

</body>
</html>