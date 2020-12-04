<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form method="post" action="insert.bo" enctype="multipart/form-data">

	<table style="height: 99%">	
		<div class="form-group" style="user-select: auto;">
		  <label class="col-form-label" for="inputDefault" style="user-select: auto;">Title</label>
		  <input type="text" class="form-control need" placeholder="제목을 입력하세요" id="inputDefault" style="user-select: auto;" name='title' title='제목'>
		</div>
		
		<input type="hidden"  id="${login_info.name}"  name='title' title='제목'>
			
			
		<div class="form-group" style="user-select: auto;">
	      <label for="exampleTextarea" style="user-select: auto;">Content</label>
	      <textarea class="form-control need" id="exampleTextarea" rows="3" title='내용' style="user-select: auto; height:450px;" name='content'></textarea>
	    </div>	
						
	
			
		  <div class="form-group" style="user-select: auto;">
	      <label for="exampleInputFile" style="user-select: auto;">File input</label>
	      <input type="file" name='file' class="form-control-file"  id='attach-file' aria-describedby="fileHelp" style="user-select: auto;">
	      <span id='preview'></span>  
	    </div>
	</table>
</form>
<div style="text-align: center;">
	<a class="btn btn-info" onclick="if( necessary()) $('form').submit()">저장</a>	
	<a class="btn btn-info" href='list.bo'>취소</a>
</div>

<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
<!-- <script type="text/javascript" src="js/image_preview.js"></script> -->
<script type="text/javascript">
	

</script>
</body>
</html>