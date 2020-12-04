package com.hanul.rabbitmarket;

import java.io.File;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import board.BoardCommentVO;
import board.BoardPage;
import board.BoardServiceImpl;
import board.BoardVO;
import common.CommonService;
import member.MemberVO;


@Controller
public class BoardController {

	@Autowired private BoardServiceImpl service;
	@Autowired private BoardPage page;
	@Autowired private CommonService common;
		
	//답글 쓰기 화면요청
	@RequestMapping("/reply.bo")
	public String reply(int id, Model model) {
		model.addAttribute("vo",service.board_detail(id)); //원글에 대한 정보
		
		return "board/reply";
	}
	
	
	
	//답글 쓰기 저장 처리 요청 
	@RequestMapping("/reply_insert.bo")
	public String reply_insert(BoardVO vo, MultipartFile file, HttpSession session) {
		
		//첨부파일처리
		if ( !file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.upload("board", file, session)); //filepath는 업로드 처리 후에 알 수 있다. 
		}
						
		vo.setUserid( ((MemberVO)session.getAttribute("login_info") ).getUserid()); //session에는 로그인 정보가 들어 있고 getA- 에는 object 타입으로 저장 되 어 있다.
		
		//화면에서 입력한 정보를 DB에 답글로 저장한 후 목록화면으로 연결		
		service.board_replyinsert(vo);
		return "redirect:list.bo";
	}
	
		//댓글 저장처리 요청
		@ResponseBody @RequestMapping("/board/comment/insert")
		public boolean comment_insert(BoardCommentVO vo, HttpSession session) {
			//화면에서 입력한 댓글글을 DB에 저장
		
			vo.setUserid( ((MemberVO)session.getAttribute("login_info")).getUserid() );
			return service.board_comment_insert(vo)>0 ? true : false;
		}
	
	
		//댓글 목록조회 요청
		@RequestMapping("/board/comment/list/{pid}")
		public String comment_list(@PathVariable int pid, Model model) {
			//방명록 글에 딸린 댓글목록을 DB에서 조회해 와 화면에 출력
			model.addAttribute("list", service.board_comment_list(pid));
			model.addAttribute("crlf", "\r\n");
			model.addAttribute("lf", "\n");
			return "board/comment/list";
		}
		
	
	
		//댓글 변경저장처리 요청
		@ResponseBody
		@RequestMapping(value="/board/comment/update", produces="application/text; charset=utf-8")
		public String comment_update(@RequestBody BoardCommentVO vo) {
			return service.board_comment_update(vo)>0 ? "성공" : "실패";
		}
		
	
	

		//댓글 삭제 처리 요청
		
		@ResponseBody @RequestMapping("board/comment/delete/{id}")
		public void comment_delete(@PathVariable int id) {			
			service.board_comment_delete(id);
		}
		
		
		
	
	//방명록 목록화면 요청	
	@RequestMapping("/list.bo")
	public String list(HttpSession session, @RequestParam(defaultValue="1") int curPage , 
						Model model, String search, String keyword, 
						@RequestParam(defaultValue="10") int pageList,
						@RequestParam(defaultValue="list") String viewType) {
		
		session.setAttribute("category", "bo");		//DB에서 방명록 목록 데이터를 조회해와 목록화면에 출력
	
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setPageList(pageList);
		page.setViewType(viewType);
		model.addAttribute("page",service.board_list(page));
		
		System.out.println(search+keyword);
		
		return "board/list";
	}
	
	
		
	//신규 방명록 화면 요청
	@RequestMapping("/new.bo")
	public String board() {		
		return "board/new";
		
	}	
	
	
	@RequestMapping("/insert.bo")
	public String insert(BoardVO vo, MultipartFile file, HttpSession session) {
		if ( !file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("board", file, session)); //업로드 하고 filepath를 받아옴
		}
		
		vo.setUserid( ((MemberVO)session.getAttribute("login_info")).getUserid() );
		//화면에서 입력한 정보를 DB에 저장한후 목록화면으로 연결 
		service.board_insert(vo);
		return "redirect:list.bo";
		
	}
		
	
	
	//방명록 상세화면 요청 
	@RequestMapping("/detail.bo")
	public String detail(int id, Model model) { //hidden으로 전송
	//	public String detail(@ModelAttribute("id") int id, Model model) { //hidden으로 전송
		service.board_read(id);
		//선택한 글의 정보를 DB에서 조회해와 상세화면에 출력 
		model.addAttribute("vo",service.board_detail(id));
		model.addAttribute("crlf","\r\n");
		model.addAttribute("page",page);
		return "board/detail";
	}
	
	
	//방명록 첨부파일 다운로드 요청
	@ResponseBody
	@RequestMapping("/download.bo")
	public File download(int id, HttpSession session, HttpServletResponse response) {
		//선택한 글의 첨부파일 정보를 DB에서 조회해온 후 파일을 다운로드 한다
		BoardVO vo = service.board_detail(id);
		return common.download(vo.getFilename(), vo.getFilepath(), session, response);
	}
	
	
	
	
	//방명록 수정화면 요청
	@RequestMapping("/modify.bo")
	public String modify(int id, Model model) {
		//해당글의 정보를 DB에서 조회해와 수정화면에 출력한다
		model.addAttribute("vo",service.board_detail(id));
		return "board/modify";
	}
	
	
	//방명록 수정저장처리 요청
	@RequestMapping("/update.bo")
	public String update(BoardVO vo, MultipartFile file, String attach, HttpSession session, 
							RedirectAttributes redirect, Model model) {
		//DB에서 원래 방명록 글의 정보를 조회해온다 
		BoardVO board = service.board_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources") + board.getFilepath();
		
		//첨부파일이 있는 경우 : 원래 없었는데 변경하면서 첨부/ 원래 있었는데 변경하면서 바꿔 첨부 
		if ( !file.isEmpty() ) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("board", file, session));	
			//원래 있었는데 변경하면서 바꿔 첨부 하는 경우 원래 파일을 삭제 
			if ( board.getFilename() !=null ) {
				File f = new File( uuid );
				if ( f.exists()) f.delete();
					
			}
		} else {
			//원래부터 첨부파일이 없는 경우 / 원래 있었는데 변경하면서 없앤 경우 
			if(attach.isEmpty()) {
				// 원래 있었는데 변경하면서 없앤 경우, 원래 파일을 물리적 영역에서도 삭제
				if ( board.getFilename() !=null ) {
					File f = new File( uuid );
					if ( f.exists()) f.delete();
				}		

			} else {		
			
			// 원래 있던 첨부파일을 그대로 사용하는 경우
			vo.setFilename(board.getFilename());
			vo.setFilepath(board.getFilepath());
			
		}
			
		
	}
		service.board_update(vo);
//		redirect.addFlashAttribute("id", vo.getId());  //detail부분에서 @ModelAttribute("id")로 받는다
//		return "redirect:detail.bo";
//		return "redirect:detail.bo?id="+vo.getId();
		model.addAttribute("url","detail.bo");
		model.addAttribute("id",vo.getId());
		return "board/redirect";
	}
	
	



	//방명록 삭제요청

		@RequestMapping("/delete.bo")
		public String delete(int id, HttpSession session, Model model){
			//첨부파일이 있는 경우 서버의 물리적영역에서 파일을 삭제 
			BoardVO vo = service.board_detail(id);
			if( vo.getFilename() != null) {
				File f =  new File( session.getServletContext().getRealPath("resources") + vo.getFilepath() ); 
				if ( f.exists() ) f.delete();
			}
			
			//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
			service.board_delete(id);
			
			model.addAttribute("id",id);
			model.addAttribute("url","list.bo");
			model.addAttribute("page",page);
			return "board/redirect";
			//return "redirect:list.bo";
		}







}














	
	

