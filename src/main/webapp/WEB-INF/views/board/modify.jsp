<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>방명록 수정</h3>
<form action="update.bo" method="post" enctype="multipart/form-data">
	<table>
		<tr><th class='w-px120'>제목</th>
			<td><input type="text" name="title" class='need' title='제목' value='${vo.title}'/></td>
		</tr>
		<tr><th>작성자</th><td class='left'>${vo.name}</td></tr>	
		<tr><th>내용</th>
			<td><textarea name='content' class='need' title='내용'>${vo.content}</textarea></td>
		</tr>	
		<tr><th>첨부파일</th>
			<td class="left td-img">
				<label>
					<input type="file" name="file" id="attach-file"/>
					<img src='img/select.png' class='file-img' />
				</label>
				<span id='file-name'>${vo.filename}</span>
				<span id='preview'></span>
				<span id='delete-file' style='margin-left: 20px; color:red;'><i class='fas fa-times font-img'></i></span>
			</td>
		</tr>	
	</table>
	<input type="hidden" name="id" value='${vo.id}'/>
	<input type="hidden" name="attach" />
</form>
<div class="btnSet">
	<a class='btn-fill' onclick='if( necessary() ){$("[name=attach]").val( $("#file-name").text() ); $("form").submit()}'>저장</a>
	<a class='btn-empty'>취소</a>
</div>

<script type="text/javascript">
	if(${!empty vo.filename}){
		$('#delete-file').css('display','inline');
		var filename = '${vo.filename}';
		var ext = filename.substring(filename.lastIndexOf('.')+1).toLowerCase();
		var imgs = ['jpg','png','gif','bmp','jpeg'];
		if ( imgs.indexOf(ext) > -1){
			var img = '<img id="preview-img" class="file-img" '
						+'style="border-radius:50%" src="'+ '${vo.filepath}'.substring(1) +'"/>';

			$('#preview').html(img);
			}

		}
</script>
<script type="text/javascript" src="js/image_preview.js"></script>
<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
</body>
</html>