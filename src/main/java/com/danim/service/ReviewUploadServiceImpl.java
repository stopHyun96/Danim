package com.danim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.danim.mapper.ReviewUploadMapper;
import com.danim.model.ReviewListVO;

@Service
public class ReviewUploadServiceImpl implements ReviewUploadService {
	private final ReviewUploadMapper mapper;
	
	@Autowired
	public ReviewUploadServiceImpl(ReviewUploadMapper mapper) {
		this.mapper = mapper;
	}
	
	//userId 찾기
	@Override
	public Integer findUserId(String userEmail) throws Exception {
		//글 작성 기능을 구현한 후 로그인을 하지 않은 상태로 게시글 상세보기로 이동하면 findUserId()에 반환되는 값이 없어 500에러가 뜸
		//따라서 쿼리에 사용된 userEmail 파라미터가 null일 경우 null로 반환하기 위해 타입을 Integer로 변경
		if(userEmail == null) {
			return null;
		}
		
		return mapper.findUserId(userEmail);
	}
	
	//writer 찾기
	@Override
	public String findWriter(String userEmail) throws Exception {
		return mapper.findWriter(userEmail);
	}
	
	//글 작성 쿼리 서비스
	@Override
	public void upload(ReviewListVO vo) throws Exception {
		mapper.upload(vo);
	}
	
	//글 수정 쿼리 서비스
	@Override
	public void modify(int num, String title, String content, String filename) throws Exception {
		mapper.modify(num, title, content, filename);
	}
	
	//글 삭제 쿼리 서비스
	@Override
	public void delete(int num) throws Exception {
		mapper.delete(num);
	}
	
	//게시글 삭제 시 게시글 안의 댓글도 함께 삭제
	@Override
	public void bbsCommentDelete(int num) throws Exception {
		mapper.bbsCommentDelete(num);
	}
	
	//댓글 작성 서비스
	@Override
	public void commentWrite(int num, String writer, int userId, String content) throws Exception {
		//댓글 작성
		mapper.commentWrite(num, writer, userId, content);
		//commentCount 증가
		mapper.commentCountUp(num);
	}
	
	//댓글 삭제 서비스
	@Override
	public void commentDelete(int commentNum) throws Exception {
		mapper.commentDelete(commentNum);
	}
	
	//게시글 목록 테이블의 commentCount 감소
	@Override
	public void commentCountDown(int num) throws Exception {
		mapper.commentCountDown(num);
	}
}
