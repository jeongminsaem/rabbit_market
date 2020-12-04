<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">ul {list-style: none; padding:0;} </style>
</head>
<body> 


	<!-- SEARCH  -->	
<div class="form-group" style="user-select: auto;">
	<form method="post" action="list.bo" style="" >
		<input type="hidden" name="curPage" value="1" /> 
		<input type="hidden" name='id' /> 
		<div style="float: left;">
			<select class="custom-select" name="search" style="user-select: auto; ">
			<option value="all" ${page.search eq 'all' ? 'selected' : ''}>전체</option>
			<option value="title" ${page.search eq 'title' ? 'selected' : ''}>제목</option>
			<option value="content" ${page.search eq 'content' ? 'selected' : ''}>내용</option>
			<option value="writer" ${page.search eq 'writer' ? 'selected' : ''}>작성자</option> 
			</select></div>		
		<div style="float: left;">
			<input type="text" class="form-control" name="keyword" id="inputDefault" value="${page.keyword}" style="user-select: auto; ">
		</div>
		<div><a class="btn btn-secondary" style="user-select: auto;" onclick='$("form").submit()'>검색</a></div>
	</form>	
</div>	

<div style="float: right;">
	<c:if test="${ !empty login_info }">
		<a class="btn btn-secondary" style="user-select: auto; margin-bottom: 10px" href='new.bo'>글쓰기</a>
	</c:if>
</div>



   <!-- 게시판  -->
			<table style="user-select: auto; text-align: center; width:100%;">
		<c:if test="${page.viewType eq 'list'}">
				<thead style="user-select: auto;">
					<tr class="table table-info" style="user-select: auto;">
						<th scope="col" style="user-select: auto; width: 60px">#</th>
						<th scope="col" style="user-select: auto; width: 300px">TITLE</th>
						<th scope="col" style="user-select: auto; width: 100px">WRITER</th>
						<th scope="col" style="user-select: auto; width: 100px">CREATED</th>
						
					</tr>
				</thead>
				<c:forEach items="${page.list}" var="vo">

<jsp:useBean id="now" class="java.util.Date" />
								
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  <!-- 현재  -->
<fmt:parseDate var="b_date" value="${vo.writedate}" pattern="yyyy-MM-dd HH:mm" /> <!-- db데이터 데이트로 바꾸기  -->
<fmt:formatDate var="writedate" value="${b_date}" pattern="yyyy-MM-dd"/> <!-- 데이트 형식 -->
<fmt:formatDate var="todaywrite" value="${b_date}" pattern="HH:mm" />	
 
				<tbody>
					<tr class="table table-light" style="user-select: auto;">
						<td style="user-select: auto;">${vo.no}</td>
					
						<td style="user-select: auto; text-align: left;">
						<c:forEach var="i" begin="1" end="${vo.repindent}">
						   ${i eq vo.repindent? '&nbsp;&nbsp;&nbsp;&nbsp;<i class="fas fa-angle-double-right" style="color:#fcba03;"></i>' : '&nbsp;&nbsp;' }
						</c:forEach>
						<a href="detail.bo?id=${vo.id}">${vo.title} ${ empty vo.filename ? '' : '<img src="img/attach.png" style="height:5%" class="file-img" />' }
						</a>[${vo.commentcnt}]</td>
						<td style="user-select: auto;">${vo.name}</td>
						<td style="user-select: auto;">${writedate eq today? todaywrite : writedate} </td>
						
					</tr>
				</tbody>
				</c:forEach>
			</c:if>
			</table>

	<!-- PAGE  -->
	<div class='btnSet' >
		<jsp:include page="/WEB-INF/views/include/page.jsp" />
	</div>
	

	

	
	<script type="text/javascript">


	$(function(){
		$('#data-list ul').css('height', ($('.grid li').length<5 ? 1 : $('.grid li').length/5 ) * $('.grid li').outerHeight(true) - 20 );
	});


	/* 주소창에 노출하지 않고 전송 */
	function go_detail(id){
			$('[name=id]').val( id );
			$('form').attr('action', 'detail.bo');
			$('form').submit();
		 
		}
	
</script>
</body>
</html>







