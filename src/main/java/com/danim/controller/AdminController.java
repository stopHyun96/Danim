package com.danim.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.danim.model.DoVO;
import com.danim.model.ReviewListVO;
import com.danim.model.UsersVO;
import com.danim.service.AdminService;
import com.danim.service.ReviewListService;
import com.danim.service.ReviewUploadService;

@Controller
@RequestMapping(value="/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	private final AdminService adminService;
	private final ReviewListService reviewListService;
	private final ReviewUploadService reviewUploadService;
	
	@Autowired
	public AdminController(AdminService adminService, ReviewListService reviewListService, ReviewUploadService reviewUploadService) {
		this.adminService = adminService;
		this.reviewListService = reviewListService;
		this.reviewUploadService = reviewUploadService;
	}
	
	//게시글 관리 페이지
	@RequestMapping("/reviewManagePage")
	public String reviewManagePageGet(@RequestParam(value="keyword", required=false) String keyword ,@RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "10") int viewNum, Model model) throws Exception{
		logger.info("관리자 모드 게시글 관리 페이지 이동");
		
		//게시글 목록 가져오기
		List<ReviewListVO> reviewList = adminService.reviewList(currentPage, viewNum, keyword);
		//게시글의 총합
		int reviewTotal = adminService.reviewTotal();
		//나눠진 게시글 목록의 페이지 수
    	int total = (int) Math.ceil(((double) reviewTotal) / ((double) viewNum));
    	//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
		
    	//게시글 목록
		model.addAttribute("reviewList", reviewList);
		//현재 페이지
        model.addAttribute("currentPage", currentPage);
        //전체 페이지
		model.addAttribute("total", total);
		//시/도 목록
        model.addAttribute("selectDo", selectDo);
		
		return "/admin/reviewManagePage";
	}
	
	//사용자 관리 페이지
	@RequestMapping("/userManagePage")
	public String userManagePageGet(@RequestParam(value="keyword", required=false) String keyword ,@RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "10") int viewNum, Model model) throws Exception{
		logger.info("관리자 모드 사용자 관리 페이지 이동");
		
		//사용자 목록 가져오기
		List<UsersVO> userList = adminService.userList(currentPage, viewNum, keyword);
		//사용자 총합
		int userTotal = adminService.userTotal();
		//나눠진 사용자 목록의 페이지 수
		int total = (int) Math.ceil(((double) userTotal) / ((double) viewNum));
		
		//사용자 목록
		model.addAttribute("userList", userList);
		//현재 페이지
        model.addAttribute("currentPage", currentPage);
        //전체 페이지
		model.addAttribute("total", total);
		
		return "/admin/userManagePage";
	}
	
	//관리자 로그인 실행
	@PostMapping("/login.do")
	@ResponseBody
	public ResponseEntity<String> adminLogin(@RequestParam("adminEmail") String adminEmail, @RequestParam("adminPw") String adminPw, HttpSession session) throws Exception {
		logger.info("Admin Login");
		
		int cnt;
		//이메일과 비밀번호가 비어있다면 cnt를 -1로 설정
		if(adminEmail == null && adminPw == null || adminEmail.equals("") && adminPw.equals("")) {
			cnt = -1;
		//그렇지 않다면 쿼리 실행
		}else {
			cnt = adminService.adminLoginCheck(adminEmail, adminPw);
		}
		
		logger.info("cnt=" + cnt);
		//쿼리 실행 결과 동일한 계정이 있다면 세션에 저장한 후 로그인 성공
		if(cnt > 0) {
			session.setAttribute("adminEmail", adminEmail);
			session.setAttribute("adminPw", adminPw);
			
			return ResponseEntity.ok("success");
		//입력받은 이메일과 비밀번호가 비어있을 경우
		}else if(cnt == -1) {
			return ResponseEntity.ok("null");
		//로그인 실패 시
		}else {
			return ResponseEntity.ok("fail");
		}
	}
	
	//관리자 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(UsersVO userVO, HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("로그아웃");
		
		//세션에 저장된 값을 지움
		session.invalidate();
		
		//이전 주소 불러오기
		String referer = request.getHeader("Referer");

	    return "redirect:" + referer;
	}
	
	//게시글 삭제
	@RequestMapping(value = "/adminReviewDelete", method = RequestMethod.GET)
	public String adminReviewDelete(@RequestParam("filename") String filename, @RequestParam("num") int num, @RequestParam("currentPage") String currentPage) throws Exception {
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
		
		reviewUploadService.delete(num);
		
		//글 삭제가 완료되면 게시글 목록 페이지로 이동
		return "redirect:/admin/reviewManagePage?currentPage=" + currentPage;
	}
	
	//사용자 삭제
	@RequestMapping(value = "/adminUserDelete", method = RequestMethod.GET)
	public String adminUserDelete(@RequestParam("userEmail") String userEmail, @RequestParam("currentPage") int currentPage) throws Exception {
		logger.info("사용자 삭제");
		
		adminService.adminUserDelete(userEmail);

	    return "redirect:/admin/userManagePage?currentPage=" + currentPage;
	}
}
