/**
 * 회원가입시 입력항목의 유효성 확인
 */
/*반환형태는 JSON*/




var join = {
	   common: {
			 empty : { code : 'invalid', desc: '입력하세요'}
		   , space : { code : 'invalid', desc: '공백없이 입력하세요'}
		   , min : { code:'invalid', desc : '최소 5자 이상 입력하세요'}
		   , max : { code:'invalid', desc : '최대 10자 이하 입력하세요'}
				
		}

	  , userid : {
		  	invalid: { code:'invalid', desc: '영문 소문자, 숫자만 입력하세요'}
	  	  , valid : { code : 'valid', desc: '아이디 중복확인하세요'}
	  	  , usable : { code : 'valid' , desc : '사용가능한 아이디 입니다'}
	  	  , unusable : {code : 'invalid', desc : '이미 사용중인 아이디입니다'}
	   }
	  
	  , userpwd : {
		    invalid: { code:'invalid', desc: '영문 대/소문자, 숫자만 입력하세요'}
		  , valid : { code : 'valid', desc: '사용가능한 비밀번호입니다'}
		  , lack : {code : 'invalid', desc: '영문 대/소문자, 숫자를 모두 포함해야 합니다'}
		  , equal : { code : 'valid', desc: '비밀번호가 일치합니다'}
		  , notEqual : { code : 'invalid', desc: '비밀번호가 일치하지 않습니다'}
		  
	   }
	  
	  
	  , tag_status : function(tag){
		  var data = tag.val();
		  tag = tag.attr('name')
		  if ( tag == 'userid')    data = this.userid_status(data);  /* 아이디 유효성*/
		  else if (tag == 'userpwd')  data = this.userpwd_status(data); 
		  else if (tag == 'userpwd_ck') data = this.userpwd_ck_status(data);
		  else if (tag == 'email') data = this.email_status(data);
		  
			  return data;
	  }
	  
	  
	  , userid_status: function(id){ /* 아이디 유효성 data */
		  var reg = /[^a-z0-9]/g;
		  
		  if( id =='') 					return this.common.empty;
		  else if (id.match(space))		return this.common.space;
		  else if (id.match(reg))		return this.userid.invalid;
		  else if (id.length<5)			return this.common.min;
		  else if (id.length>10)		return this.common.max;
		  else 							return this.userid.valid;
		  
	  }
	  
	  
	  , id_usable : function(data){ /* 아이디 중복체크 */
		  if ( data ) return this.userid.usable;
		  else 		  return this.userid.unusable;
	  }
	  
	  
	  
	  , userpwd_status: function(pwd){ /* 비밀번호 유효성 data */
		  var reg = /[^a-zA-Z0-9]/g;
		  var upper = /[A-Z]/g, lower= /[a-z]/g, digit= /[0-9]/g;
		  		  
		  if( pwd =='') 				return this.common.empty;		 
		  else if (pwd.match(space))	return this.common.space;
		  else if (reg.test(pwd))		return this.userpwd.invalid;
		  else if (pwd.length<5)		return this.common.min;
		  else if (pwd.length>10)		return this.common.max;
		  else if (!upper.test(pwd) || !lower.test(pwd) || !digit.test(pwd) )
			  							return this.userpwd.lack;
		  else 							return this.userpwd.valid;
		  
		  
		  
	  }
	  
	  , userpwd_ck_status: function(pwd_ck){ /* 비밀번호 확인 유효성 data */
	  
		  if( pwd_ck =='') 				return this.common.empty;	
		  else if (pwd_ck == $('[name=userpwd]').val()) return this.userpwd.equal;
		  else 											return this.userpwd.notEqual;
		
	   }
	  
	  
	  
	  , email: {
			valid: { code:'valid', desc:'유효한 이메일입니다'}
		, invalid: { code:'invalid', desc:'유효하지 않은 이메일입니다'}
	}
	  
	  
	, email_status: function(email){
		var reg =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if( email=='' )					return this.common.empty;
		else if( email.match(space) )	return this.common.space;
		else if( reg.test(email) )		return this.email.valid;
		else 							return this.email.invalid;
	} 



}; 





var space = /\s/g;







