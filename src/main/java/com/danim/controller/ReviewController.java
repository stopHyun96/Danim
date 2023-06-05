package com.danim.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.danim.model.CommentsVO;
import com.danim.model.DoVO;
import com.danim.model.ReviewListVO;
import com.danim.model.UsersVO;
import com.danim.service.ReviewListService;
import com.danim.service.ReviewUploadService;
import com.danim.service.UserService;

@Controller
@RequestMapping(value="/board/*")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	private final ReviewListService reviewListService;
	private final ReviewUploadService reviewUploadService;
	private final UserService userService;
	
	@Autowired
	public ReviewController(ReviewListService reviewListService, ReviewUploadService reviewUploadService, UserService userService) {
		this.reviewListService = reviewListService;
		this.reviewUploadService = reviewUploadService;
		this.userService = userService;
	}
	
	/* 전체 게시판 이동 */
    @GetMapping("/reviewList")
    // => @RequestMapping(value="reviewList", method=RequestMethod.GET)
    public void ReviewListGET(
    		@RequestParam(value="doId", required=false) Integer doId, 
    		@RequestParam(value="keyword", required=false) String keyword, 
    		@RequestParam(value="condition", required=false) String condition ,
    		Model model, @RequestParam(defaultValue = "1") int currentPage, 
    		@RequestParam(defaultValue = "9") int viewNum, String userEmail, 
    		HttpSession session) throws Exception {
    	//기준이 될 criNum과 viewNum 매개변수를 넣어 페이징 처리
    	
    	//게시글 목록 가져오기
    	List<ReviewListVO> listAll = reviewListService.reviewList(currentPage, viewNum, keyword, condition, doId);
    	//베스트 게시글 목록 가져오기
    	List<ReviewListVO> bestList = reviewListService.bestList();
    	//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
    	//게시글의 수
    	int reviewPages = this.reviewListService.reviewPages();
    	//나눠진 게시글 목록의 페이지 수
    	int total = (int) Math.ceil(((double) reviewPages) / ((double) viewNum));
    	
    	userEmail = (String) session.getAttribute("userEmail");
    	
    	logger.info("리뷰 게시판 이동");
    	logger.info("총 게시글 수 : " + reviewPages);
    	
    	//게시글 목록
        model.addAttribute("listAll", listAll);
        //베스트 게시글
        model.addAttribute("bestList", bestList);
        //시/도 목록
        model.addAttribute("selectDo", selectDo);
        //현재 페이지
        model.addAttribute("currentPage", currentPage);
        //전체 페이지
        model.addAttribute("total", total);
        //로그인 여부 확인에 이용할 userEmail
        model.addAttribute("userEmail", userEmail);
    }
    
    //리뷰 게시판 상세보기
  	@RequestMapping(value = "/reviewDetail", method = RequestMethod.GET)
  	public String reviewDetailGET(
  			@RequestParam(defaultValue = "1") int commentPage, 
  			@RequestParam(defaultValue = "10") int viewNum, 
  			ReviewListVO review, @RequestParam("num") int num, 
  			Model model, 
  			Integer userId, 
  			String writer,
  			String userEmail,
  			HttpSession session) throws Exception {
  		model.addAttribute("review", review);
  		
  		userEmail = (String) session.getAttribute("userEmail");
  		
  		//userId
		userId = reviewUploadService.findUserId(userEmail);
		//writer
		writer = reviewUploadService.findWriter(userEmail);

		int allGoods = reviewListService.allGoods(num);
		
		//댓글의 수
		int reviewPages = reviewListService.commentCount(num);
		//나눠진 게시글 목록의 페이지 수
		int total = (int) Math.ceil(((double) reviewPages) / ((double) viewNum));
		
		//게시판 상세보기 정보 조회
  		ReviewListVO reviewDetail = reviewListService.reviewDetail(num);
  		//댓글 리스트 조회
  		List<CommentsVO> commentList = reviewListService.commentList(num, commentPage, viewNum);
  		//상세보기 데이터
  		model.addAttribute("reviewDetail", reviewDetail);
  		//댓글 리스트
  		model.addAttribute("commentList", commentList);
  		//현재 로그인한 사용자의 userId
  		model.addAttribute("userId", userId);
  		//현재 로그인한 사용자의 닉네임
  		model.addAttribute("writer", writer);
  		//현재 댓글 페이지
        model.addAttribute("commentPage", commentPage);
  		//전체 댓글 페이지
        model.addAttribute("total", total);
        //추천 수
        model.addAttribute("allGoods", allGoods);
  		
  		//조회수 증가
  		reviewListService.viewCountUp(num);
  		logger.info("조회수: " + reviewDetail.getViewCount());
  		
  		return "/board/reviewDetail";
  	}
  	
  	//게시글 작성 페이지 이동
  	@RequestMapping(value = "/reviewUpload", method = RequestMethod.GET)
  	//Controller 메소드에 정수형 파라미터를 선언할 시 int가 아닌 Integer로 선언해야함.
	public String uploadPageGET(HttpSession session, Model model, String userEmail, Integer userId, String writer) throws Exception {
		logger.info("글 작성 페이지 불러오기");
		
		//세션에 저장된 userEmail을 변수로 선언
		userEmail = (String) session.getAttribute("userEmail");
		userId = null;
		writer = null;
		//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
		
		//회원 정보 가져오기
		List<UsersVO> userInfo = userService.userInfo(userEmail);

		//시/도 목록
        model.addAttribute("selectDo", selectDo);
        //회원 정보 가져오기
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("userEmail", userEmail);
		
		return "board/reviewUpload";
	}
  	
  	//게시글 작성 실행
  	@RequestMapping(value = "/reviewUpload.do", method = RequestMethod.POST)
	public ModelAndView reviewUpload(ReviewListVO reviewVO, @RequestParam("imgFile") MultipartFile filename, ModelAndView mav, Model model) throws Exception {
		logger.info("글 작성 실행");
		
		// 파일 업로드 처리
		if (!filename.isEmpty()) {
			//파일이 저장될 경로 지정
			String path = "C:/stopHyunProject/workspace/danim/src/main/webapp/resources/upload/";
			//String 타입의 파일명
			String originalFilename = filename.getOriginalFilename();
			//파일명 중복방지를 위해 파일명 앞에 랜덤판 UUID를 붙여줌
			String changeFilename = UUID.randomUUID().toString() + "_" + originalFilename;
			//파일변환
			filename.transferTo(new File(path, changeFilename));
			//파일을 매퍼에 추가함
			reviewVO.setFilename(changeFilename);
		}else {
			String changeFilename = "imgNull";
			
			reviewVO.setFilename(changeFilename);
		}
		
		reviewUploadService.upload(reviewVO);
		//글 작성이 완료되면 게시글 목록 페이지로 이동
		mav.setViewName("redirect:/board/reviewList?currentPage=1");
		
		return mav;
	}
  	
  	//게시글 수정 페이지 이동
  	@RequestMapping(value = "/reviewModify", method = RequestMethod.GET)
  	//Controller 메소드에 정수형 파라미터를 선언할 시 int가 아닌 Integer로 선언해야함.
	public String modifyPageGET(HttpSession session, Model model, @RequestParam("num") int num) throws Exception {
		logger.info("글 수정 페이지 불러오기");
		
		String userEmail = (String) session.getAttribute("userEmail");
		
		ReviewListVO review = reviewListService.reviewDetail(num);
		//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
    	//회원 정보 가져오기
    	List<UsersVO> userInfo = userService.userInfo(userEmail);
		
		model.addAttribute("review", review);
		//시/도 목록
        model.addAttribute("selectDo", selectDo);
        model.addAttribute("userInfo", userInfo);
		
		return "board/reviewModify";
	}
  	
  	//게시글 수정 실행
  	@RequestMapping(value = "/reviewModify.do", method = RequestMethod.POST)
	public ModelAndView reviewModify(ReviewListVO reviewVO, 
			@RequestParam("oldFile") String oldFile, 
			@RequestParam("newFile") MultipartFile filename, 
			@RequestParam("num") int num, 
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			ModelAndView mav) throws Exception {
		logger.info("글 수정 실행");
		
		// 기존에 업로드 되어있던 이미지 파일 수정 처리
		if (!filename.isEmpty()) {
			//기존 파일이 저장되어 있는 경로
			String oldPath = "C:/stopHyunProject/workspace/danim/src/main/webapp/resources/upload/";
			File oldDelete = new File(oldPath, oldFile);
			//기존 파일이 있다면 지워줌
			if(oldDelete.exists()) {
				oldDelete.delete();
			}
			
			//새로운 파일이 저장될 경로 지정
			String path = "C:/stopHyunProject/workspace/danim/src/main/webapp/resources/upload/";
			//String 타입의 파일명
			String originalFilename = filename.getOriginalFilename();
			//파일명 중복방지를 위해 파일명 앞에 랜덤판 UUID를 붙여줌
			String changeFilename = UUID.randomUUID().toString() + "_" + originalFilename;
			//파일을 지정한 경로에 추가
			filename.transferTo(new File(path, changeFilename));
			//파일을 매퍼에 추가함
			reviewVO.setFilename(changeFilename);
			
			reviewUploadService.modify(num, title, content, changeFilename);
		}else {
			reviewUploadService.modify(num, title, content, oldFile);
		}
		
		//글 수정이 완료되면 게시글 목록 페이지로 이동
		mav.setViewName("redirect:/board/reviewList?currentPage=1");
		
		return mav;
	}
  	
  	//게시글 삭제
  	@RequestMapping(value = "/reviewDelete", method = RequestMethod.GET)
	public ModelAndView reviewDelete(@RequestParam("filename") String filename, @RequestParam("num") int num, ModelAndView mav) throws Exception {
		logger.info("게시글 삭제 실행");
		
		// 기존에 업로드 되어있던 파일 삭제 처리
		if (filename != "imgNull" || filename != null) {
			//기존 파일이 저장되어 있는 경로
			String path = "C:/stopHyunProject/workspace/danim/src/main/webapp/resources/upload/";
			File fileDelete = new File(path, filename);
			//기존 파일이 있다면 지워줌
			if(fileDelete.exists()) {
				fileDelete.delete();
			}
		}
		
		//게시글 삭제
		reviewUploadService.delete(num);
		//게시글 삭제 시 게시글 안의 댓글도 함께 삭제
		reviewUploadService.bbsCommentDelete(num);
		
		//글 삭제가 완료되면 게시글 목록 페이지로 이동
		mav.setViewName("redirect:/board/reviewList?currentPage=1");
		
		return mav;
	}
  	
  	//댓글 작성
  	@RequestMapping(value = "/commentWrite.do", method = RequestMethod.POST)
	public ModelAndView commentWrite(@RequestParam("num") int num, @RequestParam("writer") String writer, @RequestParam("userId") int userId, @RequestParam("content") String content, ModelAndView mav) throws Exception {
		logger.info("댓글 작성 실행");
		
		reviewUploadService.commentWrite(num, writer, userId, content);
		
		//글 수정이 완료되면 게시글 목록 페이지로 이동
		mav.setViewName("redirect:/board/reviewDetail?num=" + num);
		
		return mav;
	}
  	
  	//댓글 삭제
  	@RequestMapping(value = "/commentDelete", method = RequestMethod.GET)
	public ModelAndView commentDelete(@RequestParam("num") int num, @RequestParam("commentNum") int commentNum, ModelAndView mav) throws Exception {
		logger.info("댓글 삭제 실행");
		
		reviewUploadService.commentDelete(commentNum);
		//댓글 삭제 시 게시판 목록의 댓글 수가 1씩 줄어든다.
		reviewUploadService.commentCountDown(num);
		
		//댓글 삭제가 완료되면 게시글 목록 페이지로 이동
		mav.setViewName("redirect:/board/reviewDetail?num=" + num);
		
		return mav;
	}
  		
  	//추천
  	@RequestMapping(value = "/goodInsert", method = RequestMethod.POST)
    public String goodInsert(@RequestParam("num") int num, @RequestParam("userId") int userId, Integer good) throws Exception {
  		good = reviewListService.goodSelect(num, userId);
  		
  		reviewListService.goodUpdate(num, userId, good);
        
        return "redirect:/board/reviewDetail?num=" + num + "&commentPage=1";
    }
}
