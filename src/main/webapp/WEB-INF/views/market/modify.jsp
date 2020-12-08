<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form method="post" action="update.mar" enctype="multipart/form-data">
	<table>	
	
		
		<div class="form-group" style="user-select: auto; ">
			<select class="custom-select need" name="category" style="user-select: auto; width:10%; float: left; margin-right: 10px;">
 				<option value="clothes" ${vo.category eq 'clothes' ? 'selected' : ''}>의류/잡화</option>
				<option value="machine" ${vo.category eq 'machine' ? 'selected' : ''}>디지털/가전</option>
				<option value="books" ${vo.category eq 'books' ? 'selected' : ''}>도서</option>
				<option value="plants" ${vo.category eq 'plants' ? 'selected' : ''}>식물</option>  
				
		  <input type="text" class="form-control need" placeholder="제목을 입력하세요" id="inputDefault" value="${vo.title}"
		  style="user-select: auto; width: 80%; float: left; margin-bottom: 10px;" name='title' title='제목'>
		</div>
		
		<select class="custom-select" name="progress" style="user-select: auto; width:10%; float: left; margin-right: 10px;">
			<option value="ing" ${vo.progress eq 'ing' ? 'selected' : ''}>판매중</option>
			<option value="done" ${vo.progress eq 'done' ? 'selected' : ''}>판매완료</option>
		</select>	
			
		<div class="form-group" style="user-select: auto; ">	      
	      <textarea class="form-control need" id="exampleTextarea" rows="3" title='내용' style="user-select: auto;  height: 400px;" name='content'>${vo.content}</textarea>
	    </div>	
	    
		<div class="form-group" style="user-select: auto;">
		    <label>
				<input type="file" name="file" id="attach-file" style="display: none;"/>
				<img src="img/camera.png" style="width: 5%">
			</label>
		    <span id='preview'></span>
		    <span id='delete-file' style="color:red;"><i class='fas fa-times font-img'></i></span> 
	    </div>	
	    
			
		<div>
			<input type="text" class="form-control need" placeholder="가격을 입력하세요" id="inputDefault" name='price' title='가격'		 
			  style="user-select: auto; width: 20%; margin: 0 10px 10px 0; float:left;" value="${vo.price}" />
		    <div class="custom-control custom-checkbox" style="user-select: auto; ">
		      <input type="checkbox" class="custom-control-input" ${vo.discuss eq 'Y' ? 'checked' : ''} 
		      			id="customCheck1" name='discuss' value="Y" style="user-select: auto; ">	      
		      <label class="custom-control-label " for="customCheck1" style="user-select: auto; margin-left: 40px; ">구매자와 상의하기</label>
	    	</div>
		</div>
		<input type="hidden" id="${login_info.name}"  name='userid'/>		
		<input type="hidden" name="id" value='${vo.id}'/>
		<input type="hidden" name="attach" />
		
	</table>
</form>

<div style="text-align: center;">
	<a class="btn btn-info" onclick="if( necessary()) $('form').submit()">저장</a>	
	<a class="btn btn-info" href='list.mar'>취소</a>
</div>

<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
<script type="text/javascript" src="js/image_preview.js"></script>
<script type="text/javascript">
	

</script>
</body>
</html>
<script type="text/javascript">

	if(${!empty vo.filename}){
		$('#delete-file').css('display','inline');
		var filename = '${vo.filename}';
		var ext = filename.substring(filename.lastIndexOf('.')+1).toLowerCase();
		var imgs = ['jpg','png','gif','bmp','jpeg'];
		if ( imgs.indexOf(ext) > -1){
			var img = '<img id="preview-img" class="file-img" '
						+'style="width:100px;" src="'+ '${vo.filepath}'.substring(1) +'"/>';

			$('#preview').html(img);
			}

		}
</script>
<script type="text/javascript" src="js/image_preview.js"></script>
<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
</body>
</html>