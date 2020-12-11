package market;

import java.util.List;

import common.FileVO;



public interface MarketService {
	
	
	
	int market_insert(MarketVO vo);   //방명록 글 저장 
	int market_insert_file(FileVO vo);
	MarketPage market_list(MarketPage page);  // 방명록 페이지 목록 조회 
	MarketVO market_detail( int id );  // 방명록 상세 조회	
	
	
	List<FileVO> detail_file(int id); //이미지 파일만 조회 
	int delete_file(int id);
	int update_file(FileVO vo);
	
	int market_read(int id); 		// 조회수 증가처리
	int market_update(MarketVO vo);	// 방명록 수정처리
	int market_delete(int id);		// 방명록 삭제처리 
	int market_update_likeIt(MarketVO vo);
	
	int updated_like(MarketVO vo); //좋아요 조회
	int delete_like(MarketVO vo); //좋아요 조회
	int likecnt(int id); //좋아요 조회
	
	int market_comment_insert(MarketCommentVO vo); //댓글저장
	List<MarketCommentVO> market_comment_list(int pid); //방명록 댓글 목록 조회
	int market_comment_update(MarketCommentVO vo); //댓글 수정 처리
	int market_comment_delete(int id); //댓글 삭제처리
	void market_replyinsert(MarketVO vo);
	
	List<MarketCommentVO> noti_count(String userid);
	int del_noti(int id);
	
	
	
}
