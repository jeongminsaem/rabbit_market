package member;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service //메모리에 올리는 처리 
public class MemberServiceImpl implements MemberService {

	@Autowired private MemberDAO dao; 
	
	@Override
	public boolean member_insert(MemberVO vo) {
		
		return dao.member_insert(vo);
	}

	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		
		return dao.member_login(map);
	}

	@Override
	public boolean member_id_check(String userid) {
		return dao.member_id_check(userid);
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
		return dao.sns_login(access_token);
	}

}
