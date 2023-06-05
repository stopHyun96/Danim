package com.danim.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.danim.mapper.ReviewListMapper;
import com.danim.model.CommentsVO;
import com.danim.model.DoVO;
import com.danim.model.ReviewListVO;

@Service
public class ReviewListServiceImpl implements ReviewListService {
	
	private final ReviewListMapper mapper;
	
	@Autowired
	public ReviewListServiceImpl(ReviewListMapper mapper) {
	    this.mapper = mapper;
	}
	
	//리뷰 게시판 전체 리스트를 불러옴
	@Override
	public List<ReviewListVO> reviewList(int criNum, int viewNum, String keyword, String condition, Integer doId) throws Exception{
		int page = (criNum - 1) * viewNum;
		
		return mapper.reviewList(page, viewNum, keyword, condition, doId);
	}
	
	//리뷰 게시판 베스트 게시글 탑4를 불러옴
	@Override
	public List<ReviewListVO> bestList() throws Exception{
		return mapper.bestList();
	}
	
	//리뷰 게시판 내의 총 게시글의 수를 불러옴
	@Override
	public int reviewPages() throws Exception{
		return mapper.reviewPages();
	}
	
	//리뷰 게시판 검색폼에 사용할 시/도 정보를 불러옴
	@Override
	public List<DoVO> selectDo() throws Exception{
		return mapper.selectDo();
	}
	
	//리뷰 게시글 상세보기 경로에 사용할 고유 번호 호출
	@Override
	public ReviewListVO reviewDetail(int num) throws Exception{
		return mapper.reviewDetail(num);
	}
	
	//댓글 목록 조회
	@Override
	public List<CommentsVO> commentList(int num, int criNum, int viewNum) throws Exception {
		int page = (criNum - 1) * viewNum;
		
		Map<String, Integer> pages = new HashMap<>();
		pages.put("num", num);
		pages.put("criNum", page);
		pages.put("viewNum", viewNum);
		
		return mapper.commentList(pages);
	}
	
	//댓글 수 조회
	@Override
	public int commentCount(int num) throws Exception {
		return mapper.commentCount(num);
	}
	
	//조회수 증가
	@Override
	public void viewCountUp(int num) throws Exception {
		mapper.viewCountUp(num);
	}
	
	//추천 여부 확인
	@Override
	public int goodSelect(int num, int userId) throws Exception {
		return mapper.goodSelect(num, userId);
	}
	
	//추천
	@Override
	public void goodUpdate(int num, int userId, int good) throws Exception {
		if(good > 0) {
			mapper.goodDelete(num, userId);
			mapper.goodCountDown(num);
		}else {
			mapper.goodInsert(num, userId);
			mapper.goodCountUp(num);
		}
	}
	
	//추천 수 조회
	@Override
	public int allGoods(int num) throws Exception {
		return mapper.allGoods(num);
	}
}
