package com.danim.service;

import java.util.List;

import com.danim.model.ReviewListVO;
import com.danim.model.UsersVO;

public interface AdminService {
	//관리자 로그인
	public int adminLoginCheck(String adminEmail, String adminPw) throws Exception;
	
	//전체 게시글 목록
	public List<ReviewListVO> reviewList(int criNum, int viewNum, String keyword) throws Exception;
	
	//게시글 총합
	public int reviewTotal() throws Exception;
	
	//사용자 목록
	public List<UsersVO> userList(int criNum, int viewNum, String keyword) throws Exception;
	
	//사용자 총합
	public int userTotal() throws Exception;
	
	//사용자 삭제
	public void adminUserDelete(String userEmail) throws Exception;
}
