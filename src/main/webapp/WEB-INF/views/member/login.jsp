<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="card border-primary mb-3" style="border: 3px solid #D8D8D8; margin: 0 auto; padding: 200px; ">
	<div  style="width: 310px; margin: 0 auto; ">
	 <input class="form-control" type="text" placeholder="아이디" id='userid' style="width: 300px; margin-bottom: 5px;">
	 <input class="form-control form-control" type="password" placeholder="비밀번호" id='userpwd' style="width: 300px; margin-bottom: 20px;" 
	        onkeypress="if( event.keyCode==13 ){ go_login() }" >	
	 <a class="btn btn-primary " style="width: 300px; font-size: 1em; margin-bottom: 5px; " onclick="go_login()">로그인</a>&nbsp;&nbsp;
	 <a class="btn btn-primary" style="width: 300px; font-size: 1em; "  href="member">회원가입</a>
	</div>	
</div>

<!-- <div class="card border-secondary mb-3" style="max-width: 20rem; user-select: auto;">
  <div class="card-header" style="user-select: auto;">Header</div>
  <div class="card-body" style="user-select: auto;">
    <h4 class="card-title" style="user-select: auto;">Secondary card title</h4>
    <p class="card-text" style="user-select: auto;">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
  </div>
</div> -->
</body>


<script type="text/javascript">
function go_login(){
	if( $('#userid').val()=='' ){
		alert('아이디를 입력하세요!');
		$('#userid').focus();
		return;
	}else if( $('#userpwd').val()=='' ){
		alert('비밀번호를 입력하세요!');
		$('#userpwd').focus();
		return;
	}

	$.ajax({
		type: 'post',
		url: 'login',
		data: { userid:$('#userid').val(), userpwd:$('#userpwd').val() },
		success: function(data){
			if( data ) location.href = "list.mar";
			else{
				alert('아이디나 비밀번호가 일치하지 않습니다!');
// 				$('#useriod').val('');
// 				$('#userpwd').val('');
			}
		},error: function(req, text){
			alert(text+": "+req.status);
		} 
	});
}

</script>
</html>