package com.danim.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.danim.model.UsersVO;

public interface UserMapper {
	//login체크 기능 매퍼
	public UsersVO loginCheck(UsersVO vo) throws Exception;
	
	//회원가입 기능 매퍼
	public void join(Map<String, Object> map) throws Exception;
	
	//비밀번호 찾기
	public String findPw(String userEmail) throws Exception;
	
	//이메일 중복 체크
	public int emailDupChk(String userEmail) throws Exception;
	
	//닉네임 중복 체크
	public int nickNameChk(String userNickname) throws Exception;
	
	//회원 정보 조회
	public List<UsersVO> userInfo(String userEmail) throws Exception;
	
	//회원 정보 수정
	public void myPageUpdate(Map<String, Object> map) throws Exception;
	
	//회원 정보 수정 시 게시물 닉네임에도 반영
	public void reviewWriterChange(@Param("userNickname") String userNickname, @Param("userId") int userId) throws Exception;
	
	//회원 정보 수정 시 댓글 닉네임에도 반영
	public void commentWriterChange(@Param("userNickname") String userNickname, @Param("userId") int userId) throws Exception;
	
	//회원 탈퇴
	public void userDelete(String userEmail) throws Exception;
}
