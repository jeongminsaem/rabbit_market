package com.hanul.rabbitmarket;
import java.util.List;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import common.CommonService;
import common.FileVO;
import market.MarketCommentVO;
import market.MarketPage;
import market.MarketServiceImpl;
import market.MarketVO;
import member.MemberVO;


@Controller
public class MarketController {
	

		@Autowired private MarketServiceImpl service;
		@Autowired private MarketPage page;
		@Autowired private CommonService common;
			
	
		// 알림 리스트 보여주기
		@RequestMapping("/noti_list")
		public String notice_list(HttpSession session, Model model) {
		
			String userid=((MemberVO)session.getAttribute("login_info")).getUserid();
			service.noti_count(userid);
		  
			List<MarketCommentVO> list = service.noti_count(userid);
			model.addAttribute("list", list);
			
			
			return "market/noti_list";
		}
		
		
		
		// 알림 삭제 
		@ResponseBody 
		@RequestMapping("/del_noti")
		public boolean del_noti(int id) {		
			
			return service.del_noti(id)>0 ? true : false;
		}
		
		
		
		
// ------------------ 좋아요 		
		
		
		// 좋아요 업데이트
		@ResponseBody @RequestMapping("/market/update_likeIt")
		public void market_update_likeIt(MarketVO vo, HttpSession session) {
		
			
			vo.setUserid( ((MemberVO)session.getAttribute("login_info")).getUserid() );	
			
			int likecnt = service.updated_like(vo);
			if (likecnt > 0) {
				service.delete_like(vo);
				
			} else {			
			
			service.market_update_likeIt(vo);
			}						
			
		}
		
		
		//좋아요 조회 
		@ResponseBody @RequestMapping("/market/updated_like")
		public boolean updated_like(MarketVO vo, HttpSession session) {
			
		
			vo.setUserid( ((MemberVO)session.getAttribute("login_info")).getUserid() );				
			System.out.println("------ 리턴"+service.updated_like(vo));
			
			
			return service.updated_like(vo)>0 ? true : false;
		}
		

		
// ------------------ 댓글 			
		
			//댓글 저장처리 요청
			@ResponseBody @RequestMapping("/market/comment/insert")
			public boolean comment_insert(MarketCommentVO vo, HttpSession session) {
				//화면에서 입력한 댓글글을 DB에 저장			
				vo.setUserid( ((MemberVO)session.getAttribute("login_info")).getUserid() );
				
				return service.market_comment_insert(vo)>0 ? true : false;
			}
		
			
			
			@ResponseBody @RequestMapping("/market/comment/noti_count")
			public List<MarketCommentVO> noti_count(String userid, HttpSession session) {
		
				List<MarketCommentVO> list = service.noti_count(userid);
				System.out.println("알림조회"+ list);
				
				return list;
			}
			
			
			
		
			//댓글 목록조회 요청
			@RequestMapping("/market/comment/list/{pid}")
			public String comment_list(@PathVariable int pid, Model model) {
				//방명록 글에 딸린 댓글목록을 DB에서 조회해 와 화면에 출력
				model.addAttribute("list", service.market_comment_list(pid));
				model.addAttribute("crlf", "\r\n");
				model.addAttribute("lf", "\n");				
				return "market/comment/list";
			}			
		
		
			//댓글 변경저장처리 요청
			@ResponseBody
			@RequestMapping(value="/market/comment/update", produces="application/text; charset=utf-8")
			public String comment_update(@RequestBody MarketCommentVO vo) {
				return service.market_comment_update(vo)>0 ? "성공" : "실패";
			}
			
				
			//댓글 삭제 처리 요청			
			@ResponseBody @RequestMapping("market/comment/delete/{id}")
			public void comment_delete(@PathVariable int id) {	
				
				service.market_comment_delete(id);
			}
			
			
		

					
			
			
// ------------------ 게시글			
			
		
		//방명록 목록화면 요청	
		@RequestMapping("/list.mar")
		public String list(HttpSession session, @RequestParam(defaultValue="1") int curPage , 
							Model model, String search, String keyword, 
							@RequestParam(defaultValue="10") int pageList,
							@RequestParam(defaultValue="grid") String viewType) {
			
			session.setAttribute("category", "mar");		//DB에서 방명록 목록 데이터를 조회해와 목록화면에 출력
		
			page.setCurPage(curPage);
			page.setSearch(search);		
			page.setPageList(pageList);
			page.setViewType(viewType);
			page.setKeyword(keyword);		
			
			MarketPage pagelist = service.market_list(page);
			
			for(int i=0; i<page.getList().size(); i++) {
				
				int id = pagelist.getList().get(i).getId(); //아이디값
				pagelist.getList().get(i).setLikecnt(service.likecnt(id));	// 조회해온 값을 page에 넣음		
			}
		
			model.addAttribute("page", pagelist);	
				
			return "market/list";
		}
		
		
			
