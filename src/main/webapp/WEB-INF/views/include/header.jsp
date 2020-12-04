<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<style>
.nav-counter {
 position:absolute;
 top: -1px;
 right: 1px;
 min-width: 8px;
 height: 20px;
 line-height: 20px;
 margin-top: -17px;
 padding: 0 6px;
 font-weight: normal;
 font-size: small;
 color: white;
 text-align: center;
 text-shadow: 0 1px rgba(0, 0, 0, 0.2);
 background: #e23442;
 border: 1px solid #911f28;
 border-radius: 11px;
 background-image: -webkit-linear-gradient(top, #e8616c, #dd202f);
 background-image: -moz-linear-gradient(top, #e8616c, #dd202f);
 background-image: -o-linear-gradient(top, #e8616c, #dd202f);
 background-image: linear-gradient(to bottom, #e8616c, #dd202f);
 -webkit-box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
 box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
}

.button {
 box-shadow: inset 0px 1px 0px rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.15);
 background-color: #EEE;
 display: inline-block;
 vertical-align: middle;
 border: 1px solid #d4d4d4;
 height: 32px;
 line-height: 30px;
 padding: 0px 25.6px;
 font-weight: 300;
 font-size: 14px;
 font-family: "Helvetica Neue Light", "Helvetica Neue", "Helvetica", "Arial", "Lucida Grande", sans-serif;
 color: #666;
 text-shadow: 0 1px 1px white;
 margin: 0;
 text-decoration: none;
 text-align: center;
}
</style>

<header>		
 <nav class="navbar navbar-expand-lg navbar-dark bg-primary " style="height: 100px; padding: 0 300px; background-color: #380B61; font-family: 'Cafe24Dangdanghae';">
  <div class="collapse navbar-collapse" id="navbarColor01" style="user-select: auto; padding: 0px  ">
  <a class="navbar-brand" href="list.mar" style="font-size: 1.7em; font-family: 'Cafe24Dangdanghae';">RABBIT MARKET</a>
    <ul class="navbar-nav mr-auto" style="user-select: auto;">     
      <li class="nav-item" style="user-select: auto;">
        <a class="nav-link" href="list.mar" style="font-size: 1.3em;">토끼마켓</a>
      </li> 
        <li class="nav-item" style="user-select: auto;">
        <a class="nav-link" style="font-size: 1.3em;">/</a>
      </li>     
      <li class="nav-item" style="user-select: auto;">
        <a class="nav-link" href="list.bo" style="font-size: 1.3em;">커뮤니티</a>
      </li> 
    </ul>
   </div>
   <div>    
<!-- 로그인 정보  -->
    <form class="form-inline my-2 my-lg-0" style="font-size: 1.1em; color: white;   font-family: 'GyeonggiBatang';">  	
<!-- 로그인한 경우 -->	    
		<c:if test="${ !empty login_info }"> 
			${login_info.name}님, 어서오세요!&nbsp;&nbsp;&nbsp;
	<!-- 알람 종  -->			
			<p class="docbtn" style="padding-top: 13px;">
		 		<a href="noti_list" style="width:150px; position:relative;">
		 			<i class="fas fa-bell" style="font-size:30px; color:gray;"></i>
		 			<span class="nav-counter" style="display:none;"></span></a>
			</p>
						&nbsp;&nbsp;&nbsp;
			<a class="btn btn-info" style="" onclick="go_logout()">로그아웃</a>
		</c:if>
<!-- 로그인하지 않은 경우 -->			
		<c:if test="${ empty login_info }">      
		  	<a class="btn btn-info" style="user-select: auto; "  href="loginPage">로그인</a>&nbsp;
			<a class="btn btn-outline-info" style="user-select: auto;  "  href="member">회원가입</a>
		</c:if>		    
    </form>
  </div>
  
    
</nav>
<!--  <div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
 <p>안녕하세요. 모달창안의 내용부분입니다.</p>
			<a href="#" rel="modal:close">닫기</a>
		</div>	 -->
</header>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Poor+Story&family=Yeon+Sung&display=swap" rel="stylesheet">
<script>

/* 로그아웃 */
function go_logout(){
	$.ajax({
		type:'post',
		url: 'logout',
		success: function(){
			location.reload();
		},error: function(req, text){
			alert(text+": "+req.status);
		} 
	});
}

/* $('div#ex1').css({
    "top":(($(window).height()-$('div#ex1').outerHeight())/2+$(window).scrollTop())+"px",
    "left":(($( window ).width()-$('div#ex1').outerWidth())/2+$(window).scrollLeft())+"px"
   }); */


var loginUser = '${login_info.userid}';


	$( document ).ready(function() {	
		 
		 if(loginUser != "" ){	
		 	connectWS();
		 	noti_count('${login_info.userid}');
		 } else {
		 }
		
		 
	});	


var socket = null;
function connectWS() {   // 소켓 연결
 
    var ws = new WebSocket('ws://localhost:80/iot/echo');
    socket = ws; 
   
    ws.onopen = function () {
        console.log('Info: connection opened.');
    };

    ws.onmessage = function (event) {
    	 alert("ReceiveMessage");
     	 let $socketAlert = $('div#socketAlert');
         $socketAlert.html(event.data);
         $socketAlert.css('display', 'block'); 
         $('#ex1').show();   
         alert('${login_info.userid}');
         noti_count('${login_info.userid}'); //노티 개수 조회 
         
         setTimeout( function() {
         	$socketAlert.css('display', 'none');
         }, 3000);  	
    	
         
    };

    ws.onclose = function (event) { 
        console.log('Info: connection closed.');
        setTimeout( function(){ connect(); }, 1000); // retry connection!!
    };
    ws.onerror = function (err) { console.log('Error:', err); };
}



function noti_count(){

    $.ajax({
		url: 'market/comment/noti_count',
		data: { userid:loginUser },
		success: function( data ){
			if( data ){			
				if(Object.keys(data).length == 0){
					$('.nav-counter').css('display','none;');					
				} else {
					$('.nav-counter').css('display','block');
					$('.nav-counter').html(Object.keys(data).length);
				}
			}
		
		},error: function(req, text){
			alert(text+":"+req.status);
		}
	});
    
	
}
	


</script>



