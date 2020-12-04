package board;

import java.util.List;



public interface BoardService {
	
	
	
	int board_insert(BoardVO vo);   //방명록 글 저장 
	BoardPage board_list(BoardPage page);  // 방명록 페이지 목록 조회 
	BoardVO board_detail( int id );  // 방명록 상세 조회
	int board_read(int id); 		// 조회수 증가처리
	int board_update(BoardVO vo);	// 방명록 수정처리
	int board_delete(int id);		// 방명록 삭제처리 
	
	int board_comment_insert(BoardCommentVO vo); //댓글저장
	List<BoardCommentVO> board_comment_list(int pid); //방명록 댓글 목록 조회
	int board_comment_update(BoardCommentVO vo); //댓글 수정 처리
	int board_comment_delete(int id); //댓글 삭제처리
	void board_replyinsert(BoardVO vo);
	
	
	
}
