package com.danim.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.danim.model.UsersVO;

public interface UserService {
	//로그인 체크 기능 서비스
	public UsersVO loginCheck(UsersVO vo, HttpSession session) throws Exception;
	
	//회원가입 서비스
	public void join(String userPw, String userName, String userNickname, int userGender, String userBirth, String userEmail, int userDo, String userAddr) throws Exception;
	
	//비밀번호 찾기
	public String findPw(String userEmail) throws Exception;
	
	//이메일 중복 체크
	public int emailDupChk(String userEmail) throws Exception;
	
	//닉네임 중복 체크
	public int nickNameChk(String userNickname) throws Exception;
	
	//회원 정보 조회
	public List<UsersVO> userInfo(String userEmail) throws Exception;
	
	//회원 정보 수정
	public void myPageUpdate(String userNickname, String userPw, int userDo, String userAddr, String userEmail) throws Exception;

	//회원 정보 수정 시 게시물 닉네임에도 반영
	public void reviewWriterChange(String userNickname, int userId) throws Exception;
	
	//회원 정보 수정 시 댓글 닉네임에도 반영
	public void commentWriterChange(String userNickname, int userId) throws Exception;
	
	//회원 탈퇴
	public void userDelete(String userEmail, HttpSession session) throws Exception;
}
