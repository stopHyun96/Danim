package com.danim.service;

import java.util.List;

import com.danim.model.CommentsVO;
import com.danim.model.DoVO;
import com.danim.model.ReviewListVO;

public interface ReviewListService {
	//리뷰 게시판 전체 리스트를 불러옴
	public List<ReviewListVO> reviewList(int criNum, int viewNum, String keyword, String condition, Integer doId) throws Exception;
	
	//리뷰 게시판 베스트 게시글 탑4를 불러옴
	public List<ReviewListVO> bestList() throws Exception;
	
	//리뷰 게시판 내의 총 게시글의 수를 불러옴
	public int reviewPages() throws Exception;
	
	//리뷰 게시판 검색폼에 사용할 시/도 정보를 불러옴
	public List<DoVO> selectDo() throws Exception;
	
	//리뷰 게시글 상세보기 경로에 사용할 고유 번호 호출
	public ReviewListVO reviewDetail(int num) throws Exception;
	
	//댓글 리스트
	public List<CommentsVO> commentList(int num, int criNum, int viewNum) throws Exception;
	
	//댓글 총 수
	public int commentCount(int num) throws Exception;
	
	//조회수 증가
	public void viewCountUp (int num) throws Exception;
	
	//추천
	public void goodUpdate(int num, int userId, int good) throws Exception;
	
	//추천 여부 확인
	public int goodSelect (int num, int userId) throws Exception;
	
	//게시글별 추천 수 조회
	public int allGoods (int num) throws Exception;
}
