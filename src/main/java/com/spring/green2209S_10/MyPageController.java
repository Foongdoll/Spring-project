package com.spring.green2209S_10;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_10.dao.MyPageDAO;
import com.spring.green2209S_10.service.HomeService;
import com.spring.green2209S_10.service.MyPageService;
import com.spring.green2209S_10.vo.CgvCouponVO;
import com.spring.green2209S_10.vo.CgvMemberVO;
import com.spring.green2209S_10.vo.CgvReportVO;
import com.spring.green2209S_10.vo.CgvReviewVO;
import com.spring.green2209S_10.vo.CgvTicketingPaymentVO;
import com.spring.green2209S_10.vo.CgvWishListVO;

@Controller
@RequestMapping("/myPage")
public class MyPageController {

	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	MyPageService myPageService;
	
	@Autowired
	HomeService homeService;
	
	@Autowired
	MyPageDAO myPageDAO;
	
	@RequestMapping(value = "/myPageHome", method = RequestMethod.GET)
	public String myPageHomeGet(Model model,HttpSession session,HttpServletResponse response,
			@RequestParam(name = "jsonData", defaultValue = "",required = false) String jsonData,
			@RequestParam(name = "sw", defaultValue = "0",required = false) int sw) {

		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String id = (String)session.getAttribute("sId");
		CgvMemberVO vo = homeService.getMemberIdCheck(id);
		
		Date date = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yy,MM,dd");
		String now = sdf.format(date);
		
		String yy = now.split(",")[0];
		String MM = now.split(",")[1];
		String dd = now.split(",")[2];
		
		model.addAttribute("yy",yy);
		model.addAttribute("MM",MM);
		model.addAttribute("dd",dd);
		model.addAttribute("sw",sw);
		
		model.addAttribute("vo",vo);
		
		// 내가 쓴 리뷰
		
		List<CgvReviewVO> rvos = myPageService.getMyReviewList(id);
		
		model.addAttribute("rvos",rvos);
		
		int no = 0;
		String nos = "";
		String[] nosArr = null;
		String nosRes = "";
		String seatA = "";
		if(sw == 0 || sw == 3) { // 예매내역,QR코드
			List<CgvTicketingPaymentVO> vos = myPageService.getMyTicket(id);
			List<String> seatVos = new ArrayList<String>();
			for(int i = 0; i < vos.size(); i++) {
				nos = vos.get(i).getTk_seat();
				nosArr = nos.split("/");

				for(int j = 0; j < nosArr.length; j++) {
					no = Integer.parseInt(nosArr[j]);
					if(no > 144 && no < 151) seatA = "A";
					else if(no > 135 && no < 145) seatA = "B";
					else if(no > 126 && no < 136) seatA = "C";
					else if(no > 117 && no < 127) seatA = "D";
					else if(no > 108 && no < 118) seatA = "E";
					else if(no > 99 && no < 109) seatA = "F";
					else if(no > 90 && no < 100) seatA = "G";
					else if(no > 81 && no < 91) seatA = "H";
					else if(no > 72 && no < 82) seatA = "I";
					else if(no > 63 && no < 73) seatA = "J";
					else if(no > 54 && no < 64) seatA = "K";
					else if(no > 45 && no < 55) seatA = "L";
					else if(no > 36 && no < 46) seatA = "M";
					else if(no > 27 && no < 37) seatA = "N";
					else if(no > 18 && no < 28) seatA = "O";
					else if(no > 9 && no < 19) seatA = "P";
					else seatA = "Q";
					
					nosRes += seatA+no +"번&nbsp;";
				}
				seatVos.add(nosRes);
				nosRes = "";
			}
			
			model.addAttribute("seatVos",seatVos);
			model.addAttribute("vos",vos);
		}
		else if(sw == 1) { // 위시리스트 
			ArrayList<CgvWishListVO> vos = myPageService.getWishList(id);
			model.addAttribute("vos",vos);
		}
		else if(sw == 2) { // 내가 본 영화
			List<CgvTicketingPaymentVO> vos = myPageService.getMyViewMovieList(id);
			model.addAttribute("vos",vos);
		}
		else if(sw == 4) { // 내가 가진 쿠폰들
			List<CgvCouponVO> vos = myPageDAO.getMyCouponList(id);
			model.addAttribute("vos",vos);
		}
		else if(sw == 8) {
			CgvMemberVO mvo = homeService.getMemberIdCheck(id);
			model.addAttribute("mvo",mvo);
		}
		else if(sw == 9) {
			// 내가 신고한 내역
			List<CgvReportVO> reportVos = myPageDAO.getMyReportList(id);
			model.addAttribute("reportVos",reportVos);
		}
		
			model.addAttribute("jsonData",jsonData);
		
		return "home/myPage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishReasonInput", method = RequestMethod.GET)
	public String wishReasonInputGet(HttpSession session,CgvWishListVO vo) {
		
		String id = (String) session.getAttribute("sId");
		myPageService.setWishCommentInput(vo,id);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/wishDelete", method = RequestMethod.GET)
	public String wishDeleteGet(HttpSession session,String movieTitle) {
		String id = (String) session.getAttribute("sId");
		myPageService.getWishDelete(movieTitle,id);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pswdChange", method = RequestMethod.GET)
	public String pswdChangeGet(String pswd,HttpSession session) {
		int res = 0;
		String id = (String)session.getAttribute("sId");
		
		CgvMemberVO vo = myPageService.getMemberInfor(id);

		if(passwordEncoder.matches(pswd,vo.getMem_pswd())) res = 1; 
		
		return res+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pswdChange", method = RequestMethod.POST)
	public String pswdChangePost(String aPswd,HttpSession session) {
		String id = (String)session.getAttribute("sId");
		String newPswd = "";
		newPswd = passwordEncoder.encode(aPswd);
		
		CgvMemberVO vo = homeService.getMemberIdCheck(id);
		
		if(passwordEncoder.matches(aPswd, vo.getMem_pswd())) return "0";
		
		System.out.println(passwordEncoder.matches(aPswd, vo.getMem_pswd()));
		homeService.setNewPswdInput(newPswd, id); 
		
		return "1";
	}
	
	@RequestMapping(value = "/myInforUpdate", method = RequestMethod.POST)
	public String myInforUpdatePost(MultipartFile file,HttpServletRequest request,CgvMemberVO vo,String bFile, String bsFile) {
		
		if (file.getOriginalFilename().equals("") || file.getOriginalFilename() == null) {
			vo.setMem_photo(bFile);
			vo.setMem_sPhoto(bsFile);
		}
		else {
			String mem_SPhoto = homeService.profilePhotoUpload(file,request);
			
			vo.setMem_photo(file.getOriginalFilename());
			vo.setMem_sPhoto(mem_SPhoto);
		}
		
		vo.setMem_id((String)request.getSession().getAttribute("sId"));
		myPageService.setMyInforUpdate(vo);
		return "redirect:/msg/myInforUpdateOk"; 
	}
		
	@ResponseBody
	@PostMapping("/myTodayCoupon")
	public String myTodayCouponPost(HttpSession session) {
		
		String id = (String) session.getAttribute("sId");
		
		String couponCode = UUID.randomUUID().toString().substring(0,8);
		
		int content = 0;
		
		
		CgvCouponVO vo = myPageDAO.getMyCoupon(id);
		
		if(vo == null) {
			content = (int)((Math.random())*6)+1;
			myPageDAO.setMyCouponInput(id,couponCode,content);
		}
		else {
			content = 100;
		}
		
		
		return content+"";
	}
	
	@ResponseBody
	@PostMapping("/memberDel")
	public String memberDelPost(String id) {

		myPageDAO.setMemberDel(id);
		
		return "";
	}
	
	
	
}
