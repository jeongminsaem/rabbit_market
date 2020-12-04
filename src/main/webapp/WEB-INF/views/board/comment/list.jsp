<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach items="${list}" var="vo" varStatus="status">
   ${status.index eq 0 ? '<hr>' :''}
  <jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  <!-- 현재  -->
<fmt:parseDate var="b_date" value="${vo.writedate}" pattern="yyyy-MM-dd HH:mm:ss" /> <!-- db데이터 데이트로 바꾸기  -->
<fmt:formatDate var="writedate" value="${b_date}" pattern="yyyy-MM-dd"/> <!-- 데이트 형식 -->
<fmt:formatDate var="todaywrite" value="${b_date}" pattern="HH:mm:ss" />	
 

 	<div data-id='${vo.id}'>  
 	<strong>${vo.name}</strong> &nbsp;&nbsp;&nbsp;&nbsp; ${writedate eq today? todaywrite : writedate} 						
		<!-- 로그인한 사용자가 작성한 댓글이면 수정/삭제 가능 -->
		<c:if test="${vo.userid eq login_info.userid}">
			<span style='float:right;'>
				<a class='btn-fill-s btn-modify-save' >수정</a>
				<a class='btn-fill-s btn-delete-cancel' >삭제</a>
			</span>
		</c:if>
		
		<div class='original' style="padding: 13px;">${fn:replace(  fn:replace(vo.content, lf, '<br>')  , crlf, '<br>')} </div>
		<div class='modify' style='display:none; margin-top:6px;'></div>
	</div>
	<hr>
</c:forEach>

<script>
	$('.btn-modify-save').on('click', function(){
	
		var $div = $(this).closest('div'); /* 자신을 포함한 가장가까운 상위 div 태그 */
	
		if( $(this).text()=='수정' ){ /* 수정  */
			//modify div 의 높이를 원글의 비례해서 지정
			$div.children('.modify').css('height', $div.children('.original').height()-6 );
			var tag = '<textarea style="width:99%; height:90%; resize:none;">'
					+ $div.children('.original').html().replace( /<br>/g, '\n')
					+ '</textarea>';
			$div.children('.modify').html( tag );
			display( 'm', $div );
			
		}else{ /* 저장 버튼 */
			var comment = {id:$div.data('id'), content:$div.children('.modify').find('textarea').val()};
			$.ajax({
				url: 'board/comment/update',
				data: JSON.stringify( comment ),
				type: 'post',
				contentType: 'application/json',
				success: function(data){
					alert('변경 ' + data);
					comment_list();
				},error: function(req, text){
					alert(text+":"+req.status);
				}	
			});		
		}
	});
	

	$('.btn-delete-cancel').on('click', function() { /* 취소  */
		var $div = $(this).closest('div');
		if ($(this).text() == '취소') {
			//원글 보이게, 수정글 안보이게
			display('d', $div);
			
		} else { /* 삭제  */
			if (confirm('정말삭제?')) {
				$.ajax({
					url : 'board/comment/delete/' + $div.data('id'),
					success : function() {
						comment_list();

					},
					error : function(req, text) {
						alert(text + ":" + req.status);
					}

				});
			}

		}
	});

	
	function display(mode, div) {
		// 	수정상태: 저장/취소버튼, 원글 안보이고, 수정글 보이고
		// 	보기상태: 수정/삭제버튼, 원글 보이고, 수정글 안보이고
		div.children('.original').css('display', mode == 'm' ? 'none' : 'block');
		div.children('.modify').css('display', mode == 'm' ? 'block' : 'none');
		div.find('.btn-modify-save').text(mode == 'm' ? '저장' : '수정');
		div.find('.btn-delete-cancel').text(mode == 'm' ? '취소' : '삭제');
	}
</script>







