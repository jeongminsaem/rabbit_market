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

 /*  *{margin:0;padding:0;} */
  ul,li{list-style:none;}
  #slide{height:100%;  width: 100%; position:relative; overflow:hidden;}
  #slide ul{width:400%; height:800px; transition:1s;}
  #slide ul:after{content:"";display:block;clear:both;}
  #slide li{float:left;width:25%;height:100%;}
  #slide li:nth-child(1){background:#FFFFFF;}
  #slide li:nth-child(2){background:#FFFFFF;}
  #slide li:nth-child(3){background:#FFFFFF;}
  #slide li:nth-child(4){background:#FFFFFF;} 
  #slide input{display:none;}
  #slide label{display:inline-block;vertical-align:middle;width:20px;height:20px;border:2px solid #666;
  background:#fff;transition:0.3s;border-radius:50%;cursor:pointer;}
  #slide .pos{text-align:center;position:absolute;bottom:10px;left:0;width:100%;text-align:center;}
  #pos1:checked~ul{margin-left:0%;}
  #pos2:checked~ul{margin-left:-100%;}
  #pos3:checked~ul{margin-left:-200%;}
  #pos4:checked~ul{margin-left:-300%;}
  #pos1:checked~.pos>label:nth-child(1){background:#666;}
  #pos2:checked~.pos>label:nth-child(2){background:#666;}
  #pos3:checked~.pos>label:nth-child(3){background:#666;}
  #pos4:checked~.pos>label:nth-child(4){background:#666;}
 

</style>


  
</head>
<body>
<!-- 날짜 처리  -->
<jsp:useBean id="now" class="java.util.Date" />
								
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  <!-- 현재  -->
<fmt:parseDate var="b_date" value="${vo.writedate}" pattern="yyyy-MM-dd HH:mm" /> <!-- db데이터 데이트로 바꾸기  -->
<fmt:formatDate var="writedate" value="${b_date}" pattern="yyyy-MM-dd"/> <!-- 데이트 형식 -->
<fmt:formatDate var="todaywrite" value="${b_date}" pattern="HH:mm" />	
 
  

<table class="table" style="width: 100%; ">
  <thead style="text-align: center; ">  
    <tr class="table-light" style="height: 100%;">
      <th scope="col" style="width: 70%;  font-size:1em; ">${vo.title}</th>
      <th scope="col" style="width: 10%;">${vo.name}</th>  
      <th scope="col" style="width: 10%;">${writedate eq today? todaywrite : writedate}</th>
      <th scope="col" style="width: 10%;">${vo.readcnt}</th>
    </tr>
  </thead>
 	 
  <!-- 내용  -->
<tbody>	
	<div class="table-default" style="user-select: auto; ">
      <td style="user-select: auto; padding:40px 10px; font-size:1em; height: 300px;" colspan="4">${fn: replace(vo.content, crlf, '<br>')}</td>      
    </div>
  
 <!-- 슬라이드 이미지  -->
	<div id="slide" style="margin: 0 auto; text-align: center;">
		<c:forEach var="file" items="${file_atta}" begin="0" end="${fn:length(file_atta)}" step="1" varStatus="status">
			<input type="radio" name="pos" id="pos${begin=begin+1}" ${ begin eq 1 ? 'checked':'' }>
		</c:forEach>
		<c:set var="begin" value="0" />		<!--begin값 초기화  -->
			<p class="pos">
				<c:forEach var="file" items="${file_atta}" begin="0" end="${fn:length(file_atta)}" step="1" varStatus="status">
					<label for="pos${begin=begin+1}"></label>
				</c:forEach>
			</p>
		<ul>
		<c:forEach var="file" items="${file_atta}" begin="0" end="${fn:length(file_atta)}" step="1" varStatus="status">
		<li><img src="resources/${file.filepath}"style="height: 100%" /></li>
		</c:forEach>
				</ul>
			</div>
  </tbody> 
</table>
 
 
 <form action="list.mar" method="post">
	<input type="hidden" name="id" value="${vo.id}"/>
	<input type="hidden" name="curPage" value="${page.curPage}"/>
	<input type="hidden" name="search" value="${page.search}"/>
	<input type="hidden" name="keyword" value="${page.keyword}"/>
	<input type="hidden" name="pagelist" value="${page.pageList}"/>
	<input type="hidden" name="viewType" value="${page.viewType}"/>

