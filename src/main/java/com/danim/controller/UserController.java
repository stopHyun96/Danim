package com.danim.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.danim.model.DoVO;
import com.danim.model.UsersVO;
import com.danim.service.ReviewListService;
import com.danim.service.UserService;

@Controller
@RequestMapping(value="/member/*")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	private final UserService userService;
	private final ReviewListService reviewListService;
	
	@Autowired
	public UserController(UserService userService, ReviewListService reviewListService) {
		this.userService = userService;
		this.reviewListService = reviewListService;
	}
	
	//로그인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPageGET() {
		logger.info("로그인 페이지 불러오기");
		
		return "member/login";
	}
	
	//회원가입 페이지
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinPageGET(Model model) throws Exception {
		logger.info("회원가입 페이지 불러오기");
		
		//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
    	
    	//시/도 목록
        model.addAttribute("selectDo", selectDo);
		
		return "member/join";
	}
	
	//마이페이지
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPageGET(HttpSession session, Model model) throws Exception {
		logger.info("마이페이지 불러오기");
		
		String userEmail = (String) session.getAttribute("userEmail");
		
		//시도 테이블 가져오기
    	List<DoVO> selectDo = reviewListService.selectDo();
    	//회원 정보 조회
    	List<UsersVO> userInfo = userService.userInfo(userEmail);
    	
    	//시/도 목록
        model.addAttribute("selectDo", selectDo);
        //회원 정보 조회
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("userEmail", userEmail);
		
		return "member/myPage";
	}
	
	//로그인 실행
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView checkLogin(UsersVO vo, ModelAndView mav, Model model, HttpSession session, HttpServletRequest request, @RequestParam("userEmail") String userEmail, @RequestParam("userPw") String userPw) throws Exception {
		UsersVO loginChk = userService.loginCheck(vo, session);
		
		//아이디 에러
		boolean loginError = false;
		
		if (loginChk != null) {
			//아이디와 비밀번호가 맞다면 메인페이지로 이동
			mav.setViewName("redirect:/");
		}else if(session.getAttribute("userPw") == null || session.getAttribute("userEmail") == null || !session.getAttribute("userPw").equals(userPw) || !session.getAttribute("userEmail").equals(userEmail)) {
			//아이디가 틀렸다면 loginError변수를 false로
			//로그인 페이지로 이동
			loginError = true;
			mav.setViewName("/member/login");
		}
		
		model.addAttribute("loginError", loginError);
		
		return mav;
	}
	
	//회원가입 실행
	@RequestMapping(value = "/join.do", method = RequestMethod.POST)
	public ModelAndView join(
			@RequestParam("userPw") String userPw, 
			@RequestParam("userName") String userName,
			@RequestParam("userNickname") String userNickname,
			@RequestParam("userGender") int userGender,
			@RequestParam("userBirth") String userBirth,
			@RequestParam("userEmail") String userEmail,
			@RequestParam("userDo") int userDo,
			@RequestParam("userAddr1") String userAddr1,
			@RequestParam("userAddr2") String userAddr2,
			@RequestParam("userAddr3") String userAddr3,
			@RequestParam("userAddr4") String userAddr4,
			ModelAndView mav) throws Exception {
		logger.info("회원가입 실행");
		
		String userAddr = userAddr1 + " " + userAddr2 + " " + userAddr3 + " " + userAddr4;
		
		userService.join(userPw, userName, userNickname, userGender, userBirth, userEmail, userDo, userAddr);
		mav.setViewName("redirect:/member/login");
		
		return mav;
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(UsersVO userVO, HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("로그아웃");
		
		//세션에 저장된 값을 지움
		session.invalidate();
		
		//이전 주소 불러오기
		String referer = request.getHeader("Referer");

	    return "redirect:" + referer;
	}
	
	//비밀번호 찾기 페이지
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public String findPw() throws Exception {
		logger.info("비밀번호 찾기");
		
		return "/member/findPw";
	}
	
	//비밀번호 찾기
	//비밀번호 찾기 결과 페이지
	@RequestMapping(value = "/findPwGet", method = RequestMethod.GET)
	public String findPwGet(@RequestParam("userEmail") String userEmail, Model model) throws Exception {
		logger.info("비밀번호 찾기");
		
		String pw = userService.findPw(userEmail);
		
		model.addAttribute("pw", pw);
		
		return "/member/findPwGet";
	}
	
	//이메일 중복 체크
	@PostMapping("/emailDupChk")
	@ResponseBody
	public ResponseEntity<String> emailDupChk(@RequestParam("userEmail") String userEmail) throws Exception {
	    logger.info("E-mail 중복 체크");

	    int cnt;
	    
	    //입력된 값이 없다면 cnt를 -1로 설정
	    if(userEmail == null || userEmail.equals("")) {
	    	cnt = -1;
	    }else {
	    	cnt = userService.emailDupChk(userEmail);
	    }
	    logger.info("cnt: " + cnt);
	    logger.info("userEmail: " + userEmail);

	  //중복 시 dup
  		if (cnt > 0) {
  			return ResponseEntity.ok("dup");
  		//중복되지 않을 시 nodup
  		} else if(cnt == 0) {
  			return ResponseEntity.ok("nodup");
  		//값이 없을 시 null
  		} else {
  			return ResponseEntity.ok("null");
  		}
	}
	
	//닉네임 중복 체크
	@PostMapping("/nickNameChk")
	@ResponseBody
	public ResponseEntity<String> nickNameChk(@RequestParam("userNickname") String userNickname) throws Exception {
		logger.info("NickName 중복 체크");
		
		int cnt;
		
		if(userNickname == null || userNickname.equals("")) {
			//입력된 값이 없을 시 cnt를 -1로 설정
			cnt = -1;
		}else {
			cnt = userService.nickNameChk(userNickname);
		}
		
		logger.info("cnt: " + cnt);
		logger.info("userNickname: " + userNickname);
		
		//중복 시 dup
		if (cnt > 0) {
			return ResponseEntity.ok("dup");
		//중복되지 않을 시 nodup
		} else if(cnt == 0) {
			return ResponseEntity.ok("nodup");
		//값이 없을 시 null
		} else {
			return ResponseEntity.ok("null");
		}
	}
	
	//회원정보 수정
	@RequestMapping(value = "/myPageUpdate", method = RequestMethod.POST)
	public String myPageUpdate(
			@RequestParam("userNickname") String userNickname, 
			@RequestParam("userPw") String userPw, 
			@RequestParam("userDo") int userDo, 
			@RequestParam("oldAddr") String oldAddr,
			@RequestParam("userId") int userId,
			@RequestParam("userAddr1") String userAddr1,
			@RequestParam("userAddr2") String userAddr2,
			@RequestParam("userAddr3") String userAddr3,
			@RequestParam("userAddr4") String userAddr4,
			HttpSession session) throws Exception {
		logger.info("회원 정보 수정 실행");
		
		String userEmail = (String) session.getAttribute("userEmail");
		
		if(userAddr1 == null || userAddr2 == null || userAddr4 == null || userAddr1.equals("") || userAddr2.equals("") || userAddr4.equals("")) {
			//회원 정보 수정 서비스
			userService.myPageUpdate(userNickname, userPw, userDo, oldAddr, userEmail);
		}else {
			String userAddr = userAddr1 + " " + userAddr2 + " " + userAddr3 + " " + userAddr4;
			userService.myPageUpdate(userNickname, userPw, userDo, userAddr, userEmail);
		}
		
		
		//회원 정보(닉네임) 수정 시 등록된 게시물과 댓글의 작성자 데이터도 함께 변경
		userService.reviewWriterChange(userNickname, userId);
		userService.commentWriterChange(userNickname, userId);
		
		return "redirect:/member/myPage";
	}
	
	//회원탈퇴
	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public String userDelete(HttpSession session) throws Exception {
		logger.info("회원 탈퇴");
		
		//세션에 저장된 userEmail을 불러옴
		String userEmail = (String) session.getAttribute("userEmail");
		
		userService.userDelete(userEmail, session);
		
		return "redirect:/";
	}
}
