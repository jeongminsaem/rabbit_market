package com.hanul.rabbitmarket;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	@Autowired private CommonService common;
	
	

	//로그인
	@ResponseBody //이자체가 응답..?
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
	
	@RequestMapping("/loginPage")
	public String loginPage() {
		
		
		 return "member/login";
		
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
