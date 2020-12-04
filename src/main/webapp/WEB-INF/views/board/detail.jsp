<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
textarea:focus {
    outline: none;
}
</style>
</head>
<body>
<jsp:useBean id="now" class="java.util.Date" />
								
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  <!-- 현재  -->
<fmt:parseDate var="b_date" value="${vo.writedate}" pattern="yyyy-MM-dd HH:mm" /> <!-- db데이터 데이트로 바꾸기  -->
<fmt:formatDate var="writedate" value="${b_date}" pattern="yyyy-MM-dd"/> <!-- 데이트 형식 -->
<fmt:formatDate var="todaywrite" value="${b_date}" pattern="HH:mm" />	
 

<table class="table" style="user-select: auto; ">
  <thead style="user-select: auto; text-align: center;">  
    <tr class="table-info" style="user-select: auto;">
      <th scope="col" style="user-select: auto; width: 70%">${vo.title}</th>
      <th scope="col" style="user-select: auto; width: 10%">${vo.name}</th>  
      <th scope="col" style="user-select: auto; width: 10%">${writedate eq today? todaywrite : writedate}</th>
      <th scope="col" style="user-select: auto; width: 10%">${vo.readcnt}</th>
    </tr>
  </thead>
  <tbody>
  
  </tbody>

  <tbody style="user-select: auto; ">
    <tr class="table-default" style="user-select: auto;">
      <td style="user-select: auto; padding: 40px 10px;" colspan="4">${fn: replace(vo.content, crlf, '<br>')}</td>      
    </tr>
    
    <c:if test="${! empty vo.filename }">
    <hr>
		<tr><th style="float: left;">첨부파일</th>
			<td colspan="4">${vo.filename}<span id='preview'></span> 
			<a href='download.bo?id=${vo.id}' style='margin-left: 20px;'><i	class='fas fa-download font-img'></i></a>
			</td>
		</tr>	  
    </c:if>
  </tbody>
  
 </table>
 
 <form action="list.bo" method="post">
	<input type="hidden" name="id" value="${vo.id}"/>
	<input type="hidden" name="curPage" value="${page.curPage}"/>
	<input type="hidden" name="search" value="${page.search}"/>
	<input type="hidden" name="keyword" value="${page.keyword}"/>
	<input type="hidden" name="pagelist" value="${page.pageList}"/>
	<input type="hidden" name="viewType" value="${page.viewType}"/>

</form>
 
<div style="padding: 15px;">
	<a class="btn btn-info" onclick='$("form").submit()'>목록</a>
	<c:if test="${login_info.userid eq vo.userid}"><!-- 로그인한 사용자가 작성한 글인 경우 수정/삭제 가능  -->
	<span style='float:right;'>
		<a class="btn btn-info" onclick="if(confirm('정말 삭제?')){$('form').attr('action','delete.bo'); $('form').submit()}">삭제</a>
		<a class="btn btn-info" onclick='$("form").attr("action","modify.bo"); $("form").submit()'>수정</a>
	</span>	
	</c:if>
		<!-- 로그인 되어 있으면 답글쓰기 가능 -->
	<c:if test="${!empty login_info}">
	<a class="btn btn-info" href='reply.bo?id=${vo.id}'>답글쓰기</a>
	</c:if>
</div>

<div id='popup-background'></div>
<div id='popup'></div>
<div id='comment_list'> <!-- 댓글 목록   -->	</div>



<!-- 댓글부분  -->
<div id='comment_regist' style="border: 1px solid #D8D8D8; padding: 30px 0px 50px 12px;">
	<div>		
		<textarea id='comment' style='width:99%; height: 150px; resize: none;border: 1px solid #D8D8D8; ' ></textarea>	
		<span style='float:right;'>
		<a class='btn btn-secondary' style="margin-right: 14px;" onclick='comment_regist()'>등록</a>
		</span>	
	</div>
</div>







<script type="text/javascript">

	/* 댓글등록 */	
function comment_regist(){

	if( ${empty login_info} ){
		alert('댓글을 등록하려면 로그인하세요!');
		return;
	}	
	if( $('#comment').val()=='' ){
		alert('댓글을 입력하세요!');
		$('#comment').focus();
		return;
	}

	$.ajax({
		url: 'board/comment/insert',
		data: { pid:${vo.id}, content:$('#comment').val() },
		success: function( data ){
			if( data ){			
				$('#comment').val('');
				comment_list();
			}else{
				alert('댓글 등록 실패ㅠㅠ');
			}
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
}

function comment_list(){ /* 댓글조회  */
	$.ajax({
		url: 'board/comment/list/${vo.id}',
		success: function( data ){
			$('#comment_list').html( data );
		},error: function(req, text){
			alert(text+":"+req.status);
			
		}
	});	
}
	
comment_list();
	

		

	 /* 첨부파일 미리보기 */
	if(${!empty vo.filename}){
		showAttachedImage('#preview');
		}

	
	function showAttachedImage( id ){
		var filename = '${vo.filename}';
		var ext = filename.substring( filename.lastIndexOf('.')+1 ).toLowerCase();
		var imgs = ['jpg','png','gif','bmp','jpeg'];
		if( imgs.indexOf(ext) > -1){
			var img = '<img id="preview-img" class="file-img" style="width:50px" src="'+'${vo.filepath}'.substring(1)+'" />';
			$(id).html(img);		
		}
			 
	}

	$('#preview-img').click(function(){
		$('#popup, #popup-background').css('display', 'block');
		showAttachedImage( '#popup' );
	});
	
	$('#popup-background').click(function(){
		$('#popup, #popup-background').css('display', 'none');
	});

	
</script>

</body>
</html>