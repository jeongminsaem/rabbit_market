package com.hanul.rabbitmarket;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;

import common.CommonService;

import member.MemberServiceImpl;
import member.MemberVO;
import socialLogin.GoogleOAuthRequest;
import socialLogin.GoogleOAuthResponse;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	@Autowired private CommonService common;
	
	
	final static String GOOGLE_AUTH_BASE_URL = "https://accounts.google.com/o/oauth2/v2/auth";
	// 인증코드 받기 위해 clientid, scope, redirt 주소를 싫어보냄. 엔드포인트 
	final static String GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token";
	//final static String GOOGLE_REVOKE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/revoke";


	@Inject String clientId;
	@Inject	String clientSecret;

	
	
	
	@RequestMapping("/loginPage")
	public String loginPage() { 
		
		 return "member/login";
		
	}
	
	
	
	@RequestMapping("/snsCheck")
	public String snsCheck() {	 
		
		 return "member/market";
		
	}
	
	
	

	/**
	 * Authentication Code를 전달 받는 엔드포인트
	 **/
	// 소셜 로그인 처리 
	@GetMapping("auth")
	public String googleAuth(Model model, @RequestParam(value = "code") String authCode, HttpSession session)
			throws JsonProcessingException {
		
		//HTTP Request를 위한 RestTemplate   Xml Document의 Elements를 자
		RestTemplate restTemplate = new RestTemplate();

		//Google OAuth Access Token 요청을 위한 파라미터 세팅
		GoogleOAuthRequest googleOAuthRequestParam = GoogleOAuthRequest
				.builder()
				.clientId(clientId)
				.clientSecret(clientSecret)
				.code(authCode)
				.redirectUri("http://localhost:80/iot/auth")
				.grantType("authorization_code").build();
				
		
		//JSON 파싱을 위한 기본값 세팅
		//요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);

		//AccessToken 발급 요청
		ResponseEntity<String> resultEntity = restTemplate
							.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam, String.class);
		
		//Token Request
		GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>(){});
	
 		
		 //ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다) JSON Web Token
		 // JWT의 구조 ::  header(헤더) . payload(내용) . signature (서명) 
		 String jwtToken = result.getIdToken();
		 					//UriComponentsBuilder 문자열 URI를 만들어야 할때
		 String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
				 							.queryParam("id_token", jwtToken).build().encode().toString();
		 
		 String resultJson = restTemplate.getForObject(requestUrl, String.class);		  
		 //System.out.println("resultJson::"+resultJson);
		 Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){}); 
		// model.addAllAttributes(userInfo);
		// model.addAttribute("token", result.getAccessToken());
	
		//로그인 유저 확인	
		String userid = userInfo.get("email");
		
		MemberVO loginResult = service.sns_login(userid);  //userid값으로 소셜 로그인하기 
	
		
			if ( loginResult == null ) {			
				
				// 없으면 db로 저장 
				System.out.println("회원가입으로");
			
				 MemberVO vo1 = new MemberVO();
				 vo1.setName(userInfo.get("name"));
				 vo1.setUserid(userInfo.get("email"));
				 vo1.setId_token(jwtToken);
				 service.member_insert(vo1);
				 
				 return "redirect:list.mar";		
				
			} else {
			
				// 있으면 로그인 
				System.out.println("소셜로그인 성공");
				session.setAttribute("login_info", loginResult);
						
				return "redirect:list.mar";		
				
			}
	
		
		


	} 
	

	//로그인
	@ResponseBody 
	@RequestMapping("/login")
	public boolean login(String userid, String userpwd, HttpSession session) {		
		
		//DB에서 입력한 아이디 , 비밀번호 일치하는 회원정보를 조회한 후 
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("userpwd", userpwd);		
		MemberVO vo = service.member_login(map);
		
		
		
		//세션에 로그인한 회원 정보를 담는다
		session.setAttribute("login_info", vo);
		//회원존재여부를 반환
		return vo == null ? false : true; 
		
	} 
	
	
	
	
	
	
	//회원가입처리
	@ResponseBody @RequestMapping(value="/join", produces="text/html; charset=utf-8")
	public String join(MemberVO vo, HttpServletRequest request, HttpSession session) {
		String msg = "<script>";
		if( service.member_insert(vo) ) {
			//축하 이메일 전송
			common.sendEmail(vo.getEmail(), vo.getName(), session);
			msg += "alert('회원가입 축하^^'); location='" + request.getContextPath() + "'";
		}else {
			msg += "alert('회원가입 실패ㅠㅠ'); history.go(-1);";
		}
		msg += "</script>";
		return msg;
	}
	
	
	
	
	
	

	
	//로그아웃
	@ResponseBody 
	@RequestMapping("/logout")
	public void logout(HttpSession session) {
		session.removeAttribute("login_info");
		//반환할 데이터가 없다
		
	}
	
	
	//회원가입화면 요청
	@RequestMapping("/member")
	public String member(HttpSession session) {
		session.removeAttribute("category");
		return "member/join";
	}
	
	
	// 아이디 중복체크 
	@ResponseBody @RequestMapping("/id_check")
	public boolean id_check(String userid) {
		return service.member_id_check(userid); // true or false 반환
	}
	

	
	
	

}
