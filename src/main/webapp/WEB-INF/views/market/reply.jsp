<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>어멋</h3>

<form method="post" action="reply_insert.bo" enctype="multipart/form-data">
<input type='hidden' name='root' value='${vo.root}'>
<input type='hidden' name='repstep' value='${vo.repstep}'>
<input type='hidden' name='repindent' value='${vo.repindent}'>
<table>
<tr><th class="w-px120">제목</th>
	<td><input type="text" name="title" class="need" title="제목" onkeypress="if( event.keyCode==13){if (!necessary() )return false;}"/></td>
</tr>
<tr><th>작성자</th>
	<td class="left">${login_info.name}</td>
</tr>

<tr><th>내용</th>
	<td><textarea name="content" class="need" title="내용"></textarea></td>
</tr>

<tr><th>첨부파일</th>
	<td class="left td-img">
		<label>
			<input type="file" name="file" id="attach-file"/>
			<img src="img/select.png" class="file-img"/>
		</label>
		<span id = "file-name"></span>
		<span id="delete-file" style="color:red"><i class="font-img fas fa-times"></i></span>
	</td>
</tr>
</table>
</form>
<div class="btnSet">
	<a class="btn-fill" onclick="if( necessary()){ $('form').submit() }">저장</a>
	<a class="btn-empty" href='list.no'>취소</a>
</div>
<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript">
$('#attach-file').on('change', function(){
	if( this.files[0] ) $('#file-name').text(this.files[0].name);
	$('#delete-file').css('display','inline');
});

$('#delete-file').on('click', function(){
	$('#attach-file').val('');
	$('#file-name').text('');
	$('#delete-file').css('display','none');
});
</script>
</body>
</html>