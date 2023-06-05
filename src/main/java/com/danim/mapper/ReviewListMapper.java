package com.danim.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.danim.model.CommentsVO;
import com.danim.model.DoVO;
import com.danim.model.ReviewListVO;

public interface ReviewListMapper {
	//전체 게시글 목록
	public List<ReviewListVO> reviewList(@Param("criNum") int criNum, @Param("viewNum") int viewNum, @Param("keyword") String keyword, @Param("condition") String condition, @Param("doId") Integer doId) throws Exception;
	
	//베스트 게시글 목록
	public List<ReviewListVO> bestList() throws Exception;
	
	//게시글 총 수
	public int reviewPages() throws Exception;
	
	//게시글 도 선택
	public List<DoVO> selectDo() throws Exception;
	
	//게시글 상세보기
	public ReviewListVO reviewDetail(int num) throws Exception;
	
	//댓글 리스트
	public List<CommentsVO> commentList(Map<String, Integer> pages) throws Exception;
	
	//댓글 총 수
	public int commentCount(int num) throws Exception;
	
	//조회수 증가
	public void viewCountUp (int num) throws Exception;
	
	//추천
	public void goodInsert (@Param("num") int num, @Param("userId") int userId) throws Exception;
	
	//추천 취소
	public void goodDelete (@Param("num") int num, @Param("userId") int userId) throws Exception;
	
	//추천 여부 확인
	public int goodSelect (@Param("num") int num, @Param("userId") int userId) throws Exception;
	
	//게시글별 추천 수 조회
	public int allGoods (int num) throws Exception;
	
	//게시글 목록 추천 수 반영
	public void goodCountUp(int num) throws Exception;
	
	//게시글 목록 추천 수 반영
	public void goodCountDown(int num) throws Exception;
}
