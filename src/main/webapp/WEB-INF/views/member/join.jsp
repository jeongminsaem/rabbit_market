<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table td { text-align:left; padding: 20px}
	.valid, .invalid { font-size:13px; font-weight:bold; }
	.valid { color:green }
	.invalid { color:red }
	table th {height: 14px;}
	/* input[name=address] { width:calc(100% - 14px); } */
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>

<div class="card border-primary mb-3" style="border: 3px solid #D8D8D8; padding: 100px;">
	
<p style="font-size:13px; padding-bottom:5px ">* 는 필수입력항목 입니다</p>
<form action="join" method="post" style="padding: 20px;">
	<table>
		<tr><th>이름</th>
			<td><input class="form-control" type="text" name="name"/></td>
		</tr>
		<tr><th style="padding-bottom: 50px;">* 아이디</th>
			<td><input class="form-control"  style="float:left;" type="text" name="userid" class="chk" />			
				<div class="valid">아이디를 입력하세요(영문소문자, 숫자만 입력 가능)</div>
			<a class="btn btn-primary"  id="btn_id">중복확인</a>
			</td>
		</tr>
		<tr><th style="padding-bottom: 30px;">* 비밀번호</th>
			<td><input class="form-control" type="password" name="userpwd" class="chk" />
				<div class="valid">비밀번호를 입력하세요(영문 대/소문자, 숫자를 모두 포함)</div>
			</td>
		</tr>
		<tr><th style="padding-bottom: 30px;">* 비밀번호확인</th>
			<td><input class="form-control" type="password" name="userpwd_ck" class="chk" />
				<div class="valid">비밀번호를 다시 입력하세요</div>
			</td>
		</tr>
		<tr><th style="padding-bottom: 30px;"> * 이메일</th>
			<td><input class="form-control" type="text" name="email" class="chk" />
				<div class="valid">이메일을 입력하세요</div>
			</td>
		</tr>
		<tr><th style="padding-bottom: 130px;">주소</th>
			<td><a class="btn btn-primary" onclick="daum_post()">우편번호찾기</a>
				<input class="form-control" type="text" name="post" class="w-px60" readonly />
				<input class="form-control" type="text" name="address" readonly />
				<input class="form-control" type="text" name="address" />
			</td>
		</tr>
	</table>
</form>
	
	<div style="margin: 0 auto;">
			<a class ="btn btn-info" onclick="go_join()">회원가입</a>
			<a class ="btn btn-info" onclick="history.go(-1)">취소</a>
	</div>

</div>


<script type="text/javascript" src="js/join_check.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- daum post -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script> <!-- fontawsome lib -->
<script type="text/javascript">


	/* 회원가입 버튼 눌렀을때 다시 전부 체크 */
	function go_join() {
		if ($('[name=name]').val() == '') {
			alert('성명을 입력하세요!');
			$('[name=name]').focus();
			return;
		}

		//중복확인여부에 따라
		if ($('[name=userid]').hasClass('chked')) {
			if ($('[name=userid]').siblings('div').hasClass('invalid')) {
				alert('회원가입 불가\n' + join.userid.unusable.desc);
				$('[name=userid]').focus();
				return;
			}
		} else {
			if (!item_check($('[name=userid]')))  return;
			else {
				alert('회원가입 불가\n' + join.userid.valid.desc);
				$('[name=userid]').focus();
				return;
			}
		}

		if (!item_check($('[name=userpwd]'))) 			return;
		if (!item_check($('[name=userpwd_ck]'))) 		return;
		if (!item_check($('[name=email]'))) 			return;

		$('form').submit();
	}
	function item_check(item) {
		var data = join.tag_status(item);
		if (data.code == 'invalid') {
			alert('회원가입 불가\n' + data.desc);
			item.focus();
			return false;
		} else
			return true;
	}

	/* 아이디 중복확인 */
	$('#btn_id').on('click', function() {

		id_check();

	});

	function id_check() {
		var $userid = $('[name=userid]');
		var data = join.tag_status($userid);
		if (data.code != 'valid') {
			alert('아이디 중복확인 불필요\n' + data.desc);
			$userid.focus();
			return;
		}

		$.ajax({
			type : 'post',
			url : 'id_check', /* controller */
			data : {
				userid : $userid.val()
			},
			success : function(data) {
				data = join.id_usable(data); /* data안에는 true or false 값  , 받아온 data는 code, desc값   */
				display_status($userid.siblings('div'), data);
				$userid.addClass('chked');

			},
			error : function(req, text) {
				alert(text + ":" + req.status);

			}
		});

	}

	/* 유효성 체크  */

	$('.chk').on('keyup', function() {
		if ($(this).attr('name') == 'userid') {
			if (event.keyCode == 13)
				id_check(); /* userid에서 엔터시 중복체크 */
			else {
				$(this).removeClass('chked');
				validate($(this));
			}
		} else
			validate($(this));

	});

	function validate(t) { /* join_check.js의 tag_status를 호출하고 data 값을 가져온다 */
		var data = join.tag_status(t);
		display_status(t.siblings('div'), data);

	}

	function display_status(div, data) { /* data를 받아와  어떤 div에 뿌릴 것인가 */
		div.text(data.desc);
		div.removeClass('valid invalid');
		div.addClass(data.code);

	}

	/* 다음 주소 API */

	function daum_post() {
		new daum.Postcode({
			oncomplete : function(data) {
				$('[name=post]').val(data.zonecode);
				var address = data.userSelectedType == 'J' ? data.jibunAddress
						: data.roadAddress;
				if (data.buildingName != '')
					address += '(' + data.buildingName + ')';
				$('[name=address]').eq(0).val(address);
			}
		}).open();
	}

	
</script>

</body>
</html>