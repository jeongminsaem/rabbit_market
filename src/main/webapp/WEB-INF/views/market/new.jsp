<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<form method="post" action="insert.mar" enctype="multipart/form-data">
	
		<input type="hidden" id="${login_info.name}"  name='userid'/>
		<input type="hidden" id="ing"  name='progress'/>		
		
		
		<div class="form-group" style="padding: 0px; font-size:1em; ">
			<select class="custom-select need" name="category" style="user-select: auto; width:15%; float: left; font-size:1em; margin-right: 10px;">
				<option value="#" ${page.search eq 'clothes' ? 'selected' : ''}>카테고리</option>
				<option value="clothes" ${page.search eq 'clothes' ? 'selected' : ''}>의류/잡화</option>
				<option value="machine" ${page.search eq 'machine' ? 'selected' : ''}>디지털/가전</option>
				<option value="books" ${page.search eq 'books' ? 'selected' : ''}>도서</option>
				<option value="plants" ${page.search eq 'plants' ? 'selected' : ''}>식물</option> 
			</select>
		  <input type="text" class="form-control need" placeholder="제목을 입력하세요" id="inputDefault" 
		  style="user-select: auto; width: 80%; float: left; margin-bottom: 10px; font-size:1em;" name='title' title='제목'>
		</div>
				
					
	
        
  
	   		<div class="form-group" style="user-select: auto; ">	      
	      <textarea class="form-control need" id="exampleTextarea" rows="3" title='내용' style=" height: 400px;" name='content'></textarea>
	    </div>
		<div style="padding: 0px 10px; float:left;">
			<input type="text" class="form-control need" placeholder="가격을 입력하세요" id="inputDefault" name='price' title='가격'		 
			  style="width: 150px;  float:left; font-size:1em;" /><span style="font-size: 1.3em;">&nbsp;원</span>
		</div>	
		    <div class="custom-control custom-checkbox" style="float:left;">
		      <input type="checkbox" class="custom-control-input" id="customCheck1" name='discuss' value="Y"  style="user-select: auto; ">		          
		      <label class="custom-control-label" for="customCheck1" style="font-size: 1.1em;">구매자와 상의하기</label>
	    	</div>
				
				
			<div style="clear:both; float: left;"> 
				<div id='preview' style="float:right; margin: 10px;"></div>	
	      <label><input multiple="multiple" type="file" name='file' class="form-control-file" 
	            id='attach-file' aria-describedby="fileHelp" style="user-select: auto; display: none;">
	            <a class="btn btn-success" style="width:1100px;">사진첨부</a>	
		 </label>	      
        </div>
	 
		
			
	
		
</form>

<div style="text-align: center; clear:both;">
	<a class="btn btn-info" onclick="if( necessary()) $('form').submit()">저장</a>	
	<a class="btn btn-info" href='list.mar'>취소</a>
</div>

<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
<!-- <script type="text/javascript" src="js/image_preview.js"></script> -->
<script type="text/javascript">



	var attachFiles = [];

	$(document).ready(function() {
		$("#attach-file").on("change", handleImgsFilesSelect);
	});

	function handleImgsFilesSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr
				.forEach(function(f) {
					if (!f.type.match("image.*")) {
						alert("이미지 확장자만 가능합니다.");
						return;
					}
					attachFiles.push(f);
					var index = 0;
					var reader = new FileReader();
					reader.onload = function(e) {
						var img = "<img style='width:200px; height:150px; board: solid 1px gray;' id=\"img_id_"+index+"\" src=\"" + e.target.result + "\" />"
								+ "<a href=\"#\" id=\"img_del_"
								+ index
								+ "\" style='margin-top:450px;' onclick=\"deleteImageAction("
								+ index
								+ ")\">"
								+ "<i style='width:30px;' class=\"font-img fas fa-times\"></i>"
								+ "</a>";

						$("#preview").append(img);
						index++;

					}
					reader.readAsDataURL(f);

				});

	}

	function deleteImageAction(index) {
		attachFiles.splice(index, 1);
		var img_id = "#img_id_" + index;
		var img_del = "#img_del_" + index;

		$(img_del).remove();
		$(img_id).remove();
	}
</script>
</body>
</html>