package market;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.FileVO;



@Repository
public class MarketDAO implements MarketService {
	
	@Autowired private SqlSession sql;  //default.xml 에 등록

	
	
	
	// 댓글 
	
	@Override
	public int market_comment_insert(MarketCommentVO vo) {
		// TODO Auto-generated method stub
		return sql.insert("market.mapper.comment_insert", vo);
	}

	@Override
	public List<MarketCommentVO> market_comment_list(int pid) {
		// TODO Auto-generated method stub
		return sql.selectList("market.mapper.comment_list",pid);
	}

	@Override
	public int market_comment_update(MarketCommentVO vo) {
		// TODO Auto-generated method stub
		return sql.update("market.mapper.comment_update",vo);
	}

	@Override
	public int market_comment_delete(int id) {
		// TODO Auto-generated method stub
		return sql.delete("market.mapper.comment_delete",id);
	}
	
	
	
	
	@Override
	public void market_replyinsert(MarketVO vo) {
		sql.insert("market.mapper.reply_insert", vo);
		
	}
	
	
	
	
	// 방명록 글 
	
	@Override
	public int market_insert(MarketVO vo) {
		
		return sql.insert("market.mapper.insert", vo);
	}

	@Override
	public int market_insert_file(FileVO fileVo) {
		// TODO Auto-generated method stub
		System.out.println(fileVo);
		return sql.insert("market.mapper.insert_file", fileVo);
	}


	
	
	@Override
	public MarketPage market_list(MarketPage page) {
		page.setTotalList( sql.selectOne("market.mapper.total", page) );
		page.setList( sql.selectList("market.mapper.list", page)); //시작글 번호와 끝 글 번호필요

		return page;
	}

	@Override
	public MarketVO market_detail(int id) {
		// TODO Auto-generated method stub
		return sql.selectOne("market.mapper.detail",id);
	}

	@Override
	public int market_read(int id) {
		// TODO Auto-generated method stub
		return sql.update("market.mapper.read",id);
	}

	@Override
	public int market_update(MarketVO vo) {
		// TODO Auto-generated method stub
		return sql.update("market.mapper.update",vo);
	}

	@Override
	public int market_delete(int id) {
		// TODO Auto-generated method stub
		return sql.delete("market.mapper.delete",id);
	}

	@Override
	public int market_update_likeIt(MarketVO vo) {
		// TODO Auto-generated method stub
		return sql.update("market.mapper.update_likeIt",vo);
	}

	@Override
	public int updated_like(MarketVO vo) {
		// TODO Auto-generated method stub
		return sql.selectOne("market.mapper.updated_like",vo);
	}

	@Override
	public int delete_like(MarketVO vo) {
		// TODO Auto-generated method stub
		return sql.delete("market.mapper.delete_like",vo);
	}

	@Override
	public int likecnt(int id) {
		// TODO Auto-generated method stub
		return sql.selectOne("market.mapper.likecnt",id);
	}


	@Override
	public List<MarketCommentVO> noti_count(String userid) {
		// TODO Auto-generated method stub
		return sql.selectList("market.mapper.noti_count",userid);
	}

	@Override
	public int del_noti(int id) {
		// TODO Auto-generated method stub
		return sql.update("market.mapper.del_noti",id);
	}

	@Override
	public List<FileVO> detail_file(int id) {
		// TODO Auto-generated method stub
		return sql.selectList("market.mapper.detail_file", id);
	}

	@Override
	public int delete_file(int id) {
		// TODO Auto-generated method stub
		System.out.println("DAO"+id);
		return sql.delete("market.mapper.delete_file",id);
	}

	@Override
	public int update_file(FileVO vo) {
		// TODO Auto-generated method stub
		return sql.update("market.mapper.update_file",vo);
	}

	
	


}
