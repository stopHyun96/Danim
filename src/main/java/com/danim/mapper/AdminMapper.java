package com.danim.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.danim.model.ReviewListVO;
import com.danim.model.UsersVO;

public interface AdminMapper {
	//관리자 로그인
	public int adminLoginCheck(@Param("adminEmail") String adminEmail, @Param("adminPw") String adminPw) throws Exception;
	
	//전체 게시글 목록
	public List<ReviewListVO> reviewList(@Param("criNum") int criNum, @Param("viewNum") int viewNum, @Param("keyword") String keyword) throws Exception;
	
	//게시글 총합
	public int reviewTotal() throws Exception;
	
	//사용자 목록
	public List<UsersVO> userList(@Param("criNum") int criNum, @Param("viewNum") int viewNum, @Param("keyword") String keyword) throws Exception;
	
	//사용자 총합
	public int userTotal() throws Exception;
	
	//사용자 삭제
	public void adminUserDelete(String userEmail) throws Exception;
}
