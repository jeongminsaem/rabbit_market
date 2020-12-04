<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table td { text-align:left; }
.valid, .invalid { font-size:13px; font-weight:bold; }
.valid { color:green }
.invalid { color:red }
input[name=address] { width:calc(100% - 14px); }
.ui-datepicker select {vertical-align: middle; height: 28px;}
.ui-datepicker-month {padding-bottom:3px}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>

<h3>회원가입</h3>

<p class="w-pct60 right" style="margin:0 auto; font-size:13px; padding-bottom:5px ">* 는 필수입력항목 입니다</p>
<form action="join" method="post">
<table class="w-pct60">
<tr><th class="w-px160">성명</th>
	<td><input type="text" name="name"/></td>
</tr>
<tr><th>* 아이디</th>
	<td><input type="text" name="userid" class="chk" />
		<a class="btn-fill-s" id="btn_id">중복확인</a><br>
		<div class="valid">아이디를 입력하세요(영문소문자, 숫자만 입력 가능)</div>
	</td>
</tr>
<tr><th>* 비밀번호</th>
	<td><input type="password" name="userpwd" class="chk" /><br>
		<div class="valid">비밀번호를 입력하세요(영문 대/소문자, 숫자를 모두 포함)</div>
	</td>
</tr>
<tr><th>* 비밀번호확인</th>
	<td><input type="password" name="userpwd_ck" class="chk" /><br>
		<div class="valid">비밀번호를 다시 입력하세요</div>
	</td>
</tr>
<tr><th>* 성별</th>
	<td><label><input type="radio" name="gender" value="남" checked/>남 </label>
		<label><input type="radio" name="gender" value="여" />여 </label>
	</td>
</tr>
<tr><th>* 이메일</th>
	<td><input type="text" name="email" class="chk" /><br>
		<div class="valid">이메일을 입력하세요</div>
	</td>
</tr>
<tr><th>생년월일</th>
	<td><input type="text" name="birth" readonly />
		<span style="position: relative; right: 25px; color: red; display:none;" id="delete"><i class="font-img fas fa-times"></i></span>
	</td>
</tr>
<tr><th>전화번호</th>
	<td><input type="text" name="phone" class="w-px40" maxlength="3"/>
		- <input type="text" name="phone" class="w-px40" maxlength="4"/>
		- <input type="text" name="phone" class="w-px40" maxlength="4"/>
	</td>
</tr>
<tr><th>주소</th>
	<td><a class="btn-fill-s" onclick="daum_post()">우편번호찾기</a>
		<input type="text" name="post" class="w-px60" readonly /><br>
		<input type="text" name="address" readonly />
		<input type="text" name="address" />
	</td>
</tr>
</table>
</form>

<div class = "btnSet">
		<a class ="btn-fill" onclick="go_join()">회원가입</a>
		<a class ="btn-empty" onclick="history.go(-1)">취소</a>

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

	/* 생년월일 */

	$(function() {
		var today = new Date();
		var endDay = new Date(today.getFullYear() - 13, today.getMonth(), today
				.getDate() - 1); /* 만13세까지 */

		$('[name=birth]').datepicker(
				{
					showMonthAfterYear : true,
					dateFormat : 'yy-mm-dd',
					changeYear : true,
					changeMonth : true,
					dayNamedMin : [ '일', '월', '화', '수', '목', '금', '토' ],
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ],
					maxDate : endDay,
					yearRange : '1950:' + endDay.toJSON().substr(0, 4) /* 년도 선택시 보여지는 범위  */
				});
	});

	$('[name=birth]').change(function() {
		$('#delete').css('display', 'inline');

	});

	$('#delete').click(function() {
		$('[name=birth]').val('');
		$('#delete').css('display', 'none');

	});
</script>

</body>
</html>