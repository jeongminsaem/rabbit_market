<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>


<header>	
</header>
<body> 

<c:forEach items="${list}" var="vo">
<div class="alert alert-dismissible alert-info" style="user-select: auto;">
  <button type="button" class="close" data-dismiss="alert" onclick="del_noti('${vo.id}')">삭제</button>
  <h6 class="alert-heading" style="user-select: auto;">Notification</h6>
  <p class="mb-0" style="user-select: auto;"><a href="detail.mar?id=${vo.pid}" class="alert-link" style="user-select: auto;">
 ${vo.name}님께서   ${vo.title}</a>에 댓글을 남겼습니다.</p>
</div>
</c:forEach>
</body>
<script type="text/javascript">


//int id='${vo.id}';

function del_noti(id){
	
	$.ajax({
		url: 'del_noti',	
		type: 'post',
		data: { 'id':id },
		success: function( data ){
			if( data ){			
				window.location.reload();
			} else {
				alert("zz");
			}
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
} 


/* $(".close").on("click",function(){       
	
	alert("zz");

	$.ajax({
		url: 'del_noti',	
		type: 'post',
		data: { 'id':${vo.id} },
		success: function( data ){
			if( data ){			
				alert('관심목록에 추가 됬어요');
				
			} else {
				alert('관심목록에 삭제됬어요');
			}
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
	
});  */















</script>
</html>