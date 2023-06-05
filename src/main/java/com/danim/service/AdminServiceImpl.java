package com.danim.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.danim.mapper.AdminMapper;
import com.danim.model.ReviewListVO;
import com.danim.model.UsersVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	private final AdminMapper mapper;
	
	@Autowired
	public AdminServiceImpl(AdminMapper mapper) {
		this.mapper = mapper;
	}
	
	//관리자 로그인
	@Override
	public int adminLoginCheck(String adminEmail, String adminPw) throws Exception {
		return mapper.adminLoginCheck(adminEmail, adminPw);
	}
	
	//게시글 가져오기
	@Override
	public List<ReviewListVO> reviewList(int criNum, int viewNum, String keyword) throws Exception{
		int page = (criNum - 1) * viewNum;
		
		return mapper.reviewList(page, viewNum, keyword);
	}
	
	//게시글 총합
	@Override
	public int reviewTotal() throws Exception {
		return mapper.reviewTotal();
	}
	
	//사용자 목록 가져오기
	@Override
	public List<UsersVO> userList(int criNum, int viewNum, String keyword) throws Exception {
		int page = (criNum - 1) * viewNum;
		
		return mapper.userList(page, viewNum, keyword);
	}
	
	//사용자 총합
	@Override
	public int userTotal() throws Exception {
		return mapper.userTotal();
	}
	
	//사용자 삭제
	@Override
	public void adminUserDelete(String userEmail) throws Exception {
		mapper.adminUserDelete(userEmail);
	}
}
