package board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class BoardDAO implements BoardService {
	
	@Autowired private SqlSession sql;  //default.xml 에 등록

	
	
	
	// 댓글 
	
	@Override
	public int board_comment_insert(BoardCommentVO vo) {
		// TODO Auto-generated method stub
		return sql.insert("board.mapper.comment_insert", vo);
	}

	@Override
	public List<BoardCommentVO> board_comment_list(int pid) {
		// TODO Auto-generated method stub
		return sql.selectList("board.mapper.comment_list",pid);
	}

	@Override
	public int board_comment_update(BoardCommentVO vo) {
		// TODO Auto-generated method stub
		return sql.update("board.mapper.comment_update",vo);
	}

	@Override
	public int board_comment_delete(int id) {
		// TODO Auto-generated method stub
		return sql.delete("board.mapper.comment_delete",id);
	}
	
	
	
	
	@Override
	public void board_replyinsert(BoardVO vo) {
		sql.insert("board.mapper.reply_insert", vo);
		
	}
	
	
	
	
	// 방명록 글 
	
	@Override
	public int board_insert(BoardVO vo) {
		
		return sql.insert("board.mapper.insert", vo);
	}

	@Override
	public BoardPage board_list(BoardPage page) {
		page.setTotalList( sql.selectOne("board.mapper.total", page) );
		page.setList( sql.selectList("board.mapper.list", page)); //시작글 번호와 끝 글 번호필요
		return page;
	}

	@Override
	public BoardVO board_detail(int id) {
		// TODO Auto-generated method stub
		return sql.selectOne("board.mapper.detail",id);
	}

	@Override
	public int board_read(int id) {
		// TODO Auto-generated method stub
		return sql.update("board.mapper.read",id);
	}

	@Override
	public int board_update(BoardVO vo) {
		// TODO Auto-generated method stub
		return sql.update("board.mapper.update",vo);
	}

	@Override
	public int board_delete(int id) {
		// TODO Auto-generated method stub
		return sql.delete("board.mapper.delete",id);
	}




}
