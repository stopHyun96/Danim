package com.danim.mapper;

import org.apache.ibatis.annotations.Param;

import com.danim.model.ReviewListVO;

public interface ReviewUploadMapper {
	//userId 찾기
	public Integer findUserId(String userEmail) throws Exception;
	
	//writer 찾기
	public String findWriter(String userEmail) throws Exception;
	
	//글 작성 쿼리 매퍼
	public void upload(ReviewListVO vo) throws Exception;
	
	//글 수정 쿼리 매퍼
	public void modify(@Param("num") int num, @Param("title") String title, @Param("content") String content, @Param("filename") String filename) throws Exception;
	
	//글 삭제 쿼리 매퍼
	public void delete(int num) throws Exception;
	
	//게시글 삭제 시 게시글 안의 댓글도 함께 삭제
	public void bbsCommentDelete(int num) throws Exception;
	
	//댓글 작성 쿼리 매퍼
	public void commentWrite(@Param("num") int num, @Param("writer") String writer, @Param("userId") int userId, @Param("content") String content) throws Exception;
	
	//댓글 삭제 쿼리 매퍼
	public void commentDelete(int commentNum) throws Exception;
	
	//댓글 작성 시 게시글 목록 commentCount 증가
	public void commentCountUp (int num) throws Exception;
	
	//댓글 삭제 시 게시글 목록 commentCount 감소
	public void commentCountDown (int num) throws Exception;
}
