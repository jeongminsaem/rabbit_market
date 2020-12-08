<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="card border-primary mb-3" style="border: 3px solid #D8D8D8; margin: 0 auto; padding: 140px; ">
	<div  style="width: 310px; margin: 0 auto; ">
		 <input class="form-control" type="text" placeholder="아이디" id='userid' style="width: 300px; margin-bottom: 5px;">
		 <input class="form-control form-control" type="password" placeholder="비밀번호" id='userpwd' style="width: 300px; margin-bottom: 20px;" 
		        onkeypress="if( event.keyCode==13 ){ go_login() }" >	
		 <a class="btn btn-primary " style="width: 300px; font-size: 1em; margin-bottom: 5px; " onclick="go_login()">로그인</a>&nbsp;&nbsp;
		 <a class="btn btn-primary" style="width: 300px; font-size: 1em; margin-bottom: 5px; "  href="member">회원가입</a>
		 <div id="googleLoginBtn" style="cursor: pointer; ">
			<img id="googleLoginImg" src="img/sns_login_google.png" style="width: 300px; height: 45px;">
		 </div>		 
	</div>	
</div>


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


/* 구글 로그인  */
	const onClickGoogleLogin = (e) => {
	
 		window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?"+
 				"client_id=87280402706-a50jub75cop67urg603kheqr7tpe0hhg.apps.googleusercontent.com&"+ 				
 				"redirect_uri=http://localhost:80/iot/auth"+
 				"&response_type=code&&scope=email%20profile%20openid&access_type=offline")
 	};
	
	const googleLoginBtn = document.getElementById("googleLoginBtn");
	
	googleLoginBtn.addEventListener("click", onClickGoogleLogin);











</script>
</html>