</form>
 
<div style="padding: 10px;">
	<a class="btn btn-info" onclick='$("form").submit()'>목록</a>
	<c:if test="${login_info.userid ne null}">
		<c:if test="${login_info.userid eq vo.userid}"><!-- 로그인한 사용자가 작성한 글인 경우 수정/삭제 가능  -->
		<span style='float:right;'>
			<a class="btn btn-info" onclick='$("form").attr("action","modify.mar"); $("form").submit()'>수정</a>
			<a class="btn btn-info" onclick="if(confirm('정말 삭제하시겠습니까?')){$('form').attr('action','delete.mar'); $('form').submit()}">삭제</a>
		</span>	
		</c:if>
		<c:if test="${login_info.userid ne vo.userid}">
		<span id="likeIt" style='float:right;' >
			<a onclick='go_like()'>${likecnt > 0 ? '찜한 상품 <i class="fas fa-heart" style="color:#FF0040;font-size:13px;"></i>' : '찜하기  <i class="far fa-heart" style="font-size:13px;"></i>' }</a>		
		</span>	
		</c:if>
	</c:if>
	
</div>



<div id='popup-background'></div>
<div id='popup'></div>
<div id='comment_list'> <!-- 댓글 목록   -->	</div>



<!-- 댓글부분  -->
<div id="comment_regist" style="border: 1px solid #D8D8D8; padding:30px 0px 50px 12px;">
	<div>		
		<textarea id="comment" style="width:99%; height: 150px; resize: none; border: 1px solid #D8D8D8;"></textarea>	
		<span style="float:right;">
		<a class="btn btn-secondary" id="commentBtn" style="margin-right: 14px;" onclick='comment_regist()'>등록</a>
		</span>	
	</div>
</div>


<script type="text/javascript">





/* 좋아요 클릭시  */
function go_like(){	
	$.ajax({
		url: 'market/update_likeIt',
		type: 'post',
		data: { 'id':${vo.id} },
		success: function(){			
				
				updated_like();
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
	
}

function updated_like(){ /* 좋아요 조회 */
	
	$.ajax({
		url: 'market/updated_like',	
		type: 'post',
		data: { 'id':${vo.id} },
		success: function( data ){
			if( data ){			
				alert('관심목록에 추가 됬어요');
				$('#likeIt').html('<a onclick="go_like()">찜한 상품 <i class="fas fa-heart" style="color:#FF0040;font-size:13px;"></i></a>');
			} else {
				alert('관심목록에 삭제됬어요');
				$('#likeIt').html('<a onclick="go_like()">찜하기 <i class="far fa-heart" style="font-size:13px;"></i></a>');
			}
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
}





var sender = '${login_info.userid}';
var receiver = '${vo.userid}'; 
var title = '${vo.title}';
var postid = '${vo.id}';

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
		url: 'market/comment/insert',
		data: { pid:${vo.id}, content:$('#comment').val() },
		success: function( data ){
			if( data ){			
				$('#comment').val('');
				comment_list();
				
				if(socket){ //웹소켓에 보내기 (reply, 댓글작성자, 게시글작성자, 글번호)
					let socketMsg = "reply," + '${login_info.userid}' + "," + '${vo.userid}' + "," + '${vo.title}';			
					socket.send(socketMsg);				
					
				}
		
			}
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
}

	
	
	
	
	
	
	
function comment_list(){ /* 댓글조회  */
	$.ajax({
		url: 'market/comment/list/${vo.id}',
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
			var img = '<img id="preview-img" class="'+(id=='#popup' ? 'popup' : 'file-img') +'" style="border-radius:50%" src="'+'${vo.filepath}'.substring(1)+'" />';
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

	
	
	
	
	$( document ).ready(function() {

		$('#commentBtn').on('click', function(evt) {
		  evt.preventDefault();
		if (socket.readyState !== 1) return;
			  let msg = $('#comment').val();
			  socket.send(msg);
		});
		
		//connectWS();
	});	
	
	 
	
	




</script>
</body>
</html>