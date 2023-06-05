package com.danim.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.danim.model.DoVO;
import com.danim.model.ReviewListVO;
import com.danim.service.ReviewListService;

@Controller
public class MainController {
	
	private final ReviewListService reviewListService;
	
	@Autowired
	public MainController(ReviewListService reviewListService) {
		this.reviewListService = reviewListService;
	}
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session, String userEmail) throws Exception {
		logger.info("메인 페이지 이동");
		
		userEmail = (String) session.getAttribute("userEmail");
		logger.info("userEmail : " + userEmail);
		
		//베스트 게시글 목록 가져오기
    	List<ReviewListVO> bestList = reviewListService.bestList();
    	//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
    	
    	//베스트 게시글 출력
    	model.addAttribute("bestList", bestList);
    	//시/도 목록
        model.addAttribute("selectDo", selectDo);
		
		return "main";
	}
	
}
