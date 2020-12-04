<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
ul {list-style: none; padding:0;} 
</style>

</head>


<body> 

<form method="post" action="list.mar" style="margin: 0 auto;" >

		<input type="hidden" name="curPage" value="1" /> <!-- 현재페이지 -->
		<input type="hidden" name='id' />  <!-- 현재 넘버 -->		

<!-- SEARCH  -->					
	<div style="padding: 0px 125px 0px 350px;">		
  		<input class="form-control form-control" type="text" placeholder="SEARCH .. " name="search" value="${page.search}"
  		id="inputLarge" style="user-select: auto; width:400px; height: 40px; float: left;" >&nbsp;
  		<a class="btn btn-warning" style="height: 40px; padding: 0 10px; font-size: 1.3em; " onclick='$("form").submit()'>&nbsp;검색&nbsp;</a>	
  	</div>
	
	<div style="float:left; clear:both; margin: 0 auto; padding:  10px 125px 50px 400px; ">	
		<button class="btn btn-outline-info ${page.keyword eq 'machine' ? 'active' : ''}" value="machine" name="keyword" onclick="$('form').submit()" style="font-family: 'Cafe24Dangdanghae'; font-size: 0.9em;">디지털/가전</button>
		<button class="btn btn-outline-info ${page.keyword eq 'clothes' ? 'active' : ''}" value="clothes"  name="keyword" onclick="$('form').submit()" style="font-family: 'Cafe24Dangdanghae'; font-size: 0.9em;">의류/잡화</button>
		<button class="btn btn-outline-info ${page.keyword eq 'books' ? 'active' : ''}" value="books"  name="keyword"  onclick="$('form').submit()" style="font-family: 'Cafe24Dangdanghae'; font-size: 0.9em;">&nbsp;&nbsp;도서&nbsp;&nbsp;</button>
		<button class="btn btn-outline-info ${page.keyword eq 'plants' ? 'active' : ''}" value="plants"  name="keyword"  onclick="$('form').submit()" style="font-family: 'Cafe24Dangdanghae'; font-size: 0.9em;">&nbsp;&nbsp;식물&nbsp;&nbsp;</button>
	</div>

<!-- 리스트/그리드 & 10개씩  -->
	<div style="padding:0 0 10px 0; clear:both;">
		<select name="pageList" class="custom-select" onchange="$('[name=curPage]').val(1); $('form').submit()" style="width:10%; margin: 0 10px 0 0; font-size: 0.9em;" >
			<option value='10' ${page.pageList eq 10 ? 'selected' : ''}>10개씩</option>
			<option value='20' ${page.pageList eq 20 ? 'selected' : ''}>20개씩</option>
			<option value='30' ${page.pageList eq 30 ? 'selected' : ''}>30개씩</option>
		</select>	
		<select name="viewType" class="custom-select" onchange="$('form').submit()" style="width:10%; float: left; margin: 0 4px 0 0; font-size: 0.9em; ">
			<option value="list" ${page.viewType eq 'list' ? 'selected' : ''}>LIST</option>
			<option value="grid" ${page.viewType eq 'grid' ? 'selected' : ''}>GRID</option>
		</select>		
<!-- 글쓰기  -->	
		<c:if test="${ !empty login_info }">
			<a class="btn btn-secondary" style=" margin:0 20px 0 0; float: right; font-size: 1em;" href='new.mar'>글쓰기</a>
		</c:if>
	</div>
	
</form>


<!-- 게시판  -->

<c:if test="${page.viewType eq 'list'}">
  <table class="table table-hover" style="user-select: auto; text-align: center;">
		<thead style="user-select: auto;">
		  <tr style="user-select: auto;">
			<th scope="col" style="user-select: auto; width: 10px">#</th>
			<th scope="col" style="user-select: auto; width: 30px">카테고리</th>
			<th scope="col" style="user-select: auto; width: 40px">진행사항</th>
			<th scope="col" style="user-select: auto; width: 350px">제목</th>
			<th scope="col" style="user-select: auto; width: 80px">작성자</th>
			<th scope="col" style="user-select: auto; width: 80px">등록일</th>
		  </tr>
		</thead>
						
	<c:forEach items="${page.list}" var="vo">
	<jsp:useBean id="now" class="java.util.Date" />								
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  <!-- 현재  -->
	<fmt:parseDate var="b_date" value="${vo.writedate}" pattern="yyyy-MM-dd HH:mm" /> <!-- db데이터 데이트로 바꾸기  -->
	<fmt:formatDate var="writedate" value="${b_date}" pattern="yyyy-MM-dd"/> <!-- 데이트 형식 -->
	<fmt:formatDate var="todaywrite" value="${b_date}" pattern="HH:mm" />	
	 	
		  <tr class="table-light" style="user-select: auto;">
		 	 <td style="user-select: auto;">${vo.no}</td>
		     <td style="user-select: auto;">		     	
		     ${vo.category eq 'clothes' ? '의류/잡화' : (vo.category eq 'machine' ? '디지털/가전' : (vo.category eq 'books' ? '도서' : (vo.category eq 'plants' ? '식물' : '#')) ) }		
			 </td>
			 <td style="user-select: auto;">${vo.progress eq 'ing' ? '<span style="color:red;">판매중</span>' : '<span style="color:green;">판매완료</span>'}</td>
			 <td style="user-select: auto; text-align: left; "><a href="detail.mar?id=${vo.id}">${vo.title}</a>&nbsp;&nbsp;[${vo.commentcnt}]</td>
			 <td style="user-select: auto;">${vo.name}</td>
			  <td style="user-select: auto;">${writedate eq today? todaywrite : writedate} </td> 
	 </c:forEach> 
  </table>