		//신규 방명록 화면 요청
		@RequestMapping("/new.mar")
		public String market() {		
			return "market/new";			
		}	
		
		
		@RequestMapping("/insert.mar")
		public String insert(MarketVO vo, FileVO fileVo, MultipartHttpServletRequest file, HttpSession session) {			
	
			List<MultipartFile> fileList = file.getFiles("file"); 
		
			vo.setUserid( ((MemberVO)session.getAttribute("login_info")).getUserid() );			
			
			// 체크 박스 체크 안됬을 때, 
			if(vo.getDiscuss() == null) {
				vo.setDiscuss("N");
			}
			
			service.market_insert(vo);
			System.out.println(vo.getId());
			
			
			  
			 for (MultipartFile SingleFile : fileList) {
		            String originFileName = SingleFile.getOriginalFilename(); // 원본 파일 명
		            //long fileSize = SingleFile.getSize(); // 파일 사이즈

		          // String safeFile = path + System.currentTimeMillis() + originFileName;		           
		           fileVo.setFilename(SingleFile.getOriginalFilename());
		           fileVo.setFilepath(common.upload("market", SingleFile, session));                   
		          // fileVo.setPostid(vo.getId());
		           
		           service.market_insert_file(fileVo);	           
		           
			 }	
		
			return "redirect:list.mar";			
		}
			
		
		
		//방명록 상세화면 요청 
		@RequestMapping("/detail.mar")
		public String detail(int id, Model model,HttpSession session, MarketVO vo) { //hidden으로 전송
		//	public String detail(@ModelAttribute("id") int id, Model model) { //hidden으로 전송
			
			// 조회수 올리기 
			service.market_read(id);			
			
			// 상세내용 조회하기 
			List<MarketVO> list = service.market_detail(id);			
			model.addAttribute("vo",list.get(0));	// 로그인한 사용자			
			model.addAttribute("crlf","\r\n");
			model.addAttribute("file_atta", list);			
			model.addAttribute("page",page);
			
			
			// 로그인 상태라면 찜한상품인지 확인
			  if (session.getAttribute("login_info") != null) {
				  			  //좋아요 눌렀는지 조회
			  vo.setUserid((((MemberVO)session.getAttribute("login_info")).getUserid()));
			  //service.updated_like(vo);
			  model.addAttribute("likecnt",service.updated_like(vo)); 
			  }
			 
			return "market/detail";		
			
		}

		
		
		
		//방명록 수정화면 요청
		@RequestMapping("/modify.mar")
		public String modify(int id, Model model) {
			//해당글의 정보를 DB에서 조회해와 수정화면에 출력한다
			model.addAttribute("vo",service.market_detail(id));
			//System.out.println(service.market_detail(id).getDiscuss());
			return "market/modify";
		}
		
		
		//방명록 수정저장처리 요청
		@RequestMapping("/update.mar")
		public String update(MarketVO vo, MultipartFile file, String attach, HttpSession session, 
								RedirectAttributes redirect, Model model) {
			//DB에서 원래 방명록 글의 정보를 조회해온다 
			List<MarketVO> market = service.market_detail(vo.getId());
		
//			
//			
//			String uuid = session.getServletContext().getRealPath("resources") + market.getFilepath();
//		
//			//첨부파일이 있는 경우 : 원래 없었는데 변경하면서 첨부/ 원래 있었는데 변경하면서 바꿔 첨부 
//			if ( !file.isEmpty() ) {
//			vo.setFilename(file.getOriginalFilename());
//				vo.setFilepath(common.upload("market", file, session));	
//			//원래 있었는데 변경하면서 바꿔 첨부 하는 경우 원래 파일을 삭제 
//			if ( market.getFilename() !=null ) {
//					File f = new File( uuid );
//					if ( f.exists()) f.delete();
//						
//				}
//			} else {
//				//원래부터 첨부파일이 없는 경우 / 원래 있었는데 변경하면서 없앤 경우 
//				if(attach.isEmpty()) {
//					// 원래 있었는데 변경하면서 없앤 경우, 원래 파일을 물리적 영역에서도 삭제
//					if ( market.getFilename() !=null ) {
//						File f = new File( uuid );
//						if ( f.exists()) f.delete();
//					}		
//
//				} else {		
//				
//				// 원래 있던 첨부파일을 그대로 사용하는 경우
//				vo.setFilename(market.getFilename());
//				vo.setFilepath(market.getFilepath());
//				
//			}
//				
//		
//		}  
			service.market_update(vo);
			redirect.addFlashAttribute("id", vo.getId());  //detail부분에서 @ModelAttribute("id")로 받는다
			return "redirect:detail.mar";
			
			/*
			 * return "redirect:detail.mar?id="+vo.getId();
			 * model.addAttribute("url","detail.mar"); model.addAttribute("id",vo.getId());
			 * return "market/redirect";
			 */  
			
			
		}
		
		



		//방명록 삭제요청
		@RequestMapping("/delete.mar")
		public String delete(int id, HttpSession session, Model model){
		//첨부파일이 있는 경우 서버의 물리적영역에서 파일을 삭제 
		List<MarketVO> vo = service.market_detail(id);
			/*
			 * if( vo.getFilename() != null) { File f = new File(
			 * session.getServletContext().getRealPath("resources") + vo.getFilepath() ); if
			 * ( f.exists() ) f.delete(); }
			 */
				
		//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
			service.market_delete(id);
			model.addAttribute("id",id);
			model.addAttribute("url","list.mar");
			model.addAttribute("page",page);
			return "market/redirect";
			//return "redirect:list.mar";
		}



}




