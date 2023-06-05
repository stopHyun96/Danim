package com.danim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.danim.mapper.UserMapper;
import com.danim.model.UsersVO;

@Service
public class UserServiceImpl implements UserService {
	private final UserMapper mapper;
	
	@Autowired
	public UserServiceImpl(UserMapper mapper) {
		this.mapper = mapper;
	}
	
	//로그인 체크 기능 서비스
	@Override
	public UsersVO loginCheck(UsersVO vo, HttpSession session) throws Exception{
		//sql에서 검색한 결과가 null이 아니라면 세션에 아이디와 비밀번호를 저장
		if(mapper.loginCheck(vo) != null) {
			session.setAttribute("userEmail", vo.getUserEmail());
			session.setAttribute("userPw", vo.getUserPw());
		}
		
		return mapper.loginCheck(vo);
	}
	
	//회원가입 서비스
	@Override
	public void join(String userPw, String userName, String userNickname, int userGender, String userBirth, String userEmail, int userDo, String userAddr) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("userPw", userPw);
		map.put("userName", userName);
		map.put("userNickname", userNickname);
		map.put("userGender", userGender);
		map.put("userBirth", userBirth);
		map.put("userEmail", userEmail);
		map.put("userDo", userDo);
		map.put("userAddr", userAddr);
		
		mapper.join(map);
	}
	
	//비밀번호 찾기
	@Override
	public String findPw(String userEmail) throws Exception {
		String pw = mapper.findPw(userEmail);
		
		return pw;
	}
	
	//이메일 중복체크
	@Override
	public int emailDupChk(String userEmail) throws Exception {
		int dup = mapper.emailDupChk(userEmail);
		System.out.println("dup : " + dup);
		
		return dup;
	}
	
	//닉네임 중복체크
	@Override
	public int nickNameChk(String userNickname) throws Exception {
		int dup = mapper.nickNameChk(userNickname);
		System.out.println("dup : " + dup);
		
		return dup;
	}
	
	//회원 정보 조회
	@Override
	public List<UsersVO> userInfo(String userEmail) throws Exception {
		return mapper.userInfo(userEmail);
	}
	
	//회원 정보 수정
	@Override
	public void myPageUpdate(String userNickname, String userPw, int userDo, String userAddr, String userEmail) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userNickname", userNickname);
		map.put("userPw", userPw);
		map.put("userDo", userDo);
		map.put("userAddr", userAddr);
		map.put("userEmail", userEmail);
		
		mapper.myPageUpdate(map);
	}
	
	//회원 정보 수정 시 게시물 닉네임에도 반영
	@Override
	public void reviewWriterChange(String userNickname, int userId) throws Exception {
		mapper.reviewWriterChange(userNickname, userId);
	}
	
	//회원 정보 수정 시 댓글 닉네임에도 반영
	@Override
	public void commentWriterChange(String userNickname, int userId) throws Exception {
		mapper.commentWriterChange(userNickname, userId);
	}
	
	//회원탈퇴
	@Override
	public void userDelete(String userEmail, HttpSession session) throws Exception {
		mapper.userDelete(userEmail);
		
		session.invalidate();
	}
}
