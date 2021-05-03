<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글쓰기</title>
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,500,700,900&display=swap&subset=korean" rel="stylesheet">
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" href="/css/write.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function writeCheck(){
			alert("ajax 시작");
			
			if($("#btitle").val() == ""){
				alert("제목을 입력하세요!");
				$("#btitle").focus();
				return false;
			}
			
			
			
			//json 파일의 데이터 구조는, {rName:"홍길동", rContent:"내용"}
			$.ajax({
				url:"./write1",   //data의 내용을 url로 지정한 경로로 넘겨준다. 
				type:"post",
				enctype:"multipart/form-data",
				data: new FormData($("#writeForm")[0]),   //보내는 data  
				processData: false,
				contentType:false,
				cache: false,
				success:function(data){   //받는 data. 
				
					alert("게시글 등록이 완료되었습니다.");
					location.href="./list";	
				
					/* if(data.loginCheck == 1){
						alert(data.message);
						location.href="/index";
					}else{
						alert(data.message);
						$("#id").val("");
						$("#id").focus();
						$("#pw").val("");
					} */
				
				},
				
				error:function(){   //실패시
					alert("에러");
				}
				
			});//ajax
			
		}//loginCheck()-js
	</script>
</head>
<body>
<section>
    <h1>관리자 글쓰기</h1>
    <hr>

    <form action="./write" id="writeForm" name="writeForm" method="post" enctype="multipart/form-data">
      <table>
        <colgroup>
          <col width="15%">
          <col width="85%">
        </colgroup>
        <tr>
          <th>작성자</th>
          <td>
            <input type="text" name="bname" id="bname">
          </td>
        </tr>
        <tr>
          <th>제목</th>
          <td>
            <input type="text" name="btitle" id="btitle">
          </td>
        </tr>
        <tr>
          <th>내용</th>
          <td>
            <textarea name="bcontent" cols="50" rows="10" id="bcontent"></textarea>
          </td>
        </tr>
        <tr>
          <th>이미지 표시</th>
          <td>
            <input type="file" name="file" id="file">
          </td>
        </tr>
      </table>
      <hr>
      <div class="button-wrapper">
        <button type="button" onclick="writeCheck()" class="write">작성완료</button>
        <button type="button" class="cancel" onclick="javascript:location.href='./list'">취소</button>
      </div>
    </form>

  </section>

</body>
</html>