</c:if>


<!-- 그리드 페이지 -->

<c:if test="${page.viewType eq 'grid'}">

  <table class="table table-info " id ="content" style="user-select: auto; text-align: center; margin-bottom: 5px;"> 
	 <c:forEach items="${page.list}" var="vo">		 						

	 <c:set var="now" value="<%=new java.util.Date()%>" />		
		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd kk:mm:ss"  var="now1"/>		
		<fmt:parseDate value="${now1}" var="strPlanDate" pattern="yyyy-MM-dd kk:mm:ss"/>			
		<fmt:parseNumber value="${strPlanDate.time / (1000 * 60 * 60 )}" integerOnly="true" var="strtime"></fmt:parseNumber>

		 <fmt:parseDate value="${vo.writedate}" var="endPlanDate" pattern="yyyy-MM-dd HH:mm:ss"/>  
		<fmt:parseNumber value="${endPlanDate.time  / (1000 * 60 * 60 )}" integerOnly="true" var="endtime"></fmt:parseNumber>
 
	 	<div style="float: left; height: 355px; " >
	 	<!-- 썸네일  -->
		  <div style="width: 210px; height: 140px;"><a onclick="go_detail(${vo.id})"><img src="resources/${vo.filepath}" style="width: 218px; height:150px; boarder: 1px solid gray"></a></div>		 	 
	      <div class="card border-default mb-3" style="max-height:218px; width: 218px; user-select: auto; ">
			  <!-- 제목부분  -->
			  <h6 class="card-header" style= "display:inline-block;  font-family: 'JSDongkang-Regular'; width:218px; white-space: nowrap; overflow: hidden;  text-overflow: ellipsis;">	
				<a onclick="go_detail(${vo.id})"> ${vo.title}</a></h6>			
			  <div class="card-body" style="font-size:0.9em; font-family: 'GyeonggiBatang';" >
			  	<fmt:formatNumber var="price" value="${vo.price}" pattern="##,###,###" />		
				  <p class="card-title" style=" ">
				  	<span>${vo.progress eq 'ing' ? '<span style="color:red;">판매중</span>' : '<span style="color:green;">판매완료</span>'} · </span>
				  	<c:choose>					
					    <c:when test="${vo.price eq 0}">무료나눔</c:when>
					    <c:otherwise>${price}원</c:otherwise>					
					</c:choose>				  	
				  	<c:if test="${vo.discuss eq 'Y'}">· 가격상의</c:if>
				  </p>	
				  					  		    	
				  <p style="">${vo.category eq 'clothes' ? '의류/잡화' : (vo.category eq 'machine' ? '디지털/가전' : (vo.category eq 'books' ? '도서' : (vo.category eq 'plants' ? '식물' : '#')) ) }</p>	
				  <p><i class="far fa-heart"></i> ${vo.likecnt}	</p>	
				  	<p class="card-text" style="color: gray; float: right;">	
					  <c:choose>
						<c:when test="${strtime - endtime >= 48}"> 
							<fmt:parseDate value=" ${vo.writedate}" pattern="yyyy-MM-dd"  var="writedate"/>	
					  		<fmt:formatDate value="${writedate}" pattern="yyyy-MM-dd"  var="writedate"/>	
					  			 ${writedate}</c:when>
						<c:when test="${strtime - endtime >= 24 }"> 어제 </c:when>
						<c:when test="${strtime - endtime < 1 }"> 방금전 </c:when>
						<c:otherwise> ${strtime - endtime} 시간 전 </c:otherwise>
					  </c:choose> 
					 </p>   			  
				   
			  </div>
			</div>	 
		</div>
 	 </c:forEach>	 
   </table>
</c:if>
<!-- PAGE  -->
<div class='btnSet' >
	<jsp:include page="/WEB-INF/views/include/page.jsp" />
</div>
		
	
<script type="text/javascript">

	/* 주소창에 노출하지 않고 전송 */
	function go_detail(id){
			$('[name=id]').val( id );
			$('form').attr('action', 'detail.mar');
			$('form').submit();
		 
		}
	
	
</script>
</mardy>
</html>







