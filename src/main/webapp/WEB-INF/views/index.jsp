<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메인 페이지</title>
	</head>
	<body>
		<c:choose>
			<c:when test="${session_flag == null || session_flag == 'fail'}">
				<h3>로그아웃 상태입니다! 로그인 후 이용해 주시기 바랍니다!</h3>
				<ul>
					<li><a href="/member/login">로그인</a></li>
					<li>회원가입</li>
				</ul>
			</c:when>
			<c:otherwise>
				<h3>${session_nickName}님, 환영합니다!</h3>
				<ul>
					<li><a href="/member/logout">로그아웃</a></li>
					<li><a href="/event/event">이벤트</a></li>
					<li>회원정보 수정</li>
					<li>전체 회원 리스트</li>
					<li><a href="/board/list">전체 게시판 리스트</a></li>
				</ul>
			</c:otherwise>
		</c:choose>
	</body>
</html>