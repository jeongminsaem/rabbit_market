<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form method="post" action="update.mar" enctype="multipart/form-data">
	<table> 	
		<div class="form-group">
			<select class="custom-select need" name="category" style="user-select: auto; width:10%; float: left; margin-right: 10px;">
 				<option value="clothes" ${vo.category eq 'clothes' ? 'selected' : ''}>의류/잡화</option>
				<option value="machine" ${vo.category eq 'machine' ? 'selected' : ''}>디지털/가전</option>
				<option value="books" ${vo.category eq 'books' ? 'selected' : ''}>도서</option>
				<option value="plants" ${vo.category eq 'plants' ? 'selected' : ''}>식물</option>  
			</select>	
			<input type="text" class="form-control need" placeholder="제목을 입력하세요" id="inputDefault" value="${vo.title}"
		 		 style="user-select: auto; width: 80%; float: left; margin-bottom: 10px;" name="title" title='제목'/>
		</div>
		
		<select class="custom-select" name="progress" style="width:10%; float: left; margin-right: 10px;">
			<option value="ing" ${vo.progress eq 'ing' ? 'selected' : ''}>판매중</option>
			<option value="done" ${vo.progress eq 'done' ? 'selected' : ''}>판매완료</option>
		</select>	
			
		<div class="form-group">	      
	      <textarea class="form-control need" id="exampleTextarea" rows="3" title='내용' 
	      	style=" height: 400px;" name='content'>${vo.content}</textarea>
	    </div>		    
	    
		<div class="form-group">
		  <!-- 원래첨부된파일 미리보기 -->	 
		   <c:forEach var="ori" items="${file_atta}" begin="0" end="${fn:length(file_atta)}" step="1" varStatus="status">
		        <img src="resources/${ori.filepath}" class="img_id_${ori.id}"  style='width:200px; height:150px; display:inline; board: solid 1px gray; ' >			        	      
		        <a href="#" class="img_del_${ori.id}" onclick="deleteImageAction(${ori.id})"><i class="font-img fas fa-times"></i></a>		        
		   </c:forEach>
		   		<div id='preview' style="float:right; margin:10px;"></div>	
	    </div>	
		   <!-- 파일첨부  -->
		      <label><input multiple="multiple" type="file" name='file' class="form-control-file" 
	            id='attach-file' aria-describedby="fileHelp" style="user-select: auto; display: none;">
	            <a class="btn btn-success" style="width:1100px;">사진첨부</a>	
		 	</label>
			
		<div>
			<input type="text" class="form-control need" placeholder="가격을 입력하세요" id="inputDefault" name='price' title='가격'		 
			  style="user-select: auto; width: 20%; margin: 0 10px 10px 0; float:left;" value="${vo.price}" />
		    <div class="custom-control custom-checkbox" style="user-select: auto; ">
		      <input type="checkbox" class="custom-control-input" ${vo.discuss eq 'Y' ? 'checked' : ''} 
		      			id="customCheck1" name='discuss' value="Y" style="user-select: auto; ">	      
		      <label class="custom-control-label " for="customCheck1" style="user-select: auto; margin-left: 40px; ">구매자와 상의하기</label>
	    	</div>
		</div>
	</table>
		<!-- 글쓴이  -->
		<input type="hidden" name="userid" value="${vo.userid}"/>		
		<input type="hidden" name="id" value="${vo.id}"/>		
		<input type="hidden" name="attach" />	
		<input type="hidden" name="del_id" />	
	
</form>

<div style="text-align: center;">
	<a class="btn btn-info" onclick="submit()">저장</a>	
	<a class="btn btn-info" href='list.mar'>취소</a>
</div>

<script type="text/javascript" src="js/need_check.js"></script>
<script type="text/javascript">

 	var del_file = new Array();

	// 미리보기 삭제시 지우기 . 
	function deleteImageAction(index) {		
		
		
		var img_del = ".img_del_" + index;
		var img_id = ".img_id_" + index;		
		
		$(img_id).remove();
		$(img_del).remove();
		del_file.push(index); // ㅂ ㅐ열로 쌓이 삭제 파일 번호들	
		
		//$("#del_id").css("value", del_file); 

	
	}
	
	
	function submit(){
		
	//alert(del_file);
		if( necessary()){
			//$("[name=attach]").val( $("#file-name").text());
			if(del_file != null){
				$("[name=del_id]").val(del_file);
			};
			$('form').submit()
		};
	}

	//삭제할 파일의 id를 컨트롤러로 보내고 싶다....


	
	// 새로 첨부한 이미지 미리보기 
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


</script>
</body>
</html>