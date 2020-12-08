package member;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository //메모리에 올린다->root-context에 등록
public class MemberDAO implements MemberService{
	
	@Autowired private SqlSession sql;

	@Override
	public boolean member_insert(MemberVO vo) {
		return sql.insert("member.mapper.insert",vo) > 0 ? true : false ;
	}

	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		
		return sql.selectOne("member.mapper.login",map);
	}

	@Override
	public boolean member_id_check(String userid) {
		return (Integer)sql.selectOne("member.mapper.id_check", userid) == 0 ? true : false ;
	}

	@Override
	public boolean member_update(MemberVO vo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean member_delete(String userid) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public MemberVO sns_login(String access_token) {
		// TODO Auto-generated method stub
		return sql.selectOne("member.mapper.sns_login",access_token);
	}

}
