<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${category eq 'cu' ? '고객관리' : (category eq 'mar' ? '토끼마켓' : (category eq 'bo' ? '방명록' : (category eq 'da' ? '공공데이터' : '')) ) }
	${empty category ? '':' - '}IoT</title>
<script type="text/javascript" 	src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/sketchy/bootstrap.min.css" 
integrity="sha384-RxqHG2ilm4r6aFRpGmBbGTjsqwfqHOKy1ArsMhHusnRO47jcGqpIQqlQK/kmGy9R" crossorigin="anonymous">


<link rel="stylesheet" href="css/common.css?v=<%=new java.util.Date().getTime()%>">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
 
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@700&family=Noto+Sans+KR:wght@300&family=Song+Myung&family=Yeon+Sung&display=swap" rel="stylesheet">

<link rel="icon" type="image/x-icon" href="img/hanul.ico">
<style type="text/css">
#content {margin: 0 auto; padding: 100px 0px; width: 1110px; font-family: 'GyeonggiBatang';}
body {font-size:0.9em; background-color: #FAFAFA;     }
a { text-decoration:none } 
input {font-family: 'GyeonggiBatang'; }
@font-face {
    font-family: 'Cafe24Dangdanghae';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.2/Cafe24Dangdanghae.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}@font-face {
    font-family: 'JSDongkang-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/JSDongkang-RegularA1.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'GyeonggiBatang';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/GyeonggiBatang.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}


</style>
</head>
<body>
	
		 
	<tiles:insertAttribute name="header" />
	<div id="content">
		<tiles:insertAttribute name="content" />			
	</div>
	<tiles:insertAttribute name="footer" />
</body>
<script type="text/javascript">

 
</script>
</html>