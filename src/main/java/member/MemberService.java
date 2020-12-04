package member;

import java.util.HashMap;

public interface MemberService {
	
	//CRUD
	boolean member_insert(MemberVO vo);
	MemberVO member_login(HashMap<String, String> map); //mapper에 값을 하나 밖에 보낼 수 없으므로 
	boolean member_id_check(String userid);
	boolean member_update(MemberVO vo);
	boolean member_delete(String userid);
}
