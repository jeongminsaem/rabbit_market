<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>공공데이터</h3>
<div class='btnSet dataOption'>
	<a class='btn-fill'>약국조회</a>
	<a class='btn-empty'>유기동물조회</a>
</div>



<script>
	$('.dataOption a').click(function(){
		$('.dataOption a').removeClass();
		$(this).addClass('btn-fill');
		var idx = $(this).index();
		$('.dataOption a:not(:eq('+idx+'))').addClass('btn-empty'); /* 현재 idx가 아닌 나머지 버튼은 다 empty */
		if(idx==0) pharmacy_list();
		else 	   animal_list();
	});


function pharmacy_list(){
	
}

function animal_list(){
	
}

	
</script>
</body>
</html>