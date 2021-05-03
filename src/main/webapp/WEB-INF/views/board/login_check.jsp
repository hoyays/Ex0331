<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인 확인</title>
		<c:choose>
			<c:when test="${session_flag == null || session_flag == 'fail'}">
				<script type="text/javascript">
					alert("ID/PW가 일치하지 않습니다. 다시 시도해 주시기 바랍니다.");
					location.href="login.html";
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					alert("로그인 성공!");
					location.href="index.jsp";
				</script>
			</c:otherwise>
		</c:choose>
	</head>
	<body>
	
	</body>
</html>