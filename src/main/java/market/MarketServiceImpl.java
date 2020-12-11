package market;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.FileVO;


@Service
public class MarketServiceImpl implements MarketService{

	
	@Autowired private MarketDAO dao;
	
	
	 // 댓글
	 
	@Override
	public int market_comment_insert(MarketCommentVO vo) {
		// TODO Auto-generated method stub
		return dao.market_comment_insert(vo);
	}

	@Override
	public List<MarketCommentVO> market_comment_list(int pid) {
		// TODO Auto-generated method stub
		return dao.market_comment_list(pid);
	}

	@Override
	public int market_comment_update(MarketCommentVO vo) {
		// TODO Auto-generated method stub
		return dao.market_comment_update(vo);
	}

	@Override
	public int market_comment_delete(int id) {
		// TODO Auto-generated method stub
		return dao.market_comment_delete(id);
	}	
	
	//답글쓰기
	@Override
	public void market_replyinsert(MarketVO vo) {
			dao.market_replyinsert(vo);

	}

	
	// 방명록 글 
	
	
	@Override
	public int market_insert(MarketVO vo) {
		
		return dao.market_insert(vo);
	}

	@Override
	public int market_insert_file(FileVO fileVo) {
		// TODO Auto-generated method stub
		return dao.market_insert_file(fileVo);
	}

	
	
	
	@Override
	public MarketPage market_list(MarketPage page) {
		
		return dao.market_list(page);
	}

	@Override
	public MarketVO market_detail(int id) {
		// TODO Auto-generated method stub
		return dao.market_detail(id);
	}

	@Override
	public int market_read(int id) {
		// TODO Auto-generated method stub
		return dao.market_read(id);
	}

	@Override
	public int market_update(MarketVO vo) {
		// TODO Auto-generated method stub
		return dao.market_update(vo);
	}

	@Override
	public int market_delete(int id) {
		// TODO Auto-generated method stub
		return dao.market_delete(id);
	}

	@Override
	public int market_update_likeIt(MarketVO vo) {
		// TODO Auto-generated method stub
		return dao.market_update_likeIt(vo);
	}

	@Override
	public int updated_like(MarketVO vo) {
		// TODO Auto-generated method stub
		return dao.updated_like(vo);
	}

	@Override
	public int delete_like(MarketVO vo) {
		// TODO Auto-generated method stub
		return dao.delete_like(vo);
	}

	@Override
	public int likecnt(int id) {
		// TODO Auto-generated method stub
		return dao.likecnt(id);
	}


	@Override
	public List<MarketCommentVO> noti_count(String userid) {
		// TODO Auto-generated method stub
		return dao.noti_count(userid);
	}

	
	@Override
	public int del_noti(int id) {
		// TODO Auto-generated method stub
		return dao.del_noti(id);
	}

	@Override
	public List<FileVO> detail_file(int id) {
		// TODO Auto-generated method stub
		return dao.detail_file(id);
	}

	@Override
	public int delete_file(int id) {
		// TODO Auto-generated method stub
		return dao.delete_file(id);
	}

	@Override
	public int update_file(FileVO vo) {
		// TODO Auto-generated method stub
		return dao.update_file(vo);
	}

	


}
