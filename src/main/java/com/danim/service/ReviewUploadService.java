package com.danim.service;

import com.danim.model.ReviewListVO;

public interface ReviewUploadService {
	//userId 찾기
	public Integer findUserId(String userEmail) throws Exception;
	
	//writer 찾기
	public String findWriter(String userEmail) throws Exception;
	
	//글 작성 쿼리 서비스
	public void upload(ReviewListVO vo) throws Exception;
	
	//글 수정 쿼리 서비스
	public void modify(int num, String title, String content, String filename) throws Exception;
	
	//글 삭제 쿼리 서비스
	public void delete(int num) throws Exception;

	//게시글 삭제 시 게시글 안의 댓글도 함께 삭제
	public void bbsCommentDelete(int num) throws Exception;
	
	//댓글 작성 서비스
	public void commentWrite(int num, String writer, int userId, String content) throws Exception;
	
	//댓글 삭제 서비스
	public void commentDelete(int commentNum) throws Exception;
	
	//댓글 삭제 시 게시글 목록 commentCount 감소
	public void commentCountDown (int num) throws Exception;
}
